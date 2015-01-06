// =====================================================================================
// 
//       Filename:  commands.cpp
// 
//    Description:  
// 
//        Version:  1.0
//        Created:  08/02/2014 09:47:41 PM
//       Revision:  none
//       Compiler:  g++
// 
//         Author:  Richard Layman (), rlayman2000@yahoo.com
//        Company:  
// 
// =====================================================================================
#include "commands.hpp"
//#include "field.hpp"
#include "scenegraph.hpp"
#include "root_node.hpp"
#include "null.hpp"
#include "object.hpp"
#include "parameter.hpp"
#include "command.hpp"

using namespace feather;
//using namespace feather::qml;

static PluginManager plugins;

status qml::command::init() {
    load_plugins();
    add_node(node::Null,null::Root,0);
    // just testing the do_it plugin calls
    scenegraph::update();
    return status();
}

status qml::command::add_node(int type, int node, int id)
{
    switch(type)
    {
        case node::Null:
            return scenegraph::add_node_to_sg<node::Null,null::N>::exec(node,id);
        case node::Camera:
            return scenegraph::add_node_to_sg<node::Camera,camera::N>::exec(node,id);
        case node::Light:
            return scenegraph::add_node_to_sg<node::Light,light::N>::exec(node,id);
        case node::Texture:
            return scenegraph::add_node_to_sg<node::Texture,texture::N>::exec(node,id);
        case node::Shader:
            return scenegraph::add_node_to_sg<node::Shader,shader::N>::exec(node,id);
        case node::Object:
            return scenegraph::add_node_to_sg<node::Object,object::N>::exec(node,id);
        default:
            break;
    }
    
    return status(FAILED, "no matching Type of Node found while trying to add node");
}

status qml::command::draw_sg(QMatrix4x4& view)
{
    return scenegraph::update();
}

status qml::command::load_plugins()
{
    return scenegraph::load_plugins(); 
}

status qml::command::run_command(std::string cmd, feather::parameter::ParameterList params)
{
    //feather::parameter::ParameterList parameters;
    return status();
    //return plugins.run_command(cmd, params);
}
