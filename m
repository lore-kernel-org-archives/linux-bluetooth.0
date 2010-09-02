Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Sep 2010 09:41:29 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, cbe-oss-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] hid/hid-sony: Apply sixaxis quirks only to sixaxis
In-Reply-To: <20100901192055.2f23c8c7.ospite@studenti.unina.it>
Message-ID: <alpine.LNX.2.00.1009020941120.26813@pobox.suse.cz>
References: <1272917756-31098-1-git-send-email-ospite@studenti.unina.it> <1272917756-31098-2-git-send-email-ospite@studenti.unina.it> <1283357615.2361.20.camel@localhost.localdomain> <20100901192055.2f23c8c7.ospite@studenti.unina.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 1 Sep 2010, Antonio Ospite wrote:

> > > Be more explicit and avoid calling sony_set_operational_usb() when we
> > > have USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE.
> > > 
> > > While at it, rename the sony_set_operational routines to
> > > sixaxis_set_operational as they are sixaxis specific.
> > > 
> > > This is also in preparation for the sysfs interface to set and get bdaddr
> > > over usb and for some other Sixaxis report fixup.
> > > 
> > > Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
> > 
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> >
> 
> Thanks Bastien for bringing this up again, I was going to repost
> this patch sometime this month.
> 
> Added Jiri to CC as I forgot to do that back then.

Thanks, I have missed that one on linux-input@.

Applied now.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
