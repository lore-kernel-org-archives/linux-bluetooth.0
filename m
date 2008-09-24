Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Write "time left" in human readable terms
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-M5BdXqxgFQPfpazzeRnW"
Date: Wed, 24 Sep 2008 14:34:23 -0700
Message-Id: <1222292063.10497.184.camel@snoogens.fab.redhat.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-M5BdXqxgFQPfpazzeRnW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Rather than using numbers, use full words, like minutes/seconds/etc.
Trivial code copied from nautilus itself
http://bugzilla.gnome.org/show_bug.cgi?id=513714

--=-M5BdXqxgFQPfpazzeRnW
Content-Disposition: attachment; filename="0001-Write-time-left-in-human-readable-terms.patch"
Content-Type: text/x-patch; name="0001-Write-time-left-in-human-readable-terms.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From da739e86900f440a1056e6d720e5014439ea168a Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Wed, 24 Sep 2008 14:30:12 -0700
Subject: [PATCH] Write "time left" in human readable terms

Rather than using numbers, use full words, like minutes/seconds/etc.
Trivial code copied from nautilus itself
http://bugzilla.gnome.org/show_bug.cgi?id=513714
---
 sendto/main.c |   49 +++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/sendto/main.c b/sendto/main.c
index b01dafc..0972ac8 100644
--- a/sendto/main.c
+++ b/sendto/main.c
@@ -69,6 +69,46 @@ static gint64 get_system_time(void)
 			(gint64) tmp.tv_sec * G_GINT64_CONSTANT(1000000);
 }
 
+/* Copied from nautilus/libnautilus-private/nautilus-file-operations.c */
+static gchar *format_time(int seconds)
+{
+	int minutes;
+	int hours;
+	char *res;
+
+	if (seconds < 0) {
+		/* Just to make sure... */
+		seconds = 0;
+	}
+
+	if (seconds < 60)
+		return g_strdup_printf(ngettext ("%'d second","%'d seconds", seconds), seconds);
+
+	if (seconds < 60*60) {
+		minutes = (seconds + 30) / 60;
+		return g_strdup_printf(ngettext ("%'d minute", "%'d minutes", minutes), minutes);
+	}
+
+	hours = seconds / (60*60);
+
+	if (seconds < 60*60*4) {
+		char *h, *m;
+
+		minutes = (seconds - hours * 60 * 60 + 30) / 60;
+
+		h = g_strdup_printf(ngettext ("%'d hour", "%'d hours", hours), hours);
+		m = g_strdup_printf(ngettext ("%'d minute", "%'d minutes", minutes), minutes);
+		res = g_strconcat(h, ", ", m, NULL);
+		g_free(h);
+		g_free(m);
+		return res;
+	}
+
+	return g_strdup_printf(ngettext ("approximately %'d hour",
+					 "approximately %'d hours",
+					 hours), hours);
+}
+
 static void response_callback(GtkWidget *dialog,
 					gint response, gpointer user_data)
 {
@@ -265,14 +305,7 @@ static void transfer_progress(DBusGProxy *proxy,
 
 	remaining_time = (total_size - current_sent) / transfer_rate;
 
-	if (remaining_time >= 3600)
-		time = g_strdup_printf(_("%d:%02d:%02d Remaining"),
-					remaining_time / 3600,
-					(remaining_time % 3600) / 60,
-					(remaining_time % 3600) % 60);
-	else
-		time = g_strdup_printf(_("%d:%02d Remaining"),
-				remaining_time / 60, remaining_time % 60);
+	time = format_time (remaining_time);
 
 	if (transfer_rate >= 3000)
 		rate = g_strdup_printf(_("%d KB/s"), transfer_rate / 1000);
-- 
1.6.0.1


--=-M5BdXqxgFQPfpazzeRnW--

