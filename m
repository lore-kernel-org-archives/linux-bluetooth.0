Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 10/28] android/hog: Add helper to create uhid device
Date: Wed,  1 Apr 2015 18:40:26 +0200
Message-Id: <1427906444-11769-11-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
References: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves the code responsible for creation of uhid device
into separate function. This improves code readability.
---
 android/hog.c | 82 ++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 47 insertions(+), 35 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index 5b93cb5..ac8c819 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -666,15 +666,57 @@ static char *item2string(char *str, const uint8_t *buf, uint8_t len)
 	return str;
 }
 
+static bool uhid_create(struct bt_hog *hog, const uint8_t *value, uint16_t vlen)
+{
+	struct uhid_event ev;
+	int err;
+	GError *gerr = NULL;
+
+	/* create uHID device */
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_CREATE;
+
+	bt_io_get(g_attrib_get_channel(hog->attrib), &gerr,
+			BT_IO_OPT_SOURCE, ev.u.create.phys,
+			BT_IO_OPT_DEST, ev.u.create.uniq,
+			BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("Failed to connection details: %s", gerr->message);
+		g_error_free(gerr);
+		return false;
+	}
+
+	strcpy((char *) ev.u.create.name, hog->name);
+	ev.u.create.vendor = hog->vendor;
+	ev.u.create.product = hog->product;
+	ev.u.create.version = hog->version;
+	ev.u.create.country = hog->bcountrycode;
+	ev.u.create.bus = BUS_BLUETOOTH;
+	ev.u.create.rd_data = (uint8_t *) value;
+	ev.u.create.rd_size = vlen;
+
+	err = bt_uhid_send(hog->uhid, &ev);
+	if (err < 0) {
+		error("bt_uhid_send: %s", strerror(-err));
+		return false;
+	}
+
+	bt_uhid_register(hog->uhid, UHID_OUTPUT, forward_report, hog);
+	bt_uhid_register(hog->uhid, UHID_FEATURE, get_feature, hog);
+	bt_uhid_register(hog->uhid, UHID_GET_REPORT, get_report, hog);
+	bt_uhid_register(hog->uhid, UHID_SET_REPORT, set_report, hog);
+
+	return true;
+}
+
 static void report_map_read_cb(bool success, uint8_t att_ecode,
 					const uint8_t *value, uint16_t vlen,
 					void *user_data)
 {
 	struct bt_hog *hog = user_data;
-	struct uhid_event ev;
+
 	char itemstr[20]; /* 5x3 (data) + 4 (continuation) + 1 (null) */
-	int i, err;
-	GError *gerr = NULL;
+	int i;
 
 	if (!success) {
 		error("Report Map read failed: %s", att_ecode2str(att_ecode));
@@ -704,39 +746,9 @@ static void report_map_read_cb(bool success, uint8_t att_ecode,
 		}
 	}
 
-	/* create uHID device */
-	memset(&ev, 0, sizeof(ev));
-	ev.type = UHID_CREATE;
-
-	bt_io_get(g_attrib_get_channel(hog->attrib), &gerr,
-			BT_IO_OPT_SOURCE, ev.u.create.phys,
-			BT_IO_OPT_DEST, ev.u.create.uniq,
-			BT_IO_OPT_INVALID);
-	if (gerr) {
-		error("Failed to connection details: %s", gerr->message);
-		g_error_free(gerr);
+	/* TODO Error handling */
+	if (!uhid_create(hog, value, vlen))
 		return;
-	}
-
-	strcpy((char *) ev.u.create.name, hog->name);
-	ev.u.create.vendor = hog->vendor;
-	ev.u.create.product = hog->product;
-	ev.u.create.version = hog->version;
-	ev.u.create.country = hog->bcountrycode;
-	ev.u.create.bus = BUS_BLUETOOTH;
-	ev.u.create.rd_data = (uint8_t *) value;
-	ev.u.create.rd_size = vlen;
-
-	err = bt_uhid_send(hog->uhid, &ev);
-	if (err < 0) {
-		error("bt_uhid_send: %s", strerror(-err));
-		return;
-	}
-
-	bt_uhid_register(hog->uhid, UHID_OUTPUT, forward_report, hog);
-	bt_uhid_register(hog->uhid, UHID_FEATURE, get_feature, hog);
-	bt_uhid_register(hog->uhid, UHID_GET_REPORT, get_report, hog);
-	bt_uhid_register(hog->uhid, UHID_SET_REPORT, set_report, hog);
 }
 
 static void info_read_cb(bool success, uint8_t status, const uint8_t *value,
-- 
1.9.1

