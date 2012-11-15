Return-Path: <cyrus@holtmann.org>
Reply-to: m.knudsen@samsung.com
From: Michael Knudsen <m.knudsen@samsung.com>
To: 'Marcel Holtmann' <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
References: <509BB56A.80609@samsung.com> <50A3B0D5.9030107@samsung.com>
 <1352935032.20338.19.camel@aeonflux>
In-reply-to: <1352935032.20338.19.camel@aeonflux>
Subject: RE: CSA2:  User space aspect
Date: Thu, 15 Nov 2012 12:34:48 +0100
Message-id: <000001cdc325$38d657f0$aa8307d0$%knudsen@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> please to not attempt to use socket options as ioctl. They are
> called options for a reason.
> 
> Getting the list of supported codecs should be done via mgmt
> interface command and it should be only done once.

Okay, I'll take a stab at this, then.

I expect that socket options are still fine for actually
setting the configuration? 

> Please ask yourself the question when and how the SCO data from the
> socket is actually affected. I still have not seen you provide the
> semantics of how the socket would be used afterwards. Especially on
> impact for the application establishing the SCO socket.

There are two cases, connect() and accept().

For connect(), this is pretty simple:

	sk = socket(..);
	setsockopt(sk, SOL_SCO, SCO_AIR_FORMAT, ...);
	connect(sk, ..);

For accept(), it is the intention that this will be used in
conjunction with BT_DEFER_SETUP such that we can set the codecs
as per how we just negotiated with the peer:

	sk = socket(..);
	bind(sk, ..);
	setsockopt(sk, SOL_SCO, BT_DEFER_SETUP, 1);
	listen(sk, ..);
	peer = accept(sk, ..);
	setsockopt(peer, SOL_SCO, SCO_AIR_FORMAT, SCO_FORMAT_MSBC);
	recvmsg(peer, ..);

> In a more important question, is this static one time fits all
> selection or is this actually to be dynamic on every new connection
> establishment.

Both (defer/non-defer).  The socket options will set the parameters
that are used by the stack whenever it sets up or accepts a connection.

Did this answer your questions?

-m.


