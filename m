Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <marcel@holtmann.org>, Lukasz Rymanowski
	<lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/9] doc: Introduce connection monitoring API
Date: Tue, 27 May 2014 09:52:43 +0200
Message-ID: <1401177171-19994-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401177171-19994-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401177171-19994-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>

This patch introduces API to monitor connection parameters.

New device properties are introduced: ConnectionRSSI, ConnectionTXPower
and ConnectionTXPowerMax.

Client can request to poll for updates of RSSI and TX power via Start-
and StopConnectionMonitor methods.
---
 doc/device-api.txt | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 577ee60..67f573c 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -100,6 +100,35 @@ Methods		void Connect()
 			Possible errors: org.bluez.Error.DoesNotExist
 					 org.bluez.Error.Failed
 
+
+		void StartConnectionMonitor()
+
+			This method starts connection monitor session. This
+			includes link RSSI and TX power.
+			Use StopConnectionMonitor to release the sessions
+			acquired.
+
+			This process will start updating connection-related
+			properties, e.g. ConnectionRSSI and ConnectionTXPower.
+
+			Note that all sessions for device are released when
+			device is disconnected and it's required to start
+			sessiong again once reconnected.
+
+			Possible errors: org.bluez.Error.Busy
+					 org.bluez.Error.NotConnected
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
+
 Properties	string Address [readonly]
 
 			The Bluetooth device address of the remote device.
@@ -193,3 +222,30 @@ Properties	string Address [readonly]
 
 			Received Signal Strength Indicator of the remote
 			device (inquiry or advertising).
+
+		int16 ConnectionRSSI [readonly, optional]
+
+			Received Signal Strength Indicator of connected remote
+			device.
+
+			This property is present only if device is connected
+			and will be updated if at least one monitoring session
+			is active.
+
+			Note that RSSI has different units for BR/EDR (dB)
+			and LE (dBm) as specified in BT Core ver. 4.1, Vol. 2,
+			Part E, Chapter 7.5.4
+
+		int16 ConnectionTXPower [readonly, optional]
+
+			Transmit power level to connected remote device.
+
+			This property is present only if device is connected
+			and will be updated if at least one monitoring session
+			is active.
+
+		int16 ConnectionTXPowerMax [readonly, optional]
+
+			Maximum transmit power level to connected remote device.
+
+			This property is present only if device is connected.
-- 
1.9.3
