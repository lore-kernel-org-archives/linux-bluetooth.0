Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 02/16] Remove use of obex_object_t on obex.h
Date: Tue, 15 Nov 2011 15:27:53 +0200
Message-Id: <1321363687-32490-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
References: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Plugins including obex.h need to include openobex headers because of
this.
---
 plugins/pbap.c  |    2 +-
 src/obex-priv.h |    2 ++
 src/obex.c      |   28 +++++++++++++---------------
 src/obex.h      |    3 +--
 4 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index 997b5bd..fb82766 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -642,7 +642,7 @@ static int pbap_get(struct obex_session *os, obex_object_t *obj,
 	if (type == NULL)
 		return -EBADR;
 
-	rsize = obex_aparam_read(os, obj, &buffer);
+	rsize = obex_get_apparam(os, &buffer);
 	if (rsize < 0) {
 		if (g_ascii_strcasecmp(type, VCARDENTRY_TYPE) != 0)
 			return -EBADR;
diff --git a/src/obex-priv.h b/src/obex-priv.h
index 01b6496..a834511 100644
--- a/src/obex-priv.h
+++ b/src/obex-priv.h
@@ -34,6 +34,8 @@ struct obex_session {
 	char *type;
 	char *path;
 	time_t time;
+	uint8_t *apparam;
+	size_t apparam_len;
 	uint8_t *buf;
 	int64_t pending;
 	int64_t offset;
diff --git a/src/obex.c b/src/obex.c
index 70a0c68..a1621b9 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -312,6 +312,11 @@ static void os_reset_session(struct obex_session *os)
 		g_free(os->path);
 		os->path = NULL;
 	}
+	if (os->apparam) {
+		g_free(os->apparam);
+		os->apparam = NULL;
+		os->apparam_len = 0;
+	}
 
 	os->object = NULL;
 	os->obj = NULL;
@@ -825,6 +830,11 @@ static void cmd_get(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 						os->service->who_size);
 			break;
 		}
+
+		if (hi == OBEX_HDR_APPARAM) {
+			os->apparam = g_memdup(hd.bs, hlen);
+			os->apparam_len = hlen;
+		}
 	}
 
 	if (os->type == NULL)
@@ -1529,23 +1539,11 @@ char *obex_get_id(struct obex_session *os)
 	return g_strdup_printf("%s+%d", address, channel);
 }
 
-ssize_t obex_aparam_read(struct obex_session *os,
-		obex_object_t *obj, const uint8_t **buffer)
+ssize_t obex_get_apparam(struct obex_session *os, const uint8_t **buffer)
 {
-	obex_headerdata_t hd;
-	uint8_t hi;
-	uint32_t hlen;
-
-	OBEX_ObjectReParseHeaders(os->obex, obj);
-
-	while (OBEX_ObjectGetNextHeader(os->obex, obj, &hi, &hd, &hlen)) {
-		if (hi == OBEX_HDR_APPARAM) {
-			*buffer = hd.bs;
-			return hlen;
-		}
-	}
+	*buffer = os->apparam;
 
-	return -EBADR;
+	return os->apparam_len;
 }
 
 int memncmp0(const void *a, size_t na, const void *b, size_t nb)
diff --git a/src/obex.h b/src/obex.h
index e3f399a..6ede0a4 100644
--- a/src/obex.h
+++ b/src/obex.h
@@ -47,8 +47,7 @@ int obex_move(struct obex_session *os, const char *source,
 						const char *destination);
 uint8_t obex_get_action_id(struct obex_session *os);
 char *obex_get_id(struct obex_session *os);
-ssize_t obex_aparam_read(struct obex_session *os, obex_object_t *obj,
-						const uint8_t **buffer);
+ssize_t obex_get_apparam(struct obex_session *os, const uint8_t **buffer);
 
 /* Just a thin wrapper around memcmp to deal with NULL values */
 int memncmp0(const void *a, size_t na, const void *b, size_t nb);
-- 
1.7.7.1

