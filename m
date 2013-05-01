Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ v2 08/16] gatt: Get rid of gint
Date: Wed,  1 May 2013 02:28:02 -0300
Message-Id: <1367386090-24633-8-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1367386090-24633-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1367386090-24633-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Use plain int instead of gint. In glib gint is always a typedef to int,
so it's safe to use it even for callbacks with glib.
---
 profiles/gatt/gas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 39e9421..2ed837f 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -71,7 +71,7 @@ static void gas_free(struct gas *gas)
 	g_free(gas);
 }
 
-static gint cmp_device(gconstpointer a, gconstpointer b)
+static int cmp_device(gconstpointer a, gconstpointer b)
 {
 	const struct gas *gas = a;
 	const struct btd_device *device = b;
-- 
1.8.2.2

