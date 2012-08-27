Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 1/3] rctest: fix typo
Date: Mon, 27 Aug 2012 08:14:49 -0500
Message-Id: <1346073291-7001-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

recevied -> received
---
 test/rctest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/rctest.c b/test/rctest.c
index 4d7c90a..f82d2cc 100644
--- a/test/rctest.c
+++ b/test/rctest.c
@@ -439,7 +439,7 @@ static void dump_mode(int sk)
 
 	syslog(LOG_INFO, "Receiving ...");
 	while ((len = read(sk, buf, data_size)) > 0)
-		syslog(LOG_INFO, "Recevied %d bytes", len);
+		syslog(LOG_INFO, "Received %d bytes", len);
 }
 
 static void recv_mode(int sk)
-- 
1.7.11.2

