Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Fix small memleak in compat/pand.c
Date: Fri, 4 Mar 2011 19:32:00 +0100
Message-ID: <1299263520-25191-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 compat/pand.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/compat/pand.c b/compat/pand.c
index c3860fa..b82650e 100644
--- a/compat/pand.c
+++ b/compat/pand.c
@@ -456,10 +456,13 @@ static void do_show(void)
 
 static void do_kill(char *dst)
 {
-	if (dst)
-		bnep_kill_connection((void *) strtoba(dst));
-	else
+	if (dst) {
+		bdaddr_t *ba = strtoba(dst);
+		bnep_kill_connection((void *) ba);
+		free(ba);
+	} else {
 		bnep_kill_all_connections();
+	}
 }
 
 static void sig_hup(int sig)
-- 
1.7.0.4
on behalf of ST-Ericsson
