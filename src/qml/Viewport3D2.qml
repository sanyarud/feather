/***********************************************************************
 *
 * Filename: Viewport3D.qml 
 *
 * Description: Holds the C++ viewport. 
 *
 * Copyright (C) 2015 Richard Layman, rlayman2000@yahoo.com 
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 ***********************************************************************/

import QtQuick 2.3
import QtQuick.Scene3D 2.0
import Qt3D 2.0
import Qt3D.Renderer 2.0
import Qt3D.Input 2.0
import feather.viewport 1.0
import feather.scenegraph 1.0

Rectangle {
    id: frame
    color: "yellow"

    Scene3D {
        id: scene3d
        anchors.fill: parent
        anchors.margins: 2
        focus: true
        aspects: "input"


            Viewport2 {
                id: vp

                Camera {
                    id: camera1
                    projectionType: CameraLens.PerspectiveProjection
                    fieldOfView: 45
                    aspectRatio: frame.width/frame.height
                    nearPlane : 0.1
                    farPlane : 1000.0
                    position: Qt.vector3d( 0.0, 0.0, 20.0 )
                    upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
                    viewCenter: Qt.vector3d( 0.0, 0.0, 0.0 )
                }

                Camera {
                    id: camera2
                    projectionType: CameraLens.PerspectiveProjection
                    fieldOfView: 45
                    aspectRatio: frame.width/frame.height
                    nearPlane : 0.1
                    farPlane : 1000.0
                    position: Qt.vector3d( 0.0, 0.0, 20.0 )
                    upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
                    viewCenter: Qt.vector3d( 0.0, 0.0, 0.0 )
                }

               Configuration  {
                    controlledCamera: camera1
                }


               Configuration  {
                    controlledCamera: camera2
                }

                    FrameGraph {
                        id: frameGraph                
                        //activeFrameGraph: Viewport {

                        Viewport {
                            rect: Qt.rect(0, 0, 1, 1)
                            clearColor: "grey"

                                ClearBuffer {
                                    buffers : ClearBuffer.ColorDepthBuffer
                                }

                            /*
                            CameraSelector { 
                                id : cameraSelectorViewport
                                camera : camera

                                ClearBuffer {
                                    buffers : ClearBuffer.ColorDepthBuffer
                                }

                            }
                            */

                            Viewport {
                                id : topLeftViewport
                                rect : Qt.rect(0, 0, 0.5, 0.5)
                                //clearColor: "grey"

                                CameraSelector { 
                                    camera : camera1
                                }
                            }

                            Viewport {
                                id : topRightViewport
                                rect : Qt.rect(0.5, 0, 0.5, 0.5)
                                //clearColor: "grey"

                                CameraSelector { 
                                    camera : camera2
                                }
                            }

                       }
 
                    } 
 

                components: [ frameGraph ]
                /*
                components: [

                    FrameGraph {
                
                        activeFrameGraph: Viewport {
                            rect: Qt.rect(0, 0, 1, 1)
                            //clearColor: "grey"

                                ClearBuffer {
                                    buffers : ClearBuffer.ColorDepthBuffer
                                }


                            CameraSelector { 
                                id : cameraSelectorViewport
                                camera : camera

                                ClearBuffer {
                                    buffers : ClearBuffer.ColorDepthBuffer
                                }

                            }

                            Viewport {
                                id : topLeftViewport
                                rect : Qt.rect(0, 0, 0.5, 0.5)
                                clearColor: "grey"

                                CameraSelector { 
                                    camera : camera
                                }
                            }

                            Viewport {
                                id : topRightViewport
                                rect : Qt.rect(0.5, 0, 0.5, 0.5)
                                clearColor: "grey"

                                CameraSelector { 
                                    camera : camera
                                }
                            }

                        }
 
                    } 
            ] 
            */

        }

    } //sceneRoot

    function addNode(uid) {
        vp.addItems(uid) 
    }

    function addDrawItems(item) {
        vp.addItems(item)
    }

    function updateDrawItems(uid) {
        vp.updateItems(uid)
    }

    function updateViewport(uid,nid,fid) {
        vp.doUpdate()
    }

    Component.onCompleted: {
        SceneGraph.nodeAdded.connect(addNode)
        SceneGraph.nodeAddDrawItems.connect(addDrawItems)
        SceneGraph.nodeUpdateDrawItems.connect(updateDrawItems)
        SceneGraph.nodeFieldChanged.connect(updateViewport)
    }
}
