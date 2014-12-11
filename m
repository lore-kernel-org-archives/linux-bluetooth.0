Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v2] doc/adapter-api.txt: StartServiceDiscovery method.
Date: Thu, 11 Dec 2014 05:45:13 -0800
Message-Id: <1418305513-4327-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch proposes new method, StartServiceDiscovery to D-Bus Adapter API for
desktop bluetoothd. It will allow for rapid discovery of nearby devices that
advertise services.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 doc/adapter-api.txt | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 74d235a..198a35a 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -22,6 +22,44 @@ Methods		void StartDiscovery()
 			Possible errors: org.bluez.Error.NotReady
 					 org.bluez.Error.Failed
 
+		void StartServiceDiscovery(string mode, dict filter)
+
+			This method starts the device discovery session with
+			filtering by uuids, and rssi or pathloss value. Use
+			StopDiscovery to release the sessions acquired.
+
+			mode parameter:
+				"LE" - le only scan
+				"BR/EDR" - br/edr inquiry
+				"INTERLEAVED" - interleaved scan
+
+ 			Parameters that can be set in filter dictionary include
+ 			the following:
+
+				string UUID : filtered service UUID (required)
+				string RSSI : RSSI threshold value (optional)
+				string pathloss : Pathloss threshold value
+						    (optional)
+
+			When a device is found that advertise UUID, it will be
+			reported if:
+			- pathloss and RSSI are both empty
+			- only pathloss param is set, device advertise TX pwer, 
+			  and computed pathloss is less than pathloss param,
+			- only RSSI param is set, and received RSSI is higher
+			  than RSSI param,
+			- both pathloss and RSSI is set. Then if TX power is
+			  advertised, pathloss condition must be met, otherwise
+			  RSSI condition must be met.
+
+			This process will start creating Device objects as new
+			devices matching criteria are discovered. It will also
+			emit PropertiesChanged signal for already existing
+			Device objects, with updated RSSI value.
+
+			Possible errors: org.bluez.Error.NotReady
+					 org.bluez.Error.Failed
+
 		void StopDiscovery()
 
 			This method will cancel any previous StartDiscovery
-- 
2.2.0.rc0.207.ga3a616c

