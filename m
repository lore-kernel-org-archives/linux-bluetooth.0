Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Nov 2014 14:35:26 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Remove temporary BLUEZ_EXTENSION flag
Message-ID: <20141106123524.GC868@aemeltch-MOBL1>
References: <1415269130-7688-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <2084665.MKgJSzBybo@uw000953>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2084665.MKgJSzBybo@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Nov 06, 2014 at 12:54:03PM +0100, Szymon Janc wrote:
> Hi Andrei,
> 
> On Thursday 06 of November 2014 12:18:50 Andrei Emeltchenko wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > BLUEZ_EXTENSION is replaced by ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
> > check.

...

> > diff --git a/android/client/if-hf-client.c b/android/client/if-hf-client.c
> > index 3f6f7c2..5783ffe 100644
> > --- a/android/client/if-hf-client.c
> > +++ b/android/client/if-hf-client.c
> > @@ -18,6 +18,8 @@
> >  #include "if-main.h"
> >  #include "../hal-utils.h"
> >  
> > +#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
> > +
> 
> I'd prefer if you handle this on Android.mk level.

Yes, I was thinking about it. Last time I was trying to use those
constructions in makefile I faced some problems.

Will try this way.

Best regards 
Andrei Emeltchenko 

