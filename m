Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ v2 11/16] input: Get rid of gint
Date: Wed,  1 May 2013 02:28:05 -0300
Message-Id: <1367386090-24633-11-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1367386090-24633-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1367386090-24633-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Use plain int instead of gint. In glib gint is always a typedef to int,
so it's safe to use it even for callbacks with glib.
---
 profiles/input/hog.c    | 2 +-
 profiles/input/server.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index c092875..3ce9480 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -539,7 +539,7 @@ static void output_written_cb(guint8 status, const guint8 *pdu,
 	}
 }
 
-static gint report_type_cmp(gconstpointer a, gconstpointer b)
+static int report_type_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct report *report = a;
 	uint8_t type = GPOINTER_TO_UINT(b);
diff --git a/profiles/input/server.c b/profiles/input/server.c
index e15ae88..5c98573 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -55,7 +55,7 @@ struct input_server {
 	GIOChannel *confirm;
 };
 
-static gint server_cmp(gconstpointer s, gconstpointer user_data)
+static int server_cmp(gconstpointer s, gconstpointer user_data)
 {
 	const struct input_server *server = s;
 	const bdaddr_t *src = user_data;
-- 
1.8.2.2

