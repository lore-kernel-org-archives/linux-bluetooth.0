Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATC -v2 2/2] Bluetooth: Fix skb length calculation
Date: Wed,  9 May 2012 18:27:16 -0300
Message-Id: <1336598836-28478-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1336598836-28478-1-git-send-email-gustavo@padovan.org>
References: <1336598836-28478-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When we add a fragment to a skb, len, data_len and truesize fields needs
to be updated.

Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
---
 net/bluetooth/l2cap_core.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 66a1a55..f45f92d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1851,6 +1851,9 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 		sent += count;
 		len  -= count;
 
+		skb->len += (*frag)->len;
+		skb->data_len += (*frag)->len;
+
 		frag = &(*frag)->next;
 	}
 
-- 
1.7.10.1

