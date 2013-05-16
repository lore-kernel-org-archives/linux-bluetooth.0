Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/2] test: Remove commented out code from simple-agent
Date: Thu, 16 May 2013 09:24:54 -0400
Message-Id: <1368710695-22623-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/simple-agent |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/test/simple-agent b/test/simple-agent
index 854e1af..64b2ca8 100755
--- a/test/simple-agent
+++ b/test/simple-agent
@@ -176,6 +176,3 @@ if __name__ == '__main__':
 		manager.RequestDefaultAgent(path)
 
 	mainloop.run()
-
-	#adapter.UnregisterAgent(path)
-	#print("Agent unregistered")
-- 
1.7.9.5

