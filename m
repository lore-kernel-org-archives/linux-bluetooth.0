Return-Path: <cyrus@holtmann.org>
Subject: Re: kernel panic happens when disconnecting Bluetooth headset
From: Marcel Holtmann <marcel@holtmann.org>
To: Lan Zhu <zhu.lan.cn@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <113d36d80909110053ybd2c203xeda76bd36248bb17@mail.gmail.com>
References: <113d36d80909110053ybd2c203xeda76bd36248bb17@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 11 Sep 2009 10:23:56 +0200
Message-Id: <1252657436.8931.52.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Zhu,

> We met a issue that kernel panic happens when disconnecting some kinds
> of Bluetooth headset, then we did some analysis and made some changes
> on kernel code which have avoided the panic happening. Would you
> please help to check if our analysis and fix is correct?
> 
> =============
> Issue description
> =============
> On Android platform(kernel 2.6.29), disconnecting Bluetooth headset
> may cause kernel panic on certain conditions.
> 
> (Pre-condition is android paired with headset.)
> Initiate the connection from android, disconnect it from android, result is OK.
> Initiate the connection from android, disconnect it from headset, result is OK.
> Initiate the connection from headset, disconnect it from headset, result is OK.
> Initiate the connection from headset, disconnect it from android, for
> Motorola H12 headset, result is OK.
> Initiate the connection from headset, disconnect it from android, for
> Motorola H620/560 headset, result is kernel panic.
> 
> =============
> Kernel panic point
> =============
> kernel panic at __list_del() in the function rfcomm_session_del() ,
> panic reason is "Unable to handle kernel paging request at virtual
> address 00200200"
> 
> =============
> Kernel log analysis
> =============
> rfcomm_session_del() is still called after the session entry is
> removed from the list. Then __list_del() will cause kernel panic
> because of the incorrect pointer. This situation occurs when calling
> rfcomm_recv_ua() when the socket state is BT_CLOSED . So we need to
> find out why the socket state become BT_CLOSED before we calling
> rfcomm_recv_ua().
> 
> # [  171.677429] rfcomm_sock_sendmsg: sock ce9a0960, sk cc5c4c00
> [  171.683532] rfcomm_dlc_send: dlc cd3fe920 mtu 255 len 14
> [  171.689422] rfcomm_process_rx: session cc751be0 state 1 qlen 0
> [  171.695709] rfcomm_process_rx: @@@ @@@ sk_state = 1
> [  171.701110] rfcomm_process_dlcs: session cc751be0 state 1
> [  171.706939] rfcomm_process_tx: dlc cd3fe920 state 1 cfc 40
> rx_credits 33 tx_credits 31
> [  171.715515] rfcomm_send_frame: session cc751be0 len 18
> [  171.721130] rfcomm_session_put: in rfcomm_session_put, s->refcnt = 3
> [  174.127807] rfcomm_sock_sendmsg: sock ce9a0960, sk cc5c4c00
> [  174.134490] rfcomm_dlc_send: dlc cd3fe920 mtu 255 len 6
> [  174.141540] rfcomm_process_rx: session cc751be0 state 1 qlen 0
> [  174.148498] rfcomm_process_rx: @@@ @@@ sk_state = 1
> [  174.154968] rfcomm_process_dlcs: session cc751be0 state 1
> [  174.161437] rfcomm_process_tx: dlc cd3fe920 state 1 cfc 40
> rx_credits 33 tx_credits 30
> [  174.171173] rfcomm_send_frame: session cc751be0 len 10
> [  174.177642] rfcomm_session_put: in rfcomm_session_put, s->refcnt = 3
> [  174.205932] rfcomm_sock_release: sock ce9a0960, sk cc5c4c00
> [  174.212707] rfcomm_sock_shutdown: sock ce9a0960, sk cc5c4c00
> [  174.220031] __rfcomm_sock_close: sk cc5c4c00 state 1 socket ce9a0960
> [  174.227508] __rfcomm_dlc_close: dlc cd3fe920 state 1 dlci 20 err 0
> session cc751be0
> [  174.236877] rfcomm_send_disc: cc751be0 dlci 20
> [  174.242706] rfcomm_send_frame: session cc751be0 len 4
> [  174.248962] rfcomm_dlc_set_timer: dlc cd3fe920 state 8 timeout 2560
> [  174.256835] rfcomm_sock_kill: sk cc5c4c00 state 1 refcnt 2
> [  174.263336] rfcomm_sock_destruct: sk cc5c4c00 dlc cd3fe920
> [  174.399444] rfcomm_l2data_ready: ccf70400 bytes 4
> [  174.404724] rfcomm_process_rx: session cc751be0 state 1 qlen 1
> [  174.411010] rfcomm_process_rx: @@@ @@@ sk_state = 1
> [  174.416412] rfcomm_recv_ua: session cc751be0 state 1 dlci 20
> [  174.422515] __rfcomm_dlc_close: dlc cd3fe920 state 9 dlci 20 err 0
> session cc751be0
> [  174.430816] rfcomm_dlc_clear_timer: dlc cd3fe920 state 9
> [  174.436553] rfcomm_dlc_unlink: dlc cd3fe920 refcnt 1 session cc751be0
> [  174.443572] rfcomm_dlc_free: cd3fe920
> [  174.447570] rfcomm_session_put: in rfcomm_session_put, s->refcnt = 3
> [  174.454528] rfcomm_send_disc: cc751be0 dlci 0
> [  174.459259] rfcomm_send_frame: session cc751be0 len 4
> [  174.464904] rfcomm_process_dlcs: session cc751be0 state 8
> [  174.470703] rfcomm_session_put: in rfcomm_session_put, s->refcnt = 2
> [  174.898284] rfcomm_l2data_ready: ccf70400 bytes 4
> [  174.903442] rfcomm_l2state_change: ccf70400 state 9
> [  174.908874] rfcomm_process_rx: session cc751be0 state 8 qlen 1
> [  174.915130] rfcomm_process_rx: @@@ @@@ sk_state = 9
> [  174.920562] rfcomm_recv_ua: session cc751be0 state 8 dlci 0
> [  174.926574] rfcomm_session_put: in rfcomm_session_put, s->refcnt = 2
> [  174.933532] rfcomm_process_rx: @@@ @@@ sk_state == BT_CLOSED , s->initiator=0
> [  174.941253] rfcomm_session_put: in rfcomm_session_put, s->refcnt = 1
> [  174.948211] rfcomm_session_del: session cc751be0 state 8
> [  174.953918] @@@@ in rfcomm_session_del()
> [  174.958312] @@@@ s->list = cc751be0
> [  174.962097] @@@@ s->list.next = ccbfe9a0
> [  174.966369] @@@@ s->list.prev = c047d524
> [  174.970733] @@@@ list is valid, call list_del()
> [  174.975646] @@@@ after list_del()
> [  174.979278] @@@@ s->list = cc751be0
> [  174.983184] @@@@ s->list.next = 00100100
> [  174.987457] @@@@ s->list.prev = 00200200
> [  174.991729] rfcomm_session_close: session cc751be0 state 8 err 104
> [  174.998504] rfcomm_session_put: in rfcomm_session_put, s->refcnt = 1
> [  175.005310] rfcomm_session_del: session cc751be0 state 9
> [  175.011169] @@@@ in rfcomm_session_del()
> [  175.015441] @@@@ s->list = cc751be0
> [  175.019409] @@@@ s->list.next = 00100100
> [  175.023651] @@@@ s->list.prev = 00200200
> [  175.027923] @@@@ list is valid, call list_del()
> [  175.032958] Unable to handle kernel paging request at virtual
> address 00200200
> [  175.040679] pgd = c0004000
> [  175.043792] [00200200] *pgd=00000000
> [  175.047821] Internal error: Oops: 817 [#1]
> [  175.052246] Modules linked in:
> [  175.055725] CPU: 0    Not tainted  (2.6.29-omap1-dirty #34)
> [  175.061859] PC is at rfcomm_session_del+0x6c/0x108
> [  175.067047] LR is at release_console_sem+0x190/0x1a0
> [  175.072509] pc : [<c033ded8>]    lr : [<c0066308>]    psr: 60000013
> [  175.072509] sp : cc1abf38  ip : cc1abe68  fp : cc1abf4c
> [  175.084960] r10: cc751c04  r9 : c036d2fc  r8 : cc751be0
> [  175.090545] r7 : 00000068  r6 : cc751c04  r5 : 00000009  r4 : cc751be0
> [  175.097656] r3 : 00100100  r2 : 00100100  r1 : 00200200  r0 : c0422876
> 
> =============
> HCI log analysis
> =============
> Compare the hcidump log of the correct case with the one of the panic
> case, we found there is only one difference in the message sequence.
> In the panic case, headset send L2CAP Disconn_Req immediately after
> sending rfcomm UA frame to android. We think this is the reason that
> cause the socket state become BT_CLOSED.
> 
> Please compare these two log, pay attention to the message direction
> of the last Disconn_Req.
> 
> 
> Log of correct case:
> ----------------------------
> 
> 
> 009-09-10 15:27:28.963519 < ACL data: handle 1 flags 0x02 dlen 22
>    L2CAP(d): cid 0x0047 len 18 [psm 3]
>      RFCOMM(d): UIH: cr 0 dlci 20 pf 0 ilen 14 fcs 0xeb
>      0000: 0d 0a 2b 43 49 45 56 3a  20 37 2c 33 0d 0a        ..+CIEV: 7,3..
> 009-09-10 15:27:28.967272 > HCI Event: Number of Completed Packets (0x13) plen
> 
>    handle 1 packets 1
> 009-09-10 15:27:29.243945 < ACL data: handle 1 flags 0x02 dlen 8
>    L2CAP(d): cid 0x0047 len 4 [psm 3]
>      RFCOMM(s): DISC: cr 0 dlci 20 pf 1 ilen 0 fcs 0x7d
> 009-09-10 15:27:29.247363 > HCI Event: Number of Completed Packets (0x13) plen
> 
>    handle 1 packets 1
> 009-09-10 15:27:29.274890 > ACL data: handle 1 flags 0x02 dlen 8
>    L2CAP(d): cid 0x0040 len 4 [psm 3]
>      RFCOMM(s): UA: cr 0 dlci 20 pf 1 ilen 0 fcs 0x57
> 009-09-10 15:27:29.296343 < ACL data: handle 1 flags 0x02 dlen 8
>    L2CAP(d): cid 0x0047 len 4 [psm 3]
>      RFCOMM(s): DISC: cr 0 dlci 0 pf 1 ilen 0 fcs 0x9c
> 009-09-10 15:27:29.298480 > HCI Event: Number of Completed Packets (0x13) plen
> 
>    handle 1 packets 1
> 009-09-10 15:27:29.319873 > ACL data: handle 1 flags 0x02 dlen 8
>    L2CAP(d): cid 0x0040 len 4 [psm 3]
>      RFCOMM(s): UA: cr 0 dlci 0 pf 1 ilen 0 fcs 0xb6
> 009-09-10 15:27:29.320727 < ACL data: handle 1 flags 0x02 dlen 12
>    L2CAP(s): Disconn req: dcid 0x0047 scid 0x0040
> 009-09-10 15:27:29.323474 > HCI Event: Number of Completed Packets (0x13) plen
> 
>    handle 1 packets 1
> 009-09-10 15:27:29.337237 > ACL data: handle 1 flags 0x02 dlen 12
>    L2CAP(s): Disconn rsp: dcid 0x0047 scid 0x0040
> 
> 
> 
> 
> log of panic case:
> ------------------------
> 
> 
> 
> 2009-09-10 13:34:24.020208 < ACL data: handle 1 flags 0x02 dlen 22
>     L2CAP(d): cid 0x0041 len 18 [psm 3]
>       RFCOMM(d): UIH: cr 0 dlci 20 pf 0 ilen 14 fcs 0xeb
>       0000: 0d 0a 2b 43 49 45 56 3a  20 37 2c 33 0d 0a        ..+CIEV: 7,3..
> 2009-09-10 13:34:24.281256 > HCI Event: Number of Completed Packets (0x13) plen
> 5
>     handle 1 packets 1
> 2009-09-10 13:34:24.083580 < ACL data: handle 1 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0041 len 4 [psm 3]
>       RFCOMM(s): DISC: cr 0 dlci 20 pf 1 ilen 0 fcs 0x7d
> 2009-09-10 13:34:24.529442 > HCI Event: Number of Completed Packets (0x13) plen
> 5
>     handle 1 packets 1
> 2009-09-10 13:34:24.531914 > ACL data: handle 1 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): UA: cr 0 dlci 20 pf 1 ilen 0 fcs 0x57
> 2009-09-10 13:34:24.533135 < ACL data: handle 1 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0041 len 4 [psm 3]
>       RFCOMM(s): DISC: cr 0 dlci 0 pf 1 ilen 0 fcs 0x9c
> 2009-09-10 13:34:25.028649 > HCI Event: Number of Completed Packets (0x13) plen
> 5
>     handle 1 packets 1
> 2009-09-10 13:34:25.032128 > ACL data: handle 1 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): UA: cr 0 dlci 0 pf 1 ilen 0 fcs 0xb6
> 2009-09-10 13:34:25.032341 > ACL data: handle 1 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0041
> 2009-09-10 13:34:25.032646 < ACL data: handle 1 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0041
> 
> =============
> Analysis Result
> =============
> For some kinds of Bluetooth headset such as Motorola H560/H620 which
> are based on BCM2044S, they will send L2CAP Disconn_Req command right
> after sending rfcomm UA frame. This L2CAP Disconn_Req will cause the
> rfcomm socket state become BT_CLOSED before completely handling UA
> frame, thus it will cause kernel panic. I think we can ignore the
> received rfcomm frames if socket state is BT_CLOSED, because it
> doesn't make sense in the BT_CLOSED state.
> 
> 
> =============
> Changed Code
> =============
> We changed the code in the function rfcomm_process_rx() in
> net/bluetooth/rfcomm/core.c, check the socket state first before
> handling the received framew. If the socket state is BT_CLOSED, we
> don't handle any rfcomm frames but just close the session.
> 
> The change is like below
> 
> +       if (sk->sk_state != BT_CLOSED) {
>         /* Get data directly from socket receive queue without copying it. */
>         while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
>                 skb_orphan(skb);
>                 rfcomm_recv_frame(s, skb);
>         }
> -
> -       if (sk->sk_state == BT_CLOSED) {
> +       } else {
>                 if (!s->initiator)
>                         rfcomm_session_put(s);
> 
>                 rfcomm_session_close(s, sk->sk_err);
>          }

so I do see the issue here, but I don't agree with the fix since it
changes behavior that might cause other issues. So in case the frame
processing leads to sk->sk_state == BT_CLOSED we are not closing the
connection anymore if we make it depend on a state before the frame
processing. And nothing guarantees that rfcomm_process_rx gets scheduled
again.

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 94b3388..606143b 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1798,12 +1798,16 @@ static inline void rfcomm_process_rx(struct rfcomm_session *s)
 
        BT_DBG("session %p state %ld qlen %d", s, s->state, skb_queue_len(&sk->sk_receive_queue));
 
+       rfcomm_session_hold(s);
+
        /* Get data directly from socket receive queue without copying it. */
        while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
                skb_orphan(skb);
                rfcomm_recv_frame(s, skb);
        }
 
+       rfcomm_session_put(s);
+
        if (sk->sk_state == BT_CLOSED) {
                if (!s->initiator)
                        rfcomm_session_put(s);

What does the above patch do for you? Since if I read it correctly, then
the rfcomm_recv_ua causes the rfcomm_session_put to trigger the closing
of the session. And then in this case it is delayed until after all
frames are processed.

Regards

Marcel


