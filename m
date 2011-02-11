Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH v2 4/5] Move main_opts from gatttool.c to header file
Date: Fri, 11 Feb 2011 11:17:22 -0300
Message-Id: <1297433843-9192-4-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1297433843-9192-1-git-send-email-sheldon.demario@openbossa.org>
References: <1297433843-9192-1-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <20110209212642.GA11368@jh-x301>
References: <20110209212642.GA11368@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatttool.c    |   22 +---------------------
 attrib/gatttool.h    |   21 +++++++++++++++++++++
 attrib/interactive.c |    2 ++
 3 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index cd6e68a..badd3b0 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -49,27 +49,7 @@
 
 static GMainLoop *event_loop;
 static gboolean got_error = FALSE;
-
-static struct main_opts {
-	gchar *src;
-	gchar *dst;
-	gchar *value;
-	gchar *sec_level;
-	uuid_t *uuid;
-	int start;
-	int end;
-	int handle;
-	int mtu;
-	int psm;
-	gboolean primary;
-	gboolean char_disc;
-	gboolean char_read;
-	gboolean listen;
-	gboolean char_desc;
-	gboolean le;
-	gboolean char_write;
-	gboolean interactive;
-} main_opts;
+static struct main_opts main_opts;
 
 struct characteristic_data {
 	GAttrib *attrib;
diff --git a/attrib/gatttool.h b/attrib/gatttool.h
index ed5d9d6..3dbe88b 100644
--- a/attrib/gatttool.h
+++ b/attrib/gatttool.h
@@ -21,4 +21,25 @@
  *
  */
 
+struct main_opts {
+	gchar *src;
+	gchar *dst;
+	gchar *value;
+	gchar *sec_level;
+	uuid_t *uuid;
+	int start;
+	int end;
+	int handle;
+	int mtu;
+	int psm;
+	gboolean primary;
+	gboolean char_disc;
+	gboolean char_read;
+	gboolean listen;
+	gboolean char_desc;
+	gboolean le;
+	gboolean char_write;
+	gboolean interactive;
+};
+
 int interactive(void);
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 0653609..425a9b2 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -25,6 +25,8 @@
 #include <stdio.h>
 #include <glib.h>
 
+#include <bluetooth/sdp.h>
+
 #include <readline/readline.h>
 #include <readline/history.h>
 
-- 
1.7.1

