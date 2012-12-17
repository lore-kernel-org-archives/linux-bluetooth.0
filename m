Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 09/11] core: Remove mode option form main_opts
Date: Mon, 17 Dec 2012 15:44:56 +0100
Message-ID: <1355755498-2700-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355755498-2700-1-git-send-email-szymon.janc@tieto.com>
References: <1355755498-2700-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Config option is removed so this is no longer needed.
---
 src/adapter.c | 9 ++-------
 src/hcid.h    | 2 --
 src/main.c    | 1 -
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index e97e9bb..035a4ca 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2746,12 +2746,7 @@ static void load_config(struct btd_adapter *adapter)
 
 	/* Get discoverable mode */
 	adapter->discoverable = g_key_file_get_boolean(key_file, "General",
-							"Discoverable", &gerr);
-	if (gerr) {
-		adapter->discoverable = (main_opts.mode == MODE_DISCOVERABLE);
-		g_error_free(gerr);
-		gerr = NULL;
-	}
+							"Discoverable", NULL);
 
 	/* Get discoverable timeout */
 	adapter->discov_timeout = g_key_file_get_integer(key_file, "General",
@@ -2762,7 +2757,7 @@ static void load_config(struct btd_adapter *adapter)
 		gerr = NULL;
 	}
 
-	adapter->mode = main_opts.mode;
+	adapter->mode = MODE_OFF;
 
 	mgmt_set_connectable(adapter->dev_id, TRUE);
 	mgmt_set_discoverable(adapter->dev_id, adapter->discoverable,
diff --git a/src/hcid.h b/src/hcid.h
index 1c3af7d..aa563dc 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -38,8 +38,6 @@ struct main_opts {
 	gboolean	name_resolv;
 	gboolean	debug_keys;
 
-	uint8_t		mode;
-
 	uint16_t	did_source;
 	uint16_t	did_vendor;
 	uint16_t	did_product;
diff --git a/src/main.c b/src/main.c
index 290a0eb..59a0ad9 100644
--- a/src/main.c
+++ b/src/main.c
@@ -230,7 +230,6 @@ static void init_defaults(void)
 {
 	/* Default HCId settings */
 	memset(&main_opts, 0, sizeof(main_opts));
-	main_opts.mode	= MODE_OFF;
 	main_opts.name	= g_strdup("BlueZ");
 	main_opts.discovto	= DEFAULT_DISCOVERABLE_TIMEOUT;
 	main_opts.autoto = DEFAULT_AUTO_CONNECT_TIMEOUT;
-- 
1.8.0

