Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH 3/4] Fix memory leaks after using strtoba, batostr
Date: Mon, 27 Dec 2010 12:02:24 +0100
Message-ID: <1293447745-8697-3-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1293447745-8697-1-git-send-email-michal.labedzki@tieto.com>
References: <1293447745-8697-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 compat/bnep.c |    5 +++--
 compat/pand.c |    9 ++++++---
 test/hciemu.c |    8 ++++++--
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/compat/bnep.c b/compat/bnep.c
index 9b0d8b8..f651dfd 100644
--- a/compat/bnep.c
+++ b/compat/bnep.c
@@ -137,9 +137,10 @@ int bnep_show_connections(void)
 	}
 
 	for (i = 0; i < req.cnum; i++) {
-		printf("%s %s %s\n", ci[i].device,
-			batostr((bdaddr_t *) ci[i].dst),
+		char *tmp_bastr = batostr((bdaddr_t *) ci[i].dst);
+		printf("%s %s %s\n", ci[i].device, tmp_bastr,
 			bnep_svc2str(ci[i].role));
+		bt_free(tmp_bastr);
 	}
 	return 0;
 }
diff --git a/compat/pand.c b/compat/pand.c
index 7331fad..8a50020 100644
--- a/compat/pand.c
+++ b/compat/pand.c
@@ -456,10 +456,13 @@ static void do_show(void)
 
 static void do_kill(char *dst)
 {
-	if (dst)
-		bnep_kill_connection((void *) strtoba(dst));
-	else
+	if (dst) {
+		bdaddr_t *tmp_ba = strtoba(dst);
+		bnep_kill_connection((void *) tmp_ba);
+		bt_free(tmp_ba);
+	} else {
 		bnep_kill_all_connections();
+	}
 }
 
 static void sig_hup(int sig)
diff --git a/test/hciemu.c b/test/hciemu.c
index ae33d72..031b867 100644
--- a/test/hciemu.c
+++ b/test/hciemu.c
@@ -499,8 +499,10 @@ static void accept_connection(uint8_t *data)
 
 static void close_connection(struct vhci_conn *conn)
 {
+	char *tmp_bastr = batostr(&conn->dest);
 	syslog(LOG_INFO, "Closing connection %s handle %d",
-					batostr(&conn->dest), conn->handle);
+					tmp_bastr, conn->handle);
+	bt_free(tmp_bastr);
 
 	g_io_channel_close(conn->chan);
 	g_io_channel_unref(conn->chan);
@@ -1017,7 +1019,9 @@ static int getbdaddrbyname(char *str, bdaddr_t *ba)
 
 	if (n == 5) {
 		/* BD address */
-		baswap(ba, strtoba(str));
+		bdaddr_t *tmp_ba = strtoba(str);
+		baswap(ba, tmp_ba);
+		bt_free(tmp_ba);
 		return 0;
 	}
 
-- 
1.7.0.4

