Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 04/12] Bluetooth: add debug output to l2cap_ack_timeout()
Date: Thu, 22 Dec 2011 16:56:05 -0200
Message-Id: <1324580173-24957-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324580173-24957-3-git-send-email-padovan@profusion.mobi>
References: <1324580173-24957-1-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-2-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-3-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap_core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 944c189..cd7bb3d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1985,6 +1985,8 @@ static void l2cap_ack_timeout(struct work_struct *work)
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
 							ack_timer.work);
 
+	BT_DBG("chan %p", chan);
+
 	lock_sock(chan->sk);
 	l2cap_send_ack(chan);
 	release_sock(chan->sk);
-- 
1.7.6.4

