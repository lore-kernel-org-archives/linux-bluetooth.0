Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v3 18/20] client-doc: PhonebookAccess sessions return transfers
Date: Tue, 13 Dec 2011 17:44:21 +0100
Message-ID: <1323794663-2711-19-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1323794663-2711-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1323794663-2711-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/sync.c      |   12 ++++--------
 doc/client-api.txt |   23 +++++++++++++++++++----
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/client/sync.c b/client/sync.c
index 83f37bf..b0f828b 100644
--- a/client/sync.c
+++ b/client/sync.c
@@ -132,15 +132,14 @@ static DBusMessage *sync_putphonebook(DBusConnection *connection,
 			DBusMessage *message, void *user_data)
 {
 	struct sync_data *sync = user_data;
-	const char *buf;
-	char *buffer;
+	const char *sourcefile;
 	DBusMessage *reply;
 	struct obc_transfer *transfer;
 	const char *path;
 	int err;
 
 	if (dbus_message_get_args(message, NULL,
-			DBUS_TYPE_STRING, &buf,
+			DBUS_TYPE_STRING, &sourcefile,
 			DBUS_TYPE_INVALID) == FALSE)
 		return g_dbus_create_error(message,
 			ERROR_INF ".InvalidArguments", NULL);
@@ -149,11 +148,8 @@ static DBusMessage *sync_putphonebook(DBusConnection *connection,
 	if (!sync->phonebook_path)
 		sync->phonebook_path = g_strdup("telecom/pb.vcf");
 
-	buffer = g_strdup(buf);
-
-	transfer = obc_session_put_mem(sync->session, sync->phonebook_path,
-				buffer, strlen(buffer), g_free, TRUE,
-				&err);
+	transfer = obc_session_put(sync->session, sync->phonebook_path,
+				sourcefile, TRUE, &err);
 
 	if (err < 0)
 		return g_dbus_create_error(message,
diff --git a/doc/client-api.txt b/doc/client-api.txt
index 5030909..b887d16 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -202,10 +202,18 @@ Methods		void Select(string location, string phonebook)
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
 
@@ -213,10 +221,17 @@ Methods		void Select(string location, string phonebook)
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

