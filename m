Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 4/8] client-doc: Update documentation of MessageAccess interface
Date: Thu, 13 Sep 2012 16:06:57 +0300
Message-Id: <1347541621-26858-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1347541621-26858-1-git-send-email-luiz.dentz@gmail.com>
References: <1347541621-26858-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/client-api.txt | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index f447789..f78b8fe 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -368,7 +368,7 @@ Methods		void SetFolder(string name)
 			Set working directory for current session, *name* may
 			be the directory name or '..[/dir]'.
 
-		array{dict} GetFolderListing(dict filter)
+		array{dict} ListFolders(dict filter)
 
 			Returns a dictionary containing information about
 			the current folder content.
@@ -377,12 +377,22 @@ Methods		void SetFolder(string name)
 
 				string Name : Folder name
 
-		array{object, dict} GetMessageListing(string folder,
-								dict filter)
+			Possible filters: Offset and MaxCount
+
+		array{string} ListFilterFields()
+
+			Return all available fields that can be used in Fields
+			filter.
+
+		array{object, dict} ListMessages(string folder, dict filter)
 
 			Returns an array containing the messages found in the
 			given folder.
 
+			Possible Filters: Offset, MaxCount, Fields, Type,
+			PeriodStart, PeriodEnd, Status, Recipient, Sender,
+			Priority
+
 			Each message is represented by an object path followed
 			by a dictionary of the properties.
 
@@ -450,6 +460,59 @@ Methods		void SetFolder(string name)
 
 					Message protected flag
 
+Filter:		uint16 Offset:
+
+			Offset of the first item, default is 0
+
+		uint16 MaxCount:
+
+			Maximum number of items, default is 1024
+
+		array{string} Fields:
+
+			Message fields, default is all values.
+
+			Possible values can be query with ListFilterFields.
+
+		array{string} Types:
+
+			Filter messages by type.
+
+			Possible values: "sms", "email", "mms".
+
+		string PeriodBegin:
+
+			Filter messages by starting period.
+
+			Possible values: Date in "YYYYMMDDTHHMMSS" format.
+
+		string PeriodEnd:
+
+			Filter messages by ending period.
+
+			Possible values: Date in "YYYYMMDDTHHMMSS" format.
+
+		boolean Read:
+
+			Filter messages by read flag.
+
+			Possible values: True for read or False for unread
+
+		string Recipient:
+
+			Filter messages by recipient address.
+
+		string Sender:
+
+			Filter messages by sender address.
+
+		gboolean Priority:
+
+			Filter messages by priority flag.
+
+			Possible values: True for high priority or False for
+			non-high priority
+
 Message hierarchy
 =================
 
-- 
1.7.11.4

