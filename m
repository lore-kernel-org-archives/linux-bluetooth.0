Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Dec 2010 09:14:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 1/5] Bluetooth: clean up sco code
Message-ID: <20101202071426.GB15525@jh-x301>
References: <1291215506-11398-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1291215506-11398-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20101201212034.GE16125@vigoh>
 <AANLkTi==oXHyrtkjRD_mbmRFsDnTH7+S_JOFHRemXJLG@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTi==oXHyrtkjRD_mbmRFsDnTH7+S_JOFHRemXJLG@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Wed, Dec 01, 2010, Anderson Lizardo wrote:
> On Wed, Dec 1, 2010 at 5:20 PM, Gustavo F. Padovan
> <padovan@profusion.mobi> wrote:
> >> -static int disable_esco = 0;
> >> +static int disable_esco;
> >
> > I don't think this change is right. Can we be sure that disable_esco
> > will be 0 by default?
> 
> I think Andrei's patch is ok. IIRC kernel zeroes BSS on init, that's
> why checkpatch.pl complains when you initialize it explicitely.

That's interesting. It'd be nice to have some comment from Marcel on
this since at least on the user space side it's considered a good thing
to explicitly initialize static variables to zero.

Johan
