Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 BlueZ 2/3] thermometer: Fix handling of missing Temperature Type
Date: Wed, 15 Feb 2012 08:38:18 -0400
Message-Id: <1329309499-14454-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1329309499-14454-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1329241945-32414-1-git-send-email-anderson.lizardo@openbossa.org>
 <1329309499-14454-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to HTS 1.0 (Table 3.1, and Sections 3.1.1.4 and 3.2), the
Temperature Type Characteristic is optional. The only restriction is
that it shall not be present if the Temperature Type is non-static, for
which case the "Temperature Type" field shall be present on the
Temperature Measurement Characteristic value.

Given there is no default value specified when the Temperature Type is
static and unknown, the "Type" entry for MeasurementReceived() on the
Thermometer API was made optional.
---
 doc/thermometer-api.txt   |    3 ++-
 test/test-thermometer     |    3 ++-
 thermometer/thermometer.c |   11 +++--------
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/doc/thermometer-api.txt b/doc/thermometer-api.txt
index 6392d39..2271270 100644
--- a/doc/thermometer-api.txt
+++ b/doc/thermometer-api.txt
@@ -103,7 +103,8 @@ Methods		void MeasurementReceived(dict measure)
 			data. The time value is expressed in seconds since epoch.
 			The value represented is (mantissa) x (10**exponent)
 			See foot note for special values when treating with
-			health devices.
+			health devices. The Type entry is only present if the
+			measurement type is known. Otherwise, it is undefined.
 
 			Dict is defined as below:
 			{
diff --git a/test/test-thermometer b/test/test-thermometer
index 5f9742a..bf3b83e 100755
--- a/test/test-thermometer
+++ b/test/test-thermometer
@@ -24,7 +24,8 @@ class Watcher(dbus.service.Object):
 		if measure.has_key("Time"):
 			print "Time: ", measure["Time"]
 
-		print "Type: ", measure["Type"]
+		if measure.has_key("Type"):
+			print "Type: ", measure["Type"]
 
 def property_changed(name, value):
 
diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 9bf9881..7aa621f 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -1086,15 +1086,10 @@ static void proc_measurement(struct thermometer *t, const uint8_t *pdu,
 		type = temptype2str(pdu[index]);
 	} else if (t->has_type)
 		type = temptype2str(t->type);
-	else {
-		DBG("Can't get temperature type");
-		return;
-	}
-
-	if (type == NULL)
-		return;
+	else
+		type = NULL;
 
-	m.type = g_strdup(type);
+	m.type = type ? g_strdup(type) : NULL;
 	m.value = final ? "Final" : "Intermediate";
 
 	recv_measurement(t, &m);
-- 
1.7.5.4

