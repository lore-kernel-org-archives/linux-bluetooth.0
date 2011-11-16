Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <ulrik.lauren@stericsson.com>, <kanak.gupta@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/5] Bluetooth: Simplify __l2cap_global_chan_by_addr
Date: Wed, 16 Nov 2011 09:32:22 +0100
Message-ID: <1321432342-8606-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1321432342-8606-1-git-send-email-szymon.janc@tieto.com>
References: <1321432342-8606-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make __l2cap_global_chan_by_addr similar to other find functions.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/l2cap_core.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f79dbe8..d63e670 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -153,12 +153,9 @@ static struct l2cap_chan *__l2cap_global_chan_by_addr(__le16 psm, bdaddr_t *src)
 
 	list_for_each_entry(c, &chan_list, global_l) {
 		if (c->sport == psm && !bacmp(&bt_sk(c->sk)->src, src))
-			goto found;
+			return c;
 	}
-
-	c = NULL;
-found:
-	return c;
+	return NULL;
 }
 
 int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm)
-- 
on behalf of ST-Ericsson

