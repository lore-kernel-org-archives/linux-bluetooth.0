Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <35c90d960907091237o72228b0v57ad2556d77f4857@mail.gmail.com>
References: <35c90d960905191820g4e3ee434hfd0060815540a4e0@mail.gmail.com>
	<1242787757.3147.13.camel@localhost.localdomain> <35c90d960905201457i508c678fqeb696cce32ae63be@mail.gmail.com>
	<35c90d960907061155t7349cc90p2e58a09a310b8926@mail.gmail.com>
	<35c90d960907091237o72228b0v57ad2556d77f4857@mail.gmail.com>
From: Nick Pelly <npelly@google.com>
Date: Mon, 13 Jul 2009 08:46:13 -0700
Message-ID: <35c90d960907130846v2320de88pd6f34b8aabfdbb9e@mail.gmail.com>
Subject: Re: bug? kernel does not send HCI Create Connection Cancel Command on
	shutdown() or close() of a connecting rfcomm socket
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jul 9, 2009 at 12:37 PM, Nick Pelly<npelly@google.com> wrote:
> For the RFCOMM issue.
>
> This is the log when shutdown() is called on the rfcomm socket while
> the ACL link is connecting:
>
> [  132.856414] rfcomm:rfcomm_sock_shutdown: sock c5cb3a20, sk c63fca00
> [  132.856933] rfcomm:__rfcomm_sock_close: sk c63fca00 state 5 socket c5cb3a20
> [  132.857788] rfcomm:__rfcomm_dlc_close: dlc c61ea240 state 7 dlci 38
> err 0 session c63d4ba0
> [  132.858612] rfcomm:rfcomm_send_disc: c63d4ba0 dlci 38
> [  132.859069] rfcomm:rfcomm_send_frame: session c63d4ba0 len 4
> [  132.859893] l2cap:l2cap_sock_sendmsg: sock c5cb38c0, sk c63fc800
> [  132.860351] rfcomm:rfcomm_dlc_set_timer: dlc c61ea240 state 8 timeout 2000
> [  133.863739] rfcomm:rfcomm_sock_release: sock c5cb3a20, sk c63fca00
> [  133.864257] rfcomm:rfcomm_sock_shutdown: sock c5cb3a20, sk c63fca00
> [  133.865081] rfcomm:rfcomm_sock_kill: sk c63fca00 state 5 refcnt 2
> [  133.865539] rfcomm:rfcomm_sock_destruct: sk c63fca00 dlc c61ea240
>
>
>
> I'm surprised to see d->state for the rfcomm_dlc is BT_CONFIG at
> __rfcomm_dlc_close(), but looking at __rfcomm_dlc_open() this appears
> to be intentional.
>
> We do not hit __l2cap_sock_close()
>
> We attempt a graceful rfcomm disconnected by sending the dlci
> disconnected frame - but this does not make sense - since there is no
> rfcomm connection yet.
>
>
> Assuming that d->state == BT_CONFIG during this phase is correct, then
> the attached patch will fix this issue.
>
> However - I don't know the rfcomm state machine - so this patch may
> having side effects. Requesting comments.

Any comments on this patch?

It works for me, but my understanding of the RFCOMM state machine is naive.

Nick
