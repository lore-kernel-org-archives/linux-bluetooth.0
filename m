Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v1 06/15] client-doc: FileTransfer sessions return transfers
Date: Mon,  4 Jun 2012 11:37:49 +0200
Message-Id: <1338802678-7009-7-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1338802678-7009-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338802678-7009-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

---
 doc/client-api.txt |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index a57f6c2..2c7c03c 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -138,21 +138,32 @@ Methods		void ChangeFolder(string folder)
 				uint64 Accessed : Last access
 				uint64 Created : Creation date
 
-		void GetFile(string targetfile, string sourcefile)
+		object, dict GetFile(string targetfile, string sourcefile)
 
 			Copy the source file (from remote device) to the
 			target file (on local filesystem).
 
-			A new Transfer object is created to represent this
-			transaction.
+			If an empty target file is given, a name will be
+			automatically calculated for the temporary file.
+
+			The returned path represents the newly created transfer,
+			which should be used to find out if the content has been
+			successfully transferred or if the operation fails.
 
-		void PutFile(string sourcefile, string targetfile)
+			The properties of this transfer are also returned along
+			with the object path, to avoid a call to GetProperties.
+
+		object, dict PutFile(string sourcefile, string targetfile)
 
 			Copy the source file (from local filesystem) to the
 			target file (on remote device).
 
-			A new Transfer object is created to represent this
-			transaction.
+			The returned path represents the newly created transfer,
+			which should be used to find out if the content has been
+			successfully transferred or if the operation fails.
+
+			The properties of this transfer are also returned along
+			with the object path, to avoid a call to GetProperties.
 
 		void CopyFile(string sourcefile, string targetfile)
 
-- 
1.7.7.6

