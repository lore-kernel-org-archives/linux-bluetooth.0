Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi
Subject: [PATCH 03/34] Bluetooth: Fix memory leak of S-frames into L2CAP
Date: Thu,  1 Apr 2010 17:23:21 -0300
Message-Id: <1270153432-6477-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1270153432-6477-3-git-send-email-padovan@profusion.mobi>
References: <1270153432-6477-1-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-2-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-3-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

l2cap_data_channel do not free the S-frame, so we free it here.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index ab3f0c4..a020b9f 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3559,6 +3559,7 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
 		break;
 	}
 
+	kfree_skb(skb);
 	return 0;
 }
 
-- 
1.6.4.4
