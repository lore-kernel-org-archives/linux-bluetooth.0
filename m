Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] doc/obex-api: Add API for PBAP 1.2 features
Date: Thu, 19 Jun 2014 16:09:34 +0300
Message-Id: <1403183374-16994-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
These changes add support for PBAP 1.2 features, the idea is that upon
connecting the stack will auto retrieve the DatabaseIdentifier which will
very likely be used by applications to detect if anything should be done.

In case DatabaseIdentifier is present the user application can then
request the folder version via GetVersion.

Two new filter are added, Operator which should be used along with Fields
and ResetNewMissedCalls which can only be used in mch and cch folders.

 doc/obex-api.txt | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index 9542a30..f86903c 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -431,6 +431,14 @@ Methods		void Select(string location, string phonebook)
 			Possible errors: org.bluez.obex.Error.Forbidden
 					 org.bluez.obex.Error.Failed
 
+		uint16, uint16 GetVersion()
+
+			Return the primary and secondy folder version counters
+			for the selected phonebook.
+
+			Possible errors: org.bluez.obex.Error.Forbidden
+					 org.bluez.obex.Error.Failed
+
 		array{string} ListFilterFields()
 
 			Return All Available fields that can be used in Fields
@@ -465,6 +473,27 @@ Filter:		string Format:
 
 			Possible values can be query with ListFilterFields.
 
+		bool Operator:
+
+			Filter items by fields. Default do not filter by
+			fields.
+
+			True: all (AND logic)
+			False: any (OR logic)
+
+		bool ResetNewMissedCalls
+
+			Reset new the missed calls items, shall only be used
+			for folders mch and cch.
+
+Properties	string Folder [readonly]
+
+			Current folder.
+
+		string DatabaseIdentifier [readonly]
+
+			Optional. 128 bits persistent identifier.
+
 
 Synchronization hierarchy
 =========================
-- 
1.9.3

