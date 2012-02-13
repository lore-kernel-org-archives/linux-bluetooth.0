Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>,
	Bastien Nocera <hadess@hadess.net>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH BlueZ 2/3] storage: add a btd_store_record_string() call
Date: Mon, 13 Feb 2012 15:42:47 +0100
Message-Id: <1329144168-19263-3-git-send-email-ospite@studenti.unina.it>
In-Reply-To: <1329144168-19263-1-git-send-email-ospite@studenti.unina.it>
References: <1329144168-19263-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add a new btd_* call to store an SDP record passed as a string, meant to
be used by _external_ plugins.
---
 src/storage.c |   17 +++++++++++++++++
 src/storage.h |    1 +
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index a65cee4..e15705c 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -785,6 +785,23 @@ int store_record(const gchar *src, const gchar *dst, sdp_record_t *rec)
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
diff --git a/src/storage.h b/src/storage.h
index 2f145d0..eb61e47 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -56,6 +56,7 @@ int write_trust(const char *src, const char *addr, const char *service, gboolean
 int write_device_profiles(bdaddr_t *src, bdaddr_t *dst, const char *profiles);
 int delete_entry(bdaddr_t *src, const char *storage, const char *key);
 int store_record(const gchar *src, const gchar *dst, sdp_record_t *rec);
+int btd_store_record_string(const gchar *src, const gchar *dst, const gchar *record_str);
 sdp_record_t *record_from_string(const gchar *str);
 sdp_record_t *fetch_record(const gchar *src, const gchar *dst, const uint32_t handle);
 int delete_record(const gchar *src, const gchar *dst, const uint32_t handle);
-- 
1.7.9

