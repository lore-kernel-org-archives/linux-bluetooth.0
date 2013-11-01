Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] android/hal-hidhost: Add implemention of .hid_info_cb
Date: Fri,  1 Nov 2013 15:08:40 +0200
Message-Id: <1383311321-28429-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1383311321-28429-1-git-send-email-luiz.dentz@gmail.com>
References: <1383311321-28429-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-hidhost.c | 22 ++++++++++++++++++++++
 android/hal-msg.h     | 14 ++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index e148dc2..c20c785 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -40,6 +40,25 @@ static void handle_conn_state(void *buf)
 								ev->state);
 }
 
+static void handle_info(void *buf)
+{
+	struct hal_ev_hid_info *ev = buf;
+	bthh_hid_info_t info;
+
+	info.attr_mask = ev->attr;
+	info.sub_class = ev->subclass;
+	info.app_id = ev->app_id;
+	info.vendor_id = ev->vendor;
+	info.product_id = ev->product;
+	info.version = ev->version;
+	info.ctry_code = ev->country;
+	info.dl_len = ev->descr_len;
+	memcpy(info.dsc_list, ev->descr, info.dl_len);
+
+	if (bt_hh_cbacks->hid_info_cb)
+		bt_hh_cbacks->hid_info_cb((bt_bdaddr_t *) ev->bdaddr, info);
+}
+
 /* will be called from notification thread context */
 void bt_notify_hh(uint16_t opcode, void *buf, uint16_t len)
 {
@@ -50,6 +69,9 @@ void bt_notify_hh(uint16_t opcode, void *buf, uint16_t len)
 	case HAL_EV_HID_CONN_STATE:
 		handle_conn_state(buf);
 		break;
+	case HAL_EV_HID_INFO:
+		handle_info(buf);
+		break;
 	default:
 		DBG("Unhandled callback opcode=0x%x", opcode);
 		break;
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 8a344d8..9276a2f 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -439,6 +439,20 @@ struct hal_ev_hid_conn_state {
 	uint8_t state;
 } __attribute__((packed));
 
+#define HAL_EV_HID_INFO			0x82
+struct hal_ev_hid_info {
+	uint8_t bdaddr[6];
+	uint8_t attr;
+	uint8_t subclass;
+	uint8_t app_id;
+	uint16_t vendor;
+	uint16_t product;
+	uint16_t version;
+	uint8_t country;
+	uint16_t descr_len;
+	uint8_t descr[884];
+} __attribute__((packed));
+
 #define HAL_EV_AV_CONNECTION_STATE	0x81
 struct hal_ev_av_connection_state {
 	uint8_t state;
-- 
1.8.3.1

