Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4C470E2D.7000607@aircable.net>
References: <4C46324D.5070800@aircable.net>
	<20100721101934.GA12188@jh-x301>
	<4C470E2D.7000607@aircable.net>
Date: Fri, 23 Jul 2010 23:37:24 +0300
Message-ID: <AANLkTi=8=BUThjVdc4EN_8uupGKmdgHQzGOe560Cv+pm@mail.gmail.com>
Subject: Re: [PATCH][RFC] Fix SDP resolving segfault
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Manuel Naranjo <manuel@aircable.net>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jul 21, 2010 at 6:11 PM, Manuel Naranjo <manuel@aircable.net> wrote:
> I think this is the one that really fix the problem. I see connect_watch
> getting called and then getting into the crash. I have a nice log with the
> tracing feature I sent the other day, here's the end of it (the hole thing
> is almost 40 megs if someone wants just ask for it).

I just figure out that our connect_watch in glib_helper.c is not quite
right, it should be something similar as we have btio.c, specially
this one is particular important:

	/* If the user aborted this connect attempt */
	if ((cond & G_IO_NVAL) || check_nval(io))
		return FALSE;

It is probably because of not having this check that the cb is still
called after bt_cancel_discovery. Of course this doesn't invalidate
your fix to bt_cancel_discovery itself, but I guess this should also
be included to safe that the callback is not called after cancelling
the discovery.

-- 
Luiz Augusto von Dentz
Computer Engineer
