Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez: bluetoothd: segmentation fault
From: David Mansfield <bluez@dm.cobite.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain
Date: Wed, 28 Jan 2009 09:54:45 -0500
Message-Id: <1233154485.32572.23.camel@gandalf.cobite.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> [AO_ALSA] alsa-lib: pcm_bluetooth.c:1531:(audioservice_recv) Error
receiving data \
> from audio service: Success(0) [AO_ALSA] alsa-lib: \
> pcm_bluetooth.c:1547:(audioservice_expect) Bogus message BT_GETCAPABILITIES_REQ \
> received while BT_GETCAPABILITIES_RSP was expected [AO_ALSA] Playback open error: \
> Invalid argument 
> 


I believe, but cannot prove, that this is caused by the bug I found in
pcm_bluetooth.c the other day (see a previous post) which causes random
memory corruption.

If you can test, try editing audio/pcm_bluetooth.c around line 801.  Try
replacing:


        revents[0] = (pfds[0].revents & ~POLLIN) | POLLOUT;
	revents[1] = (pfds[1].revents & ~POLLIN);

with:

        *revents = (pfds[0].revents & ~POLLIN) | (pfds[1].revents & ~POLLIN)| POLLOUT;

and rebuild.

Thanks,
David


