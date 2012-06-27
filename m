Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 06/10] client-doc: Add documentation of MessageAccess.GetMessageListing
Date: Wed, 27 Jun 2012 15:04:51 +0300
Message-Id: <1340798695-6785-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1340798695-6785-1-git-send-email-luiz.dentz@gmail.com>
References: <1340798695-6785-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/client-api.txt |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 5a960e1..1ad9001 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -361,6 +361,30 @@ Methods		void SetFolder(string name)
 
 				string Name : Folder name
 
+		array{dict} GetMessageListing(string folder, dict filter)
+
+			Returns a dictionary containing information about
+			the messages in the given folder.
+
+			The following keys are defined:
+
+				string Handle : Message handle
+				string Subject : Message subject
+				string Timestamp: Message timestamp
+				string Sender: Message sender name
+				string SenderAddress: Message sender address
+				string ReplyTo: Message Reply-To address
+				string Recipient: Message recipient name
+				string RecipientAddress: Message recipient
+							 address
+				string Type: Message type
+				uint64 Size: Message size in bytes
+				string Status: Message reception status
+				boolean Priority: Message priority flag
+				boolean Read: Message read flag
+				boolean Sent: Message sent flag
+				boolean Protected: Message protected flag
+
 Transfer hierarchy
 ==================
 
-- 
1.7.10.2

