Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v4] doc/adapter-api.txt: StartFilteredDiscovery method.
Date: Wed, 17 Dec 2014 22:12:47 +0100
Message-Id: <1418850767-31602-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch proposes new method, StartFilteredDiscovery to D-Bus Adapter
API for desktop bluetoothd. It will allow for rapid discovery of nearby
devices that advertise services.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 doc/adapter-api.txt | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 74d235a..7e688ef 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -22,6 +22,40 @@ Methods		void StartDiscovery()
 			Possible errors: org.bluez.Error.NotReady
 					 org.bluez.Error.Failed
 
+		void StartFilteredDiscovery(dict filter, string transport)
+
+			This method starts the device discovery session with
+			filtering by uuids, and rssi or pathloss value. Use
+			StopDiscovery to release the sessions acquired.
+
+			transport parameter:
+				"auto"	- interleaved scan, default value
+				"bredr"	- br/edr inquiry
+				"le"	- le only scan
+
+ 			Parameters that can be set in filter dictionary include
+ 			the following:
+
+			array{string} UUIDs : filtered service UUIDs (required)
+			int16 RSSI	: RSSI threshold value (optional)
+			uint16 pathloss	: Pathloss threshold value (optional)
+
+			When a device is found that advertise any UUID from
+			UUIDs, it will be reported if:
+			- pathloss and RSSI are both empty,
+			- only pathloss param is set, device advertise TX pwer, 
+			  and computed pathloss is less than pathloss param,
+			- only RSSI param is set, and received RSSI is higher
+			  than RSSI param,
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
2.1.0

