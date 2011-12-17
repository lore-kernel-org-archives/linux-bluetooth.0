Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/3] gobex: add defines for possible values of SRMP header
Date: Sat, 17 Dec 2011 12:17:46 +0200
Message-Id: <1324117067-12459-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1324117067-12459-1-git-send-email-luiz.dentz@gmail.com>
References: <1324117067-12459-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Also rename G_OBEX_HDR_SRM_PARAMETERS to just G_OBEX_HDR_SRMP as the spec
normally refer to it.
---
 gobex/gobex-header.h |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gobex/gobex-header.h b/gobex/gobex-header.h
index 3320cfa..2ee8364 100644
--- a/gobex/gobex-header.h
+++ b/gobex/gobex-header.h
@@ -53,7 +53,7 @@
 #define G_OBEX_HDR_DESTNAME		0x15
 #define G_OBEX_HDR_PERMISSIONS		0xd6
 #define G_OBEX_HDR_SRM			0x97
-#define G_OBEX_HDR_SRM_PARAMETERS	0x98
+#define G_OBEX_HDR_SRMP			0x98
 
 /* Action header values */
 #define G_OBEX_ACTION_COPY		0x00
@@ -65,6 +65,11 @@
 #define G_OBEX_SRM_ENABLE		0x01
 #define G_OBEX_SRM_INDICATE		0x02
 
+/* SRMP header values */
+#define G_OBEX_SRMP_NEXT		0x00
+#define G_OBEX_SRMP_WAIT		0x01
+#define G_OBEX_SRMP_NEXT_WAIT		0x02
+
 typedef struct _GObexHeader GObexHeader;
 
 gboolean g_obex_header_get_unicode(GObexHeader *header, const char **str);
-- 
1.7.7.4

