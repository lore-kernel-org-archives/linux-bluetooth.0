Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH 4/5] Move main_opts from gatttool.c to header file
Date: Tue,  8 Feb 2011 12:32:15 -0300
Message-Id: <1297179136-14750-4-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1297179136-14750-1-git-send-email-sheldon.demario@openbossa.org>
References: <1297179136-14750-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatttool.c |   21 ---------------------
 attrib/gatttool.h |   21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 3eb3b0b..e0de05b 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -50,27 +50,6 @@
 static GMainLoop *event_loop;
 static gboolean got_error = FALSE;
 
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
-
 struct characteristic_data {
 	GAttrib *attrib;
 	uint16_t start;
diff --git a/attrib/gatttool.h b/attrib/gatttool.h
index 9190730..0f78aa8 100644
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
+} main_opts;
+
 int do_interactive(void);
-- 
1.7.1

