Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Sep 2009 15:22:26 +0800
From: Dave Young <hidave.darkstar@gmail.com>
To: Nick Pelly <npelly@google.com>
Cc: Lan Zhu <zhu.lan.cn@gmail.com>, Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: kernel panic happens when disconnecting Bluetooth headset
Message-ID: <20090923072226.GA2399@darkstar.vlan7>
References: <113d36d80909110053ybd2c203xeda76bd36248bb17@mail.gmail.com> <1252657436.8931.52.camel@violet> <113d36d80909110828i1b53e8f5x5b913fb7861850fd@mail.gmail.com> <1252687514.8931.77.camel@violet> <113d36d80909140210n476f5826x1ae2ea621b57782c@mail.gmail.com> <35c90d960909211752u389e5d6dqbd4afe0e055c43d0@mail.gmail.com> <35c90d960909211829u71880f94j861055c61efc8c@mail.gmail.com> <35c90d960909221318m4b918d2dg3e2688a89427319a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <35c90d960909221318m4b918d2dg3e2688a89427319a@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Sep 22, 2009 at 01:18:26PM -0700, Nick Pelly wrote:
> On Mon, Sep 21, 2009 at 6:29 PM, Nick Pelly <npelly@google.com> wrote:
> > On Mon, Sep 21, 2009 at 5:52 PM, Nick Pelly <npelly@google.com> wrote:
> >> On Mon, Sep 14, 2009 at 2:10 AM, Lan Zhu <zhu.lan.cn@gmail.com> wrote:
> >>> Hi Marcel,
> >>>
> >>> 2009/9/12 Marcel Holtmann <marcel@holtmann.org>:
> >>>> Hi Zhu,
> >>>>
> >>>>> >> We met a issue that kernel panic happens when disconnecting some kinds
> >>>>> >> of Bluetooth headset, then we did some analysis and made some changes
> >>>>> >> on kernel code which have avoided the panic happening. Would you
> >>>>> >> please help to check if our analysis and fix is correct?
> >>>>> >>
> >>>>> >> =============
> >>>>> >> Issue description
> >>>>> >> =============
> >>>>> >> On Android platform(kernel 2.6.29), disconnecting Bluetooth headset
> >>>>> >> may cause kernel panic on certain conditions.
> >>>>> >>
> >>>>> >> (Pre-condition is android paired with headset.)
> >>>>> >> Initiate the connection from android, disconnect it from android, result is OK.
> >>>>> >> Initiate the connection from android, disconnect it from headset, result is OK.
> >>>>> >> Initiate the connection from headset, disconnect it from headset, result is OK.
> >>>>> >> Initiate the connection from headset, disconnect it from android, for
> >>>>> >> Motorola H12 headset, result is OK.
> >>>>> >> Initiate the connection from headset, disconnect it from android, for
> >>>>> >> Motorola H620/560 headset, result is kernel panic.
> >>>>> >>
> >>>>> >> =============
> >>>>> >> Kernel panic point
> >>>>> >> =============
> >>>>> >> kernel panic at __list_del() in the function rfcomm_session_del() ,
> >>>>> >> panic reason is "Unable to handle kernel paging request at virtual
> >>>>> >> address 00200200"
> >>>>> >>
> >>>>> >> =============
> >>>>> >> Kernel log analysis
> >>>>> >> =============
> >>>>> >> rfcomm_session_del() is still called after the session entry is
> >>>>> >> removed from the list. Then __list_del() will cause kernel panic
> >>>>> >> because of the incorrect pointer. This situation occurs when calling
> >>>>> >> rfcomm_recv_ua() when the socket state is BT_CLOSED . So we need to
> >>>>> >> find out why the socket state become BT_CLOSED before we calling
> >>>>> >> rfcomm_recv_ua().
> >>>>> >>
> >>>>> >> # [  171.677429] rfcomm_sock_sendmsg: sock ce9a0960, sk cc5c4c00
> >>>>> >> [  171.683532] rfcomm_dlc_send: dlc cd3fe920 mtu 255 len 14
> >>>>> >> [  171.689422] rfcomm_process_rx: session cc751be0 state 1 qlen 0
> >>>>> >> [  171.695709] rfcomm_process_rx: @@@ @@@ sk_state = 1
> >>>>> >> [  171.701110] rfcomm_process_dlcs: session cc751be0 state 1
> >>>>> >> [  171.706939] rfcomm_process_tx: dlc cd3fe920 state 1 cfc 40
> >>>>> >> rx_credits 33 tx_credits 31
> >>>>> >> [  171.715515] rfcomm_send_frame: session cc751be0 len 18
> >>>>> >> [  171.721130] rfcomm_session_put: in rfcomm_session_put, s->refcnt = 3
> >>>>> >> [  174.127807] rfcomm_sock_sendmsg: sock ce9a0960, sk cc5c4c00
> >>>>> >> [  174.134490] rfcomm_dlc_send: dlc cd3fe920 mtu 255 len 6
> >>>>> >> [  174.141540] rfcomm_process_rx: session cc751be0 state 1 qlen 0
> >>>>> >> [  174.148498] rfcomm_process_rx: @@@ @@@ sk_state = 1
> >>>>> >> [  174.154968] rfcomm_process_dlcs: session cc751be0 state 1
> >>>>> >> [  174.161437] rfcomm_process_tx: dlc cd3fe920 state 1 cfc 40
> >>>>> >> rx_credits 33 tx_credits 30
> >>>>> >> [  174.171173] rfcomm_send_frame: session cc751be0 len 10
> >>>>> >> [  174.177642] rfcomm_session_put: in rfcomm_session_put, s->refcnt = 3
> >>>>> >> [  174.205932] rfcomm_sock_release: sock ce9a0960, sk cc5c4c00
> >>>>> >> [  174.212707] rfcomm_sock_shutdown: sock ce9a0960, sk cc5c4c00
> >>>>> >> [  174.220031] __rfcomm_sock_close: sk cc5c4c00 state 1 socket ce9a0960
> >>>>> >> [  174.227508] __rfcomm_dlc_close: dlc cd3fe920 state 1 dlci 20 err 0
> >>>>> >> session cc751be0
> >>>>> >> [  174.236877] rfcomm_send_disc: cc751be0 dlci 20
> >>>>> >> [  174.242706] rfcomm_send_frame: session cc751be0 len 4
> >>>>> >> [  174.248962] rfcomm_dlc_set_timer: dlc cd3fe920 state 8 timeout 2560
> >>>>> >> [  174.256835] rfcomm_sock_kill: sk cc5c4c00 state 1 refcnt 2
> >>>>> >> [  174.263336] rfcomm_sock_destruct: sk cc5c4c00 dlc cd3fe920
> >>>>> >> [  174.399444] rfcomm_l2data_ready: ccf70400 bytes 4
> >>>>> >> [  174.404724] rfcomm_process_rx: session cc751be0 state 1 qlen 1
> >>>>> >> [  174.411010] rfcomm_process_rx: @@@ @@@ sk_state = 1
> >>>>> >> [  174.416412] rfcomm_recv_ua: session cc751be0 state 1 dlci 20
> >>>>> >> [  174.422515] __rfcomm_dlc_close: dlc cd3fe920 state 9 dlci 20 err 0
> >>>>> >> session cc751be0
> >>>>> >> [  174.430816] rfcomm_dlc_clear_timer: dlc cd3fe920 state 9
> >>>>> >> [  174.436553] rfcomm_dlc_unlink: dlc cd3fe920 refcnt 1 session cc751be0
> >>>>> >> [  174.443572] rfcomm_dlc_free: cd3fe920
> >>>>> >> [  174.447570] rfcomm_session_put: in rfcomm_session_put, s->refcnt = 3
> >>>>> >> [  174.454528] rfcomm_send_disc: cc751be0 dlci 0
> >>>>> >> [  174.459259] rfcomm_send_frame: session cc751be0 len 4
> >>>>> >> [  174.464904] rfcomm_process_dlcs: session cc751be0 state 8
> >>>>> >> [  174.470703] rfcomm_session_put: in rfcomm_session_put, s->refcnt = 2
> >>>>> >> [  174.898284] rfcomm_l2data_ready: ccf70400 bytes 4
> >>>>> >> [  174.903442] rfcomm_l2state_change: ccf70400 state 9
> >>>>> >> [  174.908874] rfcomm_process_rx: session cc751be0 state 8 qlen 1
> >>>>> >> [  174.915130] rfcomm_process_rx: @@@ @@@ sk_state = 9
> >>>>> >> [  174.920562] rfcomm_recv_ua: session cc751be0 state 8 dlci 0
> >>>>> >> [  174.926574] rfcomm_session_put: in rfcomm_session_put, s->refcnt = 2
> >>>>> >> [  174.933532] rfcomm_process_rx: @@@ @@@ sk_state == BT_CLOSED , s->initiator=0
> >>>>> >> [  174.941253] rfcomm_session_put: in rfcomm_session_put, s->refcnt = 1
> >>>>> >> [  174.948211] rfcomm_session_del: session cc751be0 state 8
> >>>>> >> [  174.953918] @@@@ in rfcomm_session_del()
> >>>>> >> [  174.958312] @@@@ s->list = cc751be0
> >>>>> >> [  174.962097] @@@@ s->list.next = ccbfe9a0
> >>>>> >> [  174.966369] @@@@ s->list.prev = c047d524
> >>>>> >> [  174.970733] @@@@ list is valid, call list_del()
> >>>>> >> [  174.975646] @@@@ after list_del()
> >>>>> >> [  174.979278] @@@@ s->list = cc751be0
> >>>>> >> [  174.983184] @@@@ s->list.next = 00100100
> >>>>> >> [  174.987457] @@@@ s->list.prev = 00200200
> >>>>> >> [  174.991729] rfcomm_session_close: session cc751be0 state 8 err 104
> >>>>> >> [  174.998504] rfcomm_session_put: in rfcomm_session_put, s->refcnt = 1
> >>>>> >> [  175.005310] rfcomm_session_del: session cc751be0 state 9
> >>>>> >> [  175.011169] @@@@ in rfcomm_session_del()
> >>>>> >> [  175.015441] @@@@ s->list = cc751be0
> >>>>> >> [  175.019409] @@@@ s->list.next = 00100100
> >>>>> >> [  175.023651] @@@@ s->list.prev = 00200200
> >>>>> >> [  175.027923] @@@@ list is valid, call list_del()
> >>>>> >> [  175.032958] Unable to handle kernel paging request at virtual
> >>>>> >> address 00200200
> >>>>> >> [  175.040679] pgd = c0004000
> >>>>> >> [  175.043792] [00200200] *pgd=00000000
> >>>>> >> [  175.047821] Internal error: Oops: 817 [#1]
> >>>>> >> [  175.052246] Modules linked in:
> >>>>> >> [  175.055725] CPU: 0    Not tainted  (2.6.29-omap1-dirty #34)
> >>>>> >> [  175.061859] PC is at rfcomm_session_del+0x6c/0x108
> >>>>> >> [  175.067047] LR is at release_console_sem+0x190/0x1a0
> >>>>> >> [  175.072509] pc : [<c033ded8>]    lr : [<c0066308>]    psr: 60000013
> >>>>> >> [  175.072509] sp : cc1abf38  ip : cc1abe68  fp : cc1abf4c
> >>>>> >> [  175.084960] r10: cc751c04  r9 : c036d2fc  r8 : cc751be0
> >>>>> >> [  175.090545] r7 : 00000068  r6 : cc751c04  r5 : 00000009  r4 : cc751be0
> >>>>> >> [  175.097656] r3 : 00100100  r2 : 00100100  r1 : 00200200  r0 : c0422876
> >>>>> >>
> >>>>> >> =============
> >>>>> >> HCI log analysis
> >>>>> >> =============
> >>>>> >> Compare the hcidump log of the correct case with the one of the panic
> >>>>> >> case, we found there is only one difference in the message sequence.
> >>>>> >> In the panic case, headset send L2CAP Disconn_Req immediately after
> >>>>> >> sending rfcomm UA frame to android. We think this is the reason that
> >>>>> >> cause the socket state become BT_CLOSED.
> >>>>> >>
> >>>>> >> Please compare these two log, pay attention to the message direction
> >>>>> >> of the last Disconn_Req.
> >>>>> >>
> >>>>> >>
> >>>>> >> Log of correct case:
> >>>>> >> ----------------------------
> >>>>> >>
> >>>>> >>
> >>>>> >> 009-09-10 15:27:28.963519 < ACL data: handle 1 flags 0x02 dlen 22
> >>>>> >>    L2CAP(d): cid 0x0047 len 18 [psm 3]
> >>>>> >>      RFCOMM(d): UIH: cr 0 dlci 20 pf 0 ilen 14 fcs 0xeb
> >>>>> >>      0000: 0d 0a 2b 43 49 45 56 3a  20 37 2c 33 0d 0a        ..+CIEV: 7,3..
> >>>>> >> 009-09-10 15:27:28.967272 > HCI Event: Number of Completed Packets (0x13) plen
> >>>>> >>
> >>>>> >>    handle 1 packets 1
> >>>>> >> 009-09-10 15:27:29.243945 < ACL data: handle 1 flags 0x02 dlen 8
> >>>>> >>    L2CAP(d): cid 0x0047 len 4 [psm 3]
> >>>>> >>      RFCOMM(s): DISC: cr 0 dlci 20 pf 1 ilen 0 fcs 0x7d
> >>>>> >> 009-09-10 15:27:29.247363 > HCI Event: Number of Completed Packets (0x13) plen
> >>>>> >>
> >>>>> >>    handle 1 packets 1
> >>>>> >> 009-09-10 15:27:29.274890 > ACL data: handle 1 flags 0x02 dlen 8
> >>>>> >>    L2CAP(d): cid 0x0040 len 4 [psm 3]
> >>>>> >>      RFCOMM(s): UA: cr 0 dlci 20 pf 1 ilen 0 fcs 0x57
> >>>>> >> 009-09-10 15:27:29.296343 < ACL data: handle 1 flags 0x02 dlen 8
> >>>>> >>    L2CAP(d): cid 0x0047 len 4 [psm 3]
> >>>>> >>      RFCOMM(s): DISC: cr 0 dlci 0 pf 1 ilen 0 fcs 0x9c
> >>>>> >> 009-09-10 15:27:29.298480 > HCI Event: Number of Completed Packets (0x13) plen
> >>>>> >>
> >>>>> >>    handle 1 packets 1
> >>>>> >> 009-09-10 15:27:29.319873 > ACL data: handle 1 flags 0x02 dlen 8
> >>>>> >>    L2CAP(d): cid 0x0040 len 4 [psm 3]
> >>>>> >>      RFCOMM(s): UA: cr 0 dlci 0 pf 1 ilen 0 fcs 0xb6
> >>>>> >> 009-09-10 15:27:29.320727 < ACL data: handle 1 flags 0x02 dlen 12
> >>>>> >>    L2CAP(s): Disconn req: dcid 0x0047 scid 0x0040
> >>>>> >> 009-09-10 15:27:29.323474 > HCI Event: Number of Completed Packets (0x13) plen
> >>>>> >>
> >>>>> >>    handle 1 packets 1
> >>>>> >> 009-09-10 15:27:29.337237 > ACL data: handle 1 flags 0x02 dlen 12
> >>>>> >>    L2CAP(s): Disconn rsp: dcid 0x0047 scid 0x0040
> >>>>> >>
> >>>>> >>
> >>>>> >>
> >>>>> >>
> >>>>> >> log of panic case:
> >>>>> >> ------------------------
> >>>>> >>
> >>>>> >>
> >>>>> >>
> >>>>> >> 2009-09-10 13:34:24.020208 < ACL data: handle 1 flags 0x02 dlen 22
> >>>>> >>     L2CAP(d): cid 0x0041 len 18 [psm 3]
> >>>>> >>       RFCOMM(d): UIH: cr 0 dlci 20 pf 0 ilen 14 fcs 0xeb
> >>>>> >>       0000: 0d 0a 2b 43 49 45 56 3a  20 37 2c 33 0d 0a        ..+CIEV: 7,3..
> >>>>> >> 2009-09-10 13:34:24.281256 > HCI Event: Number of Completed Packets (0x13) plen
> >>>>> >> 5
> >>>>> >>     handle 1 packets 1
> >>>>> >> 2009-09-10 13:34:24.083580 < ACL data: handle 1 flags 0x02 dlen 8
> >>>>> >>     L2CAP(d): cid 0x0041 len 4 [psm 3]
> >>>>> >>       RFCOMM(s): DISC: cr 0 dlci 20 pf 1 ilen 0 fcs 0x7d
> >>>>> >> 2009-09-10 13:34:24.529442 > HCI Event: Number of Completed Packets (0x13) plen
> >>>>> >> 5
> >>>>> >>     handle 1 packets 1
> >>>>> >> 2009-09-10 13:34:24.531914 > ACL data: handle 1 flags 0x02 dlen 8
> >>>>> >>     L2CAP(d): cid 0x0040 len 4 [psm 3]
> >>>>> >>       RFCOMM(s): UA: cr 0 dlci 20 pf 1 ilen 0 fcs 0x57
> >>>>> >> 2009-09-10 13:34:24.533135 < ACL data: handle 1 flags 0x02 dlen 8
> >>>>> >>     L2CAP(d): cid 0x0041 len 4 [psm 3]
> >>>>> >>       RFCOMM(s): DISC: cr 0 dlci 0 pf 1 ilen 0 fcs 0x9c
> >>>>> >> 2009-09-10 13:34:25.028649 > HCI Event: Number of Completed Packets (0x13) plen
> >>>>> >> 5
> >>>>> >>     handle 1 packets 1
> >>>>> >> 2009-09-10 13:34:25.032128 > ACL data: handle 1 flags 0x02 dlen 8
> >>>>> >>     L2CAP(d): cid 0x0040 len 4 [psm 3]
> >>>>> >>       RFCOMM(s): UA: cr 0 dlci 0 pf 1 ilen 0 fcs 0xb6
> >>>>> >> 2009-09-10 13:34:25.032341 > ACL data: handle 1 flags 0x02 dlen 12
> >>>>> >>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0041
> >>>>> >> 2009-09-10 13:34:25.032646 < ACL data: handle 1 flags 0x02 dlen 12
> >>>>> >>     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0041
> >>>>> >>
> >>>>> >> =============
> >>>>> >> Analysis Result
> >>>>> >> =============
> >>>>> >> For some kinds of Bluetooth headset such as Motorola H560/H620 which
> >>>>> >> are based on BCM2044S, they will send L2CAP Disconn_Req command right
> >>>>> >> after sending rfcomm UA frame. This L2CAP Disconn_Req will cause the
> >>>>> >> rfcomm socket state become BT_CLOSED before completely handling UA
> >>>>> >> frame, thus it will cause kernel panic. I think we can ignore the
> >>>>> >> received rfcomm frames if socket state is BT_CLOSED, because it
> >>>>> >> doesn't make sense in the BT_CLOSED state.
> >>>>> >>
> >>>>> >>
> >>>>> >> =============
> >>>>> >> Changed Code
> >>>>> >> =============
> >>>>> >> We changed the code in the function rfcomm_process_rx() in
> >>>>> >> net/bluetooth/rfcomm/core.c, check the socket state first before
> >>>>> >> handling the received framew. If the socket state is BT_CLOSED, we
> >>>>> >> don't handle any rfcomm frames but just close the session.
> >>>>> >>
> >>>>> >> The change is like below
> >>>>> >>
> >>>>> >> +       if (sk->sk_state != BT_CLOSED) {
> >>>>> >>         /* Get data directly from socket receive queue without copying it. */
> >>>>> >>         while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
> >>>>> >>                 skb_orphan(skb);
> >>>>> >>                 rfcomm_recv_frame(s, skb);
> >>>>> >>         }
> >>>>> >> -
> >>>>> >> -       if (sk->sk_state == BT_CLOSED) {
> >>>>> >> +       } else {
> >>>>> >>                 if (!s->initiator)
> >>>>> >>                         rfcomm_session_put(s);
> >>>>> >>
> >>>>> >>                 rfcomm_session_close(s, sk->sk_err);
> >>>>> >>          }
> >>>>> >
> >>>>> > so I do see the issue here, but I don't agree with the fix since it
> >>>>> > changes behavior that might cause other issues. So in case the frame
> >>>>> > processing leads to sk->sk_state == BT_CLOSED we are not closing the
> >>>>> > connection anymore if we make it depend on a state before the frame
> >>>>> > processing. And nothing guarantees that rfcomm_process_rx gets scheduled
> >>>>> > again.
> >>>>> >
> >>>>> > diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> >>>>> > index 94b3388..606143b 100644
> >>>>> > --- a/net/bluetooth/rfcomm/core.c
> >>>>> > +++ b/net/bluetooth/rfcomm/core.c
> >>>>> > @@ -1798,12 +1798,16 @@ static inline void rfcomm_process_rx(struct rfcomm_session *s)
> >>>>> >
> >>>>> >        BT_DBG("session %p state %ld qlen %d", s, s->state, skb_queue_len(&sk->sk_receive_queue));
> >>>>> >
> >>>>> > +       rfcomm_session_hold(s);
> >>>>> > +
> >>>>> >        /* Get data directly from socket receive queue without copying it. */
> >>>>> >        while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
> >>>>> >                skb_orphan(skb);
> >>>>> >                rfcomm_recv_frame(s, skb);
> >>>>> >        }
> >>>>> >
> >>>>> > +       rfcomm_session_put(s);
> >>>>> > +
> >>>>> >        if (sk->sk_state == BT_CLOSED) {
> >>>>> >                if (!s->initiator)
> >>>>> >                        rfcomm_session_put(s);
> >>>>> >
> >>>>> > What does the above patch do for you? Since if I read it correctly, then
> >>>>> > the rfcomm_recv_ua causes the rfcomm_session_put to trigger the closing
> >>>>> > of the session. And then in this case it is delayed until after all
> >>>>> > frames are processed.
> >>>>> >
> >>>>> >
> >>>>>
> >>>>> I've tried your patch but unfortunately kernel panic still happened.
> >>>>>
> >>>>> From the log I noticed that if rfcomm_l2state_change is called before
> >>>>> rfcomm_process_rx, kernel panic will happen definitely.
> >>>>>
> >>>>> Below lines are in the correct log,
> >>>>>
> >>>>> [  139.323852] rfcomm_l2data_ready: ccf70000 bytes 4
> >>>>> [  139.346252] rfcomm_process_rx: session ccb94ce0 state 8 qlen 1
> >>>>> ...
> >>>>> [  139.457519] rfcomm_l2state_change: ccf70000 state 9
> >>>>> (disconnect ok)
> >>>>>
> >>>>> In the above case, when process_rx, the code in the condition "if
> >>>>> (sk->sk_state == BT_CLOSED)" will never run.
> >>>>>
> >>>>> Below lines are in the panic log,
> >>>>>
> >>>>> [  174.898284] rfcomm_l2data_ready: ccf70400 bytes 4
> >>>>> [  174.903442] rfcomm_l2state_change: ccf70400 state 9
> >>>>> [  174.908874] rfcomm_process_rx: session cc751be0 state 8 qlen 1
> >>>>> ...
> >>>>> ( then panic)
> >>>>>
> >>>>> In the above case, sk_state is changed to 9 (BT_CLOSED) firstly,  then
> >>>>> process_rx, so the code in the condition "if (sk->sk_state ==
> >>>>> BT_CLOSED) " will be run, it will call session_put twice. I think this
> >>>>> is the root cause of panic.
> >>>>
> >>>> I know why it happens, that is not the problem. My point is not to break
> >>>> current scheduling assumptions.
> >>>>
> >>>> So if you move the rfcomm_session_put() now at the end of the function,
> >>>> then it should be fine, right?
> >>>>
> >>>> Regards
> >>>>
> >>>> Marcel
> >>>>
> >>>>
> >>>>
> >>>
> >>> You are right. I moved the rfcomm_session_put() at the end of
> >>> rfcomm_process_tx() then kernel panic doesn't happen any longer.
> >>>
> >>> The changed code is like below,
> >>>
> >>> @@ -1796,6 +1796,8 @@ static inline void rfcomm_process_rx(struct rfcomm_session
> >>>
> >>>        BT_DBG("session %p state %ld qlen %d", s, s->state, skb_queue_len(&sk->s
> >>>
> >>> +       rfcomm_session_hold(s);
> >>> +
> >>>        /* Get data directly from socket receive queue without copying it. */
> >>>        while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
> >>>                skb_orphan(skb);
> >>> @@ -1808,6 +1810,8 @@ static inline void rfcomm_process_rx(struct rfcomm_session
> >>>
> >>>                rfcomm_session_close(s, sk->sk_err);
> >>>        }
> >>> +
> >>> +       rfcomm_session_put(s);
> >>>  }
> >>>
> >>>  static inline void rfcomm_accept_connection(struct rfcomm_session *s)
> >>>
> >>> Please submit this change to bluez release.
> >>
> >>
> >> Unfortunately, with this change I get a panic disconnecting from
> >> Motorola H270 in the case that the headset initiated RFCOMM and we
> >> disconnect RFCOMM.
> >>
> >> Here is the hcidump:
> >>
> >> 2009-09-21 17:22:37.384811 < ACL data: handle 1 flags 0x02 dlen 22
> >>    L2CAP(d): cid 0x0041 len 18 [psm 3]
> >>      RFCOMM(d): UIH: cr 0 dlci 20 pf 0 ilen 14 fcs 0xeb
> >>      0000: 0d 0a 2b 43 49 45 56 3a  20 37 2c 33 0d 0a        ..+CIEV: 7,3..
> >> 2009-09-21 17:22:37.502273 > HCI Event: Number of Completed Packets
> >> (0x13) plen 5
> >>    handle 1 packets 1
> >> 2009-09-21 17:22:37.788895 < ACL data: handle 1 flags 0x02 dlen 8
> >>    L2CAP(d): cid 0x0041 len 4 [psm 3]
> >>      RFCOMM(s): DISC: cr 0 dlci 20 pf 1 ilen 0 fcs 0x7d
> >> 2009-09-21 17:22:37.906204 > HCI Event: Number of Completed Packets
> >> (0x13) plen 5
> >>    handle 1 packets 1
> >> 2009-09-21 17:22:37.933090 > ACL data: handle 1 flags 0x02 dlen 8
> >>    L2CAP(d): cid 0x0040 len 4 [psm 3]
> >>      RFCOMM(s): UA: cr 0 dlci 20 pf 1 ilen 0 fcs 0x57
> >> 2009-09-21 17:22:38.636764 < ACL data: handle 1 flags 0x02 dlen 8
> >>    L2CAP(d): cid 0x0041 len 4 [psm 3]
> >>      RFCOMM(s): DISC: cr 0 dlci 0 pf 1 ilen 0 fcs 0x9c
> >> 2009-09-21 17:22:38.744125 > HCI Event: Number of Completed Packets
> >> (0x13) plen 5
> >>    handle 1 packets 1
> >> 2009-09-21 17:22:38.763687 > ACL data: handle 1 flags 0x02 dlen 8
> >>    L2CAP(d): cid 0x0040 len 4 [psm 3]
> >>      RFCOMM(s): UA: cr 0 dlci 0 pf 1 ilen 0 fcs 0xb6
> >> 2009-09-21 17:22:38.783554 > ACL data: handle 1 flags 0x02 dlen 12
> >>    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0041
> >> 2009-09-21 17:22:39.029526 < ACL data: handle 1 flags 0x02 dlen 12
> >>    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0041
> >> 2009-09-21 17:22:39.136581 > HCI Event: Number of Completed Packets
> >> (0x13) plen 5
> >>    handle 1 packets 1
> >> 2009-09-21 17:22:41.337203 > HCI Event: Disconn Complete (0x05) plen 4
> >>    status 0x00 handle 1 reason 0x13
> >>    Reason: Remote User Terminated Connection
> >>
> >> And the panic:
> >>
> >> <7>[ 3161.665557] rfcomm:rfcomm_session_del: session c9c06ad0 state 9
> >> <7>[ 3161.671905] l2cap:l2cap_sock_release: sock cea04360, sk c97f02f8
> >> <7>[ 3161.678497] l2cap:l2cap_sock_shutdown: sock cea04360, sk c97f02f8
> >> <7>[ 3161.685028] l2cap:l2cap_sock_kill: sk c97f02f8 state 9
> >> <7>[ 3161.695587] l2cap:l2cap_sock_destruct: sk c97f02f8
> >> <4>[ 3161.700805] npelly 1911 rfcomm_process_sessions session c9c06ad0
> >> refcnt 1802201963
> >> <7>[ 3161.709014] rfcomm:rfcomm_process_dlcs: session c9c06ad0 state 1802201963
> >> <7>[ 3161.716308] rfcomm:rfcomm_process_dlcs: session c9c06ad0 dlc 6b6b6b6b
> >> <1>[ 3161.726776] Unable to handle kernel paging request at virtual
> >> address 6b6b6b6b
> >> <1>[ 3161.734619] pgd = c0004000
> >> <1>[ 3161.737609] [6b6b6b6b] *pgd=00000000
> >> <4>[ 3161.741638] Internal error: Oops: 5 [#1] PREEMPT
> >> <4>[ 3161.746734] Modules linked in:
> >> <4>[ 3161.750213] CPU: 0    Not tainted
> >> (2.6.29-omap1-07358-g9a3fd55-dirty #206)
> >> <4>[ 3161.757629] PC is at rfcomm_process_dlcs+0x108/0x590
> >> <4>[ 3161.762969] LR is at preempt_schedule+0x44/0x54
> >> <4>[ 3161.767852] pc : [<c03911f4>]    lr : [<c03a27c4>]    psr: 60000113
> >> <4>[ 3161.767883] sp : ccdf9e80  ip : ccdf9dd8  fp : ccdf9edc
> >> <4>[ 3161.780273] r10: 00000000  r9 : c9c06af4  r8 : c9c06ad0
> >> <4>[ 3161.786010] r7 : 00000000  r6 : c9c06ad0  r5 : c4c68680  r4 : 6b6b6b6b
> >> <4>[ 3161.792968] r3 : c9c06ae0  r2 : ccdf8000  r1 : c61a8940  r0 : 0000004c
> >> <4>[ 3161.800079] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
> >> Segment kernel
> >> <4>[ 3161.807983] Control: 10c5387d  Table: 86db8019  DAC: 00000017
> >> <4>[ 3161.814147]
> >> <4>[ 3161.814147] PC: 0xc0391174:
> >> [...]
> >> <4>[ 3162.973175] Backtrace:
> >> <4>[ 3162.976013] [<c03910ec>] (rfcomm_process_dlcs+0x0/0x590) from
> >> [<c03930b0>] (rfcomm_process_sessions+0x1a34/0x1a9c)
> >> <4>[ 3162.987579] [<c039167c>] (rfcomm_process_sessions+0x0/0x1a9c)
> >> from [<c03932ec>] (rfcomm_run+0x1d4/0x2ac)
> >> <4>[ 3162.998199] [<c0393118>] (rfcomm_run+0x0/0x2ac) from
> >> [<c008e7d8>] (kthread+0x5c/0x94)
> >> <4>[ 3163.013763] [<c008e77c>] (kthread+0x0/0x94) from [<c007c998>]
> >> (do_exit+0x0/0x714)
> >>
> >>
> >> Seems like this fix avoids the panic due to calling
> >> rfcomm_session_close() on a deleted session, but does not always
> >> address the unbalanced rfcomm_session_put() which may be the root
> >> cause.
> >>
> >> Lan Zhu suspected this in the original post, and his original fix does
> >> in fact fix this panic as well as the originally reported panic,
> >> because it avoids the unbalanced rfcomm_session_put().
> >>
> >> Marcel I know you are concerned about the original fix changing
> >> scheduling assumptions, are you able to comment on this further?
> >>
> >> Are there any other suggestions for patches for this issue? I have
> >> spent the best part of the day trying to figure this one out, but the
> >> recounting in the rfcomm core is quite subtle and I think it really
> >> needs someone familiar with the code to have a quick look and come up
> >> with the safest patch. I can run tests.
> >>
> >> In the mean time, I am doing some testing of Lan Zhu's original fix
> >> and if there are no better suggestions we will run with that one for
> >> Android.
> >>
> >> Nick
> >>
> >>
> >> Some more analysis:
> >>
> >> With the RFCOMM connection in idle there are 2 references on s->refcnt
> >>
> >> However three references are removed during disconnect with the H270
> >> - rfcomm_process_sessions() -> __rfcomm_dlc_close() -> rfcomm_dlc_unlink()
> >> - rfcomm_process_sessions() -> rfcomm_process_rx() -> rfcomm_recv_ua()
> >> with dlci = 0 and s->state = BT_DISCONN
> >> - rfcomm_process_sessions() -> rfcomm_process_rx() with sk_state =
> >> BT_CLOSED and s->initiator = 0
> >>
> >> in that order.
> >>
> >> On another headset, for example the Moto H350, we only see the first
> >> two references removed during disconnect.
> >>
> >> - rfcomm_process_sessions() -> __rfcomm_dlc_close() -> rfcomm_dlc_unlink()
> >> - rfcomm_process_sessions() -> rfcomm_process_rx() -> rfcomm_recv_ua()
> >> with dlci = 0 and s->state = BT_DISCONN
> >>
> >
> > How about this. We still call rfcomm_process_rx(), but avoid the
> > rfcomm_session_put() due to RFCOMM UA when the socket state is
> > BT_CLOSED.
> >
> > It is less invasive, so might address Marcel's concerns with regard to
> > scheduling changes.
> >
> >
> > diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> > index c109a3a..333c6e9 100644
> > --- a/net/bluetooth/rfcomm/core.c
> > +++ b/net/bluetooth/rfcomm/core.c
> > @@ -1105,6 +1105,8 @@ static int rfcomm_recv_ua(struct rfcomm_session
> > *s, u8 dlci)
> >                }
> >        } else {
> >                /* Control channel */
> > +               struct socket *sock = s->sock;
> > +               struct sock *sk = sock->sk;
> >                switch (s->state) {
> >                case BT_CONNECT:
> >                        s->state = BT_CONNECTED;
> > @@ -1112,7 +1114,8 @@ static int rfcomm_recv_ua(struct rfcomm_session
> > *s, u8 dlci)
> >                        break;
> >
> >                case BT_DISCONN:
> > -                       rfcomm_session_put(s);
> > +                       if (sk->sk_state != BT_CLOSED)
> > +                               rfcomm_session_put(s);
> >                        break;
> >                }
> >        }
> >
> 
> I made a minor style improvement and added commit message. Patch available from
> 
> http://android.git.kernel.org/?p=kernel/common.git;a=commit;h=1048e007842da2d6440679e1ca80f45438a6369d
> 

What about following fix? (building test only)


--- linux-2.6.orig/net/bluetooth/rfcomm/core.c	2009-09-19 15:25:23.000000000 +0800
+++ linux-2.6/net/bluetooth/rfcomm/core.c	2009-09-23 15:15:30.000000000 +0800
@@ -1927,16 +1927,15 @@ static inline void rfcomm_process_sessio
 
 		rfcomm_session_hold(s);
 
-		switch (s->state) {
-		case BT_BOUND:
-			rfcomm_check_connection(s);
-			break;
-
-		default:
-			rfcomm_process_rx(s);
-			break;
+		rfcomm_check_connection(s);
+
+		if (s->state == BT_CLOSED) {
+			rfcomm_session_put(s);
+			continue;
 		}
 
+		rfcomm_process_rx(s);
+
 		rfcomm_process_dlcs(s);
 
 		rfcomm_session_put(s);
