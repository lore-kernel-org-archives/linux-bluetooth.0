Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 7/7] Add generic function to delete by pattern
Date: Thu, 13 Oct 2011 11:43:24 -0300
Message-Id: <1318517004-17003-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1318517004-17003-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1318517004-17003-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove entries of textfile if the key has the prefix defined by the
pattern string.
---
 src/storage.c |   66 ++++++++++++++++++++------------------------------------
 1 files changed, 24 insertions(+), 42 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 1bd86d0..3aa1b7f 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1139,76 +1139,58 @@ int write_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
 static void filter_keys(char *key, char *value, void *data)
 {
 	struct match *match = data;
-	const char *address = match->pattern;
 
-	/* Each key contains: MAC#handle*/
-	if (strncasecmp(key, address, 17) == 0)
+	if (strncasecmp(key, match->pattern, strlen(match->pattern)) == 0)
 		match->keys = g_slist_append(match->keys, g_strdup(key));
 }
 
-int delete_device_service(const bdaddr_t *sba, const bdaddr_t *dba)
+static void delete_by_pattern(const char *filename, char *pattern)
 {
-	GSList *l;
 	struct match match;
-	char filename[PATH_MAX + 1], address[18];
+	GSList *l;
 	int err;
 
-	create_filename(filename, PATH_MAX, sba, "primary");
-
-	memset(address, 0, sizeof(address));
-	ba2str(dba, address);
-
-	err = textfile_del(filename, address);
-	if (err < 0)
-		return err;
-
-	/* Deleting all characteristics of a given address */
 	memset(&match, 0, sizeof(match));
-	match.pattern = address;
+	match.pattern = pattern;
 
-	create_filename(filename, PATH_MAX, sba, "characteristic");
 	err = textfile_foreach(filename, filter_keys, &match);
 	if (err < 0)
-		return err;
+		goto done;
 
 	for (l = match.keys; l; l = l->next) {
 		const char *key = l->data;
 		textfile_del(filename, key);
 	}
 
+done:
 	g_slist_free_full(match.keys, g_free);
+}
 
-	/* Deleting all attributes values of a given address */
-	memset(&match, 0, sizeof(match));
-	match.pattern = address;
+int delete_device_service(const bdaddr_t *sba, const bdaddr_t *dba)
+{
+	char filename[PATH_MAX + 1], address[18];
+	int err;
 
-	create_filename(filename, PATH_MAX, sba, "attributes");
-	err = textfile_foreach(filename, filter_keys, &match);
+	create_filename(filename, PATH_MAX, sba, "primary");
+
+	memset(address, 0, sizeof(address));
+	ba2str(dba, address);
+
+	err = textfile_del(filename, address);
 	if (err < 0)
 		return err;
 
-	for (l = match.keys; l; l = l->next) {
-		const char *key = l->data;
-		textfile_del(filename, key);
-	}
+	/* Deleting all characteristics of a given address */
+	create_filename(filename, PATH_MAX, sba, "characteristic");
+	delete_by_pattern(filename, address);
 
-	g_slist_free_full(match.keys, g_free);
+	/* Deleting all attributes values of a given address */
+	create_filename(filename, PATH_MAX, sba, "attributes");
+	delete_by_pattern(filename, address);
 
 	/* Deleting all CCC values of a given address */
-	memset(&match, 0, sizeof(match));
-	match.pattern = address;
-
 	create_filename(filename, PATH_MAX, sba, "ccc");
-	err = textfile_foreach(filename, filter_keys, &match);
-	if (err < 0)
-		return err;
-
-	for (l = match.keys; l; l = l->next) {
-		const char *key = l->data;
-		textfile_del(filename, key);
-	}
-
-	g_slist_free_full(match.keys, g_free);
+	delete_by_pattern(filename, address);
 
 	return 0;
 }
-- 
1.7.7

