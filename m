Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <syamsidhardh@gmail.com>
Subject: [PATCH obexd 2/3] doc: Fix typo in client-api
Date: Thu, 11 Aug 2011 00:13:27 +0530
Message-Id: <1313001808-29597-2-git-send-email-syamsidhardh@gmail.com>
In-Reply-To: <1313001808-29597-1-git-send-email-syamsidhardh@gmail.com>
References: <1313001808-29597-1-git-send-email-syamsidhardh@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/client-api.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 4104adb..3e61cf7 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -130,7 +130,7 @@ Methods		void ChangeFolder(string folder)
 
 		void MoveFile(string sourcefile, string targetfile)
 
-			Movea file within the remote device from source file
+			Move a file within the remote device from source file
 			to the target file.
 
 		void Delete(string file)
@@ -245,11 +245,11 @@ Methods		void SetLocation(string location)
 
 		string GetPhonebook()
 
-			retrieve an entire Phonebook Object store from remote device
+			Retrieve an entire Phonebook Object store from remote device
 
 		void PutPhonebook(string obj)
 
-			send an entire Phonebook Object store to remote device
+			Send an entire Phonebook Object store to remote device
 
 Transfer hierarchy
 ==================
@@ -317,7 +317,7 @@ Methods		void Release()
 
 		void Complete(object transfer)
 
-			Informs that the transfer has completed sucessfully.
+			Informs that the transfer has completed successfully.
 
 		void Error(object transfer, string message)
 
-- 
1.7.4.1

