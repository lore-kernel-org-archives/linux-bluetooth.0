Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 08/15] thermometer: Change string properties to lower-case
Date: Mon, 1 Oct 2012 11:23:50 +0200
Message-ID: <1349083437-23528-9-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1349083437-23528-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1349083437-23528-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/thermometer-api.txt            | 10 +++++-----
 profiles/thermometer/thermometer.c | 26 +++++++++++++-------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/doc/thermometer-api.txt b/doc/thermometer-api.txt
index 0fb28f5..7ae161c 100644
--- a/doc/thermometer-api.txt
+++ b/doc/thermometer-api.txt
@@ -116,7 +116,7 @@ Methods		void MeasurementReceived(dict measurement)
 
 				string Unit:
 
-					Possible values: "Celsius" or "Fahrenheit"
+					Possible values: "celsius" or "fahrenheit"
 
 				uint64 Time (optional):
 
@@ -127,10 +127,10 @@ Methods		void MeasurementReceived(dict measurement)
 
 					Only present if measurement type is known.
 
-					Possible values: "Armpit", "Body", "Ear",
-						"Finger", "Intestines", "Mouth",
-						"Rectum", "Toe", "Tympanum"
+					Possible values: "armpit", "body", "ear",
+						"finger", "intestines", "mouth",
+						"rectum", "toe", "tympanum"
 
 				string Measurement:
 
-					Possible values: "Final" or "Intermediate"
+					Possible values: "final" or "intermediate"
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index f0c1d67..6b5faa2 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -120,15 +120,15 @@ static GSList *thermometer_adapters = NULL;
 
 const char *temp_type[] = {
 	"<reserved>",
-	"Armpit",
-	"Body",
-	"Ear",
-	"Finger",
-	"Intestines",
-	"Mouth",
-	"Rectum",
-	"Toe",
-	"Tympanum"
+	"armpit",
+	"body",
+	"ear",
+	"finger",
+	"intestines",
+	"mouth",
+	"rectum",
+	"toe",
+	"tympanum"
 };
 
 static const gchar *temptype2str(uint8_t value)
@@ -1070,7 +1070,7 @@ static void recv_measurement(struct thermometer *t, struct measurement *m)
 
 	m->t = t;
 
-	if (g_strcmp0(m->value, "Intermediate") == 0)
+	if (g_strcmp0(m->value, "intermediate") == 0)
 		wlist = t->tadapter->iwatchers;
 	else
 		wlist = t->tadapter->fwatchers;
@@ -1093,9 +1093,9 @@ static void proc_measurement(struct thermometer *t, const uint8_t *pdu,
 
 	flags = pdu[3];
 	if (flags & TEMP_UNITS)
-		m.unit = "Fahrenheit";
+		m.unit = "fahrenheit";
 	else
-		m.unit = "Celsius";
+		m.unit = "celsius";
 
 	if (len < 8) {
 		DBG("Temperature measurement value is not provided");
@@ -1153,7 +1153,7 @@ static void proc_measurement(struct thermometer *t, const uint8_t *pdu,
 		type = NULL;
 
 	m.type = type ? g_strdup(type) : NULL;
-	m.value = final ? "Final" : "Intermediate";
+	m.value = final ? "final" : "intermediate";
 
 	recv_measurement(t, &m);
 	g_free(m.type);
-- 
1.7.11.3

