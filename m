Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH] doc/adapter-api.txt: StartServiceDiscovery method.
Date: Mon,  8 Dec 2014 14:47:19 +0100
Message-Id: <1418046439-15725-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch proposes new method, StartServiceDiscovery to D-Bus Adapter API for
desktop bluetoothd. It will allow for rapid discovery of nearby devices that
advertise services.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 doc/adapter-api.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 74d235a..88533ed 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -22,6 +22,26 @@ Methods		void StartDiscovery()
 			Possible errors: org.bluez.Error.NotReady
 					 org.bluez.Error.Failed
 
+		void StartServiceDiscovery(uint8 rssi, array{string} uuids)
+
+			This method starts the device discovery session with
+			filtering by uuids, and rssi value. Use StopDiscovery to
+			release the sessions acquired.
+
+			This method will use LE scan only.
+
+			Device that have RSSI bigger than rssi parameter, and
+			advertise at least one service from uuids array, is
+			conseidered filter match.
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

