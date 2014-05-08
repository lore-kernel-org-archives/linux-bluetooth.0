Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 May 2014 12:35:34 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 01/12] android/hal-sco: Add audio HAL for SCO handling
Message-ID: <20140508093531.GC21149@aemeltch-MOBL1>
References: <1399536103-19052-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1399536103-19052-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20140508085542.GA21149@aemeltch-MOBL1>
 <4668430.NqV7pR9ADr@uw000953>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4668430.NqV7pR9ADr@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, May 08, 2014 at 11:14:12AM +0200, Szymon Janc wrote:
> Hi Andrei,
> 
> On Thursday 08 of May 2014 11:55:47 Andrei Emeltchenko wrote:
> > On Thu, May 08, 2014 at 11:01:32AM +0300, Andrei Emeltchenko wrote:
> > > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > > 
> > > This adds audio HAL for handling SCO. Following needs to be added to
> > > audio_policy.conf:
> > > 
> > >   sco {
> > >     outputs {
> > >       sco {
> > >         ...
> > >         devices AUDIO_DEVICE_OUT_ALL_SCO
> > >         ...
> > >       }
> > >     }
> > > ---
> > >  android/Android.mk  |  23 ++++++
> > >  android/Makefile.am |  15 ++++
> > >  android/hal-sco.c   | 211 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 249 insertions(+)
> > >  create mode 100644 android/hal-sco.c
> > > 
> > > diff --git a/android/Android.mk b/android/Android.mk
> > > index 638a042..b7b284d 100644
> > > --- a/android/Android.mk
> > > +++ b/android/Android.mk
> > > @@ -271,6 +271,29 @@ LOCAL_MODULE := audio.a2dp.default
> > >  include $(BUILD_SHARED_LIBRARY)
> > >  
> > >  #
> > > +# SCO audio
> > > +#
> > > +
> > > +include $(CLEAR_VARS)
> > > +
> > > +LOCAL_SRC_FILES := bluez/android/hal-sco.c
> > > +
> > > +LOCAL_C_INCLUDES = \
> > > +	$(call include-path-for, system-core) \
> > > +	$(call include-path-for, libhardware) \
> > > +
> > > +LOCAL_SHARED_LIBRARIES := \
> > > +	libcutils \
> > > +
> > > +LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
> > > +
> > > +LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
> > > +LOCAL_MODULE_TAGS := optional
> > > +LOCAL_MODULE := audio.sco.default
> > 
> > I changed hsp to sco, I think this is not a good idea here since hsp is
> > mentioned in audio_policy.conf
> 
> Different devices have different customizations in audio_policy.conf.
> If one is integrating BlueZ he should provide proper audio_policy.conf anyway.
> 
> IMHO sco is better name here.

My idea was to make as little changes as possible to the existing code.
There is always a better name ;)

Best regards 
Andrei Emeltchenko 
