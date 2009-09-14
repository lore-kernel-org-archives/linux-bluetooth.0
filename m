Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1252687514.8931.77.camel@violet>
References: <113d36d80909110053ybd2c203xeda76bd36248bb17@mail.gmail.com>
	 <1252657436.8931.52.camel@violet>
	 <113d36d80909110828i1b53e8f5x5b913fb7861850fd@mail.gmail.com>
	 <1252687514.8931.77.camel@violet>
Date: Mon, 14 Sep 2009 17:10:41 +0800
Message-ID: <113d36d80909140210n476f5826x1ae2ea621b57782c@mail.gmail.com>
Subject: Re: kernel panic happens when disconnecting Bluetooth headset
From: Lan Zhu <zhu.lan.cn@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

2009/9/12 Marcel Holtmann <marcel@holtmann.org>:
> Hi Zhu,
>
>> >> We met a issue that kernel panic happens when disconnecting some kind=
s
>> >> of Bluetooth headset, then we did some analysis and made some changes
>> >> on kernel code which have avoided the panic happening. Would you
>> >> please help to check if our analysis and fix is correct?
>> >>
>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> Issue description
>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> On Android platform(kernel 2.6.29), disconnecting Bluetooth headset
>> >> may cause kernel panic on certain conditions.
>> >>
>> >> (Pre-condition is android paired with headset.)
>> >> Initiate the connection from android, disconnect it from android, res=
ult is OK.
>> >> Initiate the connection from android, disconnect it from headset, res=
ult is OK.
>> >> Initiate the connection from headset, disconnect it from headset, res=
ult is OK.
>> >> Initiate the connection from headset, disconnect it from android, for
>> >> Motorola H12 headset, result is OK.
>> >> Initiate the connection from headset, disconnect it from android, for
>> >> Motorola H620/560 headset, result is kernel panic.
>> >>
>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> Kernel panic point
>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> kernel panic at __list_del() in the function rfcomm_session_del() ,
>> >> panic reason is "Unable to handle kernel paging request at virtual
>> >> address 00200200"
>> >>
>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> Kernel log analysis
>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> rfcomm_session_del() is still called after the session entry is
>> >> removed from the list. Then __list_del() will cause kernel panic
>> >> because of the incorrect pointer. This situation occurs when calling
>> >> rfcomm_recv_ua() when the socket state is BT_CLOSED . So we need to
>> >> find out why the socket state become BT_CLOSED before we calling
>> >> rfcomm_recv_ua().
>> >>
>> >> # [ =A0171.677429] rfcomm_sock_sendmsg: sock ce9a0960, sk cc5c4c00
>> >> [ =A0171.683532] rfcomm_dlc_send: dlc cd3fe920 mtu 255 len 14
>> >> [ =A0171.689422] rfcomm_process_rx: session cc751be0 state 1 qlen 0
>> >> [ =A0171.695709] rfcomm_process_rx: @@@ @@@ sk_state =3D 1
>> >> [ =A0171.701110] rfcomm_process_dlcs: session cc751be0 state 1
>> >> [ =A0171.706939] rfcomm_process_tx: dlc cd3fe920 state 1 cfc 40
>> >> rx_credits 33 tx_credits 31
>> >> [ =A0171.715515] rfcomm_send_frame: session cc751be0 len 18
>> >> [ =A0171.721130] rfcomm_session_put: in rfcomm_session_put, s->refcnt=
 =3D 3
>> >> [ =A0174.127807] rfcomm_sock_sendmsg: sock ce9a0960, sk cc5c4c00
>> >> [ =A0174.134490] rfcomm_dlc_send: dlc cd3fe920 mtu 255 len 6
>> >> [ =A0174.141540] rfcomm_process_rx: session cc751be0 state 1 qlen 0
>> >> [ =A0174.148498] rfcomm_process_rx: @@@ @@@ sk_state =3D 1
>> >> [ =A0174.154968] rfcomm_process_dlcs: session cc751be0 state 1
>> >> [ =A0174.161437] rfcomm_process_tx: dlc cd3fe920 state 1 cfc 40
>> >> rx_credits 33 tx_credits 30
>> >> [ =A0174.171173] rfcomm_send_frame: session cc751be0 len 10
>> >> [ =A0174.177642] rfcomm_session_put: in rfcomm_session_put, s->refcnt=
 =3D 3
>> >> [ =A0174.205932] rfcomm_sock_release: sock ce9a0960, sk cc5c4c00
>> >> [ =A0174.212707] rfcomm_sock_shutdown: sock ce9a0960, sk cc5c4c00
>> >> [ =A0174.220031] __rfcomm_sock_close: sk cc5c4c00 state 1 socket ce9a=
0960
>> >> [ =A0174.227508] __rfcomm_dlc_close: dlc cd3fe920 state 1 dlci 20 err=
 0
>> >> session cc751be0
>> >> [ =A0174.236877] rfcomm_send_disc: cc751be0 dlci 20
>> >> [ =A0174.242706] rfcomm_send_frame: session cc751be0 len 4
>> >> [ =A0174.248962] rfcomm_dlc_set_timer: dlc cd3fe920 state 8 timeout 2=
560
>> >> [ =A0174.256835] rfcomm_sock_kill: sk cc5c4c00 state 1 refcnt 2
>> >> [ =A0174.263336] rfcomm_sock_destruct: sk cc5c4c00 dlc cd3fe920
>> >> [ =A0174.399444] rfcomm_l2data_ready: ccf70400 bytes 4
>> >> [ =A0174.404724] rfcomm_process_rx: session cc751be0 state 1 qlen 1
>> >> [ =A0174.411010] rfcomm_process_rx: @@@ @@@ sk_state =3D 1
>> >> [ =A0174.416412] rfcomm_recv_ua: session cc751be0 state 1 dlci 20
>> >> [ =A0174.422515] __rfcomm_dlc_close: dlc cd3fe920 state 9 dlci 20 err=
 0
>> >> session cc751be0
>> >> [ =A0174.430816] rfcomm_dlc_clear_timer: dlc cd3fe920 state 9
>> >> [ =A0174.436553] rfcomm_dlc_unlink: dlc cd3fe920 refcnt 1 session cc7=
51be0
>> >> [ =A0174.443572] rfcomm_dlc_free: cd3fe920
>> >> [ =A0174.447570] rfcomm_session_put: in rfcomm_session_put, s->refcnt=
 =3D 3
>> >> [ =A0174.454528] rfcomm_send_disc: cc751be0 dlci 0
>> >> [ =A0174.459259] rfcomm_send_frame: session cc751be0 len 4
>> >> [ =A0174.464904] rfcomm_process_dlcs: session cc751be0 state 8
>> >> [ =A0174.470703] rfcomm_session_put: in rfcomm_session_put, s->refcnt=
 =3D 2
>> >> [ =A0174.898284] rfcomm_l2data_ready: ccf70400 bytes 4
>> >> [ =A0174.903442] rfcomm_l2state_change: ccf70400 state 9
>> >> [ =A0174.908874] rfcomm_process_rx: session cc751be0 state 8 qlen 1
>> >> [ =A0174.915130] rfcomm_process_rx: @@@ @@@ sk_state =3D 9
>> >> [ =A0174.920562] rfcomm_recv_ua: session cc751be0 state 8 dlci 0
>> >> [ =A0174.926574] rfcomm_session_put: in rfcomm_session_put, s->refcnt=
 =3D 2
>> >> [ =A0174.933532] rfcomm_process_rx: @@@ @@@ sk_state =3D=3D BT_CLOSED=
 , s->initiator=3D0
>> >> [ =A0174.941253] rfcomm_session_put: in rfcomm_session_put, s->refcnt=
 =3D 1
>> >> [ =A0174.948211] rfcomm_session_del: session cc751be0 state 8
>> >> [ =A0174.953918] @@@@ in rfcomm_session_del()
>> >> [ =A0174.958312] @@@@ s->list =3D cc751be0
>> >> [ =A0174.962097] @@@@ s->list.next =3D ccbfe9a0
>> >> [ =A0174.966369] @@@@ s->list.prev =3D c047d524
>> >> [ =A0174.970733] @@@@ list is valid, call list_del()
>> >> [ =A0174.975646] @@@@ after list_del()
>> >> [ =A0174.979278] @@@@ s->list =3D cc751be0
>> >> [ =A0174.983184] @@@@ s->list.next =3D 00100100
>> >> [ =A0174.987457] @@@@ s->list.prev =3D 00200200
>> >> [ =A0174.991729] rfcomm_session_close: session cc751be0 state 8 err 1=
04
>> >> [ =A0174.998504] rfcomm_session_put: in rfcomm_session_put, s->refcnt=
 =3D 1
>> >> [ =A0175.005310] rfcomm_session_del: session cc751be0 state 9
>> >> [ =A0175.011169] @@@@ in rfcomm_session_del()
>> >> [ =A0175.015441] @@@@ s->list =3D cc751be0
>> >> [ =A0175.019409] @@@@ s->list.next =3D 00100100
>> >> [ =A0175.023651] @@@@ s->list.prev =3D 00200200
>> >> [ =A0175.027923] @@@@ list is valid, call list_del()
>> >> [ =A0175.032958] Unable to handle kernel paging request at virtual
>> >> address 00200200
>> >> [ =A0175.040679] pgd =3D c0004000
>> >> [ =A0175.043792] [00200200] *pgd=3D00000000
>> >> [ =A0175.047821] Internal error: Oops: 817 [#1]
>> >> [ =A0175.052246] Modules linked in:
>> >> [ =A0175.055725] CPU: 0 =A0 =A0Not tainted =A0(2.6.29-omap1-dirty #34=
)
>> >> [ =A0175.061859] PC is at rfcomm_session_del+0x6c/0x108
>> >> [ =A0175.067047] LR is at release_console_sem+0x190/0x1a0
>> >> [ =A0175.072509] pc : [<c033ded8>] =A0 =A0lr : [<c0066308>] =A0 =A0ps=
r: 60000013
>> >> [ =A0175.072509] sp : cc1abf38 =A0ip : cc1abe68 =A0fp : cc1abf4c
>> >> [ =A0175.084960] r10: cc751c04 =A0r9 : c036d2fc =A0r8 : cc751be0
>> >> [ =A0175.090545] r7 : 00000068 =A0r6 : cc751c04 =A0r5 : 00000009 =A0r=
4 : cc751be0
>> >> [ =A0175.097656] r3 : 00100100 =A0r2 : 00100100 =A0r1 : 00200200 =A0r=
0 : c0422876
>> >>
>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> HCI log analysis
>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> Compare the hcidump log of the correct case with the one of the panic
>> >> case, we found there is only one difference in the message sequence.
>> >> In the panic case, headset send L2CAP Disconn_Req immediately after
>> >> sending rfcomm UA frame to android. We think this is the reason that
>> >> cause the socket state become BT_CLOSED.
>> >>
>> >> Please compare these two log, pay attention to the message direction
>> >> of the last Disconn_Req.
>> >>
>> >>
>> >> Log of correct case:
>> >> ----------------------------
>> >>
>> >>
>> >> 009-09-10 15:27:28.963519 < ACL data: handle 1 flags 0x02 dlen 22
>> >> =A0 =A0L2CAP(d): cid 0x0047 len 18 [psm 3]
>> >> =A0 =A0 =A0RFCOMM(d): UIH: cr 0 dlci 20 pf 0 ilen 14 fcs 0xeb
>> >> =A0 =A0 =A00000: 0d 0a 2b 43 49 45 56 3a =A020 37 2c 33 0d 0a =A0 =A0=
 =A0 =A0..+CIEV: 7,3..
>> >> 009-09-10 15:27:28.967272 > HCI Event: Number of Completed Packets (0=
x13) plen
>> >>
>> >> =A0 =A0handle 1 packets 1
>> >> 009-09-10 15:27:29.243945 < ACL data: handle 1 flags 0x02 dlen 8
>> >> =A0 =A0L2CAP(d): cid 0x0047 len 4 [psm 3]
>> >> =A0 =A0 =A0RFCOMM(s): DISC: cr 0 dlci 20 pf 1 ilen 0 fcs 0x7d
>> >> 009-09-10 15:27:29.247363 > HCI Event: Number of Completed Packets (0=
x13) plen
>> >>
>> >> =A0 =A0handle 1 packets 1
>> >> 009-09-10 15:27:29.274890 > ACL data: handle 1 flags 0x02 dlen 8
>> >> =A0 =A0L2CAP(d): cid 0x0040 len 4 [psm 3]
>> >> =A0 =A0 =A0RFCOMM(s): UA: cr 0 dlci 20 pf 1 ilen 0 fcs 0x57
>> >> 009-09-10 15:27:29.296343 < ACL data: handle 1 flags 0x02 dlen 8
>> >> =A0 =A0L2CAP(d): cid 0x0047 len 4 [psm 3]
>> >> =A0 =A0 =A0RFCOMM(s): DISC: cr 0 dlci 0 pf 1 ilen 0 fcs 0x9c
>> >> 009-09-10 15:27:29.298480 > HCI Event: Number of Completed Packets (0=
x13) plen
>> >>
>> >> =A0 =A0handle 1 packets 1
>> >> 009-09-10 15:27:29.319873 > ACL data: handle 1 flags 0x02 dlen 8
>> >> =A0 =A0L2CAP(d): cid 0x0040 len 4 [psm 3]
>> >> =A0 =A0 =A0RFCOMM(s): UA: cr 0 dlci 0 pf 1 ilen 0 fcs 0xb6
>> >> 009-09-10 15:27:29.320727 < ACL data: handle 1 flags 0x02 dlen 12
>> >> =A0 =A0L2CAP(s): Disconn req: dcid 0x0047 scid 0x0040
>> >> 009-09-10 15:27:29.323474 > HCI Event: Number of Completed Packets (0=
x13) plen
>> >>
>> >> =A0 =A0handle 1 packets 1
>> >> 009-09-10 15:27:29.337237 > ACL data: handle 1 flags 0x02 dlen 12
>> >> =A0 =A0L2CAP(s): Disconn rsp: dcid 0x0047 scid 0x0040
>> >>
>> >>
>> >>
>> >>
>> >> log of panic case:
>> >> ------------------------
>> >>
>> >>
>> >>
>> >> 2009-09-10 13:34:24.020208 < ACL data: handle 1 flags 0x02 dlen 22
>> >> =A0 =A0 L2CAP(d): cid 0x0041 len 18 [psm 3]
>> >> =A0 =A0 =A0 RFCOMM(d): UIH: cr 0 dlci 20 pf 0 ilen 14 fcs 0xeb
>> >> =A0 =A0 =A0 0000: 0d 0a 2b 43 49 45 56 3a =A020 37 2c 33 0d 0a =A0 =
=A0 =A0 =A0..+CIEV: 7,3..
>> >> 2009-09-10 13:34:24.281256 > HCI Event: Number of Completed Packets (=
0x13) plen
>> >> 5
>> >> =A0 =A0 handle 1 packets 1
>> >> 2009-09-10 13:34:24.083580 < ACL data: handle 1 flags 0x02 dlen 8
>> >> =A0 =A0 L2CAP(d): cid 0x0041 len 4 [psm 3]
>> >> =A0 =A0 =A0 RFCOMM(s): DISC: cr 0 dlci 20 pf 1 ilen 0 fcs 0x7d
>> >> 2009-09-10 13:34:24.529442 > HCI Event: Number of Completed Packets (=
0x13) plen
>> >> 5
>> >> =A0 =A0 handle 1 packets 1
>> >> 2009-09-10 13:34:24.531914 > ACL data: handle 1 flags 0x02 dlen 8
>> >> =A0 =A0 L2CAP(d): cid 0x0040 len 4 [psm 3]
>> >> =A0 =A0 =A0 RFCOMM(s): UA: cr 0 dlci 20 pf 1 ilen 0 fcs 0x57
>> >> 2009-09-10 13:34:24.533135 < ACL data: handle 1 flags 0x02 dlen 8
>> >> =A0 =A0 L2CAP(d): cid 0x0041 len 4 [psm 3]
>> >> =A0 =A0 =A0 RFCOMM(s): DISC: cr 0 dlci 0 pf 1 ilen 0 fcs 0x9c
>> >> 2009-09-10 13:34:25.028649 > HCI Event: Number of Completed Packets (=
0x13) plen
>> >> 5
>> >> =A0 =A0 handle 1 packets 1
>> >> 2009-09-10 13:34:25.032128 > ACL data: handle 1 flags 0x02 dlen 8
>> >> =A0 =A0 L2CAP(d): cid 0x0040 len 4 [psm 3]
>> >> =A0 =A0 =A0 RFCOMM(s): UA: cr 0 dlci 0 pf 1 ilen 0 fcs 0xb6
>> >> 2009-09-10 13:34:25.032341 > ACL data: handle 1 flags 0x02 dlen 12
>> >> =A0 =A0 L2CAP(s): Disconn req: dcid 0x0040 scid 0x0041
>> >> 2009-09-10 13:34:25.032646 < ACL data: handle 1 flags 0x02 dlen 12
>> >> =A0 =A0 L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0041
>> >>
>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> Analysis Result
>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> For some kinds of Bluetooth headset such as Motorola H560/H620 which
>> >> are based on BCM2044S, they will send L2CAP Disconn_Req command right
>> >> after sending rfcomm UA frame. This L2CAP Disconn_Req will cause the
>> >> rfcomm socket state become BT_CLOSED before completely handling UA
>> >> frame, thus it will cause kernel panic. I think we can ignore the
>> >> received rfcomm frames if socket state is BT_CLOSED, because it
>> >> doesn't make sense in the BT_CLOSED state.
>> >>
>> >>
>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> Changed Code
>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> We changed the code in the function rfcomm_process_rx() in
>> >> net/bluetooth/rfcomm/core.c, check the socket state first before
>> >> handling the received framew. If the socket state is BT_CLOSED, we
>> >> don't handle any rfcomm frames but just close the session.
>> >>
>> >> The change is like below
>> >>
>> >> + =A0 =A0 =A0 if (sk->sk_state !=3D BT_CLOSED) {
>> >> =A0 =A0 =A0 =A0 /* Get data directly from socket receive queue withou=
t copying it. */
>> >> =A0 =A0 =A0 =A0 while ((skb =3D skb_dequeue(&sk->sk_receive_queue))) =
{
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 skb_orphan(skb);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfcomm_recv_frame(s, skb);
>> >> =A0 =A0 =A0 =A0 }
>> >> -
>> >> - =A0 =A0 =A0 if (sk->sk_state =3D=3D BT_CLOSED) {
>> >> + =A0 =A0 =A0 } else {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!s->initiator)
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfcomm_session_put(s)=
;
>> >>
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfcomm_session_close(s, sk->sk_err);
>> >> =A0 =A0 =A0 =A0 =A0}
>> >
>> > so I do see the issue here, but I don't agree with the fix since it
>> > changes behavior that might cause other issues. So in case the frame
>> > processing leads to sk->sk_state =3D=3D BT_CLOSED we are not closing t=
he
>> > connection anymore if we make it depend on a state before the frame
>> > processing. And nothing guarantees that rfcomm_process_rx gets schedul=
ed
>> > again.
>> >
>> > diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
>> > index 94b3388..606143b 100644
>> > --- a/net/bluetooth/rfcomm/core.c
>> > +++ b/net/bluetooth/rfcomm/core.c
>> > @@ -1798,12 +1798,16 @@ static inline void rfcomm_process_rx(struct rf=
comm_session *s)
>> >
>> > =A0 =A0 =A0 =A0BT_DBG("session %p state %ld qlen %d", s, s->state, skb=
_queue_len(&sk->sk_receive_queue));
>> >
>> > + =A0 =A0 =A0 rfcomm_session_hold(s);
>> > +
>> > =A0 =A0 =A0 =A0/* Get data directly from socket receive queue without =
copying it. */
>> > =A0 =A0 =A0 =A0while ((skb =3D skb_dequeue(&sk->sk_receive_queue))) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0skb_orphan(skb);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rfcomm_recv_frame(s, skb);
>> > =A0 =A0 =A0 =A0}
>> >
>> > + =A0 =A0 =A0 rfcomm_session_put(s);
>> > +
>> > =A0 =A0 =A0 =A0if (sk->sk_state =3D=3D BT_CLOSED) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!s->initiator)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rfcomm_session_put(s);
>> >
>> > What does the above patch do for you? Since if I read it correctly, th=
en
>> > the rfcomm_recv_ua causes the rfcomm_session_put to trigger the closin=
g
>> > of the session. And then in this case it is delayed until after all
>> > frames are processed.
>> >
>> >
>>
>> I've tried your patch but unfortunately kernel panic still happened.
>>
>> From the log I noticed that if rfcomm_l2state_change is called before
>> rfcomm_process_rx, kernel panic will happen definitely.
>>
>> Below lines are in the correct log,
>>
>> [ =A0139.323852] rfcomm_l2data_ready: ccf70000 bytes 4
>> [ =A0139.346252] rfcomm_process_rx: session ccb94ce0 state 8 qlen 1
>> ...
>> [ =A0139.457519] rfcomm_l2state_change: ccf70000 state 9
>> (disconnect ok)
>>
>> In the above case, when process_rx, the code in the condition "if
>> (sk->sk_state =3D=3D BT_CLOSED)" will never run.
>>
>> Below lines are in the panic log,
>>
>> [ =A0174.898284] rfcomm_l2data_ready: ccf70400 bytes 4
>> [ =A0174.903442] rfcomm_l2state_change: ccf70400 state 9
>> [ =A0174.908874] rfcomm_process_rx: session cc751be0 state 8 qlen 1
>> ...
>> ( then panic)
>>
>> In the above case, sk_state is changed to 9 (BT_CLOSED) firstly, =A0then
>> process_rx, so the code in the condition "if (sk->sk_state =3D=3D
>> BT_CLOSED) " will be run, it will call session_put twice. I think this
>> is the root cause of panic.
>
> I know why it happens, that is not the problem. My point is not to break
> current scheduling assumptions.
>
> So if you move the rfcomm_session_put() now at the end of the function,
> then it should be fine, right?
>
> Regards
>
> Marcel
>
>
>

You are right. I moved the rfcomm_session_put() at the end of
rfcomm_process_tx() then kernel panic doesn't happen any longer.

The changed code is like below,

@@ -1796,6 +1796,8 @@ static inline void rfcomm_process_rx(struct rfcomm_se=
ssion

        BT_DBG("session %p state %ld qlen %d", s, s->state, skb_queue_len(&=
sk->s

+       rfcomm_session_hold(s);
+
        /* Get data directly from socket receive queue without copying it. =
*/
        while ((skb =3D skb_dequeue(&sk->sk_receive_queue))) {
                skb_orphan(skb);
@@ -1808,6 +1810,8 @@ static inline void rfcomm_process_rx(struct rfcomm_se=
ssion

                rfcomm_session_close(s, sk->sk_err);
        }
+
+       rfcomm_session_put(s);
 }

 static inline void rfcomm_accept_connection(struct rfcomm_session *s)

Please submit this change to bluez release.

Thank you,
Zhu Lan
