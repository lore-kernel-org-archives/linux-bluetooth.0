Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] scotest: Use correct buffer size
Date: Mon, 13 Jan 2014 18:34:45 +0200
Message-Id: <1389630885-32676-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 tools/scotest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/scotest.c b/tools/scotest.c
index 69150b1..227287d 100644
--- a/tools/scotest.c
+++ b/tools/scotest.c
@@ -255,7 +255,7 @@ static void dump_mode(int sk)
 							strerror(errno), errno);
 
 	if (defer_setup) {
-		len = read(sk, buf, sizeof(buf));
+		len = read(sk, buf, data_size);
 		if (len < 0)
 			syslog(LOG_ERR, "Initial read error: %s (%d)",
 						strerror(errno), errno);
@@ -283,7 +283,7 @@ static void recv_mode(int sk)
 							strerror(errno), errno);
 
 	if (defer_setup) {
-		len = read(sk, buf, sizeof(buf));
+		len = read(sk, buf, data_size);
 		if (len < 0)
 			syslog(LOG_ERR, "Initial read error: %s (%d)",
 						strerror(errno), errno);
-- 
1.8.3.2

