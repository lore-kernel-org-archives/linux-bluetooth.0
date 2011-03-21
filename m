Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 09/10] Bluetooth: Fix checkpatch error in cmtp.h
Date: Mon, 21 Mar 2011 14:20:05 +0100
Message-ID: <1300713606-23523-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1300713606-23523-1-git-send-email-szymon.janc@tieto.com>
References: <1300713606-23523-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Do not use C99 // comments.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/cmtp/cmtp.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/cmtp/cmtp.h b/net/bluetooth/cmtp/cmtp.h
index 785e79e..c6f78f8 100644
--- a/net/bluetooth/cmtp/cmtp.h
+++ b/net/bluetooth/cmtp/cmtp.h
@@ -37,7 +37,7 @@
 #define CMTP_LOOPBACK	0
 
 struct cmtp_connadd_req {
-	int   sock;	// Connected socket
+	int   sock;	/* Connected socket */
 	__u32 flags;
 };
 
-- 
1.7.0.4

