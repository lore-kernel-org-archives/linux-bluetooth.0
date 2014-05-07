Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, szymon.janc@tieto.com,
	andrzej.kaczmarek@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/2] doc: Introduce Start/Stop Connection Monitor
Date: Wed,  7 May 2014 16:17:13 +0200
Message-Id: <1399472233-19056-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1399472233-19056-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1399472233-19056-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduce device method to start and stop connection monitor
and two new device properties ConnectionRSSI and ConnectionTXPower which
are tracked when monitor is active
---
 doc/device-api.txt | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 7a301d3..9e7296e 100644
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
@@ -193,3 +221,23 @@ Properties	string Address [readonly]
 
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
+		int16 ConnectionTXPower [readonly, optional]
+
+			Transmit power level to the remote device on the existing
+			connection
+
+			This property is present only if at least one connection
+			monitor session is active.
-- 
1.8.4

