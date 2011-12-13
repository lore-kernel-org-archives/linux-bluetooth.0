Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v3 14/20] client-doc: FileTransfer sessions return transfers
Date: Tue, 13 Dec 2011 17:44:17 +0100
Message-ID: <1323794663-2711-15-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1323794663-2711-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1323794663-2711-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/client-api.txt |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 00f56e1..2e8c37a 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -141,21 +141,26 @@ Methods		void ChangeFolder(string folder)
 				uint64 Accessed : Last access
 				uint64 Created : Creation date
 
-		void GetFile(string targetfile, string sourcefile)
+		object GetFile(string targetfile, string sourcefile)
 
 			Copy the source file (from remote device) to the
 			target file (on local filesystem).
 
-			A new Transfer object is created to represent this
-			transaction.
+			If an empty target file is given, a name will be
+			automatically calculated for the temporary file.
 
-		void PutFile(string sourcefile, string targetfile)
+			The returned path represents the newly created transfer,
+			which should be used to find out if the content has been
+			successfully transferred or if the operation fails.
+
+		object PutFile(string sourcefile, string targetfile)
 
 			Copy the source file (from local filesystem) to the
 			target file (on remote device).
 
-			A new Transfer object is created to represent this
-			transaction.
+			The returned path represents the newly created transfer,
+			which should be used to find out if the content has been
+			successfully transferred or if the operation fails.
 
 		void CopyFile(string sourcefile, string targetfile)
 
-- 
1.7.6.4

