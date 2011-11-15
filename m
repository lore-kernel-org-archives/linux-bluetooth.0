Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 01/16] Remove unused function obex_aparam_write
Date: Tue, 15 Nov 2011 15:27:52 +0200
Message-Id: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/obex.c |   11 -----------
 src/obex.h |    2 --
 2 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index 0d00f7f..70a0c68 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -1548,17 +1548,6 @@ ssize_t obex_aparam_read(struct obex_session *os,
 	return -EBADR;
 }
 
-int obex_aparam_write(struct obex_session *os,
-		obex_object_t *obj, const uint8_t *data, unsigned int size)
-{
-	obex_headerdata_t hd;
-
-	hd.bs = data;
-
-	return OBEX_ObjectAddHeader(os->obex, obj,
-			OBEX_HDR_APPARAM, hd, size, 0);
-}
-
 int memncmp0(const void *a, size_t na, const void *b, size_t nb)
 {
 	if (na != nb)
diff --git a/src/obex.h b/src/obex.h
index 0f3360b..e3f399a 100644
--- a/src/obex.h
+++ b/src/obex.h
@@ -49,8 +49,6 @@ uint8_t obex_get_action_id(struct obex_session *os);
 char *obex_get_id(struct obex_session *os);
 ssize_t obex_aparam_read(struct obex_session *os, obex_object_t *obj,
 						const uint8_t **buffer);
-int obex_aparam_write(struct obex_session *os, obex_object_t *obj,
-				const uint8_t *buffer, unsigned int size);
 
 /* Just a thin wrapper around memcmp to deal with NULL values */
 int memncmp0(const void *a, size_t na, const void *b, size_t nb);
-- 
1.7.7.1

