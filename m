Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 01/10] ATT: Avoid invalid memory access for large PDU
Date: Wed, 20 Jun 2012 14:27:43 -0300
Message-Id: <1340213272-2853-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1340213272-2853-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1340213272-2853-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch avoids invalid memory access when decoding ATT read response
PDUs. The ATT_MTU value is a per ATT Bearer value defined by the higher
layer specification.
---
 attrib/att.c              |   17 +++++++++--------
 attrib/att.h              |    2 +-
 attrib/gatttool.c         |    7 +++++--
 attrib/interactive.c      |    6 ++++--
 deviceinfo/deviceinfo.c   |    5 +++--
 proximity/monitor.c       |    7 ++++---
 thermometer/thermometer.c |   15 +++++++++------
 7 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index c8e2e1d..0550ac1 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -681,22 +681,23 @@ uint16_t enc_read_blob_resp(uint8_t *value, int vlen, uint16_t offset,
 	return vlen + 1;
 }
 
-uint16_t dec_read_resp(const uint8_t *pdu, int len, uint8_t *value, int *vlen)
+ssize_t dec_read_resp(const uint8_t *pdu, int len, uint8_t *value, int vlen)
 {
 	if (pdu == NULL)
-		return 0;
+		return -EINVAL;
 
-	if (value == NULL || vlen == NULL)
-		return 0;
+	if (value == NULL)
+		return -EINVAL;
 
 	if (pdu[0] != ATT_OP_READ_RESP)
-		return 0;
+		return -EINVAL;
 
-	memcpy(value, pdu + 1, len - 1);
+	if (vlen < (len - 1))
+		return -ENOBUFS;
 
-	*vlen = len - 1;
+	memcpy(value, pdu + 1, len - 1);
 
-	return len;
+	return len - 1;
 }
 
 uint16_t enc_error_resp(uint8_t opcode, uint16_t handle, uint8_t status,
diff --git a/attrib/att.h b/attrib/att.h
index 144513f..1c1102a 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -234,7 +234,7 @@ uint16_t dec_read_blob_req(const uint8_t *pdu, int len, uint16_t *handle,
 uint16_t enc_read_resp(uint8_t *value, int vlen, uint8_t *pdu, int len);
 uint16_t enc_read_blob_resp(uint8_t *value, int vlen, uint16_t offset,
 							uint8_t *pdu, int len);
-uint16_t dec_read_resp(const uint8_t *pdu, int len, uint8_t *value, int *vlen);
+ssize_t dec_read_resp(const uint8_t *pdu, int len, uint8_t *value, int vlen);
 uint16_t enc_error_resp(uint8_t opcode, uint16_t handle, uint8_t status,
 							uint8_t *pdu, int len);
 uint16_t enc_find_info_req(uint16_t start, uint16_t end, uint8_t *pdu, int len);
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 8a43ec1..c70b1d6 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -227,14 +227,17 @@ static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
 	uint8_t value[ATT_MAX_MTU];
-	int i, vlen;
+	ssize_t vlen;
+	int i;
 
 	if (status != 0) {
 		g_printerr("Characteristic value/descriptor read failed: %s\n",
 							att_ecode2str(status));
 		goto done;
 	}
-	if (!dec_read_resp(pdu, plen, value, &vlen)) {
+
+	vlen = dec_read_resp(pdu, plen, value, sizeof(value));
+	if (vlen < 0) {
 		g_printerr("Protocol error\n");
 		goto done;
 	}
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 0a01cdf..1cdbfef 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -275,7 +275,8 @@ static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
 	uint8_t value[ATT_MAX_MTU];
-	int i, vlen;
+	ssize_t vlen;
+	int i;
 
 	if (status != 0) {
 		printf("Characteristic value/descriptor read failed: %s\n",
@@ -283,7 +284,8 @@ static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		return;
 	}
 
-	if (!dec_read_resp(pdu, plen, value, &vlen)) {
+	vlen = dec_read_resp(pdu, plen, value, sizeof(value));
+	if (vlen < 0) {
 		printf("Protocol error\n");
 		return;
 	}
diff --git a/deviceinfo/deviceinfo.c b/deviceinfo/deviceinfo.c
index 8c3af93..41fc3fc 100644
--- a/deviceinfo/deviceinfo.c
+++ b/deviceinfo/deviceinfo.c
@@ -85,14 +85,15 @@ static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
 {
 	struct characteristic *ch = user_data;
 	uint8_t value[ATT_MAX_MTU];
-	int vlen;
+	ssize_t vlen;
 
 	if (status != 0) {
 		error("Error reading PNP_ID value: %s", att_ecode2str(status));
 		return;
 	}
 
-	if (!dec_read_resp(pdu, len, value, &vlen)) {
+	vlen = dec_read_resp(pdu, len, value, sizeof(value));
+	if (vlen < 0) {
 		error("Error reading PNP_ID: Protocol error");
 		return;
 	}
diff --git a/proximity/monitor.c b/proximity/monitor.c
index 98dbcd1..2645321 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -212,20 +212,21 @@ static void tx_power_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
 	uint8_t value[ATT_MAX_MTU];
-	int vlen;
+	ssize_t vlen;
 
 	if (status != 0) {
 		DBG("Tx Power Level read failed: %s", att_ecode2str(status));
 		return;
 	}
 
-	if (!dec_read_resp(pdu, plen, value, &vlen)) {
+	vlen = dec_read_resp(pdu, plen, value, sizeof(value));
+	if (vlen < 0) {
 		DBG("Protocol error");
 		return;
 	}
 
 	if (vlen != 1) {
-		DBG("Invalid length for TX Power value: %d", vlen);
+		DBG("Invalid length for TX Power value: %zd", vlen);
 		return;
 	}
 
diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 85f0811..4a44177 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -299,7 +299,7 @@ static void valid_range_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 	struct descriptor *desc = user_data;
 	uint8_t value[ATT_MAX_MTU];
 	uint16_t max, min;
-	int vlen;
+	ssize_t vlen;
 
 	if (status != 0) {
 		DBG("Valid Range descriptor read failed: %s",
@@ -307,7 +307,8 @@ static void valid_range_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 		return;
 	}
 
-	if (!dec_read_resp(pdu, len, value, &vlen)) {
+	vlen = dec_read_resp(pdu, len, value, sizeof(value));
+	if (vlen < 0) {
 		DBG("Protocol error\n");
 		return;
 	}
@@ -443,7 +444,7 @@ static void read_temp_type_cb(guint8 status, const guint8 *pdu, guint16 len,
 	struct characteristic *ch = user_data;
 	struct thermometer *t = ch->t;
 	uint8_t value[ATT_MAX_MTU];
-	int vlen;
+	ssize_t vlen;
 
 	if (status != 0) {
 		DBG("Temperature Type value read failed: %s",
@@ -451,7 +452,8 @@ static void read_temp_type_cb(guint8 status, const guint8 *pdu, guint16 len,
 		return;
 	}
 
-	if (!dec_read_resp(pdu, len, value, &vlen)) {
+	vlen = dec_read_resp(pdu, len, value, sizeof(value));
+	if (vlen < 0) {
 		DBG("Protocol error.");
 		return;
 	}
@@ -471,7 +473,7 @@ static void read_interval_cb(guint8 status, const guint8 *pdu, guint16 len,
 	struct characteristic *ch = user_data;
 	uint8_t value[ATT_MAX_MTU];
 	uint16_t interval;
-	int vlen;
+	ssize_t vlen;
 
 	if (status != 0) {
 		DBG("Measurement Interval value read failed: %s",
@@ -479,7 +481,8 @@ static void read_interval_cb(guint8 status, const guint8 *pdu, guint16 len,
 		return;
 	}
 
-	if (!dec_read_resp(pdu, len, value, &vlen)) {
+	vlen = dec_read_resp(pdu, len, value, sizeof(value));
+	if (vlen < 0) {
 		DBG("Protocol error\n");
 		return;
 	}
-- 
1.7.8.6

