Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v3 07/15] thermometer: Reformat MeasurementReceived description
Date: Tue, 9 Oct 2012 13:19:50 +0200
Message-ID: <1349781598-22580-8-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1349781598-22580-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1349781598-22580-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

MeasurementReceived method description is reformatted to be more
readable and consistent with other API documents.

Special values for Exponent and Mantissa fields specify now only NaN
value as this is only special value defined by HTS specification for
measurement.
---
 doc/thermometer-api.txt | 76 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 30 deletions(-)

diff --git a/doc/thermometer-api.txt b/doc/thermometer-api.txt
index 1828811..a1da2e6 100644
--- a/doc/thermometer-api.txt
+++ b/doc/thermometer-api.txt
@@ -97,33 +97,49 @@ Service		unique name
 Interface	org.bluez.ThermometerWatcher
 Object path	freely definable
 
-Methods		void MeasurementReceived(dict measure)
-
-			This callback gets called when a measure has been
-			scanned	in the thermometer. The Time entry in the dict
-			will be only present if the device supports storing of
-			data. The time value is expressed in seconds since epoch.
-			The value represented is (mantissa) x (10**exponent)
-			See foot note for special values when treating with
-			health devices. The Type entry is only present if the
-			measurement type is known. Otherwise, it is undefined.
-
-			Dict is defined as below:
-			{
-				"Exponent" : int8,
-				"Mantissa" : int32,
-				"Unit" : ("Celsius" or "Fahrenheit"),
-				"Time" : uint64,
-				"Type" : ("Armpit", "Body", "Ear", "Finger",
-					"Intestines", "Mouth", "Rectum", "Toe",
-					"Tympanum"),
-				"Measurement" : ("Final" or "Intermediate"),
-			}
-
-			For special cases, the exponent shall always be zero and
-			the mantissa should be one of following values:
-
-			NRes = -(2**23)
-			NaN = +(2**23-1)
-			INFINITY = (2**23-2)
-			-INFINITY = -(2**23-2)
+Methods		void MeasurementReceived(dict measurement)
+
+			This callback gets called when a measurement has been
+			scanned in the thermometer.
+
+			Measurement:
+
+				int16 Exponent:
+				int32 Mantissa:
+
+					Exponent and Mantissa values as
+					extracted from float value defined by
+					IEEE-11073-20601.
+
+					Measurement value is calculated as
+					(Mantissa) * (10^Exponent)
+
+					For special cases Exponent is set to 0
+					and Mantissa is set to one of following
+					values:
+
+					+(2^23 - 1)	NaN (invalid or missing data)
+					-(2^23)		NRes
+					+(2^23 - 2)	+Infinity
+					-(2^23 - 2)	-Infinity
+
+				string Unit:
+
+					Possible values: "Celsius" or "Fahrenheit"
+
+				uint64 Time (optional):
+
+					Time of measurement, if supported by device.
+					Expressed in seconds since epoch.
+
+				string Type (optional):
+
+					Only present if measurement type is known.
+
+					Possible values: "Armpit", "Body", "Ear",
+						"Finger", "Intestines", "Mouth",
+						"Rectum", "Toe", "Tympanum"
+
+				string Measurement:
+
+					Possible values: "Final" or "Intermediate"
-- 
1.7.11.3

