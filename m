Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 2/2] doc: Introduce Start/Stop Connection Monitor
Date: Thu,  8 May 2014 12:31:17 +0200
Message-Id: <1399545077-9344-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1399545077-9344-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1399545077-9344-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces device method to start and stop connection monitor
and two new device properties ConnectionRSSI, ConnectionTXPower and
ConnectionTXPowerMax.

ConnectionRSSI and ConnectionTXPower  are tracked when monitor is active
---
 doc/device-api.txt | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 7a301d3..0b44417 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -100,6 +100,34 @@ Methods		void Connect()
 			Possible errors: org.bluez.Error.DoesNotExist
 					 org.bluez.Error.Failed
 
+
+		void StartConnectionMonitor()
+
+			This method starts connection monitor session.
+
+			This method enables connection information tracking.
+			E.g. ConnectionRSSI, ConnectionTXPower.
+
+			Use StopConnectionMonitor to release session.
+
+			Possible errors: org.bluez.Error.NotReady
+					 org.bluez.Error.Failed
+					 org.bluez.Error.NotConnected
+					 org.bluez.Error.NotSupported
+
+		void StopConnectionMonitor()
+
+			This method stops previous StartConnectionMonitor
+			session.
+
+			Note that connection monitor is shared between all
+			monitor sessions thus calling StopConnectionMonitor
+			releases a single session.
+
+			Possible errors: org.bluez.Error.Failed
+					 org.bluez.Error.NotReady
+					 org.bluez.Error.NotAuthorized
+
 Properties	string Address [readonly]
 
 			The Bluetooth device address of the remote device.
@@ -193,3 +221,26 @@ Properties	string Address [readonly]
 
 			Received Signal Strength Indicator (inquiry) of the remote
 			device.
+
+		int16 ConnectionRSSI [readonly, optional]
+
+			Received Signal Strength Indicator of connected remote
+			device.
+
+			This property is present only if at least one connection
+			monitor session is active.
+
+			Note that RSSI has different units for BR/EDR (dB)
+			and LE (dBm) as specified in BT Core ver. 4.1, Vol. 2,
+			Part E, Chapter 7.5.4
+
+		int16 ConnectionTXPowerMax [readonly, optional]
+
+			Maximum transmit power level to connected remote device.
+
+		int16 ConnectionTXPower [readonly, optional]
+
+			Transmit power level to connected remote device.
+
+			This property is present only if at least one connection
+			monitor session is active.
-- 
1.8.4

