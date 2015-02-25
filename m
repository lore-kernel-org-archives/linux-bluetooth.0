Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v7] doc/adapter-api.txt: StartFilteredDiscovery method.
Date: Tue, 24 Feb 2015 16:29:04 -0800
Message-Id: <1424824144-10711-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch proposes new method, StartFilteredDiscovery to D-Bus Adapter
API for desktop bluetoothd. It will allow for rapid discovery of nearby
devices that advertise services.

It also adds FilteredDiscovery property, that is set to true when any
StartFilteredDiscovery session is active.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 doc/adapter-api.txt | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 74d235a..4a67bbd 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -22,6 +22,45 @@ Methods		void StartDiscovery()
 			Possible errors: org.bluez.Error.NotReady
 					 org.bluez.Error.Failed
 
+		void StartFilteredDiscovery(dict filter) [Experimental]
+
+			This method starts the device discovery session with
+			filtering by uuids, and rssi or pathloss value. Use
+			StopDiscovery to release the sessions acquired.
+
+			Parameters that can be set in filter dictionary include
+			the following:
+
+			array{string} UUIDs : filtered service UUIDs (required)
+			int16 RSSI	: RSSI threshold value (optional)
+			uint16 pathloss	: Pathloss threshold value (optional)
+			string transport: type of scan to run
+
+			When a device is found that advertise any UUID from
+			UUIDs, it will be reported if:
+			- pathloss and RSSI are both empty,
+			- only pathloss param is set, device advertise TX pwer,
+			  and computed pathloss is less than pathloss param,
+			- only RSSI param is set, and received RSSI is higher
+			  than RSSI param,
+
+			transport parameter determines the type of scan:
+				"auto"	- interleaved scan
+				"bredr"	- br/edr inquiry
+				"le"	- le only scan, default value
+
+			This process will start creating Device objects as new
+			devices matching criteria are discovered. It will also
+			emit PropertiesChanged signal for already existing
+			Device objects, with updated RSSI value. This is
+			different from StartDiscovery behaviour, that keeps
+			imposing the delta-threshold, but as soon as there's
+			one or more StartFilteredDiscovery active this type of
+			filtering is removed.
+
+			Possible errors: org.bluez.Error.NotReady
+					 org.bluez.Error.Failed
+
 		void StopDiscovery()
 
 			This method will cancel any previous StartDiscovery
-- 
2.2.0.rc0.207.ga3a616c

