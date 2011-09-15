Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 3/5] Remove not referenced function in storage.c
Date: Thu, 15 Sep 2011 16:32:21 -0300
Message-Id: <1316115141-19802-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1315572669-5006-4-git-send-email-claudio.takahasi@openbossa.org>
References: <1315572669-5006-4-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/storage.c |   29 -----------------------------
 src/storage.h |    1 -
 2 files changed, 0 insertions(+), 30 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 8d3a39d..85cfed8 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -732,35 +732,6 @@ gboolean read_trust(const bdaddr_t *local, const char *addr, const char *service
 	return ret;
 }
 
-struct trust_list {
-	GSList *trusts;
-	const char *service;
-};
-
-static void append_trust(char *key, char *value, void *data)
-{
-	struct trust_list *list = data;
-
-	if (strstr(value, list->service))
-		list->trusts = g_slist_append(list->trusts, g_strdup(key));
-}
-
-GSList *list_trusts(bdaddr_t *local, const char *service)
-{
-	char filename[PATH_MAX + 1];
-	struct trust_list list;
-
-	create_filename(filename, PATH_MAX, local, "trusts");
-
-	list.trusts = NULL;
-	list.service = service;
-
-	if (textfile_foreach(filename, append_trust, &list) < 0)
-		return NULL;
-
-	return list.trusts;
-}
-
 int write_device_profiles(bdaddr_t *src, bdaddr_t *dst, const char *profiles)
 {
 	char filename[PATH_MAX + 1], addr[18];
diff --git a/src/storage.h b/src/storage.h
index 7340ff7..dbe717f 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -52,7 +52,6 @@ int read_link_key(bdaddr_t *local, bdaddr_t *peer, unsigned char *key, uint8_t *
 ssize_t read_pin_code(bdaddr_t *local, bdaddr_t *peer, char *pin);
 gboolean read_trust(const bdaddr_t *local, const char *addr, const char *service);
 int write_trust(const char *src, const char *addr, const char *service, gboolean trust);
-GSList *list_trusts(bdaddr_t *local, const char *service);
 int write_device_profiles(bdaddr_t *src, bdaddr_t *dst, const char *profiles);
 int delete_entry(bdaddr_t *src, const char *storage, const char *key);
 int store_record(const gchar *src, const gchar *dst, sdp_record_t *rec);
-- 
1.7.6.1

