Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v1 10/15] client-doc: PhonebookAccess sessions return transfers
Date: Mon,  4 Jun 2012 11:37:53 +0200
Message-Id: <1338802678-7009-11-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1338802678-7009-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338802678-7009-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

---
 doc/client-api.txt |   31 ++++++++++++++++++++++++++-----
 1 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 5a3e252..17c15bb 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -205,10 +205,21 @@ Methods		void Select(string location, string phonebook)
 				"mch":	missing call history
 				"cch":	combination of ich och mch
 
-		string PullAll()
+		object, dict PullAll(string targetfile)
 
 			Return the entire phonebook object from the PSE server
-			in plain string with vcard format.
+			in plain string with vcard format, and store it in
+			a local file.
+
+			If an empty target file is given, a name will be
+			automatically calculated for the temporary file.
+
+			The returned path represents the newly created transfer,
+			which should be used to find out if the content has been
+			successfully transferred or if the operation fails.
+
+			The properties of this transfer are also returned along
+			with the object path, to avoid a call to GetProperties.
 
 		array{string vcard, string name} List()
 
@@ -216,10 +227,20 @@ Methods		void Select(string location, string phonebook)
 			vcard : name paired string, for example "1.vcf" :
 				"John".
 
-		string Pull(string vcard)
+		object, dict Pull(string vcard, string targetfile)
 
-			Retrieve the vcard in the current phonebook object
-			for example : Pull("0.vcf")
+			Retrieve the vcard in the current phonebook object and
+			store it in a local file.
+
+			If an empty target file is given, a name will be
+			automatically calculated for the temporary file.
+
+			The returned path represents the newly created transfer,
+			which should be used to find out if the content has been
+			successfully transferred or if the operation fails.
+
+			The properties of this transfer are also returned along
+			with the object path, to avoid a call to GetProperties.
 
 		array{string vcard, string name}
 		Search(string field, string value)
-- 
1.7.7.6

