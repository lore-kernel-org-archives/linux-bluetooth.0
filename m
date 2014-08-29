Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/6] android/avdtptest: Add option to reject commands
Date: Fri, 29 Aug 2014 15:17:55 +0200
Message-Id: <1409318278-798-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1409318278-798-1-git-send-email-szymon.janc@tieto.com>
References: <1409318278-798-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently all commands are rejected. If needed this can be extended
to specify which command to reject.
---
 android/avdtptest.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/android/avdtptest.c b/android/avdtptest.c
index 402d931..15fecc1 100644
--- a/android/avdtptest.c
+++ b/android/avdtptest.c
@@ -47,6 +47,7 @@ static struct avdtp *avdtp = NULL;
 struct avdtp_stream *avdtp_stream = NULL;
 struct avdtp_local_sep *local_sep = NULL;
 static GIOChannel *io = NULL;
+static bool reject = false;
 
 static guint media_player = 0;
 
@@ -218,6 +219,9 @@ static gboolean get_capability_ind(struct avdtp *session,
 
 	printf("%s\n", __func__);
 
+	if (reject)
+		return FALSE;
+
 	*caps = NULL;
 
 	service = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT, NULL, 0);
@@ -239,6 +243,9 @@ static gboolean set_configuration_ind(struct avdtp *session,
 {
 	printf("%s\n", __func__);
 
+	if (reject)
+		return FALSE;
+
 	avdtp_stream = stream;
 
 	cb(session, stream, NULL);
@@ -252,6 +259,9 @@ static gboolean get_configuration_ind(struct avdtp *session,
 {
 	printf("%s\n", __func__);
 
+	if (reject)
+		return FALSE;
+
 	return FALSE;
 }
 
@@ -261,6 +271,9 @@ static gboolean open_ind(struct avdtp *session, struct avdtp_local_sep *lsep,
 {
 	printf("%s\n", __func__);
 
+	if (reject)
+		return FALSE;
+
 	return TRUE;
 }
 
@@ -270,6 +283,9 @@ static gboolean start_ind(struct avdtp *session, struct avdtp_local_sep *lsep,
 {
 	printf("%s\n", __func__);
 
+	if (reject)
+		return FALSE;
+
 	start_media_player();
 
 	return TRUE;
@@ -282,6 +298,9 @@ static gboolean suspend_ind(struct avdtp *session,
 {
 	printf("%s\n", __func__);
 
+	if (reject)
+		return FALSE;
+
 	stop_media_player();
 
 	return TRUE;
@@ -293,6 +312,9 @@ static gboolean close_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 {
 	printf("%s\n", __func__);
 
+	if (reject)
+		return FALSE;
+
 	stop_media_player();
 	avdtp_stream = NULL;
 
@@ -315,7 +337,10 @@ static gboolean reconfigure_ind(struct avdtp *session,
 {
 	printf("%s\n", __func__);
 
-	return FALSE;
+	if (reject)
+		return FALSE;
+
+	return TRUE;
 }
 
 static gboolean delayreport_ind(struct avdtp *session,
@@ -325,7 +350,10 @@ static gboolean delayreport_ind(struct avdtp *session,
 {
 	printf("%s\n", __func__);
 
-	return FALSE;
+	if (reject)
+		return FALSE;
+
+	return TRUE;
 }
 
 static struct avdtp_sep_ind sep_ind = {
@@ -405,7 +433,8 @@ static void usage(void)
 		"\t-s <stream_role>   INT (initiator) or ACP (acceptor)\n"
 		"\t-i <hcidev>        HCI adapter\n"
 		"\t-c <bdaddr>        connect\n"
-		"\t-l                 listen\n");
+		"\t-l                 listen\n"
+		"\t-r                 reject commands\n");
 }
 
 static struct option main_options[] = {
@@ -415,6 +444,7 @@ static struct option main_options[] = {
 	{ "adapter",		1, 0, 'i' },
 	{ "connect",		1, 0, 'c' },
 	{ "listen",		0, 0, 'l' },
+	{ "reject",		0, 0, 'r' },
 	{ 0, 0, 0, 0 }
 };
 
@@ -434,7 +464,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	while ((opt = getopt_long(argc, argv, "d:hi:s:c:l",
+	while ((opt = getopt_long(argc, argv, "d:hi:s:c:lr",
 						main_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'i':
@@ -473,6 +503,9 @@ int main(int argc, char *argv[])
 		case 'l':
 			bacpy(&dst, BDADDR_ANY);
 			break;
+		case 'r':
+			reject = true;
+			break;
 		case 'h':
 		default:
 			usage();
-- 
1.9.1

