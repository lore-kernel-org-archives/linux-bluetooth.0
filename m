Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
Cc: claudio.takahasi@openbossa.org, padovan@profusion.mobi,
	rshaffer@codeaurora.org, linux-bluetooth@vger.kernel.org,
	Brian Gix <bgix@codeaurora.org>
Subject: [PATCH 2/2] Fix gatt_read_char() to support long Attrib Values
Date: Tue,  4 Jan 2011 16:01:38 -0800
Message-Id: <1294185698-1499-3-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1294185698-1499-1-git-send-email-bgix@codeaurora.org>
References: <1294185698-1499-1-git-send-email-bgix@codeaurora.org>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix gatt_read_char() to support long Attribute Values by recognizing
	that results longer that 21 octets may include data beyond
	what has been returned with the first read. Extra data is
	obtained by issuing READ_BLOB requests until either a
	result is returned shorter than 22 octets, or an error
	is recieved indicating that no further data is available.
	The API for this function has not changed.
---
 attrib/gatt.c |  134 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 132 insertions(+), 2 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 320759f..304c2b1 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -97,15 +97,145 @@ guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
 					pdu, plen, func, user_data, NULL);
 }
 
+struct read_long_data {
+	GAttrib *attrib;
+	GAttribResultFunc func;
+	gpointer user_data;
+	guint8 *buffer;
+	guint16 size;
+	guint16 handle;
+	guint id;
+	guint8 ref;
+};
+
+static void read_long_destroy(gpointer user_data)
+{
+	struct read_long_data *long_read = user_data;
+
+	if (--long_read->ref)
+		return;
+
+	if (long_read->buffer != NULL)
+		g_free(long_read->buffer);
+
+	g_free(long_read);
+}
+
+static void read_blob_helper(guint8 status, const guint8 *rpdu, guint16 rlen,
+							gpointer user_data)
+{
+	struct read_long_data *long_read = user_data;
+	uint8_t pdu[ATT_DEFAULT_MTU];
+	guint8 *tmp;
+	guint16 plen;
+	guint id;
+
+	if (status == ATT_ECODE_ATTR_NOT_LONG ||
+					status == ATT_ECODE_INVALID_OFFSET) {
+		status = 0;
+		goto done;
+	}
+
+	if (status != 0 || rlen == 1)
+		goto done;
+
+	tmp = g_try_realloc(long_read->buffer, long_read->size + rlen - 1);
+
+	if (tmp == NULL) {
+		status = ATT_ECODE_INSUFF_RESOURCES;
+		goto done;
+	}
+
+	memcpy(&tmp[long_read->size], &rpdu[1], rlen - 1);
+	long_read->buffer = tmp;
+	long_read->size += rlen - 1;
+
+	if (rlen < ATT_DEFAULT_MTU)
+		goto done;
+
+	plen = enc_read_blob_req(long_read->handle, long_read->size - 1,
+							pdu, sizeof(pdu));
+	id = g_attrib_send(long_read->attrib, long_read->id,
+				ATT_OP_READ_BLOB_REQ, pdu, plen,
+				read_blob_helper, long_read, read_long_destroy);
+
+	if (id != 0) {
+		long_read->ref++;
+		return;
+	}
+
+	status = ATT_ECODE_IO;
+
+done:
+	long_read->func(status, long_read->buffer, long_read->size,
+							long_read->user_data);
+}
+
+static void read_char_helper(guint8 status, const guint8 *rpdu,
+					guint16 rlen, gpointer user_data)
+{
+	struct read_long_data *long_read = user_data;
+	uint8_t pdu[ATT_DEFAULT_MTU];
+	guint16 plen;
+	guint id;
+
+	if (status != 0 || rlen < ATT_DEFAULT_MTU)
+		goto done;
+
+	long_read->buffer = g_malloc(rlen);
+
+	if (long_read->buffer == NULL)
+		goto done;
+
+	memcpy(long_read->buffer, rpdu, rlen);
+	long_read->size = rlen;
+
+	plen = enc_read_blob_req(long_read->handle, rlen - 1, pdu, sizeof(pdu));
+	id = g_attrib_send(long_read->attrib, long_read->id,
+			ATT_OP_READ_BLOB_REQ, pdu, plen, read_blob_helper,
+			long_read, read_long_destroy);
+
+	if (id != 0) {
+		long_read->ref++;
+		return;
+	}
+
+	status = ATT_ECODE_IO;
+
+done:
+	long_read->func(status, rpdu, rlen, long_read->user_data);
+}
+
 guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
 							gpointer user_data)
 {
 	uint8_t pdu[ATT_DEFAULT_MTU];
 	guint16 plen;
+	guint id;
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
-	return g_attrib_send(attrib, 0, ATT_OP_READ_REQ, pdu, plen, func,
-							user_data, NULL);
+	id = g_attrib_send(attrib, 0, ATT_OP_READ_REQ, pdu, plen,
+				read_char_helper, long_read, read_long_destroy);
+
+	if (id == 0)
+		g_free(long_read);
+	else {
+		long_read->ref++;
+		long_read->id = id;
+	}
+
+	return id;
 }
 
 guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
-- 
1.7.1
-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
