Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, rshaffer@codeaurora.org,
	Brian Gix <bgix@codeaurora.org>
Subject: [PATCH 1/1] Support for reading long Characteristic Values.
Date: Mon, 13 Dec 2010 09:24:26 -0800
Message-Id: <1292261066-28100-3-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1292261066-28100-1-git-send-email-bgix@codeaurora.org>
References: <1292261066-28100-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Modify existing gatt_read_char() function support the reading of 
attributes (specifically Characteristic Values) that are longer than
the MTU would otherwise allow.  When a result to an ATT_OP_READ_REQ
is received, it will be passed to the requester as always if the total
result was shorter than the Default MTU (23). Any results equal to or
longer will cause a series of READ_BLOB requests to be made, with the
additional results built up until the end of the Attribute is detected.
The full result will then be passed to the original requester.

The end of the Attribute is detected by either a successful result to
the READ_BLOB request that is shorter than the Default MTU, or by an
error result that indicates that a read is being attempted beyond the
length of the attribute, or that the Attribute wasn't "Long".

This patch is dependant on the earlier patch:
0001-Implempent-READ_BLOB-encoding-for-ATT.patch

The packet composed conforms to the Bluetooth Core v4.0 specification.

Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 

---
 attrib/gatt.c |  114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index bca8b49..d888f1d 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -97,15 +97,125 @@ guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
 					pdu, plen, func, user_data, NULL);
 }
 
+struct read_long_data {
+	GAttrib *attrib;
+	GAttribResultFunc func;
+	gpointer user_data;
+	guint8 *result_data;
+	guint16 result_len;
+	guint16 handle;
+};
+
+static void read_blob_helper(guint8 status, const guint8 *res_pdu,
+					guint16 res_len, gpointer user_data)
+{
+	struct read_long_data *long_read = user_data;
+	uint8_t pdu[ATT_DEFAULT_MTU];
+	guint8 *tmp;
+	guint16 plen;
+	guint ret_val;
+
+	if (status == ATT_ECODE_ATTR_NOT_LONG ||
+	    status == ATT_ECODE_INVALID_OFFSET) {
+		status = 0;
+		goto done;
+	}
+
+	if (status != 0 || res_len == 1)
+		goto done;
+
+	tmp = g_try_realloc(long_read->result_data,
+			    	long_read->result_len + res_len - 1);
+
+	if (tmp == NULL) {
+		status = ATT_ECODE_INSUFF_RESOURCES;
+		goto done;
+	}
+
+	memcpy(&tmp[long_read->result_len], &res_pdu[1], res_len-1);
+	long_read->result_data = tmp;
+	long_read->result_len += res_len-1;
+
+	if (res_len < ATT_DEFAULT_MTU)
+		goto done;
+
+	plen = enc_read_blob_req(long_read->handle, long_read->result_len-1,
+			 				pdu, sizeof(pdu));
+	ret_val = g_attrib_send(long_read->attrib, ATT_OP_READ_BLOB_REQ, pdu,
+				plen, read_blob_helper, long_read, NULL);
+
+	if (ret_val != 0)
+		return;
+
+	status = ATT_ECODE_INSUFF_RESOURCES;
+
+done:
+	long_read->func(status, long_read->result_data, long_read->result_len,
+							long_read->user_data);
+	g_free(long_read->result_data);
+	g_free(long_read);
+}
+
+static void read_char_helper(guint8 status, const guint8 *res_pdu,
+					guint16 res_len, gpointer user_data)
+{
+	struct read_long_data *long_read = user_data;
+	uint8_t pdu[ATT_DEFAULT_MTU];
+	guint16 plen;
+	guint ret_val;
+
+	if (status != 0 || res_len < ATT_DEFAULT_MTU)
+		goto done;
+
+	long_read->result_data = g_malloc(res_len);
+
+	if (long_read->result_data == NULL)
+		goto done;
+
+	memcpy(long_read->result_data, res_pdu, res_len);
+	long_read->result_len = res_len;
+
+	plen = enc_read_blob_req(long_read->handle, res_len-1, pdu,
+				 				sizeof(pdu));
+	ret_val = g_attrib_send(long_read->attrib, ATT_OP_READ_BLOB_REQ,
+			pdu, plen, read_blob_helper, long_read, NULL);
+
+	if (ret_val != 0)
+		return;
+
+	status = ATT_ECODE_INSUFF_RESOURCES;
+
+done:
+	long_read->func(status, res_pdu, res_len, long_read->user_data);
+	g_free(long_read);
+}
+
 guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
 							gpointer user_data)
 {
 	uint8_t pdu[ATT_DEFAULT_MTU];
 	guint16 plen;
+	guint ret_val;
+	struct read_long_data *long_read;
+
+	long_read = g_try_new0(struct read_long_data, 1);
+
+	if (long_read == NULL)
+		return 0;
+
+	long_read->attrib = attrib;
+	long_read->func = func;
+	long_read->user_data = user_data;
+	long_read->handle = handle;
 
 	plen = enc_read_req(handle, pdu, sizeof(pdu));
-	return g_attrib_send(attrib, ATT_OP_READ_REQ, pdu, plen, func,
-							user_data, NULL);
+	ret_val = g_attrib_send(attrib, ATT_OP_READ_REQ, pdu, plen,
+			     		read_char_helper, long_read, NULL);
+
+	if (ret_val == 0)
+		g_free(long_read);
+
+	return ret_val;
 }
 
 guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
-- 
1.7.1

