Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] doc: Add mgmt command for changing the controller public address
Date: Thu,  8 May 2014 17:46:47 -0700
Message-Id: <1399596407-41740-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index cd5cd2417b07..2bb275227abe 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1679,6 +1679,42 @@ Load Identity Resolving Keys Command
 				Invalid Index
 
 
+Change Public Address Command
+=============================
+
+	Command Code:		0x0031
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+	Return Parameters:
+
+	This command allows changing the public address. Since a vendor
+	specific procedure is required, this command might not be supported
+	by all controllers. Actually most likely only a handful embedded
+	controllers will offer support for this command.
+
+	It is only possible to change the public address when the
+	controller is powered off.
+
+	When this command succeeds, the current controller index will
+	become invalid and an Index Removed event will be send. Once
+	the address has been successfully changed an Index Added event
+	will be send. There is no guarantee that the controller index
+	stays the same.
+
+	All previous configured parameters and settings are lost when
+	this command succeeds. The controller has to be treated as new
+	one. Use this command only when you really know what you are
+	doing.
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
1.9.0

