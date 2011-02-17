Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH] Replace batostr() with ba2str() to avoid memleaks
Date: Fri, 18 Feb 2011 00:06:26 +0100
Message-Id: <1297983986-10131-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

batostr() returns dynamically allocated strings. Replace it with
ba2str() wherever possible to avoid heap allocations and fix
memleaks.
---
 compat/bnep.c |    5 +++--
 test/hciemu.c |    4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/compat/bnep.c b/compat/bnep.c
index 9b0d8b8..3617e0e 100644
--- a/compat/bnep.c
+++ b/compat/bnep.c
@@ -128,6 +128,7 @@ int bnep_show_connections(void)
 	struct bnep_connlist_req req;
 	struct bnep_conninfo ci[48];
 	unsigned int i;
+	char buf[18];
 
 	req.cnum = 48;
 	req.ci   = ci;
@@ -137,9 +138,9 @@ int bnep_show_connections(void)
 	}
 
 	for (i = 0; i < req.cnum; i++) {
+		ba2str((bdaddr_t*)ci[i].dst, buf);
 		printf("%s %s %s\n", ci[i].device,
-			batostr((bdaddr_t *) ci[i].dst),
-			bnep_svc2str(ci[i].role));
+			buf, bnep_svc2str(ci[i].role));
 	}
 	return 0;
 }
diff --git a/test/hciemu.c b/test/hciemu.c
index ba9b89d..db7c613 100644
--- a/test/hciemu.c
+++ b/test/hciemu.c
@@ -499,8 +499,10 @@ static void accept_connection(uint8_t *data)
 
 static void close_connection(struct vhci_conn *conn)
 {
+	char buf[18];
+	ba2str(&conn->dest, buf);
 	syslog(LOG_INFO, "Closing connection %s handle %d",
-					batostr(&conn->dest), conn->handle);
+					buf, conn->handle);
 
 	g_io_channel_shutdown(conn->chan, TRUE, NULL);
 	g_io_channel_unref(conn->chan);
-- 
1.7.4.1

