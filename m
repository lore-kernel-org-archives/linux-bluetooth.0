Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6aeb672b1003010154u6660632fj53fdbac2c8d0e302@mail.gmail.com>
References: <6aeb672b1001220212u518836fds5df2a7e3de8463bf@mail.gmail.com>
	<6aeb672b1001272156m678aa8fepec2498386947936a@mail.gmail.com>
	<6aeb672b1003010154u6660632fj53fdbac2c8d0e302@mail.gmail.com>
From: Nick Pelly <npelly@google.com>
Date: Wed, 7 Apr 2010 17:15:56 -0700
Message-ID: <v2x35c90d961004071715m2c4d5550pb5ffc58af65663dc@mail.gmail.com>
Subject: Re: Kernel panic when handing Motorola S305 headset
To: Liang Bao <tim.bao@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Mar 1, 2010 at 1:54 AM, Liang Bao <tim.bao@gmail.com> wrote:
> I'd like to continue the previous thread on that Motorola S305 causes
> kernel panic because I did find some clue here. Sorry for misleading
> guess one month ago if any.
>
> Recap the problem here so that you don't to read the first long post.
> The pattern to reproduce the issue is:
> 1. Pair the S305 headset from the phone or the PC( I am using a Ubuntu)
> 2. Remove pairing on the phone or PC
> 3. Power off and then power on S305.
> 4. The S305 will try to connect and since link key removed on this
> side it will try to pair. Input 0000.
> 5. Kernel panic happens. This can be observed on kernel version
> 2.6.29(on the Droid phone, yes, it's a modified version),
> 2.6.31-19-generic on a Ubuntu and a pretty latest 2.6.33-020633rc8
> from Ubuntu official RC release.
>
> The exact kernel crash point is
> =A0 =A0 =A0 =A0 =A0 =A0 if (l2cap_check_security(sk)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (bt_sk(sk)->defer_setup) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct sock *parent =3D bt_sk(=
sk)->parent;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rsp.result =3D cpu_to_le16(L2C=
AP_CR_PEND);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rsp.status =3D cpu_to_le16(L2C=
AP_CS_AUTHOR_PEND);
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 parent->sk_data_ready(parent, 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>
> After tracing the issue for a couple of weeks, I find the difference
> between a normal flow and the panic one. If the user space process
> accepts the L2CAP connection request before L2CAP_INFO_RSP received,
> the following calls will be carried out:
>
> l2cap_sock_accept-> bt_accept_dequeue->bt_accept_unlink(in the branch
> bt_sk(parent)->defer_setup)-> set bt_sk(sk)->parent =3D NULL. Later when
> L2CAP_INFO_RSP arrives, the l2cap_conn_start() will try to call the
> marked line above and de-referring NULL happen.
>
> To fix this, shall we consider checking if a pending socket can be
> accepted in bt_accept_dequeue() prior to a pending L2CAP_INFO_REQ
> responded? For example, =A0adding a check to BT_CONNECT2 in
> af_bluetooth.c.
>
> 215 =A0 =A0 =A0 =A0 if (sk->sk_state =3D=3D BT_CONNECTED || !newsock ||
> 216 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( bt_sk(parent)->defe=
r_setup &&
> (sk->sk_state !=3D BT_CONNECT2))) {
>
> Again, I am not sure if this will bring a side-effect. Please advise
> the most appropriate way. Thanks.
>
> p.s: I attached partial trace files for those who're interested to the tr=
aces.
>

We can reproduce this issue.

There is nothing preventing an l2cap socket with deferred setup from
accepting an l2cap connection before the info response packet has come
in. This causes the null pointer panic when the info response
eventually arrives.

I'm not sure the best way to fix this. Ideally we'd check
L2CAP_INFO_FEAT_MASK_REQ_DONE, but that is not available in
af_bluetooth.c:bt_accept_dequeue(). I think the problem is that
BT_CONNECT2 - which is available in af_bluetooth.c is used for both
deferred setup and for the case where we are waiting for the info
response.

Marcel, some advice on the best way to proceed here would be helpful.

Nick
