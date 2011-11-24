Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd 10/10] client-doc: Synchronization sessions return transports
Date: Thu, 24 Nov 2011 15:09:02 +0100
Message-ID: <1322143742-31182-11-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1322143742-31182-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1322143742-31182-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/client-api.txt |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index d631cff..fa9e0cd 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -288,14 +288,25 @@ Methods		void SetLocation(string location)
 				"SIM2"
 				......
 
-		string GetPhonebook()
+		object GetPhonebook(string targetfile)
 
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
 
-			Send an entire Phonebook Object store to remote device
+		object PutPhonebook(string obj)
+
+			Send an entire Phonebook Object store to remote device.
+
+			The returned path represents the newly created transfer,
+			which should be used to find out if the content has been
+			successfully transferred or if the operation fails.
 
 Transfer hierarchy
 ==================
-- 
1.7.6.4

