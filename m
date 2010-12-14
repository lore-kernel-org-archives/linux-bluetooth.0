Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Dec 2010 17:34:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Pawlik <lucas.pawlik@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix crash while reading from mapped file
Message-ID: <20101214153405.GA11741@jh-x301>
References: <1291989348-3911-1-git-send-email-michalski.raf@gmail.com>
 <AANLkTinVMvv9KG0oG1C=_wA6t7LhcYcCunuYGTWyn1Hs@mail.gmail.com>
 <AANLkTi=jaKy=o0MhzV6xRwyk00OxOhk302-DHXM7fEgE@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTi=jaKy=o0MhzV6xRwyk00OxOhk302-DHXM7fEgE@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Tue, Dec 14, 2010, Lukasz Pawlik wrote:
> > I also wonder why we didn't use g_strsplit for this, it seems it would
> > actually do the same, there is a little performance impact since we
> > would have to iterate on the vector generated to call the callback
> > while the current code do it in-place.
> 
> Marcel, Johan any thoughts about this ? Should we reimplement this
> code using glib functions ?

It'd be nice to get some comments from Marcel since he is the original
author of the textfile.c code. In general I'm not too happy about having
to allocate a duplicate amount of memory for this (which is completely
dependent on the file size), but I do agree that some fix is needed. I'd
also like to make sure that we get a fix upstream before the next BlueZ
release.

Johan
