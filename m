Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 06/16] cyclingspeed: Get rid of gint
Date: Wed,  1 May 2013 02:12:01 -0300
Message-Id: <1367385131-24034-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1367385131-24034-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1367385131-24034-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Use plain int instead of gint. In glib gint is always a typedef to int, so it's safe to use it even for callbacks with glib.
---
 profiles/cyclingspeed/cyclingspeed.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 6080f09..76be234 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -166,7 +166,7 @@ static int str2location(const char *location)
 	return -1;
 }
 
-static gint cmp_adapter(gconstpointer a, gconstpointer b)
+static int cmp_adapter(gconstpointer a, gconstpointer b)
 {
 	const struct csc_adapter *cadapter = a;
 	const struct btd_adapter *adapter = b;
@@ -177,7 +177,7 @@ static gint cmp_adapter(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
-static gint cmp_device(gconstpointer a, gconstpointer b)
+static int cmp_device(gconstpointer a, gconstpointer b)
 {
 	const struct csc *csc = a;
 	const struct btd_device *dev = b;
@@ -188,7 +188,7 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
-static gint cmp_watcher(gconstpointer a, gconstpointer b)
+static int cmp_watcher(gconstpointer a, gconstpointer b)
 {
 	const struct watcher *watcher = a;
 	const struct watcher *match = b;
-- 
1.8.2.2

