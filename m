Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd] client-doc: several style fixes
Date: Mon, 23 Jan 2012 08:49:42 +0100
Message-Id: <1327304982-4016-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Adjusts line length to 80 and some other minor style fixes.
---
 doc/client-api.txt |   80 ++++++++++++++++++++++++++++-----------------------
 1 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index fb5a8b2..7dd83d9 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -22,7 +22,8 @@ Methods		void SendFiles(dict device, array{string} files, object agent)
 			Request the business card from a remote device and
 			store it in the local file.
 
-		void ExchangeBusinessCards(dict device, string clientfile, string file)
+		void ExchangeBusinessCards(dict device, string clientfile,
+								string file)
 
 			Push the client's business card to the remote device
 			and then retrieve the remote business card and store
@@ -49,7 +50,6 @@ Properties	string Target
 
 		byte Channel
 
-
 Session hierarchy
 =================
 
@@ -70,12 +70,11 @@ Methods		dict GetProperties()
 
 			Release a previously assigned OBEX agent.
 
-Properties	string Source [read-only]
-
-		string Destination [read-only]
+Properties	string Source [readonly]
 
-		byte Channel [read-only]
+		string Destination [readonly]
 
+		byte Channel [readonly]
 
 File Transfer hierarchy
 =======================
@@ -101,11 +100,13 @@ Methods		void ChangeFolder(string folder)
 
 				string Name : Object name in UTF-8 format
 				string Type : Either "folder" or "file"
-				uint64 Size : Object size or number of items in folder
-				string Permission : Group, owner and other permission
-				guint64 Modified : Last change
-				guint64 Accessed : Last access
-				guint64 Created : Creation date
+				uint64 Size : Object size or number of items in
+						folder
+				string Permission : Group, owner and other
+							permission
+				uint64 Modified : Last change
+				uint64 Accessed : Last access
+				uint64 Created : Creation date
 
 		void GetFile(string targetfile, string sourcefile)
 
@@ -137,7 +138,6 @@ Methods		void ChangeFolder(string folder)
 
 			Deletes the specified file/folder.
 
-
 Phonebook Access hierarchy
 =======================
 
@@ -150,7 +150,8 @@ Methods		void Select(string location, string phonebook)
 			Select the phonebook object for other operations. Should
 			be call before all the other operations.
 
-			location : Where the phonebook is stored, possible inputs :
+			location : Where the phonebook is stored, possible
+			inputs :
 				"INT" ( "INTERNAL" which is default )
 				"SIM" ( "SIM1" )
 				"SIM2"
@@ -171,7 +172,8 @@ Methods		void Select(string location, string phonebook)
 		array{string vcard, string name} List()
 
 			Return an array of vcard-listing data which contains the
-			vcard : name paired string, for example "1.vcf" : "John".
+			vcard : name paired string, for example "1.vcf" :
+				"John".
 
 		string Pull(string vcard)
 
@@ -190,36 +192,40 @@ Methods		void Select(string location, string phonebook)
 
 		uint16 GetSize()
 
-			Return the number of the non-null entries in the selected
-			phonebook object.
+			Return the number of the non-null entries in the
+			selected phonebook object.
 
 		void SetFormat(string format)
 
-			Indicate the format of the vcard that should be return by
-			related methods.
+			Indicate the format of the vcard that should be return
+			by related methods.
 
 			format : { "vcard21" (default) | "vcard30" }
 
 		void SetOrder(string order)
 
-			Indicate the sorting method of the vcard-listing data returned
-			by List and Search methods.
+			Indicate the sorting method of the vcard-listing data
+			returned by List and Search methods.
 
-			order : { "indexed" (default) | "alphanumeric" | "phonetic" }
+			order : { "indexed" (default) | "alphanumeric" |
+					"phonetic" }
 
 		void SetFilter(array{string})
 
-			Indicate fields that should be contained in vcards return by
-			related methods.
+			Indicate fields that should be contained in vcards
+			return by related methods.
 
-			Give an empty array will clear the filter and return all fields
-			available in vcards. And this is the default behavior.
+			Give an empty array will clear the filter and return
+			all fields available in vcards. And this is the default
+			behavior.
 
-			Possible filter fields : "VERSION", "FN", ..., "ALL", "bit[0-63]"
+			Possible filter fields : "VERSION", "FN", ..., "ALL",
+			"bit[0-63]"
 
 		array{string} ListFilterFields()
 
-			Return All Available fields that can be used in SefFilter method.
+			Return All Available fields that can be used in
+			SefFilter method.
 
 		array{string} GetFilter()
 
@@ -234,10 +240,12 @@ Object path	[variable prefix]/{session0,session1,...}
 
 Methods		void SetLocation(string location)
 
-			Set the phonebook object store location for other operations. Should
-			be called before all the other operations.
+			Set the phonebook object store location for other
+			operations. Should be called before all the other
+			operations.
 
-			location: Where the phonebook is stored, possible values:
+			location: Where the phonebook is stored, possible
+			values:
 				"INT" ( "INTERNAL" which is default )
 				"SIM1"
 				"SIM2"
@@ -245,7 +253,8 @@ Methods		void SetLocation(string location)
 
 		string GetPhonebook()
 
-			Retrieve an entire Phonebook Object store from remote device
+			Retrieve an entire Phonebook Object store from remote
+			device
 
 		void PutPhonebook(string obj)
 
@@ -279,20 +288,19 @@ Methods		dict GetProperties()
 
 			Cancels this transfer.
 
-Properties	string Name [read-only]
+Properties	string Name [readonly]
 
 			Name of the transferred object.
 
-		uint64 Size [read-only]
+		uint64 Size [readonly]
 
 			Size of the transferred object. If the size is
 			unknown, then this property will not be present.
 
-		string Filename [read-only]
+		string Filename [readonly]
 
 			Complete name of the file being received or sent.
 
-
 Agent hierarchy
 ===============
 
@@ -319,7 +327,7 @@ Methods		void Release()
 			empty it will be calculated automatically.
 
 			Possible errors: org.openobex.Error.Rejected
-			                 org.openobex.Error.Canceled
+					 org.openobex.Error.Canceled
 
 		void Progress(object transfer, uint64 transferred)
 
-- 
1.7.6.5

