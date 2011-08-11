Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [RFC obexd 3/4] Adapt get_next_header for 1 and 4 byte headers
Date: Fri, 12 Aug 2011 01:43:07 +0200
Message-Id: <1313106188-30273-4-git-send-email-adamek.kuba@gmail.com>
In-Reply-To: <1313106188-30273-1-git-send-email-adamek.kuba@gmail.com>
References: <1313106188-30273-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to not complicate memory management by having drivers
allocate their own memory for multibyte headers, functions
are introduced that encode the 1 and 4 byte headers in the
given buffer.
---
 src/obex.c |   40 +++++++++++++++++++++++++++++++++++++++-
 src/obex.h |    3 +++
 2 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index e207f66..42e9f20 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -612,6 +612,24 @@ static int obex_write_stream(struct obex_session *os,
 	return 0;
 }
 
+static void fill_headerdata(obex_headerdata_t *hd, uint8_t hi, void *buf)
+{
+	guint8 *val8 = buf;
+	guint32 *val32 = buf;
+	switch (hi & OBEX_HDR_TYPE_MASK) {
+	case OBEX_HDR_TYPE_BYTES:
+	case OBEX_HDR_TYPE_UNICODE:
+		hd->bs = buf;
+		break;
+	case OBEX_HDR_TYPE_UINT8:
+		hd->bq1 = *val8;
+		break;
+	case OBEX_HDR_TYPE_UINT32:
+		hd->bq4 = *val32;
+		break;
+	}
+}
+
 static int obex_write(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 {
 	obex_headerdata_t hd;
@@ -657,7 +675,7 @@ static int obex_write(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 		if (hi == OBEX_HDR_EMPTY)
 			break;
 
-		hd.bs = os->buf;
+		fill_headerdata(&hd, hi, os->buf);
 		OBEX_ObjectAddHeader(obex, obj, hi, hd, len, 0);
 	}
 
@@ -1627,6 +1645,26 @@ int obex_aparam_write(struct obex_session *os,
 			OBEX_HDR_APPARAM, hd, size, 0);
 }
 
+inline ssize_t put_hdr_u8(void *buf, size_t mtu, guint8 u8) {
+	guint8 *tmp = buf;
+	if (tmp == NULL)
+		return -1;
+	if (mtu < sizeof(guint8))
+		return -1;
+	*tmp = u8;
+	return sizeof(guint8);
+}
+
+inline ssize_t put_hdr_u32(void *buf, size_t mtu, guint32 u32) {
+	guint32 *tmp = buf;
+	if (tmp == NULL)
+		return -1;
+	if (mtu < sizeof(guint32))
+		return -1;
+	*tmp = u32;
+	return sizeof(guint32);
+}
+
 int memncmp0(const void *a, size_t na, const void *b, size_t nb)
 {
 	if (na != nb)
diff --git a/src/obex.h b/src/obex.h
index 03243f1..1fff957 100644
--- a/src/obex.h
+++ b/src/obex.h
@@ -71,5 +71,8 @@ int obex_aparam_write(struct obex_session *os, obex_object_t *obj,
 const char *obex_option_root_folder(void);
 gboolean obex_option_symlinks(void);
 
+inline gboolean put_hdr_u8(void *buf, size_t mtu, guint8 u8);
+inline gboolean put_hdr_u32(void *buf, size_t mtu, guint32 u32);
+
 /* Just a thin wrapper around memcmp to deal with NULL values */
 int memncmp0(const void *a, size_t na, const void *b, size_t nb);
-- 
1.7.4.1

