Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH 3/3] Add option to pass adapter to interactive gatttool
Date: Wed,  2 Mar 2011 19:36:58 -0300
Message-Id: <1299105418-15795-3-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1299105418-15795-1-git-send-email-sheldon.demario@openbossa.org>
References: <1299105418-15795-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatttool.c    |    2 +-
 attrib/gatttool.h    |    2 +-
 attrib/interactive.c |    4 +++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 975fb47..4e344ba 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -572,7 +572,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (opt_interactive) {
-		interactive(opt_dst, opt_psm);
+		interactive(opt_src, opt_dst, opt_psm);
 		goto done;
 	}
 
diff --git a/attrib/gatttool.h b/attrib/gatttool.h
index e652a81..89ac282 100644
--- a/attrib/gatttool.h
+++ b/attrib/gatttool.h
@@ -21,7 +21,7 @@
  *
  */
 
-int interactive(const gchar *dst, gboolean le);
+int interactive(const gchar *src, const gchar *dst, gboolean le);
 GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
 			const gchar *sec_level, int psm, int mtu,
 			BtIOConnect connect_cb);
diff --git a/attrib/interactive.c b/attrib/interactive.c
index e39b43c..5fc0af5 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -691,13 +691,14 @@ static gboolean prompt_read(GIOChannel *chan, GIOCondition cond,
 	return TRUE;
 }
 
-int interactive(const gchar *dst, int psm)
+int interactive(const gchar *src, const gchar *dst, int psm)
 {
 	GIOChannel *pchan;
 	gint events;
 
 	opt_sec_level = g_strdup("low");
 
+	opt_src = g_strdup(src);
 	opt_dst = g_strdup(dst);
 	opt_psm = psm;
 
@@ -720,6 +721,7 @@ int interactive(const gchar *dst, int psm)
 	g_main_loop_unref(event_loop);
 	g_string_free(prompt, TRUE);
 
+	g_free(opt_src);
 	g_free(opt_dst);
 	g_free(opt_sec_level);
 
-- 
1.7.1

