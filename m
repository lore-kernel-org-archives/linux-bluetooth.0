Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PBAP 1/2] obexd/client/pbap: Add support for spd,fav in PBAP
Date: Thu, 25 Sep 2014 14:40:11 +0530
Message-id: <1411636212-5872-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for the speed-dial and favorite entries in PBAP.
---
 doc/obex-api.txt          |  2 ++
 obexd/client/pbap.c       | 10 +++++++---
 obexd/plugins/phonebook.h |  4 ++++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index f80ef39..4439a41 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -341,6 +341,8 @@ Methods		void Select(string location, string phonebook)
 				"och":	outgoing call history
 				"mch":	missing call history
 				"cch":	combination of ich och mch
+				"spd":	speed dials entry ( only for "internal" )
+				"fav":	favorites entry ( only for "internal" )
 
 			Possible errors: org.bluez.obex.Error.InvalidArguments
 					 org.bluez.obex.Error.Failed
diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 2089860..614616c 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -183,11 +183,13 @@ static const GMarkupParser listing_parser = {
 static char *build_phonebook_path(const char *location, const char *item)
 {
 	char *path = NULL, *tmp, *tmp1;
+	int int_telecom = 0;
 
 	if (!g_ascii_strcasecmp(location, "int") ||
-			!g_ascii_strcasecmp(location, "internal"))
+			!g_ascii_strcasecmp(location, "internal")) {
 		path = g_strdup("/telecom");
-	else if (!g_ascii_strncasecmp(location, "sim", 3)) {
+		int_telecom = 1;
+	} else if (!g_ascii_strncasecmp(location, "sim", 3)) {
 		if (strlen(location) == 3)
 			tmp = g_strdup("sim1");
 		else
@@ -202,7 +204,9 @@ static char *build_phonebook_path(const char *location, const char *item)
 		!g_ascii_strcasecmp(item, "ich") ||
 		!g_ascii_strcasecmp(item, "och") ||
 		!g_ascii_strcasecmp(item, "mch") ||
-		!g_ascii_strcasecmp(item, "cch")) {
+		!g_ascii_strcasecmp(item, "cch") ||
+		(int_telecom && !g_ascii_strcasecmp(item, "spd")) ||
+		(int_telecom && !g_ascii_strcasecmp(item, "fav"))) {
 		tmp = path;
 		tmp1 = g_ascii_strdown(item, -1);
 		path = g_build_filename(tmp, tmp1, NULL);
diff --git a/obexd/plugins/phonebook.h b/obexd/plugins/phonebook.h
index fff33c1..70a9cb7 100644
--- a/obexd/plugins/phonebook.h
+++ b/obexd/plugins/phonebook.h
@@ -37,6 +37,8 @@
 #define PB_CALLS_INCOMING_FOLDER "/telecom/ich"
 #define PB_CALLS_MISSED_FOLDER "/telecom/mch"
 #define PB_CALLS_OUTGOING_FOLDER "/telecom/och"
+#define PB_CALLS_SPEEDDIAL_FOLDER "/telecom/spd"
+#define PB_CALLS_FAVORITE_FOLDER "/telecom/fav"
 #define PB_LUID_FOLDER "/telecom/pb/luid"
 
 #define PB_CONTACTS "/telecom/pb.vcf"
@@ -44,6 +46,8 @@
 #define PB_CALLS_INCOMING "/telecom/ich.vcf"
 #define PB_CALLS_MISSED "/telecom/mch.vcf"
 #define PB_CALLS_OUTGOING "/telecom/och.vcf"
+#define PB_CALLS_SPEEDDIAL "/telecom/spd.vcf"
+#define PB_CALLS_FAVORITE "/telecom/fav.vcf"
 #define PB_DEVINFO "/telecom/devinfo.txt"
 #define PB_INFO_LOG "/telecom/pb/info.log"
 #define PB_CC_LOG "/telecom/pb/luid/cc.log"
-- 
1.9.1

