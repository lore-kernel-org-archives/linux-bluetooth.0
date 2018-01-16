Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Trevor Sutter <TSutter@efji.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: L2CAP refcount underflow during disconnect
Date: Tue, 16 Jan 2018 15:40:26 +0000
Message-ID: <CBD21621126AF744AA6D654F9A938607477372F7@EFJDFWMB01.EFJDFW.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am using Linux(v4.12.0)/blueZ(v5.46), running on an embedded device(OMAP-=
L138).
During pairing/connecting, I started to see some warnings in my dmesg logs =
as follows:

WARNING: CPU: 0 PID: 824 at lib/refcount.c:184 0xc01c7e84
refcount_t: underflow; use-after-free.

Investigation showed that this is a mismanaged refcount to an L2CAP channel=
, and it occurs when shutting down an l2cap connection.
Stack traces show the following:

l2cap_disconnect_req() -> l2cap_chan_del() -> chan->ops->teardown()[l2cap_s=
ock_teardown_cb]

l2cap_sock_teardown_cb() sets SOCK_ZAPPED and calls sk->sk_state_change(sk)=
, waking up the wait queue associated with this socket (in this case, the t=
hread is owned by bluetoothd).

There is a race condition here when a thread that is waiting on this queue =
wants to release this socket.

At this point, the refcount is 3. I see one of two scenarios.

1.
                - The call to l2cap_chan_del returns and calls chan->ops->c=
lose()[l2cap_sock_close_cb] which returns since the socket is not yet an or=
phan.
                - A reference to the channel is put (one is held right befo=
re calling l2cap_chan_del())(refcount =3D 2).
                - Immediately after, a thread that was waiting on the wait =
queue calls l2cap_sock_release() putting a ref to the channel (refcount =3D=
 1)
                  and putting the last ref to the socket, releasing another=
 ref to the channel (refcount =3D 0).

2.
                - Before the call to teardown returns, a thread that was wa=
iting on the wait queue get scheduled and calls l2cap_sock_release() puttin=
g a ref to the channel (refcount =3D 2)
                  and putting the last ref to the socket, releasing another=
 ref to the channel (refcount =3D 1).
                - Then, the call to l2cap_chan_del returns and calls chan->=
ops->close()[l2cap_sock_close_cb] which will put a ref to the channel since=
 the socket is orphaned now refcount =3D 0).
                - A reference to the channel is put (one is held right befo=
re calling l2cap_chan_del()) (refcount =3D -1).

It does not seem like this is causing any undesirable behavior, but it shou=
ld probably be addressed. What I am considering now is to place a check for=
 the SOCK_DEAD
flag in l2cap_sock_close_cb.

                static void l2cap_sock_close_cb(struct l2cap_chan *chan)
                {
                                struct sock *sk =3D chan->data;

+                             if(!sock_flag(sk, SOCK_DEAD))
                                                l2cap_sock_kill(sk);
                }

This will prevent l2cap_sock_kill from getting called twice. I am not extre=
mely knowledgeable when it comes to inner workings of l2cap/blueZ.
I would appreciate any suggestions or feedback on this proposed fix.

Note: This is my first time using a mailing list. Please feel free to corre=
ct any broken conventions/give feedback for improving future posts.

Thank you,
Trevor Sutter
This e-mail transmission, and any documents, files or previous e-mail messa=
ges attached to it, may contain confidential information. If you are not th=
e intended recipient, or a person responsible for delivering it to the inte=
nded recipient, you are hereby notified that any disclosure, distribution, =
review, copy or use of any of the information contained in or attached to t=
his message is STRICTLY PROHIBITED. If you have received this transmission =
in error, please immediately notify us by reply e-mail, and destroy the ori=
ginal transmission and its attachments without reading them or saving them =
to disk. Thank you.

