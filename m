Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/3] shared/gatt-client: Expose API to set/get security level on att
Date: Thu, 12 Feb 2015 18:00:07 +0100
Message-Id: <1423760408-31020-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1423760408-31020-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1423760408-31020-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/gatt-client.c | 17 +++++++++++++++++
 src/shared/gatt-client.h |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 293e0c2..d27354e 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2854,3 +2854,20 @@ bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 	complete_unregister_notify(notify_data);
 	return true;
 }
+
+bool bt_gatt_client_set_sec_level(struct bt_gatt_client *client,
+								int level)
+{
+	if (!client)
+		return false;
+
+	return bt_att_set_sec_level(client->att, level);
+}
+
+int bt_gatt_client_get_sec_level(struct bt_gatt_client *client)
+{
+	if (!client)
+		return -1;
+
+	return bt_att_get_sec_level(client->att);
+}
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 46eb207..4346386 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -128,3 +128,6 @@ unsigned int bt_gatt_client_register_notify(struct bt_gatt_client *client,
 				bt_gatt_client_destroy_func_t destroy);
 bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 							unsigned int id);
+
+bool bt_gatt_client_set_sec_level(struct bt_gatt_client *client, int level);
+int bt_gatt_client_get_sec_level(struct bt_gatt_client *client);
-- 
1.8.4

