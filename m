Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd 08/10] client-doc: FileTransfer sessions return transports
Date: Thu, 24 Nov 2011 15:09:00 +0100
Message-ID: <1322143742-31182-9-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1322143742-31182-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1322143742-31182-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/client-api.txt |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 5a23c6e..c6f19ea 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -125,21 +125,26 @@ Methods		void ChangeFolder(string folder)
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

