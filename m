Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd 09/10] client-doc: PhonebookAccess sessions return transports
Date: Thu, 24 Nov 2011 15:09:01 +0100
Message-ID: <1322143742-31182-10-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1322143742-31182-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1322143742-31182-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/client-api.txt |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index c6f19ea..d631cff 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -186,10 +186,18 @@ Methods		void Select(string location, string phonebook)
 				"mch":	missing call history
 				"cch":	combination of ich och mch
 
-		string PullAll()
+		object PullAll(string targetfile)
 
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
 
 		array{string vcard, string name} List()
 
@@ -197,10 +205,17 @@ Methods		void Select(string location, string phonebook)
 			vcard : name paired string, for example "1.vcf" :
 				"John".
 
-		string Pull(string vcard)
+		object Pull(string vcard, string targetfile)
 
 			Retrieve the vcard in the current phonebook object
-			for example : Pull("0.vcf")
+			for example : Pull("0.vcf", "pull-result.vcf")
+
+			If an empty target file is given, a name will be
+			automatically calculated for the temporary file.
+
+			The returned path represents the newly created transfer,
+			which should be used to find out if the content has been
+			successfully transferred or if the operation fails.
 
 		array{string vcard, string name}
 		Search(string field, string value)
-- 
1.7.6.4

