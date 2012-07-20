Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 3/4] client-doc: Rephrase ambiguities in PBAP interface
Date: Fri, 20 Jul 2012 13:02:27 +0200
Message-Id: <1342782148-10684-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1342782148-10684-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1342782148-10684-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Rephrase method descriptions that can be misleading or are not clear
enough.
---
 doc/client-api.txt |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 8202f39..8621df8 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -224,14 +224,15 @@ Methods		void Select(string location, string phonebook)
 
 		array{string vcard, string name} List()
 
-			Return an array of vcard-listing data which contains the
-			vcard : name paired string, for example "1.vcf" :
-				"John".
+			Return an array of vcard-listing data where every entry
+			consists of a pair of strings containing the vcard
+			handle and the contact name. For example:
+				"1.vcf" : "John"
 
 		object, dict Pull(string vcard, string targetfile)
 
-			Retrieve the vcard in the current phonebook object and
-			store it in a local file.
+			Given a vcard handle, retrieve the vcard in the current
+			phonebook object and store it in a local file.
 
 			If an empty target file is given, a name will be
 			automatically calculated for the temporary file.
@@ -246,7 +247,11 @@ Methods		void Select(string location, string phonebook)
 		array{string vcard, string name}
 		Search(string field, string value)
 
-			Return an array of vcard-listing data which contains the
+			Search for entries matching the given condition and
+			return an array of vcard-listing data where every entry
+			consists of a pair of strings containing the vcard
+			handle and the contact name.
+
 			vcard : name paired string match the search condition.
 
 			field : the field in the vcard to search with
@@ -255,8 +260,9 @@ Methods		void Select(string location, string phonebook)
 
 		uint16 GetSize()
 
-			Return the number of the non-null entries in the
-			selected phonebook object.
+			Return the number of entries in the selected phonebook
+			object that are actually used (i.e. indexes that
+			correspond to non-NULL entries).
 
 		void SetFormat(string format)
 
-- 
1.7.7.6

