Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 28 May 2010 12:58:21 +0300
Message-ID: <AANLkTikmq2PK9jA_nl9eWto8Ihfn_4PHoeWwhRLIwo1C@mail.gmail.com>
Subject: Race between SCO disconnection and AVDTP Start
From: =?ISO-8859-1?Q?Daniel_=D6rstadius?= <daniel.orstadius@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

If the audio client closes the SCO connection (by disconnecting the
unix socket to bluetoothd) and then immediately tries to open an A2DP
connection, the kernel might not send the SCO disconnect and AVDTP
Start to the remote in the sequence they were requested by bluetoothd.

Is there a way to preserve the order, so that SCO disc is consistently
sent before AVDTP Start? (some headsets behave better in this case)

Have tried with the sockopt SO_LINGER on the SCO socket, but it didn't
seem to make any difference [1].

/Daniel

[1] Not sure what LINGER really does here. Looking at the code in
sco_sock_shutdown(), it waits for the BT_CLOSED state:

__sco_sock_close(sk);

if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime)
        err = bt_sock_wait_state(sk, BT_CLOSED, sk->sk_lingertime);


However the socket state is set to BT_CLOSED in sco_chan_del() which
is called from __sco_sock_close(), so it looks like it's waiting for a
state that's already set (or maybe I'm just missing something here?).
