Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Bastien Nocera <hadess@hadess.net>
Subject: [RFC PATCH BlueZ 2/3] Add a btd_store_record_string() call
Date: Mon, 19 Sep 2011 19:42:04 +0200
Message-Id: <1316454126-32614-3-git-send-email-ospite@studenti.unina.it>
In-Reply-To: <1316454126-32614-1-git-send-email-ospite@studenti.unina.it>
References: <1316454126-32614-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add a new btd_* call to store an SDP record passed as a string, this is
going to be used by the external playstation-peripheral plugin.
---
 src/storage.h |    1 +
 src/storage.c |   17 +++++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/src/storage.h b/src/storage.h
index bb64727..c94c691 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -56,6 +56,7 @@ GSList *list_trusts(bdaddr_t *local, const char *service);
 int write_device_profiles(bdaddr_t *src, bdaddr_t *dst, const char *profiles);
 int delete_entry(bdaddr_t *src, const char *storage, const char *key);
 int store_record(const gchar *src, const gchar *dst, sdp_record_t *rec);
+int btd_store_record_string(const gchar *src, const gchar *dst, const gchar *record_str);
 sdp_record_t *record_from_string(const gchar *str);
 sdp_record_t *fetch_record(const gchar *src, const gchar *dst, const uint32_t handle);
 int delete_record(const gchar *src, const gchar *dst, const uint32_t handle);
diff --git a/src/storage.c b/src/storage.c
index 1f3da6e..8bf2d8d 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -816,6 +816,23 @@ int store_record(const gchar *src, const gchar *dst, sdp_record_t *rec)
 	return err;
 }
 
+int btd_store_record_string(const gchar *src,
+			    const gchar *dst,
+			    const gchar *record_str)
+{
+	sdp_record_t *record;
+	int ret = 0;
+
+	record = record_from_string(record_str);
+	if (record == NULL) {
+		return -ENOMEM;
+	}
+	ret = store_record(src, dst, record);
+	sdp_record_free(record);
+
+	return ret;
+}
+
 sdp_record_t *record_from_string(const gchar *str)
 {
 	sdp_record_t *rec;
-- 
1.7.6.3

