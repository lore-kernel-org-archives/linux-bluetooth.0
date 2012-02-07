Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix not clearing ack timer when sending an i-frame
Date: Tue, 7 Feb 2012 12:21:51 +0100
CC: Ulisses Furquim <ulisses@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1328539133-26410-1-git-send-email-luiz.dentz@gmail.com> <201202070908.45952.szymon.janc@tieto.com>  <CABBYNZ+4RzNn1Qi0_19Q=WxsdKkjZWsMmvyU-bMSosXuM8q3TQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+4RzNn1Qi0_19Q=WxsdKkjZWsMmvyU-bMSosXuM8q3TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID: <201202071221.51920.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
 
> >> Hmm, maybe we can clear ack timer only once if we check nsent in the
> >> end of l2cap_ertm_send() instead of potentially call it several times?
> >> Not sure if it's worth it or not, though.
> >
> > This is what __l2cap_send_ack is doing  i.e. sends RR frame only if
> > l2cap_ertm_send() returned 0 (or error). Would be good to have this consistent.
> >
> > So maybe just clear ack timer when incrementing nsent for the 1st time?
> >
> > if (!nsent++)
> >        __clear_ack_timer(chan);
> >
> 
> But that means we would be clearing ack timer even for retransmit
> frames which Im not sure can be account as an ack?

Right, only pending I-frame(s) is an acknowledgement. But that means
__l2cap_send_ack() is broken.

To fix that, I think l2cap_ertm_send should return number of pending I-frames
transmitted, not a total number of I-frames sent.
I've quickly looked over the code and that change should be OK.

What do you think?

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 09cd860..8dece4e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1448,17 +1448,19 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
 
                chan->next_tx_seq = __next_seq(chan, chan->next_tx_seq);
 
-               if (bt_cb(skb)->retries == 1)
+               if (bt_cb(skb)->retries == 1) {
                        chan->unacked_frames++;
 
+                       if (!nsent++)
+                               __clear_ack_timer(chan);
+               }
+
                chan->frames_sent++;
 
                if (skb_queue_is_last(&chan->tx_q, skb))
                        chan->tx_send_head = NULL;
                else
                        chan->tx_send_head = skb_queue_next(&chan->tx_q, skb);
-
-               nsent++;
        }
 
        return nsent;


-- 
BR
Szymon Janc
