Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ v2 10/16] heartrate: Get rid of gint
Date: Wed,  1 May 2013 02:28:04 -0300
Message-Id: <1367386090-24633-10-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1367386090-24633-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1367386090-24633-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Use plain int instead of gint. In glib gint is always a typedef to int,
so it's safe to use it even for callbacks with glib.
---
 profiles/heartrate/heartrate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 3a2d419..8de81bb 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -115,7 +115,7 @@ static const char *location2str(uint8_t value)
 	return NULL;
 }
 
-static gint cmp_adapter(gconstpointer a, gconstpointer b)
+static int cmp_adapter(gconstpointer a, gconstpointer b)
 {
 	const struct heartrate_adapter *hradapter = a;
 	const struct btd_adapter *adapter = b;
@@ -126,7 +126,7 @@ static gint cmp_adapter(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
-static gint cmp_device(gconstpointer a, gconstpointer b)
+static int cmp_device(gconstpointer a, gconstpointer b)
 {
 	const struct heartrate *hr = a;
 	const struct btd_device *dev = b;
@@ -137,7 +137,7 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
-static gint cmp_watcher(gconstpointer a, gconstpointer b)
+static int cmp_watcher(gconstpointer a, gconstpointer b)
 {
 	const struct watcher *watcher = a;
 	const struct watcher *match = b;
-- 
1.8.2.2

