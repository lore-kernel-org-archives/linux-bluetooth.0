Return-Path: <SRS0=2Kq+=ZE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E7DC43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 13:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9861D2084E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 13:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKLNK1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:10:27 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:10738 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfKLNK1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Nov 2019 08:10:27 -0500
Received: from [10.2.7.65] (81.89.61.168.host.vnet.sk [81.89.61.168])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 47C7QT0TVMz5tl9
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2019 14:10:25 +0100 (CET)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 1/2] core/advertising: Fix crash when unregistering
 advertisement too fast
To:     linux-bluetooth@vger.kernel.org
References: <157250771818414>
Organization: StreamUnlimited
Message-ID: <cf18270c-aa9f-fe32-ada8-fdf825246840@streamunlimited.com>
Date:   Tue, 12 Nov 2019 14:10:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <157250771818414>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When advertisement is unregistered during MGMT_OP_ADD_ADVERTISING it will
crash in add_adv_callback because struct btd_adv_client no longer exist.

This is seen also in debug log from bluetoothd:
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

Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
src/advertising.c | 34 ++++++++++++++++++++++++++--------
1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 3ed1376..f53c14c 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -73,6 +73,7 @@ struct btd_adv_client {
uint16_t discoverable_to;
unsigned int to_id;
unsigned int disc_to_id;
+ unsigned int add_adv_id;
GDBusClient *client;
GDBusProxy *proxy;
DBusMessage *reg;
@@ -117,6 +118,15 @@ static void client_free(void *data)
g_dbus_client_unref(client->client);
}
+ if (client->reg) {
+ g_dbus_send_message(btd_get_dbus_connection(),
+ dbus_message_new_method_return(client->reg));
+ dbus_message_unref(client->reg);
+ }
+
+ if (client->add_adv_id)
+ mgmt_cancel(client->manager->mgmt, client->add_adv_id);
+
if (client->instance)
util_clear_uid(&client->manager->instance_bitmap,
client->instance);
@@ -765,7 +775,8 @@ static uint8_t *generate_scan_rsp(struct 
btd_adv_client *client,
return bt_ad_generate(client->scan, len);
}
-static int refresh_adv(struct btd_adv_client *client, 
mgmt_request_func_t func)
+static int refresh_adv(struct btd_adv_client *client, 
mgmt_request_func_t func,
+ unsigned int *mgmt_id)
{
struct mgmt_cp_add_advertising *cp;
uint8_t param_len;
@@ -774,6 +785,7 @@ static int refresh_adv(struct btd_adv_client 
*client, mgmt_request_func_t func)
uint8_t *scan_rsp;
size_t scan_rsp_len = -1;
uint32_t flags = 0;
+ unsigned int mgmt_ret;
DBG("Refreshing advertisement: %s", client->path);
@@ -822,13 +834,17 @@ static int refresh_adv(struct btd_adv_client 
*client, mgmt_request_func_t func)
free(adv_data);
free(scan_rsp);
- if (!mgmt_send(client->manager->mgmt, MGMT_OP_ADD_ADVERTISING,
- client->manager->mgmt_index, param_len, cp,
- func, client, NULL)) {
+ mgmt_ret = mgmt_send(client->manager->mgmt, MGMT_OP_ADD_ADVERTISING,
+ client->manager->mgmt_index, param_len, cp,
+ func, client, NULL);
+
+ if (!mgmt_ret) {
error("Failed to add Advertising Data");
free(cp);
return -EINVAL;
}
+ if (mgmt_id)
+ *mgmt_id = mgmt_ret;
free(cp);
@@ -845,7 +861,7 @@ static gboolean client_discoverable_timeout(void 
*user_data)
bt_ad_clear_flags(client->data);
- refresh_adv(client, NULL);
+ refresh_adv(client, NULL, NULL);
return FALSE;
}
@@ -948,7 +964,7 @@ static void properties_changed(GDBusProxy *proxy, 
const char *name,
continue;
if (parser->func(iter, client)) {
- refresh_adv(client, NULL);
+ refresh_adv(client, NULL, NULL);
break;
}
}
@@ -980,6 +996,8 @@ static void add_adv_callback(uint8_t status, 
uint16_t length,
struct btd_adv_client *client = user_data;
const struct mgmt_rp_add_advertising *rp = param;
+ client->add_adv_id = 0;
+
if (status)
goto done;
@@ -1059,7 +1077,7 @@ static DBusMessage *parse_advertisement(struct 
btd_adv_client *client)
goto fail;
}
- err = refresh_adv(client, add_adv_callback);
+ err = refresh_adv(client, add_adv_callback, &client->add_adv_id);
if (!err)
return NULL;
@@ -1449,7 +1467,7 @@ void btd_adv_manager_destroy(struct 
btd_adv_manager *manager)
static void manager_refresh(void *data, void *user_data)
{
- refresh_adv(data, user_data);
+ refresh_adv(data, user_data, NULL);
}
void btd_adv_manager_refresh(struct btd_adv_manager *manager)

-- 
2.7.4

