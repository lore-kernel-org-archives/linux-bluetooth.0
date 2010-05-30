Return-Path: <cyrus@holtmann.org>
Subject: Re: Race between SCO disconnection and AVDTP Start
From: Marcel Holtmann <marcel@holtmann.org>
To: Daniel =?ISO-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <AANLkTikmq2PK9jA_nl9eWto8Ihfn_4PHoeWwhRLIwo1C@mail.gmail.com>
References: <AANLkTikmq2PK9jA_nl9eWto8Ihfn_4PHoeWwhRLIwo1C@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 30 May 2010 12:44:42 +0200
Message-ID: <1275216282.4706.90.camel@aeonflux.t-mobile.de>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

> If the audio client closes the SCO connection (by disconnecting the
> unix socket to bluetoothd) and then immediately tries to open an A2DP
> connection, the kernel might not send the SCO disconnect and AVDTP
> Start to the remote in the sequence they were requested by bluetoothd.
> 
> Is there a way to preserve the order, so that SCO disc is consistently
> sent before AVDTP Start? (some headsets behave better in this case)
> 
> Have tried with the sockopt SO_LINGER on the SCO socket, but it didn't
> seem to make any difference [1].
> 
> /Daniel
> 
> [1] Not sure what LINGER really does here. Looking at the code in
> sco_sock_shutdown(), it waits for the BT_CLOSED state:
> 
> __sco_sock_close(sk);
> 
> if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime)
>         err = bt_sock_wait_state(sk, BT_CLOSED, sk->sk_lingertime);
> 
> 
> However the socket state is set to BT_CLOSED in sco_chan_del() which
> is called from __sco_sock_close(), so it looks like it's waiting for a
> state that's already set (or maybe I'm just missing something here?).

I would agree that we might need to fix the SO_LINGER implementation and
actually wait for the HCI_Disconnect event. And that way we should also
only send HUP signal when we received the confirmation that the SCO link
has been fully terminated.

However in the end the SO_LINGER support is not really helping since it
will make close() block. You need to poll() the socket for HUP and that
should be done properly inside PulseAudio. And only when the kernel
signaled that the SCO connection has been closed, it should try to
establish the A2DP one.

Regards

Marcel


