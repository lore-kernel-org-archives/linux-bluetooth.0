Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/12] android/dis: Add bt_dis_set_notification
Date: Tue, 24 Jun 2014 11:36:10 +0300
Message-Id: <1403598979-31032-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1403598979-31032-1-git-send-email-luiz.dentz@gmail.com>
References: <1403598979-31032-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Function bt_dis_set_notification can be used to set notify callback.
---
 android/dis.c | 21 +++++++++++++++++++++
 android/dis.h |  7 +++++++
 2 files changed, 28 insertions(+)

diff --git a/android/dis.c b/android/dis.c
index 7914293..3237c03 100644
--- a/android/dis.c
+++ b/android/dis.c
@@ -51,6 +51,8 @@ struct bt_dis {
 	GAttrib			*attrib;	/* GATT connection */
 	struct gatt_primary	*primary;	/* Primary details */
 	GSList			*chars;		/* Characteristics */
+	bt_dis_notify		notify;
+	void			*notify_data;
 };
 
 struct characteristic {
@@ -132,6 +134,13 @@ static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
 	dis->vendor = get_le16(&value[1]);
 	dis->product = get_le16(&value[3]);
 	dis->version = get_le16(&value[5]);
+
+	DBG("source: 0x%02X vendor: 0x%04X product: 0x%04X version: 0x%04X",
+			dis->source, dis->vendor, dis->product, dis->version);
+
+	if (dis->notify)
+		dis->notify(dis->source, dis->vendor, dis->product,
+						dis->version, dis->notify_data);
 }
 
 static void process_deviceinfo_char(struct characteristic *ch)
@@ -194,3 +203,15 @@ void bt_dis_detach(struct bt_dis *dis)
 	g_attrib_unref(dis->attrib);
 	dis->attrib = NULL;
 }
+
+bool bt_dis_set_notification(struct bt_dis *dis, bt_dis_notify func,
+							void *user_data)
+{
+	if (!dis)
+		return false;
+
+	dis->notify = func;
+	dis->notify_data = user_data;
+
+	return true;
+}
diff --git a/android/dis.h b/android/dis.h
index 6cc0b58..faf27b3 100644
--- a/android/dis.h
+++ b/android/dis.h
@@ -30,3 +30,10 @@ void bt_dis_unref(struct bt_dis *dis);
 
 bool bt_dis_attach(struct bt_dis *dis, void *gatt);
 void bt_dis_detach(struct bt_dis *dis);
+
+typedef void (*bt_dis_notify) (uint8_t source, uint16_t vendor,
+					uint16_t product, uint16_t version,
+					void *user_data);
+
+bool bt_dis_set_notification(struct bt_dis *dis, bt_dis_notify func,
+							void *user_data);
-- 
1.9.3

