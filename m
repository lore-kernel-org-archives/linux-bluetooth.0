Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 06/10] client-doc: Add documentation of MessageAccess.GetMessageListing
Date: Tue,  3 Jul 2012 21:28:10 +0300
Message-Id: <1341340094-32522-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1341340094-32522-1-git-send-email-luiz.dentz@gmail.com>
References: <1341340094-32522-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/client-api.txt |   76 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 5a960e1..6f7d13f 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -361,6 +361,82 @@ Methods		void SetFolder(string name)
 
 				string Name : Folder name
 
+		array{object, dict} GetMessageListing(string folder, dict filter)
+
+			Returns an array containing the messages found in the
+			given folder.
+
+			Each message is represented by an object path followed
+			by a dictionary of the properties.
+
+			Properties:
+
+				string Handle:
+
+					Message handle
+
+				string Subject:
+
+					Message subject
+
+				string Timestamp:
+
+					Message timestamp
+
+				string Sender:
+
+					Message sender name
+
+				string SenderAddress:
+
+					Message sender address
+
+				string ReplyTo:
+
+					Message Reply-To address
+
+				string Recipient:
+
+					Message recipient name
+
+				string RecipientAddress:
+
+					Message recipient address
+
+				string Type:
+
+					Message type
+
+					Possible values: "EMAIL", "SMS_GSM",
+					"SMS_CDMA" and "MMS"
+
+				uint64 Size:
+
+					Message size in bytes
+
+				string Status:
+
+					Message reception status
+
+					Possible values: "complete",
+					"fractioned" and "notification"
+
+				boolean Priority:
+
+					Message priority flag
+
+				boolean Read:
+
+					Message read flag
+
+				boolean Sent:
+
+					Message sent flag
+
+				boolean Protected:
+
+					Message protected flag
+
 Transfer hierarchy
 ==================
 
-- 
1.7.10.4

