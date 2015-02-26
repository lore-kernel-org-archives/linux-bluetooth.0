Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] doc/mgmt-api: Add security level to new CSRK events
Date: Thu, 26 Feb 2015 17:59:57 +0200
Message-Id: <1424966397-24650-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In order to distinguish between LE Security Mode 2 levels 1 and 2 we
need to know whether a CSRK is authenticated or unauthenticated. So far
this information wasn't available in the New CSRK event from the kernel.

This patch renames the Master parameter of the event to Type and adds
two new values to it. The two old values 0x00 and 0x01 still have the
same meaning as before from the local/remote CSRK perspective. Since we
so far have not known anything about the security level these values
must be assumed to be unauthenticated.

The consequence of this update is that authenticated keys with new
kernels will simply be ignored by existing code (which only accepts
values 0x00 and 0x01), however since we haven't really had any code
doing real signing so far this should be an acceptable compromise.
---
 doc/mgmt-api.txt | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index bef99902a225..c72067c95f44 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2969,7 +2969,7 @@ New Signature Resolving Key Event
 				Key {
 					Address (6 Octets)
 					Address_Type (1 Octet)
-					Master (1 Octet)
+					Type (1 Octet)
 					Value (16 Octets)
 				}
 
@@ -2979,17 +2979,20 @@ New Signature Resolving Key Event
 	The Store_Hint parameter indicates whether the host is expected
 	to store the key persistently or not.
 
-	When the Master parameter is set to 0x01, then the signature
-	resolving key from the remote peer device is provided. It is
-	the key that is used for signature verification.
+	The Type parameter has the following possible values:
+
+		0x00	Unauthenticated local CSRK
+		0x01	Unauthenticated remote CSRK
+		0x02	Authenticated local CSRK
+		0x03	Authenticated remote CSRK
 
-	When the Master parameter is set to 0x00, then it is the local
-	signature resolving key that is used to sign data. The remote
-	peer device will be using it for signature verification.
+	The local keys are used for signing data to be sent to the
+	remote device, whereas the remote keys are used to verify
+	signatures received from the remote device.
 
 	The local signature resolving key will be generated with each
-	pairing request. Only after receiving this event with Master
-	parameter set to 0x00 it is possible to use ATT Signed Write
+	pairing request. Only after receiving this event with the Type
+	indicating a local key is it possible to use ATT Signed Write
 	procedures.
 
 	Possible values for the Address_Type parameter:
-- 
2.1.0

