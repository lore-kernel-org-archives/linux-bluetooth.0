Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix crash while reading from mapped file
From: Bastien Nocera <hadess@hadess.net>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Lukasz Pawlik <lucas.pawlik@gmail.com>,
	linux-bluetooth@vger.kernel.org
Date: Tue, 14 Dec 2010 15:41:13 +0000
In-Reply-To: <20101214153405.GA11741@jh-x301>
References: <1291989348-3911-1-git-send-email-michalski.raf@gmail.com>
	 <AANLkTinVMvv9KG0oG1C=_wA6t7LhcYcCunuYGTWyn1Hs@mail.gmail.com>
	 <AANLkTi=jaKy=o0MhzV6xRwyk00OxOhk302-DHXM7fEgE@mail.gmail.com>
	 <20101214153405.GA11741@jh-x301>
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1292341274.3050.15.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2010-12-14 at 17:34 +0200, Johan Hedberg wrote:
> Hi Lukasz,
> 
> On Tue, Dec 14, 2010, Lukasz Pawlik wrote:
> > > I also wonder why we didn't use g_strsplit for this, it seems it would
> > > actually do the same, there is a little performance impact since we
> > > would have to iterate on the vector generated to call the callback
> > > while the current code do it in-place.
> > 
> > Marcel, Johan any thoughts about this ? Should we reimplement this
> > code using glib functions ?
> 
> It'd be nice to get some comments from Marcel since he is the original
> author of the textfile.c code. In general I'm not too happy about having
> to allocate a duplicate amount of memory for this (which is completely
> dependent on the file size), but I do agree that some fix is needed. I'd
> also like to make sure that we get a fix upstream before the next BlueZ
> release.

If somebody can explain what that code is supposed to do, then writing a
glib-ish version should be trivial, without having to duplicate the
contents again. Then again, using something like:
g_mapped_file_new ();
g_strsplit ();
g_mapped_file_unref ();
wouldn't actually allocate more memory per se. You could also loop over
the content of each line, from the mmapped contents, but you'd be making
the code harder to read, with not much real world gain.

In a very worst case scenario, duping 50k of memory shouldn't be this
expensive. I would certainly understand the problem if we had megabyte
files though.

Cheers

