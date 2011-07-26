Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<ulrik.lauren@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 2/3] Enhance dynamic debug with support for external debug sections
Date: Tue, 26 Jul 2011 15:57:11 +0200
Message-ID: <1311688632-19334-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1311688632-19334-1-git-send-email-szymon.janc@tieto.com>
References: <1311688632-19334-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow to enable debug messages whose control flag is not
stored in debug section of main binary but i.e. in external plugin
foo.so file.
---
 src/log.c |   25 +++++++++++++++++++++++++
 src/log.h |    8 ++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/src/log.c b/src/log.c
index 2c492e9..c5e0c74 100644
--- a/src/log.c
+++ b/src/log.c
@@ -70,6 +70,7 @@ extern struct btd_debug_desc __start___debug[];
 extern struct btd_debug_desc __stop___debug[];
 
 static gchar **enabled = NULL;
+static GSList *ext_debugs = NULL;
 
 static gboolean is_enabled(struct btd_debug_desc *desc)
 {
@@ -89,9 +90,17 @@ static gboolean is_enabled(struct btd_debug_desc *desc)
 void __btd_toggle_debug(void)
 {
 	struct btd_debug_desc *desc;
+	GSList *l;
 
 	for (desc = __start___debug; desc < __stop___debug; desc++)
 		desc->flags |= BTD_DEBUG_FLAG_PRINT;
+
+	for (l = ext_debugs; l; l = l->next) {
+		struct btd_debug_section *debug = l->data;
+
+		for (desc = debug->start; desc < debug->stop; desc++)
+			desc->flags |= BTD_DEBUG_FLAG_PRINT;
+	}
 }
 
 void __btd_log_init(const char *debug, int detach)
@@ -120,3 +129,19 @@ void __btd_log_cleanup(void)
 
 	g_strfreev(enabled);
 }
+
+void __btd_log_add(struct btd_debug_section *debug)
+{
+	struct btd_debug_desc *desc;
+
+	ext_debugs = g_slist_prepend(ext_debugs, debug);
+
+	for (desc = debug->start; desc < debug->stop; desc++)
+		if (is_enabled(desc))
+			desc->flags |= BTD_DEBUG_FLAG_PRINT;
+}
+
+void __btd_log_remove(struct btd_debug_section *debug)
+{
+	ext_debugs = g_slist_remove(ext_debugs, debug);
+}
diff --git a/src/log.h b/src/log.h
index 78bbdd8..1f2d13d 100644
--- a/src/log.h
+++ b/src/log.h
@@ -37,6 +37,14 @@ struct btd_debug_desc {
 	unsigned int flags;
 } __attribute__((aligned(8)));
 
+struct btd_debug_section {
+	struct btd_debug_desc *start;
+	struct btd_debug_desc *stop;
+};
+
+void __btd_log_add(struct btd_debug_section *debug);
+void __btd_log_remove(struct btd_debug_section *debug);
+
 /**
  * DBG:
  * @fmt: format string
-- 
on behalf of ST-Ericsson

