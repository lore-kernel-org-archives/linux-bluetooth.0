Return-Path: <greg@kroah.com>
Date: Wed, 18 Jan 2006 12:46:00 -0800
From: Greg KH <greg@kroah.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        linux-usb-devel@lists.sourceforge.net, marcel@holtmann.org,
        maxk@qualcomm.com, linux-kernel@vger.kernel.org,
        bluez-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: [PATCH] hci_usb: implement suspend/resume
Message-ID: <20060118204600.GB18902@kroah.com>
References: <1137540084.4543.15.camel@localhost> <200601181425.35524.oliver@neukum.org> <1137593621.4543.22.camel@localhost> <200601181634.08869.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200601181634.08869.oliver@neukum.org>
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, Jan 18, 2006 at 04:34:08PM +0100, Oliver Neukum wrote:
> Am Mittwoch, 18. Januar 2006 15:13 schrieb Johannes Berg:
> > On Wed, 2006-01-18 at 14:25 +0100, Oliver Neukum wrote:
> > 
> > > This patch is wrong. usb_kill_urb() will sleep. You must not use it under
> > > a spinlock.
> > 
> > Whoops. Good catch. I'll have to analyse the logic with the lists being
> > used here (and probably add a temporary list). Will try to get a new
> > patch until tomorrow.
> > 
> > [side note: how about adding might_sleep() to usb_kill_urb? Then I'd at
> > least have noticed this right away]
> 
> Good idea.

Done.

thanks,

greg k-h
