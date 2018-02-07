Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Matt Schulte <schultetwin1@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Matt Schulte <schultetwin1@gmail.com>
Subject: [PATCH BlueZ] advertising: only parse adv from adv interfaces
Date: Tue,  6 Feb 2018 23:48:56 -0800
Message-Id: <20180207074856.14603-1-schultetwin1@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

client_proxy_added is called for every interface on an object passed in
to the dbus RegisterAdvertisement method. This can cause a NULL
dereference to occur and a failure status in the reply on dbus
RegisterAdvertisement method calls. The fix is to return early from
client_proxy_added if the proxy interface is not
org.bluez.LEAdvertisement1. If this early return is not there, two
different error paths could occur.

1) client_proxy_added is first called with the
org.bluez.LEAdvertisement1 interface and then with another interface.
The second call will fail the parse_advertisement call and possibly
cause a NULL dereference on the dbus_message_unref if
add_client_complete has already occurred.

2) client_proxy_added is first called with an unknown interface and then
org.bluez.LEAdvertisement1. The first call will cause
parse_advertisement to fail and a failure to be replied to the client
calling RegisterAdvertisement. The advertisement may be successfully
registered on the second client_proxy_added call but a NULL dereference
will occur on the call to dbus_message_new_method_return in
add_client_complete.
---
 src/advertising.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index 94a8c4050..b4cb00e72 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -776,6 +776,11 @@ static void client_proxy_added(GDBusProxy *proxy, void *data)
 {
 	struct btd_adv_client *client = data;
 	DBusMessage *reply;
+	const char *interface;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+	if (g_str_equal(interface, LE_ADVERTISEMENT_IFACE) == FALSE)
+		return;
 
 	reply = parse_advertisement(client);
 	if (!reply)
-- 
2.16.1

