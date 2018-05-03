Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Sahil Pai <sahil.pai1@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>,
        Sahil Pai <sahil.pai1@samsung.com>
Subject: [PATCH 1/1] obexd: Fix memory leak when loading plugins
Date: Thu, 03 May 2018 17:35:38 +0530
Message-id: <1525349138-6194-1-git-send-email-sahil.pai1@samsung.com>
References: <CGME20180503120603epcas1p1d9863187b17bd7afae23284c8767aa9c@epcas1p1.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On failure to open plugin directory, memory allocated to 'patterns'
and 'excludes' is not being freed, and the following memory leak is
logged:

Direct leak of 28 byte(s) in 1 object(s) allocated from:
    #0 0xb6aa1c49 in malloc (/usr/lib/liblsan.so+0x9c49)
    #1 0xb6976e89 in g_malloc (/lib/libglib-2.0.so.0+0x3ae89)
    #2 0xb69886f1 in g_strsplit_set (/lib/libglib-2.0.so.0+0x4c6f1)
    #3 0xb6f82f3b in plugin_init (/usr/libexec/bluetooth/obexd+0x20f3b)
    #4 0xb6f70dc9 in main (/usr/libexec/bluetooth/obexd+0xedc9)
---
 obexd/src/plugin.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/obexd/src/plugin.c b/obexd/src/plugin.c
index 7d971b6..a1962b9 100644
--- a/obexd/src/plugin.c
+++ b/obexd/src/plugin.c
@@ -138,8 +138,11 @@ gboolean plugin_init(const char *pattern, const char *exclude)
 	DBG("Loading plugins %s", PLUGINDIR);
 
 	dir = g_dir_open(PLUGINDIR, 0, NULL);
-	if (!dir)
+	if (!dir) {
+		g_strfreev(patterns);
+		g_strfreev(excludes);
 		return FALSE;
+	}
 
 	while ((file = g_dir_read_name(dir)) != NULL) {
 		struct obex_plugin_desc *desc;
-- 
1.9.1

