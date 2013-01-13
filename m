Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1358111392.1806.87.camel@aeonflux>
References: <1357905018-23237-1-git-send-email-luiz.dentz@gmail.com>
	<1357937184.1806.82.camel@aeonflux>
	<CABBYNZJyaBUt+oRSzyYJ0PNLTys8BfODLJFNY5NzC5touoraGA@mail.gmail.com>
	<1358111392.1806.87.camel@aeonflux>
Date: Mon, 14 Jan 2013 00:36:02 +0200
Message-ID: <CABBYNZ+=oDRu-x3toCQfWi7wdzk9SCm2Fx1AhS6SNVf+6SEpkw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/7] gdbus: Add g_dbus_client_get_proxy
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jan 13, 2013 at 11:09 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>> >> g_dbus_client_get_proxy gives the possibilitity to just check if a
>> >> proxy exist for the given path and interface pair instead of using
>> >> g_dbus_proxy_new which end up creating a proxy if it doesn't exists
>> >> which is not always necessary.
>> >
>> > why would we do that. You get the proxy via the client callbacks for
>> > proxy created or proxy removed.
>>
>> That way we the user don't have to maintain a list of found proxies,
>> such a list exist and is maintained by GDBusClient.
>
> see how bluetoothctl does it. Pretty damn simple. So I am not convinced
> that this is a good idea.
>
>> > The proxy_new method is for dealing with services that do not have
>> > ObjectManager support.
>>
>> Yep, so in one way or the other you are already letting the user
>> application search in the list of proxies maintained by GDBusClient,
>> the only thing this does is to make the proxy_lookup public so the
>> client don't have to maintain its how list only to be able to look
>> back when a proxy point to another, btw the reason proxy_new is not
>> enough is because it may lead to extra calls when the user application
>> may just want to bail out if the proxy is not found.
>
> Still not convinced. What kind of application would this. This seems to
> be all half thought trough. I am really failing to see the real purpose
> here. Either you go all the way with ObjectManager and do it the right
> way or you don't have an object manager, then you need to manually
> trigger the get all properties.

Im actually using these functions in an upcoming patch:

static void register_player(GDBusProxy *proxy)
{
...
client = g_dbus_proxy_get_client(proxy);

if (!g_dbus_proxy_get_property(proxy, "Device", &iter))
    return;

dbus_message_iter_get_basic(&iter, &path);

device = g_dbus_client_get_proxy(client, path, "org.bluez.Device1");
if (device == NULL)
    return;

if (!g_dbus_proxy_get_property(device, "Name", &iter))
    return;
...
static void proxy_added(GDBusProxy *proxy, void *user_data)
{
...
    } else if (!strcmp(interface, BLUEZ_MEDIA_PLAYER_INTERFACE)) {
         printf("Bluetooth Player %s found\n", g_dbus_proxy_get_path(proxy));
         register_player(proxy);
   }
...

With this I don't have to keep any list of found devices what so ever,
if I need a proxy I can just query it via g_dbus_client_get_proxy. Now
compare this to what bluetoothctl does:

static void proxy_added(GDBusProxy *proxy, void *user_data)
{
...
    if (!strcmp(interface, "org.bluez.Device1")) {
        if (device_is_child(proxy, default_ctrl) == TRUE) {
            dev_list = g_list_append(dev_list, proxy);

            print_device(proxy, "NEW");
    } else if (!strcmp(interface, "org.bluez.Adapter1")) {
            ctrl_list = g_list_append(ctrl_list, proxy);

            if (!default_ctrl)
                default_ctrl = proxy;

             print_adapter(proxy, "NEW");
...

So you are keeping the list of proxies while GDBusClient keeps them
too, now it maybe useful for bluetoothctl but for mpris-tool it is
completely useless, why would I keep a proxy of a device that doesn't
contain any player, specially while discovering devices this would
just populate with useless temporary devices.

Btw, with these functions we could actually have the following changes
to device_is_child:

diff --git a/client/main.c b/client/main.c
index 9a927a8..1cd6d10 100644
--- a/client/main.c
+++ b/client/main.c
@@ -224,8 +224,10 @@ static void print_uuids(GDBusProxy *proxy)

 static gboolean device_is_child(GDBusProxy *device, GDBusProxy *master)
 {
+       GDBusClient *client;
+       GDBusProxy *proxy;
        DBusMessageIter iter;
-       const char *adapter, *path;
+       const char *path;

        if (!master)
                return FALSE;
@@ -233,13 +235,13 @@ static gboolean device_is_child(GDBusProxy
*device, GDBusProxy *master)
        if (g_dbus_proxy_get_property(device, "Adapter", &iter) == FALSE)
                return FALSE;

-       dbus_message_iter_get_basic(&iter, &adapter);
-       path = g_dbus_proxy_get_path(master);
+       dbus_message_iter_get_basic(&iter, &path);

-       if (!strcmp(path, adapter))
-               return TRUE;
+       client = g_dbus_proxy_get_client(device);

-       return FALSE;
+       proxy = g_dbus_client_get_proxy(client, path, "org.bluez.Adapter1");
+
+       return proxy == master ? TRUE : FALSE;
 }

So we compare the proxies not the path alone.

--
Luiz Augusto von Dentz
