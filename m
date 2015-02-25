Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] core/device: Set Local/Remote CSRK
Date: Wed, 25 Feb 2015 15:42:12 +0200
Message-Id: <1424871733-14610-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1424871733-14610-1-git-send-email-luiz.dentz@gmail.com>
References: <1424871733-14610-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This set Local/Remote CSRK as keys to bt_att so it can use for signed
writes.
---
 src/device.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/src/device.c b/src/device.c
index bef1f0c..a801bb3 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4012,6 +4012,30 @@ static void gatt_server_init(struct btd_device *device, struct gatt_db *db)
 		error("Failed to initialize bt_gatt_server");
 }
 
+static bool local_counter(uint32_t *sign_cnt, void *user_data)
+{
+	struct btd_device *dev = user_data;
+
+	if (!dev->local_csrk)
+		return false;
+
+	*sign_cnt = dev->local_csrk->counter++;
+
+	return true;
+}
+
+static bool remote_counter(uint32_t *sign_cnt, void *user_data)
+{
+	struct btd_device *dev = user_data;
+
+	if (!dev->remote_csrk || *sign_cnt < dev->remote_csrk->counter)
+		return false;
+
+	dev->remote_csrk->counter = *sign_cnt;
+
+	return true;
+}
+
 bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 {
 	GError *gerr = NULL;
@@ -4061,6 +4085,14 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 						att_disconnected_cb, dev, NULL);
 	bt_att_set_close_on_unref(dev->att, true);
 
+	if (dev->local_csrk)
+		bt_att_set_local_key(dev->att, dev->local_csrk->key,
+							local_counter, dev);
+
+	if (dev->remote_csrk)
+		bt_att_set_remote_key(dev->att, dev->remote_csrk->key,
+							remote_counter, dev);
+
 	database = btd_adapter_get_database(dev->adapter);
 
 	gatt_client_init(dev);
-- 
2.1.0

