Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Biman Paul <biman.paul@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Biman Paul <biman.paul@samsung.com>,
        Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 1/2] gatttool: add prepare write request
Date: Fri, 07 Jul 2017 20:04:01 +0530
Message-id: <1499438042-4741-1-git-send-email-biman.paul@samsung.com>
References: <CGME20170707142624epcas1p1acf47103a81eb92fe612a1d2ab4bf55a@epcas1p1.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some PTS testcase explicitly require to send prepare
write request with offset and number of bytes to be
written less than mtu size.

Currently, gatttool implicitly converts a write request
to prepare write request if data size more than mtu size.
But it cannot send prepare write request if data size is
less than mtu size.
---
 attrib/gatt.c        |   26 ++++++++++++++++++++
 attrib/interactive.c |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++
 attrib/utils.c       |   17 +++++++++++++
 3 files changed, 109 insertions(+)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 480f874..b674623 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -946,6 +946,32 @@ static guint prepare_write(struct write_long_data *long_write)
 									NULL);
 }
 
+guint gatt_write_long(GAttrib *attrib, uint16_t handle,
+		uint16_t offset, const uint8_t *value,
+		size_t vlen, GAttribResultFunc func, gpointer user_data)
+{
+	uint8_t *buf;
+	size_t buflen;
+	struct write_long_data *long_write;
+
+	buf = g_attrib_get_buffer(attrib, &buflen);
+
+	/* Write Long Characteristic Values */
+	long_write = g_try_new0(struct write_long_data, 1);
+	if (long_write == NULL)
+		return 0;
+
+	long_write->attrib = attrib;
+	long_write->func = func;
+	long_write->user_data = user_data;
+	long_write->handle = handle;
+	long_write->offset = offset;
+	long_write->value = g_memdup(value, vlen);
+	long_write->vlen = vlen;
+
+	return prepare_write(long_write);
+}
+
 guint gatt_write_char(GAttrib *attrib, uint16_t handle, const uint8_t *value,
 			size_t vlen, GAttribResultFunc func, gpointer user_data)
 {
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 7d4786a..12ed148 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -457,6 +457,19 @@ static int strtohandle(const char *src)
 	return dst;
 }
 
+static int strtooffset(const char *src)
+{
+	char *e;
+	int dst;
+
+	errno = 0;
+	dst = strtoll(src, &e, 10);
+	if (errno != 0 || *e != '\0')
+		return -EINVAL;
+
+	return dst;
+}
+
 static void cmd_included(int argcp, char **argvp)
 {
 	int start = 0x0001;
@@ -637,6 +650,57 @@ static void char_write_req_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	rl_printf("Characteristic value was written successfully\n");
 }
 
+static void cmd_queued_write(int argcp, char **argvp)
+{
+	uint8_t *value;
+	size_t plen;
+	int handle;
+	int offset = 0;
+
+	if (conn_state != STATE_CONNECTED) {
+		failed("Disconnected\n");
+		return;
+	}
+
+	if (argcp < 3 || argcp > 4) {
+		rl_printf("Usage: %s <handle> <new value> [offest]\n",
+							argvp[0]);
+		return;
+	}
+
+	handle = strtohandle(argvp[1]);
+	if (handle <= 0) {
+		error("A valid handle is required\n");
+		return;
+	}
+
+	plen = gatt_attr_data_from_string(argvp[2], &value);
+	if (plen == 0) {
+		error("Invalid value\n");
+		return;
+	}
+
+	if (argcp >= 4) {
+		offset = strtooffset(argvp[3]);
+		if (offset < 0) {
+			error("A valid offset is required\n");
+			g_free(value);
+			return;
+		}
+
+		plen = gatt_attr_data_offset_padding(offset, plen, &value);
+		if (plen == 0) {
+			error("Invalid value\n");
+			g_free(value);
+			return;
+		}
+	}
+
+	gatt_write_long(attrib, handle, offset, value, plen,
+				char_write_req_cb, NULL);
+	g_free(value);
+}
+
 static void cmd_char_write(int argcp, char **argvp)
 {
 	uint8_t *value;
@@ -802,6 +866,8 @@ static struct {
 		"Characteristics Value/Descriptor Read by UUID" },
 	{ "char-write-req",	cmd_char_write,	"<handle> <new value>",
 		"Characteristic Value Write (Write Request)" },
+	{ "char-prep-write",	cmd_queued_write, "<handle> <value> [offset]",
+		"Characteristic Value Long Write (Write Request)" },
 	{ "char-write-cmd",	cmd_char_write,	"<handle> <new value>",
 		"Characteristic Value Write (No response)" },
 	{ "sec-level",		cmd_sec_level,	"[low | medium | high]",
diff --git a/attrib/utils.c b/attrib/utils.c
index 8e2fc1a..af6682d 100644
--- a/attrib/utils.c
+++ b/attrib/utils.c
@@ -120,3 +120,20 @@ size_t gatt_attr_data_from_string(const char *str, uint8_t **data)
 
 	return size;
 }
+
+size_t gatt_attr_data_offset_padding(size_t offset, size_t len, uint8_t **data)
+{
+	size_t size;
+	uint8_t *temp;
+
+	size = offset + len;
+	temp = g_try_malloc0(size);
+	if (temp == NULL)
+		return 0;
+
+	memcpy(temp + offset, *data, len);
+	g_free(*data);
+	*data = temp;
+
+	return size;
+}
-- 
1.7.9.5

