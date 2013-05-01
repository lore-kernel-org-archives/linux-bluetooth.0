Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 04/16] plugins: Get rid of gint
Date: Wed,  1 May 2013 02:11:59 -0300
Message-Id: <1367385131-24034-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1367385131-24034-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1367385131-24034-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Use plain int instead of gint. In glib gint is always a typedef to int, so it's safe to use it even for callbacks with glib.
---
 plugins/gatt-example.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index bd0fbff..37972e8 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -83,7 +83,7 @@ static void gatt_example_adapter_free(struct gatt_example_adapter *gadapter)
 	g_free(gadapter);
 }
 
-static gint adapter_cmp(gconstpointer a, gconstpointer b)
+static int adapter_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct gatt_example_adapter *gatt_adapter = a;
 	const struct btd_adapter *adapter = b;
-- 
1.8.2.2

