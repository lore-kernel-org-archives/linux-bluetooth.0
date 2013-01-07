Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 BlueZ 3/5] input: Validate SDP HIDDescriptorList subattributes
Date: Mon,  7 Jan 2013 07:56:33 -0400
Message-Id: <1357559795-22090-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357559795-22090-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357559795-22090-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It should not be assumed that remote SDP attributes are in a compliant
format. This fixes a couple of invalid pointer access on invalid data.
---
 profiles/input/device.c |   60 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 14 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index eaf5681..1da9d99 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -222,6 +222,49 @@ static int create_hid_dev_name(sdp_record_t *rec, struct hidp_connadd_req *req)
 	return 0;
 }
 
+/* See HID profile specification v1.0, "7.11.6 HIDDescriptorList" for details
+ * on the attribute format. */
+static int extract_hid_desc_data(sdp_record_t *rec,
+						struct hidp_connadd_req *req)
+{
+	sdp_data_t *d;
+
+	d = sdp_data_get(rec, SDP_ATTR_HID_DESCRIPTOR_LIST);
+	if (!d)
+		goto invalid_desc;
+
+	if (!SDP_IS_SEQ(d->dtd))
+		goto invalid_desc;
+
+	/* First HIDDescriptor */
+	d = d->val.dataseq;
+	if (!SDP_IS_SEQ(d->dtd))
+		goto invalid_desc;
+
+	/* ClassDescriptorType */
+	d = d->val.dataseq;
+	if (d->dtd != SDP_UINT8)
+		goto invalid_desc;
+
+	/* ClassDescriptorData */
+	d = d->next;
+	if (!d || !SDP_IS_TEXT_STR(d->dtd))
+		goto invalid_desc;
+
+	req->rd_data = g_try_malloc0(d->unitSize);
+	if (req->rd_data) {
+		memcpy(req->rd_data, d->val.str, d->unitSize);
+		req->rd_size = d->unitSize;
+		epox_endian_quirk(req->rd_data, req->rd_size);
+	}
+
+	return 0;
+
+invalid_desc:
+	error("Missing or invalid HIDDescriptorList SDP attribute");
+	return -EINVAL;
+}
+
 static int extract_hid_record(sdp_record_t *rec, struct hidp_connadd_req *req)
 {
 	sdp_data_t *pdlist;
@@ -251,20 +294,9 @@ static int extract_hid_record(sdp_record_t *rec, struct hidp_connadd_req *req)
 	if (attr_val)
 		req->flags |= (1 << HIDP_BOOT_PROTOCOL_MODE);
 
-	pdlist = sdp_data_get(rec, SDP_ATTR_HID_DESCRIPTOR_LIST);
-	if (pdlist) {
-		pdlist = pdlist->val.dataseq;
-		pdlist = pdlist->val.dataseq;
-		pdlist = pdlist->next;
-
-		req->rd_data = g_try_malloc0(pdlist->unitSize);
-		if (req->rd_data) {
-			memcpy(req->rd_data, (unsigned char *) pdlist->val.str,
-								pdlist->unitSize);
-			req->rd_size = pdlist->unitSize;
-			epox_endian_quirk(req->rd_data, req->rd_size);
-		}
-	}
+	err = extract_hid_desc_data(rec, req);
+	if (err < 0)
+		return err;
 
 	return 0;
 }
-- 
1.7.9.5

