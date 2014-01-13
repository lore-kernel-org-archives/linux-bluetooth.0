Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] l2test: Use correct buffer size
Date: Mon, 13 Jan 2014 18:39:44 +0200
Message-Id: <1389631184-32758-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 tools/l2test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index aaa1608..0993f74 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -782,7 +782,7 @@ static void dump_mode(int sk)
 		data_size = imtu;
 
 	if (defer_setup) {
-		len = read(sk, buf, sizeof(buf));
+		len = read(sk, buf, data_size);
 		if (len < 0)
 			syslog(LOG_ERR, "Initial read error: %s (%d)",
 						strerror(errno), errno);
@@ -842,7 +842,7 @@ static void recv_mode(int sk)
 		data_size = imtu;
 
 	if (defer_setup) {
-		len = read(sk, buf, sizeof(buf));
+		len = read(sk, buf, data_size);
 		if (len < 0)
 			syslog(LOG_ERR, "Initial read error: %s (%d)",
 						strerror(errno), errno);
-- 
1.8.3.2

