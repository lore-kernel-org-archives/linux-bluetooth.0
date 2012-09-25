Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 11/14] thermometer: Refactor processing of measurement characteristic value
Date: Tue, 25 Sep 2012 16:52:40 +0200
Message-ID: <1348584763-22824-12-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Data buffer is read by simply moving buffer pointer instead of calculating
indexes of consecutive fields. This makes function flow easier to follow
as there's no need to care about presence of fields prior to current when
reading data.
---
 profiles/thermometer/thermometer.c | 66 +++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 29d5e02..f42ab7d 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -1021,27 +1021,37 @@ static void proc_measurement(struct thermometer *t, const uint8_t *pdu,
 						uint16_t len, gboolean final)
 {
 	struct measurement m;
-	const char *type;
+	const char *type = NULL;
 	uint8_t flags;
 	uint32_t raw;
 
-	if (len < 4) {
+	/* skip opcode and handle */
+	pdu += 3;
+	len -= 3;
+
+	if (len < 1) {
 		DBG("Mandatory flags are not provided");
 		return;
 	}
 
-	flags = pdu[3];
+	flags = *pdu;
+
 	if (flags & TEMP_UNITS)
 		m.unit = "Fahrenheit";
 	else
 		m.unit = "Celsius";
 
-	if (len < 8) {
-		DBG("Temperature measurement value is not provided");
+	pdu++;
+	len--;
+
+	if (len < 4) {
+		DBG("Mandatory temperature measurement value is not provided");
 		return;
 	}
 
-	raw = att_get_u32(&pdu[4]);
+	memset(&m, 0, sizeof(m));
+
+	raw = att_get_u32(pdu);
 	m.mant = raw & 0x00FFFFFF;
 	m.exp = ((int32_t) raw) >> 24;
 
@@ -1050,48 +1060,46 @@ static void proc_measurement(struct thermometer *t, const uint8_t *pdu,
 		m.mant = m.mant - FLOAT_MAX_MANTISSA;
 	}
 
+	pdu += 4;
+	len -= 4;
+
 	if (flags & TEMP_TIME_STAMP) {
 		struct tm ts;
 		time_t time;
 
-		if (len < 15) {
-			DBG("Can't get time stamp value");
+		if (len < 7) {
+			DBG("Time stamp is not provided");
 			return;
 		}
 
-		ts.tm_year = att_get_u16(&pdu[8]) - 1900;
-		ts.tm_mon = pdu[10] - 1;
-		ts.tm_mday = pdu[11];
-		ts.tm_hour = pdu[12];
-		ts.tm_min = pdu[13];
-		ts.tm_sec = pdu[14];
+		ts.tm_year = att_get_u16(pdu) - 1900;
+		ts.tm_mon = *(pdu + 2) - 1;
+		ts.tm_mday = *(pdu + 3);
+		ts.tm_hour = *(pdu + 4);
+		ts.tm_min = *(pdu + 5);
+		ts.tm_sec = *(pdu + 6);
 		ts.tm_isdst = -1;
 
 		time = mktime(&ts);
 		m.time = (uint64_t) time;
 		m.suptime = TRUE;
-	} else
-		m.suptime = FALSE;
+
+		pdu += 7;
+		len -= 7;
+	}
 
 	if (flags & TEMP_TYPE) {
-		uint8_t index;
-
-		if (m.suptime && len >= 16)
-			index = 15;
-		else if (!m.suptime && len >= 9)
-			index = 9;
-		else {
-			DBG("Can't get temperature type");
+		if (len < 1) {
+			DBG("Temperature type is not provided");
 			return;
 		}
 
-		type = temptype2str(pdu[index]);
-	} else if (t->has_type)
+		type = temptype2str(*pdu);
+	} else if (t->has_type) {
 		type = temptype2str(t->type);
-	else
-		type = NULL;
+	}
 
-	m.type = type ? g_strdup(type) : NULL;
+	m.type = g_strdup(type);
 	m.value = final ? "Final" : "Intermediate";
 
 	recv_measurement(t, &m);
-- 
1.7.11.3

