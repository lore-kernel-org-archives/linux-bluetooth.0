Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 07/14] client-doc: Synchronization sessions return transfers
Date: Fri,  1 Jun 2012 12:51:16 +0200
Message-Id: <1338547883-18907-8-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1338547883-18907-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338547883-18907-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Note that the parameter given to PutPhonebook now represents the file
name to be read, instead of containing the phonebook data.
---
 doc/client-api.txt |   25 +++++++++++++++++++++----
 1 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 8e0819d..189a7a0 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -292,14 +292,31 @@ Methods		void SetLocation(string location)
 				"SIM2"
 				......
 
-		string GetPhonebook()
+		object, dict GetPhonebook(string targetfile)
 
 			Retrieve an entire Phonebook Object store from remote
-			device
+			device, and stores it in a local file.
 
-		void PutPhonebook(string obj)
+			If an empty target file is given, a name will be
+			automatically calculated for the temporary file.
+
+			The returned path represents the newly created transfer,
+			which should be used to find out if the content has been
+			successfully transferred or if the operation fails.
+
+			The properties of this transfer are also returned along
+			with the object path, to avoid a call to GetProperties.
 
-			Send an entire Phonebook Object store to remote device
+		object, dict PutPhonebook(string sourcefile)
+
+			Send an entire Phonebook Object store to remote device.
+
+			The returned path represents the newly created transfer,
+			which should be used to find out if the content has been
+			successfully transferred or if the operation fails.
+
+			The properties of this transfer are also returned along
+			with the object path, to avoid a call to GetProperties.
 
 Message Access hierarchy
 =========================
-- 
1.7.7.6

