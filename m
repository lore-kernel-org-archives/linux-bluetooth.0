Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1275216282.4706.90.camel@aeonflux.t-mobile.de>
References: <AANLkTikmq2PK9jA_nl9eWto8Ihfn_4PHoeWwhRLIwo1C@mail.gmail.com>
	<1275216282.4706.90.camel@aeonflux.t-mobile.de>
Date: Mon, 31 May 2010 11:33:58 +0300
Message-ID: <AANLkTil6ytJDwcCOGhLdgE1TlS9Hih8JSUpNuznOyBnb@mail.gmail.com>
Subject: Re: Race between SCO disconnection and AVDTP Start
From: =?ISO-8859-1?Q?Daniel_=D6rstadius?= <daniel.orstadius@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, May 30, 2010 at 1:44 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Daniel,
>
>> If the audio client closes the SCO connection (by disconnecting the
>> unix socket to bluetoothd) and then immediately tries to open an A2DP
>> connection, the kernel might not send the SCO disconnect and AVDTP
>> Start to the remote in the sequence they were requested by bluetoothd.
>>
>> Is there a way to preserve the order, so that SCO disc is consistently
>> sent before AVDTP Start? (some headsets behave better in this case)
>>
>> Have tried with the sockopt SO_LINGER on the SCO socket, but it didn't
>> seem to make any difference [1].
>>
>> /Daniel
>>
>> [1] Not sure what LINGER really does here. Looking at the code in
>> sco_sock_shutdown(), it waits for the BT_CLOSED state:
>>
>> __sco_sock_close(sk);
>>
>> if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime)
>> =A0 =A0 =A0 =A0 err =3D bt_sock_wait_state(sk, BT_CLOSED, sk->sk_lingert=
ime);
>>
>>
>> However the socket state is set to BT_CLOSED in sco_chan_del() which
>> is called from __sco_sock_close(), so it looks like it's waiting for a
>> state that's already set (or maybe I'm just missing something here?).
>
> I would agree that we might need to fix the SO_LINGER implementation and
> actually wait for the HCI_Disconnect event. And that way we should also
> only send HUP signal when we received the confirmation that the SCO link
> has been fully terminated.
>
> However in the end the SO_LINGER support is not really helping since it
> will make close() block. You need to poll() the socket for HUP and that
> should be done properly inside PulseAudio. And only when the kernel
> signaled that the SCO connection has been closed, it should try to
> establish the A2DP one.
>
> Regards
>
> Marcel
>
>
>

Thanks for the reply.

Just to clarify, would the Pulseaudio solution work with the current
kernel implementation?
If PA can receive the HUP signal before the SCO link disconnect is
sent to the remote, I think the same situation could potentially
occur.
(Although for timing reasons it might be less likely)

In other words, what is the semantics of HUP in terms of the actual BT link=
?

Regards,
Daniel
