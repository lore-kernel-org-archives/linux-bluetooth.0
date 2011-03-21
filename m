Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 07/10] Bluetooth: Do not use assignments in IF conditions
Date: Mon, 21 Mar 2011 14:20:03 +0100
Message-ID: <1300713606-23523-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1300713606-23523-1-git-send-email-szymon.janc@tieto.com>
References: <1300713606-23523-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix checkpatch warnings concerning assignments in if conditions.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/cmtp/core.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/cmtp/core.c b/net/bluetooth/cmtp/core.c
index 964ea91..16aa6bd 100644
--- a/net/bluetooth/cmtp/core.c
+++ b/net/bluetooth/cmtp/core.c
@@ -235,9 +235,12 @@ static void cmtp_process_transmit(struct cmtp_session *session)
 
 		size = min_t(uint, ((tail < 258) ? (tail - 2) : (tail - 3)), skb->len);
 
-		if ((scb->id < 0) && ((scb->id = cmtp_alloc_block_id(session)) < 0)) {
-			skb_queue_head(&session->transmit, skb);
-			break;
+		if (scb->id < 0) {
+			scb->id = cmtp_alloc_block_id(session);
+			if (scb->id < 0) {
+				skb_queue_head(&session->transmit, skb);
+				break;
+			}
 		}
 
 		if (size < 256) {
-- 
1.7.0.4

