Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd 03/10] client-doc: minor formatting changes
Date: Thu, 24 Nov 2011 15:08:55 +0100
Message-ID: <1322143742-31182-4-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1322143742-31182-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1322143742-31182-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/client-api.txt |   22 +++++++++-------------
 1 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index e6f8270..304e489 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -51,7 +51,6 @@ Properties	string Target
 
 		byte Channel
 
-
 Session hierarchy
 =================
 
@@ -72,12 +71,11 @@ Methods		dict GetProperties()
 
 			Release a previously assigned OBEX agent.
 
-Properties	string Source [read-only]
-
-		string Destination [read-only]
+Properties	string Source [readonly]
 
-		byte Channel [read-only]
+		string Destination [readonly]
 
+		byte Channel [readonly]
 
 File Transfer hierarchy
 =======================
@@ -107,9 +105,9 @@ Methods		void ChangeFolder(string folder)
 						folder
 				string Permission : Group, owner and other
 							permission
-				guint64 Modified : Last change
-				guint64 Accessed : Last access
-				guint64 Created : Creation date
+				uint64 Modified : Last change
+				uint64 Accessed : Last access
+				uint64 Created : Creation date
 
 		void GetFile(string targetfile, string sourcefile)
 
@@ -141,7 +139,6 @@ Methods		void ChangeFolder(string folder)
 
 			Deletes the specified file/folder.
 
-
 Phonebook Access hierarchy
 =======================
 
@@ -280,20 +277,19 @@ Methods		dict GetProperties()
 
 			Cancels this transfer.
 
-Properties	string Name [read-only]
+Properties	string Name [readonly]
 
 			Name of the transferred object.
 
-		uint64 Size [read-only]
+		uint64 Size [readonly]
 
 			Size of the transferred object. If the size is
 			unknown, then this property will not be present.
 
-		string Filename [read-only]
+		string Filename [readonly]
 
 			Complete name of the file being received or sent.
 
-
 Agent hierarchy
 ===============
 
-- 
1.7.6.4

