Return-Path: <cyrus@holtmann.org>
Subject: Re: btusb autosuspend and circular lock dep
From: Marcel Holtmann <marcel@holtmann.org>
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Oliver Neukum <oliver@neukum.org>, linux-bluetooth@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Arjan Van De Ven <arjan@linux.intel.com>,
	saharabeara@gmail.com
In-Reply-To: <20090824224924.GA30024@gamba.jf.intel.com>
References: <20090615175435.GA4772@gamba.jf.intel.com>
	 <200908242326.01149.oliver@neukum.org>
	 <1251149817.2950.72.camel@localhost.localdomain>
	 <200908242344.59861.oliver@neukum.org>
	 <20090824215838.GA9991@gamba.jf.intel.com>
	 <20090824224924.GA30024@gamba.jf.intel.com>
Content-Type: text/plain
Date: Mon, 24 Aug 2009 16:07:11 -0700
Message-Id: <1251155231.2950.74.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sara,

> > I just tested this patch (against 2.6.31-rc7) on my X200s laptop, and it
> > works fine with the Broadcom USB bluetooth device with VID:PID
> > 0a5c:2145.  I tested transmitting audio to a bluetooth headset, so the
> > isoc transfers to work fine.  ISTR you were concerned about them.
> > 
> > I'm still testing on my T61 (Broadcom 0a5c:2110).  The autosuspend patch
> > seems to work fine, but I'm getting a circular lock dependency warning.
> > I'm recompiling a vanilla 2.6.31-rc7 to see if the lock warning is still
> > there.
> 
> The lock dep warning is still present in 2.6.31-rc7, so it's not your
> auto-suspend patch.  The dmesg is attached.  The warning came right
> after I stopped mplayer streaming audio to the bluetooth headset (with
> CTRL+c).  I'm running an older gnome bluetooth stack from June 14
> (from commit 7b1f2782).  I haven't tested whether updating the userspace
> bits makes the lock dep warning go way.

can you try the bluetooth-testing.git tree from kernel.org with the
patch from Oliver. The SCO shutdown patch might fix this.

Regards

Marcel


