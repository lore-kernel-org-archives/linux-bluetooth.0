Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v4 8/8] Update test/test-oob to match new DBus OOB API
Date: Mon, 13 Aug 2012 12:46:40 +0200
Message-ID: <1344854800-20972-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1344854800-20972-1-git-send-email-szymon.janc@tieto.com>
References: <1344854800-20972-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/test-oob |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/test-oob b/test/test-oob
index bec9de5..d44215f 100755
--- a/test/test-oob
+++ b/test/test-oob
@@ -68,8 +68,8 @@ if __name__ == '__main__':
 	print()
 	print("Exchanging Out of Band data...")
 
-	oob_adapter0.AddRemoteData(adapter1_address, oob1[0], oob1[1])
-	oob_adapter1.AddRemoteData(adapter0_address, oob0[0], oob0[1])
+	oob_adapter0.AddRemoteData(adapter1_address, oob1)
+	oob_adapter1.AddRemoteData(adapter0_address, oob0)
 
 	print("Done.")
 	print()
-- 
1.7.9.5

