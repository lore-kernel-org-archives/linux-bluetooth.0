Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: fix oops in rfcomm tty code (v2)
From: Marcel Holtmann <marcel@holtmann.org>
To: Vegard Nossum <vegard.nossum@gmail.com>
Cc: Maxim Krasnyansky <maxk@qualcomm.com>,
	Dave Young <hidave.darkstar@gmail.com>,
	Soeren Sonnenburg <kernel@nn7.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <19f34abd0807202351w52b45bc9m6ba5133af696748b@mail.gmail.com>
References: <20080719211227.GA14173@localhost.localdomain>
	 <1216503500.8411.110.camel@violet.holtmann.net>
	 <19f34abd0807202351w52b45bc9m6ba5133af696748b@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 21 Jul 2008 12:31:13 +0200
Message-Id: <1216636273.31819.25.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vegard,

> >> This is a resend of a patch I sent earlier. It fixes a reproducible
> >> oops (see http://lkml.org/lkml/2008/7/13/89 for test case), and I'd
> >> be very happy for some feedback from Bluetooth people. Can this be
> >> included for testing somewhere? I don't have any bluetooth devices
> >> myself, so all my testing is limited to creating/releasing devices
> >> with ioctl (I'm not sure that's good enough).
> >>
> >> Dave: I have extended the rfcomm_dev_lock to include all the setup and
> >> teardown of a single device. On second thought, it doesn't really make
> >> sense to use a separate lock for that. May I have your opinion on this
> >> second version? (I've fixed the comments/BUG_ON that you pointed out.)
> >
> > it seems it is the actually the first time, I see this one. Anyway, so
> > holding that lock is a bad idea. Fixing this the right way might be
> > tricky since the TTY layer is involved here and own the kobject. So I
> > would say we have to make sure that the RFCOMM TTY will hangup when
> > calling RELEASEDEV or otherwise fail.
> 
> On Mon, Jul 21, 2008 at 7:14 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> >> The patch titled
> >>      Bluetooth: fix oops in rfcomm tty code
> >> has been added to the -mm tree.  Its filename is
> >>      bluetooth-fix-oops-in-rfcomm-tty-code-v2.patch
> >>
> > just a quick note that I am not okay with this patch. Holding the lock
> > isn't the right solution since it would also block any other application
> > from creating new devices. We can't do this.
> 
> Hi,
> 
> We are not holding the lock across any ioctl/syscall boundary, which
> would be an error anyway.
> 
> The lock now additionally protects the calls to:
> 
>     tty_register_device
>     tty_unregister_device
>     device_create_file
> 
> I don't think these functions block or do anything with the device
> apart from just registering/unregistering the files.
> 
> Can you please explain in more detail what is wrong with the patch?
> Where are we preventing other applications from creating new devices?
> My intention was to prevent other applications from creating the
> _same_ devices while they are still in use, although attempting to
> register a new device (with an already-in-use ID) should simply fail,
> and not block.

I see an issue when a malicious application like the test program keeps
the TTY open. Then we would block any other TTY creation. Even if it is
a different TTY or process.

Regards

Marcel


