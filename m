Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 7/7] client-doc: Update documentation of PhonebookAccess interface
Date: Fri, 24 Aug 2012 16:59:55 +0300
Message-Id: <1345816795-14092-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1345816795-14092-1-git-send-email-luiz.dentz@gmail.com>
References: <1345816795-14092-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/client-api.txt | 180 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 145 insertions(+), 35 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 839a78c..adbb12d 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -206,7 +206,7 @@ Methods		void Select(string location, string phonebook)
 				"mch":	missing call history
 				"cch":	combination of ich och mch
 
-		object, dict PullAll(string targetfile)
+		object, dict PullAll(string targetfile, dict filters)
 
 			Return the entire phonebook object from the PSE server
 			in plain string with vcard format, and store it in
@@ -222,14 +222,95 @@ Methods		void Select(string location, string phonebook)
 			The properties of this transfer are also returned along
 			with the object path, to avoid a call to GetProperties.
 
-		array{string vcard, string name} List()
+			filters:
+
+				string Format:
+
+					Items vcard format
+
+					Possible values: "vcard21" (default) or
+					"vcard30"
+
+				string Order:
+
+					Items order
+
+					Possible values: "indexed" (default),
+					"alphanumeric" or "phonetic"
+
+				uint16 Offset:
+
+					Offset of the first item, default is 0
+
+				uint16 Items:
+
+					Maximum number of items, default is
+					unlimited (65535)
+
+				array{string} Fields:
+
+					Item vcard fields, default is all
+					values.
+
+					Possible values:
+
+						"VERSION",
+						"FN",
+						"N",
+						"PHOTO",
+						"BDAY",
+						"ADR",
+						"LABEL",
+						"TEL",
+						"EMAIL",
+						"MAILER",
+						"TZ",
+						"GEO",
+						"TITLE",
+						"ROLE",
+						"LOGO",
+						"AGENT",
+						"ORG",
+						"NOTE",
+						"REV",
+						"SOUND",
+						"URL",
+						"UID",
+						"KEY",
+						"NICKNAME",
+						"CATEGORIES",
+						"PROID",
+						"CLASS",
+						"SORT-STRING",
+						"X-IRMC-CALL-DATETIME"
+
+		array{string vcard, string name} List(dict filters)
 
 			Return an array of vcard-listing data where every entry
 			consists of a pair of strings containing the vcard
 			handle and the contact name. For example:
 				"1.vcf" : "John"
 
-		object, dict Pull(string vcard, string targetfile)
+			filters:
+
+				string Order:
+
+					Items order
+
+					Possible values: "indexed" (default),
+					"alphanumeric" or "phonetic"
+
+				uint16 Offset:
+
+					Offset of the first item, default is 0
+
+				uint16 Items:
+
+					Maximum number of items, default is
+					unlimited (65535)
+
+		object, dict
+		Pull(string vcard, string targetfile, dict filters)
 
 			Given a vcard handle, retrieve the vcard in the current
 			phonebook object and store it in a local file.
@@ -244,8 +325,54 @@ Methods		void Select(string location, string phonebook)
 			The properties of this transfer are also returned along
 			with the object path, to avoid a call to GetProperties.
 
+			filters:
+
+				string Format:
+
+					Items vcard format
+
+					Possible values: "vcard21" (default) or
+					"vcard30"
+
+				array{string} Fields:
+
+					Item vcard fields, default is all
+					values.
+
+					Possible values:
+
+						"VERSION",
+						"FN",
+						"N",
+						"PHOTO",
+						"BDAY",
+						"ADR",
+						"LABEL",
+						"TEL",
+						"EMAIL",
+						"MAILER",
+						"TZ",
+						"GEO",
+						"TITLE",
+						"ROLE",
+						"LOGO",
+						"AGENT",
+						"ORG",
+						"NOTE",
+						"REV",
+						"SOUND",
+						"URL",
+						"UID",
+						"KEY",
+						"NICKNAME",
+						"CATEGORIES",
+						"PROID",
+						"CLASS",
+						"SORT-STRING",
+						"X-IRMC-CALL-DATETIME"
+
 		array{string vcard, string name}
-		Search(string field, string value)
+		Search(string field, string value, dict filters)
 
 			Search for entries matching the given condition and
 			return an array of vcard-listing data where every entry
@@ -258,47 +385,30 @@ Methods		void Select(string location, string phonebook)
 				{ "name" (default) | "number" | "sound" }
 			value : the string value to search for
 
-		uint16 GetSize()
-
-			Return the number of entries in the selected phonebook
-			object that are actually used (i.e. indexes that
-			correspond to non-NULL entries).
-
-		void SetFormat(string format)
-
-			Indicate the format of the vcard that should be return
-			by related methods.
-
-			format : { "vcard21" (default) | "vcard30" }
-
-		void SetOrder(string order)
+			filters:
 
-			Indicate the sorting method of the vcard-listing data
-			returned by List and Search methods.
+				string Order:
 
-			order : { "indexed" (default) | "alphanumeric" |
-					"phonetic" }
+					Items order
 
-		void SetFilter(array{string})
+					Possible values: "indexed" (default),
+					"alphanumeric" or "phonetic"
 
-			Indicate fields that should be contained in vcards
-			return by related methods.
+				uint16 Offset:
 
-			Give an empty array will clear the filter and return
-			all fields available in vcards. And this is the default
-			behavior.
+					Offset of the first item, default is 0
 
-			Possible filter fields : "VERSION", "FN", ..., "ALL",
-			"bit[0-63]"
+				uint16 Items:
 
-		array{string} ListFilterFields()
+					Maximum number of items, default is
+					unlimited (65535)
 
-			Return All Available fields that can be used in
-			SetFilter method.
+		uint16 GetSize()
 
-		array{string} GetFilter()
+			Return the number of entries in the selected phonebook
+			object that are actually used (i.e. indexes that
+			correspond to non-NULL entries).
 
-			Return the current filter setting
 
 Synchronization hierarchy
 =======================
-- 
1.7.11.4

