Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] doc: Add management command for setting signature resolving key
Date: Sat,  8 Mar 2014 23:12:54 -0800
Message-Id: <1394349174-7722-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index d008704198df..88f79eb87bef 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1659,6 +1659,31 @@ Load Identity Resolving Keys Command
 				Invalid Index
 
 
+Set Signature Resolving Key Command
+===================================
+
+	Command Code:		0x0031
+	Controller Index:	<controller id>
+	Command Parameters:	Signature_Resolving_Key (16 Octets)
+	Return Parameters:
+
+	This command allows for setting the signature resolving key and
+	is only supported on controllers with LE support.
+
+	The key can only be changed when the controller is powered off.
+
+	The special empty key (all zeros) can be used to disable the
+	signature resolving key.
+
+	This command generates a Command Complete event on success or a
+	Command Status event on failure.
+
+	Possible errors:	Rejected
+				Not Supported
+				Invalid Parameters
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
-- 
1.8.5.3

