Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] doc: Add mode for enabling generation of debug keys
Date: Sat, 21 Jun 2014 04:21:08 +0200
Message-Id: <1403317268-1162-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index e15a78f3e4b7..5a7d2ef0e5d3 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1622,8 +1622,23 @@ Set Debug Keys Command
 
 	This command is used to tell the kernel whether to accept the
 	usage of debug keys or not. The allowed values for this parameter
-	are 0x00 and 0x01. All other values will return an Invalid Parameters
-	response.
+	are 0x00, 0x01 and 0x02. All other values will return an Invalid
+	Parameters response.
+
+	With a value of 0x00 any generated debug key will be discarded
+	as soon as the connection terminates.
+
+	With a value of 0x01 generated debug keys will be kept and can
+	be used for future connections. However debug keys are always
+	marked as non persistent and should not be stored. This means
+	a reboot or changing the value back to 0x00 will delete them.
+
+	With a value of 0x02 generated debug keys will be kept and can
+	be used for future connections. This has the same affect as
+	with value 0x01. However in addition this value will also
+	enter the controller mode to generate debug keys for each
+	new pairing. Changing the value back to 0x01 or 0x00 will
+	disable the controller mode for generating debug keys.
 
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
-- 
1.9.3

