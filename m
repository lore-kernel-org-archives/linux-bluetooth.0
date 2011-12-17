Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/3] gobex: add defines for possible values of SRM header
Date: Sat, 17 Dec 2011 12:17:45 +0200
Message-Id: <1324117067-12459-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 gobex/gobex-header.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/gobex/gobex-header.h b/gobex/gobex-header.h
index 2420e75..3320cfa 100644
--- a/gobex/gobex-header.h
+++ b/gobex/gobex-header.h
@@ -60,6 +60,11 @@
 #define G_OBEX_ACTION_MOVE		0x01
 #define G_OBEX_ACTION_SETPERM		0x02
 
+/* SRM header values */
+#define G_OBEX_SRM_DISABLE		0x00
+#define G_OBEX_SRM_ENABLE		0x01
+#define G_OBEX_SRM_INDICATE		0x02
+
 typedef struct _GObexHeader GObexHeader;
 
 gboolean g_obex_header_get_unicode(GObexHeader *header, const char **str);
-- 
1.7.7.4

