Return-Path: <jp-www@dcs.gla.ac.uk>
Date: Sun, 12 Oct 2003 13:25:45 +0100 (BST)
From: Jonathan Paisley <jp-www@dcs.gla.ac.uk>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Bluetooth update for 2.4.23-pre2
In-Reply-To: <1065723861.14514.91.camel@pegasus>
Message-ID: <Pine.LNX.4.54.999.0310121324110.10464@sibu.dcs.gla.ac.uk>
References: <5.1.0.14.2.20031008180324.059f6750@unixmail.qualcomm.com>
 <5.1.0.14.2.20030912095921.030764b0@unixmail.qualcomm.com>
 <5.1.0.14.2.20030912095921.030764b0@unixmail.qualcomm.com>
 <5.1.0.14.2.20031008180324.059f6750@unixmail.qualcomm.com>
 <5.1.0.14.2.20031009103605.05a94590@unixmail.qualcomm.com>
 <1065723861.14514.91.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, 9 Oct 2003 8:24pm +0200, Marcel Holtmann wrote:

> > btw How about fixing it in 2.6 and leaving 2.4 alone ?
> > I don't think we will ever have decent Voice support in 2.4 anyway.
> > For example ALSA driver will definitely go into 2.6 not 2.4.
>
> the ALSA support is not the point, because you can use the SCO socket
> for 2.4 for now and it is working fine for me. I think we should drop
> this for 2.4.23 and wait until 2.4.24-pre.

Have you had a chance to try or look at my snd-bluez-sco ALSA driver yet?
I'm interested to hear your thoughts on its design.

	http://www.dcs.gla.ac.uk/~jp/snd-bluez-sco/

Thanks.
