Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oneukum@suse.de>
To: James <theholyettlz@gmail.com>
Subject: Re: Bluetooth dongle (13d3:3304) not responding after reboot until suspend/resume
Date: Mon, 2 Jul 2012 21:58:54 +0200
Cc: Al Cho <acho@suse.com>, linux-bluetooth@vger.kernel.org
References: <1340312488.2203.16.camel@iseult> <CAKzePaoOQoXjx5QeRJPCcfOdfULF+EZ9BXf8ihM84YL9rb3D6Q@mail.gmail.com> <4FF1D148.4030009@gmail.com>
In-Reply-To: <4FF1D148.4030009@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201207022158.54868.oneukum@suse.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am Montag, 2. Juli 2012, 18:50:16 schrieb James:
> On 02/07/12 11:22, Al Cho wrote:
> >>
> > 
> > Yes,
> > James,would you please help us to get these log from test with unplug
> > and plug-in,
> > after warm reboot into Linux from Windows 7 ?
> > 
> > Sincerely,
> >                   AL
> > 
> 
> 
> Hello,
> 
> I think the device is built into the notebook on a dual USB/mini PCI
> Express card, so I can't hotplug it. As far as I can tell, there's no
> special keyboard combination to toggle it either. Closest I believe I
> can get is a suspend/resume (unless you know of a USB trick to power
> down the internal hub).

The rfkill switch should do the job.

	Regards
		Oliver
