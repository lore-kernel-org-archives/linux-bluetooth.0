Return-Path: <cyrus@holtmann.org>
Date: Thu, 23 Jul 2009 14:43:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lamarque Vieira Souza <lamarque@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel
 Holtmann <marcel@holtmann.org>,
        Anthony Waters <awaters1@gmail.com>
Subject: Re: [PATCH] Fix for Acer  Bluetooth Optical Rechargeable Mouse
Message-Id: <20090723144336.3ab01751.akpm@linux-foundation.org>
In-Reply-To: <200907231830.57719.lamarque@gmail.com>
References: <200907170301.43807.lamarque@gmail.com>
	<20090723132810.6a7aa3dc.akpm@linux-foundation.org>
	<200907231830.57719.lamarque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 23 Jul 2009 18:30:57 -0300
Lamarque Vieira Souza <lamarque@gmail.com> wrote:

> Em Quinta-feira 23 Julho 2009, Andrew Morton escreveu:
> > On Fri, 17 Jul 2009 03:01:43 -0300
> >
> > Lamarque Vieira Souza <lamarque@gmail.com> wrote:
> > > 	This patch works around one problem with my Acer Bluetooth Optical
> > > Rechargeable Mouse where the cursor gets stuck at screen's upper-left
> > > corner. Even my notebook's touchpad is not able to move cursor when the
> > > bluetooth mouse is connected to my Acer Ferrari 4005 notebook. Using
> > > input session instead of hid session solves this problem although the
> > > cursor still moves a little sluggishly with the bluetooth mouse, cursor
> > > moves correctly using the touchpad. My bluetooth mouse used to work well
> > > (no sluggish) until kernel 2.6.21, since then the problems are getting
> > > worse with each kernel release (it got sluggish in 2.6.22 and this this
> > > upper-left corner problem appeared in 2.6.28 or 2.6.27).
> 
> 	By the way, I have found that bug 
> http://bugzilla.kernel.org/show_bug.cgi?id=13314 is the cause of the sluggish 
> in my mouse.

(cc's added)

OK, thanks.  Did you test Anthony's patch on your system?

Also, you've determined that
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e4e8e37c42bdaaefcb84eeaef0dc1bc3f696f8f6
caused the problem on your machine and that reverting it fixes things
up.

I'm all confused.
