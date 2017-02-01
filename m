Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: SCO socket MTU problem in PulseAudio
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1485867673.2993.5.camel@iki.fi>
Date: Wed, 1 Feb 2017 20:47:51 +0100
Cc: linux-bluetooth@vger.kernel.org,
        Renjith Thomas <renjith@lightlevitate.com>,
        Georg Chini <georg@chini.tk>
Message-Id: <A00CAB7E-3131-4430-8AEA-4132E28CE8FE@holtmann.org>
References: <1485867673.2993.5.camel@iki.fi>
To: Tanu Kaskinen <tanuk@iki.fi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tanu,

> PulseAudio recently started to use
> 
>    getsockopt(sock, SOL_SCO, SCO_OPTIONS, &sco_opt, &len);
>    read_mtu = sco_opt.mtu;
>    write_mtu = sco_opt.mtu;
> 
> to query the MTU of the SCO socket. Previously we used a fixed value of
> 48, but that didn't work for some bluetooth chipsets (see the commit
> message[1]). Now, however, it was reported[2] that the new code doesn't
> work on some hardware where the old fixed MTU used to work.

can you share details here and btmon traces for the data buffer sizes and the USB descriptor details. We would need to figure out where this goes wrong and maybe introduce some driver quirks to ensure that it returns usable values.

Regards

Marcel

