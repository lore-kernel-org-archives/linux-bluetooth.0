Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Fix skb length calculation
Date: Wed,  9 May 2012 10:12:39 -0300
Message-Id: <1336569159-4710-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1336569159-4710-1-git-send-email-gustavo@padovan.org>
References: <1336569159-4710-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When we add a fragment to a skb, len, data_len and truesize fields needs
to be updated.

Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
---
 net/bluetooth/l2cap_core.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 66a1a55..8d7c6ba 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1851,6 +1851,10 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 		sent += count;
 		len  -= count;
 
+		skb->len += (*frag)->len;
+		skb->data_len += (*frag)->len;
+		skb->truesize += (*frag)->truesize;
+
 		frag = &(*frag)->next;
 	}
 
-- 
1.7.10.1

