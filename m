Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 7/7 v2] client-doc: Update documentation of PhonebookAccess interface
Date: Tue, 28 Aug 2012 15:31:55 +0300
Message-Id: <1346157115-23933-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1346157115-23933-1-git-send-email-luiz.dentz@gmail.com>
References: <1346157115-23933-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/client-api.txt | 62 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 7ca65cc..f447789 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -206,7 +206,7 @@ Methods		void Select(string location, string phonebook)
 				"mch":	missing call history
 				"cch":	combination of ich och mch
 
-		object, dict PullAll(string targetfile)
+		object, dict PullAll(string targetfile, dict filters)
 
 			Return the entire phonebook object from the PSE server
 			in plain string with vcard format, and store it in
@@ -222,14 +222,21 @@ Methods		void Select(string location, string phonebook)
 			The properties of this transfer are also returned along
 			with the object path, to avoid a call to GetProperties.
 
-		array{string vcard, string name} List()
+			Possible filters: Format, Order, Offset, MaxCount and
+			Fields
+
+		array{string vcard, string name} List(dict filters)
 
 			Return an array of vcard-listing data where every entry
 			consists of a pair of strings containing the vcard
 			handle and the contact name. For example:
 				"1.vcf" : "John"
 
-		object, dict Pull(string vcard, string targetfile)
+			Possible filters: Order, Offset and MaxCount
+
+
+		object, dict
+		Pull(string vcard, string targetfile, dict filters)
 
 			Given a vcard handle, retrieve the vcard in the current
 			phonebook object and store it in a local file.
@@ -244,8 +251,11 @@ Methods		void Select(string location, string phonebook)
 			The properties of this transfer are also returned along
 			with the object path, to avoid a call to GetProperties.
 
+			Possbile filters: Format and Fields
+
+
 		array{string vcard, string name}
-		Search(string field, string value)
+		Search(string field, string value, dict filters)
 
 			Search for entries matching the given condition and
 			return an array of vcard-listing data where every entry
@@ -258,47 +268,47 @@ Methods		void Select(string location, string phonebook)
 				{ "name" (default) | "number" | "sound" }
 			value : the string value to search for
 
+
+			Possible filters: Order, Offset and MaxCount
+
 		uint16 GetSize()
 
 			Return the number of entries in the selected phonebook
 			object that are actually used (i.e. indexes that
 			correspond to non-NULL entries).
 
-		void SetFormat(string format)
+		array{string} ListFilterFields()
 
-			Indicate the format of the vcard that should be return
-			by related methods.
+			Return All Available fields that can be used in Fields
+			filter.
 
-			format : { "vcard21" (default) | "vcard30" }
+Filter:		string Format:
 
-		void SetOrder(string order)
+			Items vcard format
 
-			Indicate the sorting method of the vcard-listing data
-			returned by List and Search methods.
+			Possible values: "vcard21" (default) or "vcard30"
 
-			order : { "indexed" (default) | "alphanumeric" |
-					"phonetic" }
+		string Order:
 
-		void SetFilter(array{string})
+			Items order
 
-			Indicate fields that should be contained in vcards
-			return by related methods.
+			Possible values: "indexed" (default), "alphanumeric" or
+			"phonetic"
 
-			Give an empty array will clear the filter and return
-			all fields available in vcards. And this is the default
-			behavior.
+		uint16 Offset:
 
-			Possible filter fields : "VERSION", "FN", ..., "ALL",
-			"bit[0-63]"
+			Offset of the first item, default is 0
 
-		array{string} ListFilterFields()
+		uint16 MaxCount:
+
+			Maximum number of items, default is unlimited (65535)
+
+		array{string} Fields:
 
-			Return All Available fields that can be used in
-			SetFilter method.
+			Item vcard fields, default is all values.
 
-		array{string} GetFilter()
+			Possible values can be query with ListFilterFields.
 
-			Return the current filter setting
 
 Synchronization hierarchy
 =======================
-- 
1.7.11.4

