Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] doc: Introduce Non Connectable flag for Device Found event
Date: Tue,  1 Jul 2014 12:51:54 +0200
Message-Id: <1404211914-3429-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 078435cd386f..d51405c67755 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2162,6 +2162,7 @@ Device Connected Event
 	The following bits are defined for the Flags parameter:
 		0	Reserved (not in use)
 		1	Legacy Pairing
+		2	Reserved (not in use)
 
 
 Device Disconnected Event
@@ -2332,6 +2333,7 @@ Device Found Event
 	The following bits are defined for the Flags parameter:
 		0	Confirm name
 		1	Legacy Pairing
+		2	Not Connectable
 
 	The Confirm name flag indicates that the kernel wants to know
 	whether user space knows the name for this device or not. If
@@ -2346,6 +2348,10 @@ Device Found Event
 	false-positives for this flag so user space should be able to
 	handle getting something else as a PIN Request when pairing.
 
+	The Not Connectable flag indicates that the device will not
+	accept any connections. This can be indicated by Low Energy
+	devices that are in broadcaster role.
+
 
 Discovering Event
 =================
-- 
1.9.3

