Return-Path: <cyrus@holtmann.org>
From: Hunyue Yau <ybeagle@rehut.com>
To: beagleboard@googlegroups.com
Subject: Re: [beagleboard] btusb+slob
Date: Wed, 11 Mar 2009 22:58:05 -0800
Cc: Russ Dill <russ.dill@gmail.com>, Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org, discussion@beagleboard.org
References: <f9d2a5e10903111551h428ca9fekea7f6960c7666be9@mail.gmail.com>
In-Reply-To: <f9d2a5e10903111551h428ca9fekea7f6960c7666be9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903112358.05854.ybeagle@rehut.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Russ,

What version of Bluez userland are you using?

On Wednesday 11 March 2009 15:51, Russ Dill wrote:
> After running into problems with btusb on my OMAP3 (arm) based Beagle
> Board, I discovered that switching from SLOB to SLAB causes the
> problems to go away. With SLOB:
>
> Scanning ...
>         05:16:CF:F7:04:20       n/a
>         00:11:F6:05:79:95       ....R#w
>         00:1A:8A:DB:E8:3D       ....R$w9
>         00:16:CF:F7:04:20
>         05:1A:8A:DB:E8:3D       n/a
>
> Devices:
>         hci0    00:00:00:00:A8:AE
>
> Connections:
>         < ACL 00:11:F6:05:79:95 handle 0 state 5 lm MASTER
>
>
> With SLAB:
>
> Scanning ...
>         00:1A:8A:DB:E8:3D       SGH-T629
>
> Devices:
> 	hci0	00:1B:DC:0F:A8:AE
>
> Connections:
> 	< ACL 00:11:F6:05:79:95 handle 42 state 1 lm SLAVE
>
> I have not been able to test on other architectures yet to determine
> if it is another component in the chain (such as the usb OTG
> controller) misbehaving with SLOB. This is with git latest (post
> 2.6.29-rc7) and a number of OMAP branches.
>
> --~--~---------~--~----~------------~-------~--~----~
> You received this message because you are subscribed to the Google Groups
> "Beagle Board" group. To post to this group, send email to
> discussion@beagleboard.org.
> To unsubscribe from this group, send email to
> beagleboard-unsubscribe@beagleboard.org For more options, visit this group
> at http://groups.google.com/group/beagleboard?hl=en
> -~----------~----~----~----~------~----~------~--~---

-- 
Hunyue Yau
http://www.hy-research.com/
