Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 6/8] core: Free parsed options
Date: Fri, 30 Nov 2012 12:25:01 +0100
Message-ID: <1354274703-15604-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1354274703-15604-1-git-send-email-szymon.janc@tieto.com>
References: <1354274703-15604-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to keep already parsed options in memory. This also
fix not freeing options at all.

2 bytes in 1 blocks are still reachable in loss record 1 of 153
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E942DD: g_strdup (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x167333: parse_debug (main.c:425)
   by 0x4E839D8: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E8403F: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E85233: g_option_context_parse (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x121084: main (main.c:462)

16 bytes in 2 blocks are still reachable in loss record 39 of 153
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E5D68B: g_convert_with_iconv (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E5D94B: g_convert (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E5DFBA: g_locale_to_utf8 (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E837C7: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E8403F: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E85233: g_option_context_parse (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x121084: main (main.c:462)
---
 src/main.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/main.c b/src/main.c
index ccb5fa5..bc53a8e 100644
--- a/src/main.c
+++ b/src/main.c
@@ -344,6 +344,18 @@ static gboolean option_detach = TRUE;
 static gboolean option_version = FALSE;
 static gboolean option_udev = FALSE;
 
+static void free_options(void)
+{
+	g_free(option_debug);
+	option_debug = NULL;
+
+	g_free(option_plugin);
+	option_plugin = NULL;
+
+	g_free(option_noplugin);
+	option_noplugin = NULL;
+}
+
 static guint last_adapter_timeout = 0;
 
 static gboolean exit_timeout(gpointer data)
@@ -533,6 +545,9 @@ int main(int argc, char *argv[])
 	 * daemon needs to be re-worked. */
 	plugin_init(config, option_plugin, option_noplugin);
 
+	/* no need to keep parsed option in memory */
+	free_options();
+
 	mgmt_err = mgmt_setup();
 	if (mgmt_err < 0) {
 		error("mgmt setup failed: %s", strerror(-mgmt_err));
-- 
1.7.9.5

