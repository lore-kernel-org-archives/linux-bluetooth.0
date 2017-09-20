Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 03/10] doc/gatt-api: Add server support for AcquireWrite and AcquireNotify
Date: Wed, 20 Sep 2017 10:44:10 +0300
Message-Id: <20170920074417.30435-4-luiz.dentz@gmail.com>
In-Reply-To: <20170920074417.30435-1-luiz.dentz@gmail.com>
References: <20170920074417.30435-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables servers to use the same mechanism to use packet based IO
using file descriptors bypassing D-Bus.

Note that the application is free to choose any type of medium that can
use file descriptors, thus this is not limited to pipe2 although that is
probably recommended due its simplicity.
---
 doc/gatt-api.txt | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index cdd15f301..400470631 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -91,13 +91,16 @@ Methods		array{byte} ReadValue(dict options)
 					 org.bluez.Error.NotAuthorized
 					 org.bluez.Error.NotSupported
 
-		fd, uint16 AcquireWrite() [experimental] (Client only)
+		fd, uint16 AcquireWrite(dict options) [experimental, optional]
 
 			Acquire file descriptor and MTU for writing. Usage of
 			WriteValue will be locked causing it to return
 			NotPermitted error.
 
-			Only works with characteristic that has
+			For server the MTU returned shall be equal or smaller
+			than the negotiated MTU.
+
+			For client it only works with characteristic that has
 			WriteAcquired property which relies on
 			write-without-response Flag.
 
@@ -111,15 +114,21 @@ Methods		array{byte} ReadValue(dict options)
 			that the file descriptor is closed during
 			reconnections as the MTU has to be renegotiated.
 
+			Possible options: "device": Object Device (Server only)
+					  "MTU": Exchanged MTU (Server only)
+
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.NotSupported
 
-		fd, uint16 AcquireNotify() [experimental] (Client only)
+		fd, uint16 AcquireNotify(dict options) [experimental, optional]
 
 			Acquire file descriptor and MTU for notify. Usage of
 			StartNotify will be locked causing it to return
 			NotPermitted error.
 
+			For server the MTU returned shall be equal or smaller
+			than the negotiated MTU.
+
 			Only works with characteristic that has NotifyAcquired
 			which relies on notify Flag and no other client have
 			called StartNotify.
@@ -140,6 +149,9 @@ Methods		array{byte} ReadValue(dict options)
 			that the file descriptor is closed during
 			reconnections as the MTU has to be renegotiated.
 
+			Possible options: "device": Object Device (Server only)
+					  "MTU": Exchanged MTU (Server only)
+
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.NotSupported
 
@@ -188,14 +200,24 @@ Properties	string UUID [read-only]
 		boolean WriteAcquired [read-only, optional]
 
 			True, if this characteristic has been acquired by any
-			client using AcquireWrite. This properties is ommited
-			in case 'write-without-response' flag is not set.
+			client using AcquireWrite.
+
+			For client properties is ommited in case
+			'write-without-response' flag is not set.
+
+			For server the presence of this property indicates
+			that AcquireWrite is supported.
 
 		boolean NotifyAcquired [read-only, optional]
 
 			True, if this characteristic has been acquired by any
-			client using AcquireNotify. This properties is ommited
-			in case 'notify' flag is not set.
+			client using AcquireNotify.
+
+			For client this properties is ommited in case 'notify'
+			flag is not set.
+
+			For server the presence of this property indicates
+			that AcquireNotify is supported.
 
 		boolean Notifying [read-only, optional]
 
-- 
2.13.5

