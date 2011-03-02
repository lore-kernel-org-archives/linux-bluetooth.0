Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH 1/3] Replace all strdup() with g_strdup() in gatttool
Date: Wed,  2 Mar 2011 19:36:56 -0300
Message-Id: <1299105418-15795-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatttool.c    |    2 +-
 attrib/interactive.c |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index e51db7b..975fb47 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -538,7 +538,7 @@ int main(int argc, char *argv[])
 	GIOChannel *chan;
 	GSourceFunc callback;
 
-	opt_sec_level = strdup("low");
+	opt_sec_level = g_strdup("low");
 
 	context = g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 52edeac..8429a47 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -303,7 +303,7 @@ static void cmd_connect(int argcp, char **argvp)
 
 	if (argcp > 1) {
 		g_free(opt_dst);
-		opt_dst = strdup(argvp[1]);
+		opt_dst = g_strdup(argvp[1]);
 	}
 
 	if (opt_dst == NULL) {
@@ -585,7 +585,7 @@ static void cmd_sec_level(int argcp, char **argvp)
 	}
 
 	g_free(opt_sec_level);
-	opt_sec_level = strdup(argvp[1]);
+	opt_sec_level = g_strdup(argvp[1]);
 
 	if (conn_state != STATE_CONNECTED)
 		return;
@@ -696,9 +696,9 @@ int interactive(gchar *dst, int psm)
 	GIOChannel *pchan;
 	gint events;
 
-	opt_sec_level = strdup("low");
+	opt_sec_level = g_strdup("low");
 
-	opt_dst = strdup(dst);
+	opt_dst = g_strdup(dst);
 	opt_psm = psm;
 
 	prompt = g_string_new(NULL);
-- 
1.7.1

