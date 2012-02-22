Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Cc: chanyeol.park@samsung.com
Subject: [PATCH] Remove leftover code of main_opts operation
Date: Wed, 22 Feb 2012 23:15:26 +0900
Message-id: <1329920126-28003-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>


diff --git a/src/hcid.h b/src/hcid.h
index 1987b7d..e2eaf86 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -46,10 +46,7 @@ struct main_opts {
 };
 
 enum {
-	HCID_SET_NAME,
-	HCID_SET_CLASS,
 	HCID_SET_PAGETO,
-	HCID_SET_DISCOVTO,
 };
 
 extern struct main_opts main_opts;
diff --git a/src/main.c b/src/main.c
index 74ec3fa..60a0816 100644
--- a/src/main.c
+++ b/src/main.c
@@ -107,7 +107,6 @@ static void parse_config(GKeyFile *config)
 	} else {
 		DBG("discovto=%d", val);
 		main_opts.discovto = val;
-		main_opts.flags |= 1 << HCID_SET_DISCOVTO;
 	}
 
 	val = g_key_file_get_integer(config, "General",
@@ -148,7 +147,6 @@ static void parse_config(GKeyFile *config)
 		DBG("name=%s", str);
 		g_free(main_opts.name);
 		main_opts.name = g_strdup(str);
-		main_opts.flags |= 1 << HCID_SET_NAME;
 		g_free(str);
 	}
 
@@ -159,7 +157,6 @@ static void parse_config(GKeyFile *config)
 	} else {
 		DBG("class=%s", str);
 		main_opts.class = strtol(str, NULL, 16);
-		main_opts.flags |= 1 << HCID_SET_CLASS;
 		g_free(str);
 	}
 
-- 
1.7.5.4

