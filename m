Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: [PATCH 3/4] hog: implement get_report functionality
Date: Fri, 21 Nov 2014 15:41:45 +0100
Message-Id: <1416580906-22134-4-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1416580906-22134-1-git-send-email-dh.herrmann@gmail.com>
References: <1416580906-22134-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

When UHID_GET_REPORT is received, hog has to update the current value
of the report and send it back to the caller.

This function should be synchronous, so the answer is sent in
get_report_cb().

(David: Track reports and cancel them on uhid timeouts. Otherwise, we'd
        incorrectly match reponses. Also fix "feature"->"get" typos and
        handle reports without IDs)
---
 profiles/input/hog.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index de7e583..25672a0 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -90,6 +90,8 @@ struct hog_device {
 	uint16_t		proto_mode_handle;
 	uint16_t		ctrlpt_handle;
 	uint8_t			flags;
+	guint			getrep_att;
+	uint16_t		getrep_id;
 };
 
 struct report {
@@ -385,6 +387,89 @@ static void forward_report(struct uhid_event *ev, void *user_data)
 						data, size, NULL, NULL);
 }
 
+static void get_report_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	struct hog_device *hogdev = user_data;
+	struct uhid_event rsp;
+	int err;
+
+	hogdev->getrep_att = 0;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.type = UHID_GET_REPORT_REPLY;
+	rsp.u.get_report_reply.id = hogdev->getrep_id;
+
+	if (status != 0) {
+		error("Error reading Report value: %s", att_ecode2str(status));
+		goto exit;
+	}
+
+	if (len <= 0) {
+		error("Error reading Report, length %d", len);
+		status = EIO;
+		goto exit;
+	}
+
+	if (pdu[0] != 0x0b) {
+		error("Error reading Report, invalid response: %02x", pdu[0]);
+		status = EPROTO;
+		goto exit;
+	}
+
+	--len;
+	++pdu;
+	if (hogdev->has_report_id && len > 0) {
+		--len;
+		++pdu;
+	}
+
+	rsp.u.get_report_reply.size = len;
+	memcpy(rsp.u.get_report_reply.data, pdu, len);
+
+exit:
+	rsp.u.get_report_reply.err = status;
+	err = bt_uhid_send(hogdev->uhid, &rsp);
+	if (err < 0)
+		error("bt_uhid_send: %s", strerror(-err));
+}
+
+static void get_report(struct uhid_event *ev, void *user_data)
+{
+	struct hog_device *hogdev = user_data;
+	struct report *report;
+	guint8 err;
+
+	/* uhid never sends reqs in parallel; if there's a req, it timed out */
+	if (hogdev->getrep_att) {
+		g_attrib_cancel(hogdev->attrib, hogdev->getrep_att);
+		hogdev->getrep_att = 0;
+	}
+
+	hogdev->getrep_id = ev->u.get_report.id;
+
+	report = find_report(hogdev, ev->u.get_report.rtype,
+							ev->u.get_report.rnum);
+	if (!report) {
+		err = ENOTSUP;
+		goto fail;
+	}
+
+	hogdev->getrep_att = gatt_read_char(hogdev->attrib,
+						report->decl->value_handle,
+						get_report_cb, hogdev);
+	if (!hogdev->getrep_att) {
+		err = ENOMEM;
+		goto fail;
+	}
+
+	return;
+
+fail:
+	/* cancel the request on failure */
+	get_report_cb(err, NULL, 0, hogdev);
+}
+
 static bool get_descriptor_item_info(uint8_t *buf, ssize_t blen, ssize_t *len,
 								bool *is_long)
 {
@@ -525,6 +610,7 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	}
 
 	bt_uhid_register(hogdev->uhid, UHID_OUTPUT, forward_report, hogdev);
+	bt_uhid_register(hogdev->uhid, UHID_GET_REPORT, get_report, hogdev);
 }
 
 static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
-- 
2.1.3
