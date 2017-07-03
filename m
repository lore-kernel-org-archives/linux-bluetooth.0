Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/10] doc/gatt-api: Add AcquireWrite and AcquireNotify
Date: Mon,  3 Jul 2017 15:11:39 +0300
Message-Id: <20170703121148.24299-2-luiz.dentz@gmail.com>
In-Reply-To: <20170703121148.24299-1-luiz.dentz@gmail.com>
References: <20170703121148.24299-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables write and notify exclusive access via file descriptors in
case the characteristic is actually trying to emulate a byte stream
transfer or have a protocol on top of GATT.
---
 doc/gatt-api.txt | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 6c98b87..02f389c 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -91,6 +91,51 @@ Methods		array{byte} ReadValue(dict options)
 					 org.bluez.Error.NotAuthorized
 					 org.bluez.Error.NotSupported
 
+		fd, uint16 AcquireWrite() [experimental] (Client only)
+
+			Acquire write file descriptor and MTU and lock
+			write access to the characteristic.
+
+			Only works with characteristic that has
+			write-without-response Flag.
+
+			To release the lock the client shall close the file
+			descriptor, a HUP is generated in case the device
+			is disconnected.
+
+			Note: the MTU can only be negotiated once and is
+			symmetric therefore this method may be delayed in
+			order to have the exchange MTU completed, because of
+			that the file descriptor is closed during
+			reconnections as the MTU has to be renegotiated.
+
+			Possible Errors: org.bluez.Error.Failed
+					 org.bluez.Error.NotSupported
+
+		fd, uint16 AcquireNotify() [experimental] (Client only)
+
+			Acquire notify file descriptor and MTU and lock
+			notifications to the characteristic.
+
+			Only works with characteristic that has notify
+			flag and no other client have called StartNotify.
+
+			Notification are enabled during this procedure so
+			StartNotify shall not be called.
+
+			To release the lock the client shall close the file
+			descriptor, a HUP is generated in case the device
+			is disconnected.
+
+			Note: the MTU can only be negotiated once and is
+			symmetric therefore this method may be delayed in
+			order to have the exchange MTU completed, because of
+			that the file descriptor is closed during
+			reconnections as the MTU has to be renegotiated.
+
+			Possible Errors: org.bluez.Error.Failed
+					 org.bluez.Error.NotSupported
+
 		void StartNotify()
 
 			Starts a notification session from this characteristic
@@ -125,6 +170,16 @@ Properties	string UUID [read-only]
 			when a notification or indication is received, upon
 			which a PropertiesChanged signal will be emitted.
 
+		boolean WriteLocked [read-only]
+
+			True, if this characteristic has been acquire by any
+			client using AcquireWrite.
+
+		boolean NotifyLocked [read-only]
+
+			True, if this characteristic has been acquire by any
+			client using AcquireNotify.
+
 		boolean Notifying [read-only, optional]
 
 			True, if notifications or indications on this
-- 
2.9.4

