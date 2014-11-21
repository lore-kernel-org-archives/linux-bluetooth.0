Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: [PATCH 4/4] hog: implement set_report functionality
Date: Fri, 21 Nov 2014 15:41:46 +0100
Message-Id: <1416580906-22134-5-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1416580906-22134-1-git-send-email-dh.herrmann@gmail.com>
References: <1416580906-22134-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

When UHID_SET_REPORT is received, hog has to send the given value
of the report to the device and send back the error code to the caller.

This function has to be synchronous, so the answer is sent in
set_report_cb().

(David: Track reports and cancel them on timeouts. Also fix some
        "get"->"set" typos.)
---
 profiles/input/hog.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 25672a0..41da9f9 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -92,6 +92,8 @@ struct hog_device {
 	uint8_t			flags;
 	guint			getrep_att;
 	uint16_t		getrep_id;
+	guint			setrep_att;
+	uint16_t		setrep_id;
 };
 
 struct report {
@@ -387,6 +389,79 @@ static void forward_report(struct uhid_event *ev, void *user_data)
 						data, size, NULL, NULL);
 }
 
+static void set_report_cb(guint8 status, const guint8 *pdu,
+					guint16 plen, gpointer user_data)
+{
+	struct hog_device *hogdev = user_data;
+	struct uhid_event rsp;
+	int err;
+
+	hogdev->setrep_att = 0;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.type = UHID_SET_REPORT_REPLY;
+	rsp.u.set_report_reply.id = hogdev->setrep_id;
+	rsp.u.set_report_reply.err = status;
+
+	if (status != 0)
+		error("Error setting Report value: %s", att_ecode2str(status));
+
+	err = bt_uhid_send(hogdev->uhid, &rsp);
+	if (err < 0)
+		error("bt_uhid_send: %s", strerror(-err));
+}
+
+static void set_report(struct uhid_event *ev, void *user_data)
+{
+	struct hog_device *hogdev = user_data;
+	struct report *report;
+	void *data;
+	int size;
+	int err;
+
+	/* uhid never sends reqs in parallel; if there's a req, it timed out */
+	if (hogdev->setrep_att) {
+		g_attrib_cancel(hogdev->attrib, hogdev->setrep_att);
+		hogdev->setrep_att = 0;
+	}
+
+	hogdev->setrep_id = ev->u.set_report.id;
+
+	report = find_report(hogdev, ev->u.set_report.rtype,
+							ev->u.set_report.rnum);
+	if (!report) {
+		err = ENOTSUP;
+		goto fail;
+	}
+
+	data = ev->u.set_report.data;
+	size = ev->u.set_report.size;
+	if (hogdev->has_report_id && size > 0) {
+		data++;
+		--size;
+	}
+
+	DBG("Sending report type %d ID %d to handle 0x%X", report->type,
+				report->id, report->decl->value_handle);
+
+	if (hogdev->attrib == NULL)
+		return;
+
+	hogdev->setrep_att = gatt_write_char(hogdev->attrib,
+						report->decl->value_handle,
+						data, size, set_report_cb,
+						hogdev);
+	if (!hogdev->setrep_att) {
+		err = ENOMEM;
+		goto fail;
+	}
+
+	return;
+fail:
+	/* cancel the request on failure */
+	set_report_cb(err, NULL, 0, hogdev);
+}
+
 static void get_report_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
@@ -610,6 +685,7 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	}
 
 	bt_uhid_register(hogdev->uhid, UHID_OUTPUT, forward_report, hogdev);
+	bt_uhid_register(hogdev->uhid, UHID_SET_REPORT, set_report, hogdev);
 	bt_uhid_register(hogdev->uhid, UHID_GET_REPORT, get_report, hogdev);
 }
 
-- 
2.1.3
