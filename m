Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH BlueZ v2] tools: Fix recevied/received typos
Date: Mon, 26 Sep 2016 17:03:12 -0700
Message-Id: <20160927000312.1275-1-mathew.j.martineau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---

I removed the ubcsp.c change because the file's CRLF line endings were
causing problems with git-am, and since the spelling problem there is
not user-visible.

 tools/l2test.c  | 2 +-
 tools/scotest.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index d4e3ae6..1819423 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -830,7 +830,7 @@ static void dump_mode(int sk)
 			return;
 		}
 
-		syslog(LOG_INFO, "Recevied %d bytes", len);
+		syslog(LOG_INFO, "Received %d bytes", len);
 		hexdump(buf, len);
 	}
 }
diff --git a/tools/scotest.c b/tools/scotest.c
index 596e403..f894c24 100644
--- a/tools/scotest.c
+++ b/tools/scotest.c
@@ -265,7 +265,7 @@ static void dump_mode(int sk)
 
 	syslog(LOG_INFO,"Receiving ...");
 	while ((len = read(sk, buf, data_size)) > 0)
-		syslog(LOG_INFO, "Recevied %d bytes", len);
+		syslog(LOG_INFO, "Received %d bytes", len);
 }
 
 static void recv_mode(int sk)
-- 
2.10.0

