Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 07/16] deviceinfo: Get rid of gint
Date: Wed,  1 May 2013 02:12:02 -0300
Message-Id: <1367385131-24034-7-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1367385131-24034-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1367385131-24034-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Use plain int instead of gint. In glib gint is always a typedef to int, so it's safe to use it even for callbacks with glib.
---
 profiles/deviceinfo/deviceinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
index fc8babd..e8cb5f7 100644
--- a/profiles/deviceinfo/deviceinfo.c
+++ b/profiles/deviceinfo/deviceinfo.c
@@ -75,7 +75,7 @@ static void deviceinfo_free(gpointer user_data)
 	g_free(d);
 }
 
-static gint cmp_device(gconstpointer a, gconstpointer b)
+static int cmp_device(gconstpointer a, gconstpointer b)
 {
 	const struct deviceinfo *d = a;
 	const struct btd_device *dev = b;
-- 
1.8.2.2

