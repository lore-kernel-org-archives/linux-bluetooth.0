Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 30 May 2016 16:22:32 +0900
Message-ID: <CA+ZaN39hHDpaF54rF+dEN0n2tA0bhj1Kh80kkyynssZqp6aArg@mail.gmail.com>
Subject: How to make object for RegisterAdvertisement()
From: Seulki Shin <sskcorea@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm trying to make a BLE avdertising device.
But I have difficulty to use Bluez D-Bus C APIs.

When I try to call RegisterAdvertisement(), I got this message.

journalctl message:
bluetoothd[352]: Failed to read "Type" property of advertisement

dbus message:
GDBus.Error:org.bluez.Error.Failed: Failed to parse advertisement.

version:
bluez: v5.39
kernel: 4.1.15

code chunk:
static const gchar advertisement_introspection_xml[] =
"<node name='/'>"
"  <interface name='org.freedesktop.DBus.ObjectManager'>"
"    <method name='GetManagedObjects'>"
"      <arg type='a{oa{sa{sv}}}'
name='object_paths_interfaces_and_properties' direction='out'/>"
"    </method>"
"  </interface>"
"  <interface name='org.bluez.LEAdvertisement1'>"
"    <property type='s' name='Type' access='read'>"
"    </property>"
"    <property type='as' name='ServiceUUIDs' access='read'>"
"    </property>"
"    <property type='a{sv}' name='ManufacturerData' access='read'>"
"    </property>"
"    <property type='as' name='SolicitUUIDs' access='read'>"
"    </property>"
"    <property type='a{sv}' name='ServiceData' access='read'>"
"    </property>"
"    <property type='b' name='IncludeTxPower' access='read'>"
"    </property>"
"  </interface>"
"</node>";

static void _serv_method_call(GDBusConnection *connection, const gchar *sender,
                const gchar *object_path, const gchar *interface_name,
                const gchar *method_name, GVariant *parameters,
                GDBusMethodInvocation *invocation, gpointer user_data)
{
GVariantBuilder *b, *b1, *b11;
b = g_variant_builder_new( G_VARIANT_TYPE("a{oa{sa{sv}}}"));
b1 = g_variant_builder_new( G_VARIANT_TYPE("a{sa{sv}}"));
b11 = g_variant_builder_new(G_VARIANT_TYPE("a{sv}"));

  g_variant_builder_add(b11, "{sv}", "Type",
                                g_variant_new_string("peripheral");
g_variant_builder_add(b1, "{sa{sv}}",
                                "org.bluez.LEAdvertisement1" , b11);
g_variant_builder_add(b, "{oa{sa{sv}}}",
                                object_path, b1);
  g_dbus_method_invocation_return_value(invocation,
                                g_variant_new("(a{oa{sa{sv}}})", b));
}

static const GDBusInterfaceVTable adv_interface_vtable = {
        _adv_method_call,
        NULL,
        NULL,
};

node = g_dbus_node_info_new_for_xml(advertisement_introspection_xml, &e);

object_id = g_dbus_connection_register_object(
                        hci.conn,
                        DBUS_ADVERTISEMENT,
                        node->interfaces[0],
                        &adv_interface_vtable,
                        NULL, NULL, &e);

g_dbus_connection_call_sync(
                        hci.conn,
                        DBUS_BLUEZ_BUS,
                        DBUS_BLUEZ_OBJECT_PATH_HCI0,
                        DBUS_IF_ADVERTISINGMANAGER1, "RegisterAdvertisement",
                        g_variant_new("(o)", DBUS_ADVERTISEMENT),
                        NULL, G_DBUS_CALL_FLAGS_NONE, G_MAXINT, NULL, &e);

Is this right way to make an advertisement object and call
"RegisterAdvertisement()" ?
How can I register object especially having a dict type properties.

I've already tested python script 'example-advertisement' and it works for me.
Any comments would be highly appreciated.

Thanks,
Slki
