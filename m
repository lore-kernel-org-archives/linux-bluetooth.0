Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Mon, 15 Mar 2010 12:05:18 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH] Bluetooth: Fix kernel crash on BT stress tests.
Message-ID: <20100315150203.GA31186@vigoh>
References: <508e92ca1002160236k34c18949jc7d7187645ef4aa0@mail.gmail.com>
 <20100311224140.GA17295@vigoh>
 <508e92ca1003150357t77defd4fqcd843965af35970a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <508e92ca1003150357t77defd4fqcd843965af35970a@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

* Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com> [2010-03-15 12:57:=
18 +0200]:

> Hi Gustavo
>=20
> On Fri, Mar 12, 2010 at 12:41 AM, Gustavo F. Padovan
> <padovan@profusion.mobi> wrote:
> > Hi Andrei,
> >
> > * Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com> [2010-02-16 12=
:36:47 +0200]:
> >
> >> From 0135f732cb45e5e91062aca84a61a40b172200a4 Mon Sep 17 00:00:00 2001
> >> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> >> Date: Tue, 16 Feb 2010 10:52:33 +0200
> >> Subject: [PATCH] Bluetooth: Fix kernel crash on BT stress tests.
> >>
> >> Added very simple check that req buffer has enough space to
> >> fit configuration parameters. Shall be enough to reject packets
> >> with configuration size more than req buffer.
> >>
> >> Crash trace below
> >>
> >> [ 6069.659393] Unable to handle kernel paging request at virtual
> >> address 02000205
> >> [ 6069.673034] Internal error: Oops: 805 [#1] PREEMPT
> >> ...
> >> [ 6069.727172] PC is at l2cap_add_conf_opt+0x70/0xf0 [l2cap]
> >> [ 6069.732604] LR is at l2cap_recv_frame+0x1350/0x2e78 [l2cap]
> >> ...
> >> [ 6070.030303] Backtrace:
> >> [ 6070.032806] [<bf1c2880>] (l2cap_add_conf_opt+0x0/0xf0 [l2cap]) from
> >> [<bf1c6624>] (l2cap_recv_frame+0x1350/0x2e78 [l2cap])
> >> [ 6070.043823] =A0r8:dc5d3100 r7:df2a91d6 r6:00000001 r5:df2a8000 r4:0=
0000200
> >> [ 6070.050659] [<bf1c52d4>] (l2cap_recv_frame+0x0/0x2e78 [l2cap]) from
> >> [<bf1c8408>] (l2cap_recv_acldata+0x2bc/0x350 [l2cap])
> >> [ 6070.061798] [<bf1c814c>] (l2cap_recv_acldata+0x0/0x350 [l2cap]) from
> >> [<bf0037a4>] (hci_rx_task+0x244/0x478 [bluetooth])
> >> [ 6070.072631] =A0r6:dc647700 r5:00000001 r4:df2ab740
> >> [ 6070.077362] [<bf003560>] (hci_rx_task+0x0/0x478 [bluetooth]) from
> >> [<c006b9fc>] (tasklet_action+0x78/0xd8)
> >> [ 6070.087005] [<c006b984>] (tasklet_action+0x0/0xd8) from [<c006c160>]
> >>
> >> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> >> ---
> >> =A0net/bluetooth/l2cap.c | =A0 =A06 ++++++
> >> =A01 files changed, 6 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> >> index 400efa2..69b7280 100644
> >> --- a/net/bluetooth/l2cap.c
> >> +++ b/net/bluetooth/l2cap.c
> >> @@ -2830,6 +2830,12 @@ static inline int l2cap_config_rsp(struct
> >> l2cap_conn *conn, struct l2cap_cmd_hdr
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int len =3D cmd->len - siz=
eof(*rsp);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char req[64];
> >>
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (len > sizeof(req) - size=
of(struct l2cap_conf_req)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BT_ERR("Conf=
ig response is too big");
> >
> > Remove the BT_ERR, normally we don't print any error on
> > l2cap_send_disconn_req.
> >
> >
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_send_d=
isconn_req(conn, sk);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> +
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* throw out any old store=
d conf requests */
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D L2CAP_CONF_SUCC=
ESS;
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D l2cap_parse_conf_r=
sp(sk, rsp->data,
> >
> > Also, this is very rare crash. Even if we add all configure options to
> > req we won't overwrite it. Doesn't make sense to me send a
> > configuration option more than once in the same config_{rsp,req}. The
> > only way to crash l2cap is using a bugous remote stack or a stress test
> > tools. We need to be protected against those bugous stacks so I'll
> > ack your patch after you send the updated patch without the BT_ERR.
> >
>=20
> I am attaching patch to the mail, otherwise it may be screwed up by maile=
rs.

Acked-by: Gustavo F. Padovan <gustavo@padovan.org>

>=20
> Regards,
> Andrei


--=20
Gustavo F. Padovan
http://padovan.org
