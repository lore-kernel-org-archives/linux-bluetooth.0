Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ v2 12/16] scanparam: Get rid of gint
Date: Wed,  1 May 2013 02:28:06 -0300
Message-Id: <1367386090-24633-12-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1367386090-24633-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1367386090-24633-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Use plain int instead of gint. In glib gint is always a typedef to int,
so it's safe to use it even for callbacks with glib.
---
 profiles/scanparam/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index dbbb4ea..a9baec8 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -66,7 +66,7 @@ struct scan {
 
 static GSList *servers = NULL;
 
-static gint scan_device_cmp(gconstpointer a, gconstpointer b)
+static int scan_device_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct scan *scan = a;
 	const struct btd_device *device = b;
-- 
1.8.2.2

