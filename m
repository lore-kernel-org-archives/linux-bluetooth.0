Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] android/hog: Add support for UHID_FEATURE event
Date: Tue, 29 Jul 2014 14:12:45 +0300
Message-Id: <1406632365-21136-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1406632365-21136-1-git-send-email-luiz.dentz@gmail.com>
References: <1406632365-21136-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hog.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/android/hog.c b/android/hog.c
index 85a6982..09a16d5 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -439,6 +439,42 @@ static void forward_report(struct uhid_event *ev, void *user_data)
 						data, size, NULL, NULL);
 }
 
+static void get_report(struct uhid_event *ev, void *user_data)
+{
+	struct bt_hog *hog = user_data;
+	struct report *report;
+	GSList *l;
+	struct uhid_event rsp;
+	int err;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.type = UHID_FEATURE_ANSWER;
+	rsp.u.feature_answer.id = ev->u.feature.id;
+
+	l = g_slist_find_custom(hog->reports,
+				GUINT_TO_POINTER(ev->u.feature.rtype),
+				report_type_cmp);
+	if (!l) {
+		rsp.u.feature_answer.err = ENOTSUP;
+		goto done;
+	}
+
+	report = l->data;
+
+	if (!report->value) {
+		rsp.u.feature_answer.err = EIO;
+		goto done;
+	}
+
+	rsp.u.feature_answer.size = report->len;
+	memcpy(rsp.u.feature_answer.data, report->value, report->len);
+
+done:
+	err = bt_uhid_send(hog->uhid, &rsp);
+	if (err < 0)
+		error("bt_uhid_send: %s", strerror(-err));
+}
+
 static bool get_descriptor_item_info(uint8_t *buf, ssize_t blen, ssize_t *len,
 								bool *is_long)
 {
@@ -576,6 +612,7 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	}
 
 	bt_uhid_register(hog->uhid, UHID_OUTPUT, forward_report, hog);
+	bt_uhid_register(hog->uhid, UHID_FEATURE, get_report, hog);
 }
 
 static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
-- 
1.9.3

