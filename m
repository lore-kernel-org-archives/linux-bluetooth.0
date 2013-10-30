Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] android: Suppress compiler warnings not used in autotools build
Date: Wed, 30 Oct 2013 10:07:12 +0100
Message-ID: <6724295.lKoBtA2rXb@uw000953>
In-Reply-To: <1664552.rzmdhg2vR5@uw000953>
References: <1383060218-25693-1-git-send-email-szymon.janc@tieto.com> <20131030081914.GH27517@aemeltch-MOBL1> <1664552.rzmdhg2vR5@uw000953>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 30 of October 2013 09:25:03 Szymon Janc wrote:
> Hi Andrei,
> 
> On Wednesday 30 of October 2013 10:19:15 Andrei Emeltchenko wrote:
> > Hi Szymon,
> > 
> > On Tue, Oct 29, 2013 at 04:23:38PM +0100, Szymon Janc wrote:
> > > Android build system is enabling some additional warnings that are not
> > > enabled when building with autotools. This avoids spurious warnings
> > > while building on Android.
> > > ---
> > >  android/Android.mk | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/android/Android.mk b/android/Android.mk
> > > index c88b27e..fc1b276 100644
> > > --- a/android/Android.mk
> > > +++ b/android/Android.mk
> > > @@ -9,6 +9,9 @@ pathmap_INCL += glib:external/bluetooth/glib
> > >  # Specify common compiler flags
> > >  BLUEZ_COMMON_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
> > >  
> > > +# Disable warnings enabled by Android but not enabled in autotools build
> > > +BLUEZ_COMMON_CFLAGS += -Wno-pointer-arith
> > 
> > I wouldn't put this to BLUEZ_COMMON_CFLAGS, maybe only bluetoothd target
> > CFLAGS, the issue withing HAL might be easily fixed. We use void pointer
> > in math operations.
> 
> This is done on purpose as using void* to operation is simply convenient as
> there is no need for char* casting (and sizeof(void *) == 1 is documented GCC

sizeof(void) == 1   that is.

> feature). Further more I think it will be easier for developers if we can have
> same code guidelines and warnings while building on host and android for all
> components.
> 
> 


