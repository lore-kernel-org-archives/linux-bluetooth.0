Return-Path: <SRS0=A2wO=YY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DEECA9EC3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Oct 2019 09:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641062083E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Oct 2019 09:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfJaJFG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Oct 2019 05:05:06 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:40859 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbfJaJFF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Oct 2019 05:05:05 -0400
Received: from [10.2.1.174] (81.89.61.168.host.vnet.sk [81.89.61.168])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 473fXw22RLz5tlC
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Oct 2019 10:05:04 +0100 (CET)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] core/advertising: Fix crash when advertisement is
 unregistered while MGMT ADD_ADVERTISEMENT call
To:     linux-bluetooth@vger.kernel.org
Organization: StreamUnlimited
Message-ID: <b81c7de0-fbd5-1bc4-3d9c-3fe16082d3e0@streamunlimited.com>
Date:   Thu, 31 Oct 2019 10:05:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is debug output of bluetoothd when crashed:
bluetoothd[29698]: src/advertising.c:register_advertisement() 
RegisterAdvertisement
bluetoothd[29698]: src/advertising.c:client_create() Adding proxy for 
/org/bluez/example/advertisement0
bluetoothd[29698]: src/advertising.c:register_advertisement() Registered 
advertisement at path /org/bluez/example/advertisement0
bluetoothd[29698]: src/advertising.c:parse_service_uuids() Adding 
ServiceUUID: 180D
bluetoothd[29698]: src/advertising.c:parse_service_uuids() Adding 
ServiceUUID: 180F
bluetoothd[29698]: src/advertising.c:parse_manufacturer_data() Adding 
ManufacturerData for ffff
bluetoothd[29698]: src/advertising.c:parse_service_data() Adding 
ServiceData for 9999
bluetoothd[29698]: src/advertising.c:parse_data() Adding Data for type 
0x26 len 3
bluetoothd[29698]: src/advertising.c:refresh_adv() Refreshing 
advertisement: /org/bluez/example/advertisement0
bluetoothd[29698]: src/advertising.c:unregister_advertisement() 
UnregisterAdvertisement
bluetoothd[29698]: src/advertising.c:add_adv_callback() Advertisement 
registered: �
Segmentation fault (core dumped)
---
src/advertising.c | 53 +++++++++++++++++++++++++++++------------------------
1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 3ed1376..7d8cadf 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -63,6 +63,8 @@ struct btd_adv_manager {
#define AD_TYPE_PERIPHERAL 1
struct btd_adv_client {
+ int ref_count;
+
struct btd_adv_manager *manager;
char *owner;
char *path;
@@ -136,13 +138,6 @@ static void client_free(void *data)
free(client);
}
-static gboolean client_free_idle_cb(void *data)
-{
- client_free(data);
-
- return FALSE;
-}
-
static void client_release(void *data)
{
struct btd_adv_client *client = data;
@@ -175,12 +170,19 @@ static void remove_advertising(struct 
btd_adv_manager *manager,
manager->mgmt_index, sizeof(cp), &cp, NULL, NULL, NULL);
}
-static void client_remove(void *data)
+static struct btd_adv_client *client_ref(struct btd_adv_client *client)
+{
+ __sync_fetch_and_add(&client->ref_count, 1);
+
+ return client;
+}
+
+static void client_unref(struct btd_adv_client *client)
{
- struct btd_adv_client *client = data;
struct mgmt_cp_remove_advertising cp;
- g_dbus_client_set_disconnect_watch(client->client, NULL, NULL);
+ if (__sync_sub_and_fetch(&client->ref_count, 1))
+ return;
cp.instance = client->instance;
@@ -188,10 +190,6 @@ static void client_remove(void *data)
client->manager->mgmt_index, sizeof(cp), &cp,
NULL, NULL, NULL);
- queue_remove(client->manager->clients, client);
-
- g_idle_add(client_free_idle_cb, client);
-
g_dbus_emit_property_changed(btd_get_dbus_connection(),
adapter_get_path(client->manager->adapter),
LE_ADVERTISING_MGR_IFACE, "SupportedInstances");
@@ -199,13 +197,18 @@ static void client_remove(void *data)
g_dbus_emit_property_changed(btd_get_dbus_connection(),
adapter_get_path(client->manager->adapter),
LE_ADVERTISING_MGR_IFACE, "ActiveInstances");
+
+ queue_remove(client->manager->clients, client);
+
+ client_free(client);
+
}
static void client_disconnect_cb(DBusConnection *conn, void *user_data)
{
DBG("Client disconnected");
- client_remove(user_data);
+ client_unref(user_data);
}
static bool parse_type(DBusMessageIter *iter, struct btd_adv_client *client)
@@ -564,7 +567,7 @@ static gboolean client_timeout(void *user_data)
client->to_id = 0;
client_release(client);
- client_remove(client);
+ client_unref(client);
return FALSE;
}
@@ -963,8 +966,6 @@ static void add_client_complete(struct 
btd_adv_client *client, uint8_t status)
mgmt_errstr(status), status);
reply = btd_error_failed(client->reg,
"Failed to register advertisement");
- queue_remove(client->manager->clients, client);
- g_idle_add(client_free_idle_cb, client);
} else
reply = dbus_message_new_method_return(client->reg);
@@ -972,6 +973,8 @@ static void add_client_complete(struct 
btd_adv_client *client, uint8_t status)
g_dbus_send_message(btd_get_dbus_connection(), reply);
dbus_message_unref(client->reg);
client->reg = NULL;
+
+ client_unref(client);
}
static void add_adv_callback(uint8_t status, uint16_t length,
@@ -1060,8 +1063,11 @@ static DBusMessage *parse_advertisement(struct 
btd_adv_client *client)
}
err = refresh_adv(client, add_adv_callback);
- if (!err)
+ if (!err) {
+ /* Hold reference to client until add_adv_callback is finished */
+ client_ref(client);
return NULL;
+ }
fail:
return btd_error_failed(client->reg, "Failed to parse advertisement.");
@@ -1082,14 +1088,12 @@ static void client_proxy_added(GDBusProxy 
*proxy, void *data)
return;
/* Failed to publish for some reason, remove. */
- queue_remove(client->manager->clients, client);
-
- g_idle_add(client_free_idle_cb, client);
-
g_dbus_send_message(btd_get_dbus_connection(), reply);
dbus_message_unref(client->reg);
client->reg = NULL;
+
+ client_unref(client);
}
static struct btd_adv_client *client_create(struct btd_adv_manager *manager,
@@ -1189,6 +1193,7 @@ static DBusMessage 
*register_advertisement(DBusConnection *conn,
DBG("Registered advertisement at path %s", match.path);
queue_push_tail(manager->clients, client);
+ client_ref(client);
return NULL;
}
@@ -1218,7 +1223,7 @@ static DBusMessage 
*unregister_advertisement(DBusConnection *conn,
if (!client)
return btd_error_does_not_exist(msg);
- client_remove(client);
+ client_unref(client);
return dbus_message_new_method_return(msg);
}

-- 
2.7.4

