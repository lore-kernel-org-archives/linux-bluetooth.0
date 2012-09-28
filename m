Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Sep 2012 16:59:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Christian Cier-Zniewski <c.cier@gmx.de>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v8 00/13] Heart Rate Profile plugin
Message-ID: <20120928135921.GB6803@x220>
References: <1348583267-16816-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <20120928102503.GA25415@x220>
 <50659E54.5010206@gmx.de>
 <20120928131647.GA4026@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120928131647.GA4026@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Sep 28, 2012, Johan Hedberg wrote:
> On Fri, Sep 28, 2012, Christian Cier-Zniewski wrote:
> > Hello Johan,
> > 
> > On 28.09.2012 12:25, Johan Hedberg wrote:
> > >   Heart Rate Profile (HRP) client API
> > >
> > >  Makefile.am                    |   9 +-
> > >
> > >All patches in this set have been applied. Thanks.
> > >
> > >
> > 
> > 
> > I had to apply the following patch to get the heart rate profile working.
> > It is currently missing in HEAD although it was present in the
> > patchset provided by Andrzej.
> > 
> > Christian
> > 
> > ---
> > 
> > diff --git a/Makefile.am b/Makefile.am
> > index 3b37198..c27eb01 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -212,7 +212,7 @@ endif
> > 
> >  if GATTMODULES
> >  builtin_modules += thermometer alert time gatt_example proximity
> > deviceinfo \
> > -                       gatt scanparam
> > +                       gatt scanparam heartrate
> >  builtin_sources += profiles/thermometer/main.c \
> >                         profiles/thermometer/manager.h \
> >                         profiles/thermometer/manager.c \
> > 
> 
> The Makefile.am changes had conflicts because of other GATT profiles I
> applied earlier, so I had to completely manually fix this and probably
> made some mistake. Could you please send a proper git patch for this and
> I'll apply it?

Nevermind, I went ahead and fixed it myself.

Johan
