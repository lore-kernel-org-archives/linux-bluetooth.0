Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Apr 2013 23:44:54 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v3 02/18] Bluetooth: hidp: verify l2cap sockets
Message-ID: <20130406024454.GB10666@joana>
References: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
 <1365166670-3271-3-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365166670-3271-3-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Herrmann <dh.herrmann@gmail.com> [2013-04-05 14:57:34 +0200]:

> We need to verify that the given sockets actually are l2cap sockets. If
> they aren't, we are not supposed to access bt_sk(sock) and we shouldn't
> start the session if the offsets turn out to be valid local BT addresses.
> 
> That is, if someone passes a TCP socket to HIDCONNADD, then we access some
> random offset in the TCP socket (which isn't even guaranteed to be valid).
> 
> Fix this by checking that the socket is an l2cap socket.
> 
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
>  include/net/bluetooth/l2cap.h | 1 +
>  net/bluetooth/hidp/core.c     | 2 ++
>  net/bluetooth/l2cap_sock.c    | 6 ++++++
>  3 files changed, 9 insertions(+)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
