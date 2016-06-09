Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: JT Harkey <jtharkeyjr@gmail.com>
Date: Wed, 8 Jun 2016 19:53:55 -0500
Message-ID: <CAPXUE4M_J5UoDpKytTY4hyvo=ewANvUVZsm=vehcG33tiBzWnA@mail.gmail.com>
Subject: Profile registration with bluez using dbus/gio.
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm trying to understand the process of registering a profile with
bluez using the dbus/gio method. When I call RegisterProfile
everything is good. I check my GError and it's NULL and my return
value is an empty GVariant. However, I can't see the new profile in
D-Bus using d-feet and I cannot connect to it using a my test device.
Sdptool also can't find it.

I've searched the web for a couple of weeks now and have asked on
StackOverflow. Below is a link to that, which has a more full version
of my code. I've only posted what I believe are the most important
bits here.

I seem to be missing a step or don't fully understand the process. Can
someone please help me understand what I'm missing? I've run out of
ideas since I don't get any error information back.

http://stackoverflow.com/questions/37573014/how-do-i-register-a-profile-with-bluez-using-dbus-gio

Here is the code in question. Thank you for looking at it.
=========================================
static const char *serial_service_class_uuid =
    "00001101-0000-1000-8000-00805F9B34FB";
static const char *my_service_uuid =
    "E62C4DCA-9ABC-11E5-8994-FEFF819CDC9F";

static const gchar btp_introspection_xml[] =
    "<node>"
    "  <interface name='org.bluez.Profile1'>"
    "    <method name='Release' />"
    "    <method name='NewConnection'>"
    "      <arg type='o' name='device' direction='in' />"
    "      <arg type='h' name='fd' direction='in' />"
    "      <arg type='a{sv}' name='fd_properties' direction='in' />"
    "    </method>"
    "    <method name='RequestDisconnection'>"
    "      <arg type='o' name='device' direction='in' />"
    "    </method>"
    "  </interface>"
    "</node>";

static const GDBusInterfaceVTable btp_interface_vtable =
{
    BTProfile::method_call,
    BTProfile::get_property,
    BTProfile::set_property
};

BTProfile::BTProfile() : bus_connection(NULL)
{
}

// ---------------------------------------------------------------------------

void BTProfile::init()
{
    GError *error = NULL;
    GDBusNodeInfo *introspection = g_dbus_node_info_new_for_xml(
        btp_introspection_xml, &error);
    if (!error)
    {
        GDBusInterfaceInfo *interface_info = g_dbus_node_info_lookup_interface(
            introspection, "org.bluez.Profile1");
        bus_connection = g_bus_get_sync(G_BUS_TYPE_SYSTEM, NULL, &error);
        if (!error)
        {
            g_dbus_connection_register_object(bus_connection,
                "/org/bluez/myprofile", interface_info, &btp_interface_vtable,
                this, NULL, &error);
            if (!error)
            {
                GVariantBuilder builder;
                g_variant_builder_init(&builder, G_VARIANT_TYPE_DICTIONARY);
                g_variant_builder_add(&builder, "{sv}", "Name",
                    g_variant_new("s", "myprofile"));
                g_variant_builder_add(&builder, "{sv}", "Service",
                    g_variant_new("s", serial_service_class_uuid));
                g_variant_builder_add(&builder, "{sv}", "Channel",
                    g_variant_new("q", 1));
                g_variant_builder_add(&builder, "{sv}", "RequireAuthentication",
                    g_variant_new("b", FALSE));
                g_variant_builder_add(&builder, "{sv}", "Role",
                    g_variant_new("s", "client"));
                g_variant_builder_add(&builder, "{sv}", "Version",
                    g_variant_new("q", 1));
                g_variant_builder_add(&builder, "{sv}", "AutoConnect",
                    g_variant_new("b", true));
                g_dbus_connection_call_sync(bus_connection, "org.bluez",
                    "/org/bluez", "org.bluez.ProfileManager1",
                    "RegisterProfile", g_variant_new("(osa{sv})",
                    "/org/bluez/myprofile", my_service_uuid, &builder),
                    NULL, G_DBUS_CALL_FLAGS_NONE, G_MAXINT, NULL, &error);
                if (!error)
                {
                    g_print("g_dbus_connection_call_sync succeeded\n");
                }
                else
                {
                    g_print("g_dbus_connection_call_sync failed: %s\n",
                        error->message);
                    g_error_free(error);
                }
            }
            else
            {
                g_print("g_dbus_connection_register_object failed: %s\n",
                    error->message);
                g_error_free(error);
            }
        }
        else
        {
            g_print("g_bus_get_sync failed: %s\n", error->message);
            g_error_free(error);
        }
    }
    else
    {
        g_print("g_dbus_node_info_new_for_xml failed: %s\n", error->message);
        g_error_free(error);
    }
}
