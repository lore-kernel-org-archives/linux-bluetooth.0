Return-Path: <tanuk@iki.fi>
Message-ID: <1486380902.4774.4.camel@iki.fi>
Subject: Re: SCO socket MTU problem in PulseAudio
From: Tanu Kaskinen <tanuk@iki.fi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, Renjith Thomas
 <renjith@lightlevitate.com>,  Georg Chini <georg@chini.tk>
Date: Mon, 06 Feb 2017 13:35:02 +0200
In-Reply-To: <A00CAB7E-3131-4430-8AEA-4132E28CE8FE@holtmann.org>
References: <1485867673.2993.5.camel@iki.fi>
	 <A00CAB7E-3131-4430-8AEA-4132E28CE8FE@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2017-02-01 at 20:47 +0100, Marcel Holtmann wrote:
> Hi Tanu,
> 
> > PulseAudio recently started to use
> > 
> >    getsockopt(sock, SOL_SCO, SCO_OPTIONS, &sco_opt, &len);
> >    read_mtu = sco_opt.mtu;
> >    write_mtu = sco_opt.mtu;
> > 
> > to query the MTU of the SCO socket. Previously we used a fixed value of
> > 48, but that didn't work for some bluetooth chipsets (see the commit
> > message[1]). Now, however, it was reported[2] that the new code doesn't
> > work on some hardware where the old fixed MTU used to work.
> 
> can you share details here and btmon traces for the data buffer sizes
> and the USB descriptor details. We would need to figure out where
> this goes wrong and maybe introduce some driver quirks to ensure that
> it returns usable values.

Georg already provided a btmon dump. Did that contain everything you
need? The way you put your words, it's not clear to me if the USB
descriptor details are included in the btmon output or is the USB
descriptor a separate thing?

I'd like to provide clear instructions for users to get the necessary
information, in case it turns out that Georg is not the only one with
this problem. What options should be given to btmon?

-- 
Tanu

https://www.patreon.com/tanuk
