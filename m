Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org, johan.hedberg@gmail.com,
	marcel@holtmann.org, Inga Stotland <ingas@codeaurora.org>
Subject: [PATCH 4/4] Allow changing AMP vs BR/EDR preference from stdin when connection is up.
Date: Fri, 30 Jul 2010 11:30:26 -0700
Message-Id: <1280514626-22559-5-git-send-email-ingas@codeaurora.org>
In-Reply-To: <1280514626-22559-1-git-send-email-ingas@codeaurora.org>
References: <1280514626-22559-1-git-send-email-ingas@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use the following keys:

"a", "A" - prefer AMP;
"b", "B" - prefer BR/EDR;
"r", "R" - require BR/EDR
---
 test/l2test.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 76 insertions(+), 11 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index 377c12e..1f627a7 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -191,6 +191,46 @@ static void hexdump(unsigned char *s, unsigned long l)
 	}
 }
 
+static void do_keys(int sk)
+{
+	struct pollfd p;
+	int len;
+	char c;
+	int old_amp_pref = amp_pref;
+
+	p.fd = 0;
+	p.events = POLLIN;
+
+	if (poll(&p, 1, 0)) {
+		len = read(0, &c, 1);
+		if (len < 0)
+			return;
+
+		switch (c) {
+		case 'A':
+		case 'a':
+			amp_pref = L2CAP_AMP_PREFER_AMP;
+			break;
+		case 'B':
+		case 'b':
+			amp_pref = L2CAP_AMP_PREFER_BR_EDR;
+			break;
+		case 'R':
+		case 'r':
+			amp_pref = L2CAP_AMP_REQUIRE_BR_EDR;
+			break;
+		default:
+			return;
+		}
+
+		setsockopt(sk, SOL_L2CAP, L2CAP_AMP, &amp_pref, sizeof(amp_pref));
+		syslog(LOG_INFO, "AMP preference updated to %d (previously %d)",
+			amp_pref, old_amp_pref);
+	}
+
+	return;
+}
+
 static int do_connect(char *svr)
 {
 	struct sockaddr_l2 addr;
@@ -584,11 +624,17 @@ static void dump_mode(int sk)
 		fd_set rset;
 
 		FD_ZERO(&rset);
+		FD_SET(0, &rset);
 		FD_SET(sk, &rset);
 
 		if (select(sk + 1, &rset, NULL, NULL, NULL) < 0)
 			return;
 
+		if (FD_ISSET(0, &rset)) {
+			do_keys(sk);
+			continue;
+		}
+
 		if (!FD_ISSET(sk, &rset))
 			continue;
 
@@ -620,7 +666,7 @@ static void dump_mode(int sk)
 static void recv_mode(int sk)
 {
 	struct timeval tv_beg, tv_end, tv_diff;
-	struct pollfd p;
+	struct pollfd p[2];
 	char ts[30];
 	long total;
 	uint32_t seq;
@@ -643,8 +689,11 @@ static void recv_mode(int sk)
 
 	memset(ts, 0, sizeof(ts));
 
-	p.fd = sk;
-	p.events = POLLIN | POLLERR | POLLHUP;
+	p[0].fd = sk;
+	p[0].events = POLLIN | POLLERR | POLLHUP;
+
+	p[1].fd = 0;
+	p[1].events = POLLIN;
 
 	seq = 0;
 	while (1) {
@@ -655,13 +704,19 @@ static void recv_mode(int sk)
 			uint16_t l;
 			int i;
 
-			p.revents = 0;
-			if (poll(&p, 1, -1) <= 0)
+			p[0].revents = 0;
+			p[1].revents = 0;
+			if (poll(p, 2, -1) <= 0)
 				return;
 
-			if (p.revents & (POLLERR | POLLHUP))
+			if (p[0].revents & (POLLERR | POLLHUP))
 				return;
 
+			if (p[1].revents & POLLIN) {
+				do_keys(sk);
+				continue;
+			}
+
 			len = recv(sk, buf, data_size, 0);
 			if (len < 0) {
 				if (reliable && (errno == ECOMM)) {
@@ -780,6 +835,8 @@ static void do_send(int sk)
 
 			sent += len;
 			size -= len;
+
+			do_keys(sk);
 		}
 
 		if (num_frames && delay && count && !(seq % count))
@@ -831,19 +888,27 @@ static void reconnect_mode(char *svr)
 
 static void connect_mode(char *svr)
 {
-	struct pollfd p;
+	struct pollfd p[2];
 	int sk;
 
 	if ((sk = do_connect(svr)) < 0)
 		exit(1);
 
-	p.fd = sk;
-	p.events = POLLERR | POLLHUP;
+	p[0].fd = sk;
+	p[0].events = POLLERR | POLLHUP;
+
+	p[1].fd = 0;
+	p[1].events = POLLIN;
 
 	while (1) {
-		p.revents = 0;
-		if (poll(&p, 1, 500))
+		p[0].revents = 0;
+		p[1].revents = 0;
+		if (poll(p, 2, 500) < 0)
+			break;
+		if (p[0].revents & (POLLERR | POLLHUP))
 			break;
+		if (p[1].revents & POLLIN)
+			do_keys(sk);
 	}
 
 	syslog(LOG_INFO, "Disconnected");
-- 
1.7.2

--
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
