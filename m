Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 13/16] thermometer: Get rid of gint
Date: Wed,  1 May 2013 02:12:08 -0300
Message-Id: <1367385131-24034-13-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1367385131-24034-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1367385131-24034-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Use plain int instead of gint. In glib gint is always a typedef to int, so it's safe to use it even for callbacks with glib.
---
 profiles/thermometer/thermometer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 3757b25..c2ca251 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -190,7 +190,7 @@ static void destroy_thermometer_adapter(gpointer user_data)
 	g_free(tadapter);
 }
 
-static gint cmp_adapter(gconstpointer a, gconstpointer b)
+static int cmp_adapter(gconstpointer a, gconstpointer b)
 {
 	const struct thermometer_adapter *tadapter = a;
 	const struct btd_adapter *adapter = b;
@@ -201,7 +201,7 @@ static gint cmp_adapter(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
-static gint cmp_device(gconstpointer a, gconstpointer b)
+static int cmp_device(gconstpointer a, gconstpointer b)
 {
 	const struct thermometer *t = a;
 	const struct btd_device *dev = b;
@@ -212,7 +212,7 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
-static gint cmp_watcher(gconstpointer a, gconstpointer b)
+static int cmp_watcher(gconstpointer a, gconstpointer b)
 {
 	const struct watcher *watcher = a;
 	const struct watcher *match = b;
-- 
1.8.2.2

