Return-Path: <jt@bougret.hpl.hp.com>
Date: Tue, 3 Feb 2004 17:58:25 -0800
To: Marcel Holtmann <marcel@holtmann.org>, Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ mailing list <bluez-devel@lists.sourceforge.net>
Subject: L2CAP non-blocking socket nasty race conditions
Message-ID: <20040204015825.GA2217@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
List-ID: <bluez-devel.lists.sourceforge.net>

	Hi,

	I've just managed to reproduce and track a few bug that so far
were escaping me. There is a race condition in the accept() code for
non-blocking L2CAP sockets, and a similar one in sendmsg. Or maybe
it's just that my code is too fast ;-)

	This is the accept race :
	1) L2CAP socket in non blocking mode, because program waiting
on multiple outputs.
	2) Wait on socket to be readable with poll/select.
	3) When socket is ready, accept() it and do what we have to do.
	4) When the race occur, accept() return an error (EAGAIN).
	5) We don't touch the socket and go back to poll/select.
	6) Poll/select returns immediately (socket is still readable).
	7) We attempt the accept(), EAGAIN, goto (5)

	I didn't managed to fully identify the sendmsg race, but I
goes like this :
	1) Open L2CAP socket in non blocking mode, because program
waiting on multiple outputs.
	2) Connect to BT peer.
	3) Wait on socket to be writeable with poll/select.
	4) When socket is ready, sendmsg() and do what we have to do.
	5) When the race occur, sendmsg() return an error (ENOTCONN).
	...

	I looked at way to fix the code, but it's not a quick fix and
there is multiple way to attack the problem. So, if one of you could
have a look at it...

	Below you will find a self explanatory log of the kernel
showing the problem with accept. The first accept was successful (no
problem), the second one was racy.

	Thanks in advance...

	Jean

----------------------------------------------------------------------
J2 - l2cap_connect_req - parent cd451ba0 sk cd451200 state 2
J2 - bt_accept_enqueue - parent cd451ba0 backlog 0 sk cd451200 state 2
J2 - l2cap_connect_req - sk cd451200 state 6 -> 7
J2 - l2cap_config_rsp - sk cd451200 state 7 -> 1
J2 - bt_sock_poll - sk cd451ba0 sk_receive_queue 0 backlog 1 shutdown 0
J2 - l2cap_sock_accept - sk cd451ba0 timeo 0
J2 - bt_accept_dequeue - parent cd451ba0 backlog 1 newsock c8434420
J2 - bt_accept_dequeue - sk cd451200 state 1
J2 - bt_sock_poll - sk cd451200 sk_receive_queue 1 backlog 0 shutdown 0
...
J2 - l2cap_disconnect_req - sk cd451200, conn c83342e0, err 104
J2 - l2cap_chan_del - sk cd451200, conn c83342e0, err 104 state 8 -> 9
J2 - l2cap_connect_rsp - sk cd451e60 state 5 -> 7
J2 - l2cap_config_rsp - sk cd451e60 state 7 -> 1
J2 - l2cap_chan_ready - sk cd451e60 state 1 -> 1
J2 - bt_sock_poll - sk cd451e60 sk_receive_queue 1 backlog 0 shutdown 0
J2 - l2cap_disconnect_rsp - sk cd451e60, conn c83342e0, err 0
J2 - l2cap_chan_del - sk cd451e60, conn c83342e0, err 0 state 8 -> 9
----------------------------------------------------------------------
J2 - l2cap_connect_req - parent cd451ba0 sk cd451200 state 2
J2 - bt_accept_enqueue - parent cd451ba0 backlog 0 sk cd451200 state 2
J2 - l2cap_connect_req - sk cd451200 state 6 -> 7
J2 - bt_sock_poll - sk cd451ba0 sk_receive_queue 0 backlog 1 shutdown 0
J2 - l2cap_sock_accept - sk cd451ba0 timeo 0
J2 - bt_accept_dequeue - parent cd451ba0 backlog 1 newsock c84340e0
J2 - bt_accept_dequeue - sk cd451200 state 7
J2 - bt_sock_poll - sk cd451ba0 sk_receive_queue 0 backlog 1 shutdown 0
J2 - l2cap_sock_accept - sk cd451ba0 timeo 0
J2 - bt_accept_dequeue - parent cd451ba0 backlog 1 newsock c84340e0
J2 - bt_accept_dequeue - sk cd451200 state 7
J2 - bt_sock_poll - sk cd451ba0 sk_receive_queue 0 backlog 1 shutdown 0
J2 - l2cap_sock_accept - sk cd451ba0 timeo 0
J2 - bt_accept_dequeue - parent cd451ba0 backlog 1 newsock c84340e0
J2 - bt_accept_dequeue - sk cd451200 state 7
...
[[Last 3 messages repeat more or less 500 times]]
...
J2 - l2cap_sock_accept - sk cd451ba0 timeo 0
J2 - bt_accept_dequeue - parent cd451ba0 backlog 1 newsock c84340e0
J2 - bt_accept_dequeue - sk cd451200 state 7
J2 - l2cap_config_rsp - sk cd451200 state 7 -> 1
J2 - bt_sock_poll - sk cd451ba0 sk_receive_queue 0 backlog 1 shutdown 0
J2 - l2cap_sock_accept - sk cd451ba0 timeo 0
J2 - bt_accept_dequeue - parent cd451ba0 backlog 1 newsock c84340e0
J2 - bt_accept_dequeue - sk cd451200 state 1
J2 - bt_sock_poll - sk cd451200 sk_receive_queue 1 backlog 0 shutdown 0
----------------------------------------------------------------------
