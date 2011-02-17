Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 10/10] Bluetooth: Log command and status parameters in command status event
Date: Thu, 17 Feb 2011 14:16:41 +0100
Message-ID: <1297948601-12723-11-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1297948601-12723-1-git-send-email-szymon.janc@tieto.com>
References: <1297948601-12723-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/mgmt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 571cbcf..208c211 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -49,7 +49,7 @@ static int cmd_status(struct sock *sk, u16 cmd, u8 status, void *data,
 	struct mgmt_hdr *hdr;
 	struct mgmt_ev_cmd_status *ev;
 
-	BT_DBG("sock %p", sk);
+	BT_DBG("sock %p, cmd %u, status %u", sk, cmd, status);
 
 	skb = alloc_skb(sizeof(*hdr) + sizeof(*ev) + data_len, GFP_ATOMIC);
 	if (!skb)
-- 
1.7.0.4

