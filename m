Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC] shared/tester: Allow to pass extra options
Date: Tue, 26 May 2015 15:33:36 +0200
Message-Id: <1432647216-11197-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to pass custom GOptionEntry from tester. Will be useful
if tester takes non-standard arguments. void* is used to not leak
Glib API to tester API if extra options are not used.
---
 src/shared/tester.c | 8 ++++++++
 src/shared/tester.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index 30857e0..6922195 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -784,12 +784,20 @@ static GOptionEntry options[] = {
 
 void tester_init(int *argc, char ***argv)
 {
+	tester_init_extra(argc, argv, NULL);
+}
+
+void tester_init_extra(int *argc, char ***argv, void *extra)
+{
 	GOptionContext *context;
 	GError *error = NULL;
 
 	context = g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
 
+	if (extra)
+		g_option_context_add_main_entries(context, extra, NULL);
+
 	if (g_option_context_parse(context, argc, argv, &error) == FALSE) {
 		if (error != NULL) {
 			g_printerr("%s\n", error->message);
diff --git a/src/shared/tester.h b/src/shared/tester.h
index 83ef5de..89a04a2 100644
--- a/src/shared/tester.h
+++ b/src/shared/tester.h
@@ -23,6 +23,7 @@
 
 #include <stdbool.h>
 
+void tester_init_extra(int *argc, char ***argv, void *extra);
 void tester_init(int *argc, char ***argv);
 int tester_run(void);
 
-- 
1.9.3

