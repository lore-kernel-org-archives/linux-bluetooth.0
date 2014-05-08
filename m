Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 May 2014 12:02:46 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 01/12] android/hal-sco: Add audio HAL for SCO handling
Message-ID: <20140508090244.GB21149@aemeltch-MOBL1>
References: <1399536103-19052-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1399536103-19052-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20140508085542.GA21149@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140508085542.GA21149@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, May 08, 2014 at 11:55:47AM +0300, Andrei Emeltchenko wrote:
> On Thu, May 08, 2014 at 11:01:32AM +0300, Andrei Emeltchenko wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > This adds audio HAL for handling SCO. Following needs to be added to
> > audio_policy.conf:
> > 
> >   sco {
> >     outputs {
> >       sco {
> >         ...
> >         devices AUDIO_DEVICE_OUT_ALL_SCO
> >         ...
> >       }
> >     }
> > ---
> >  android/Android.mk  |  23 ++++++
> >  android/Makefile.am |  15 ++++
> >  android/hal-sco.c   | 211 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 249 insertions(+)
> >  create mode 100644 android/hal-sco.c
> > 
> > diff --git a/android/Android.mk b/android/Android.mk
> > index 638a042..b7b284d 100644
> > --- a/android/Android.mk
> > +++ b/android/Android.mk
> > @@ -271,6 +271,29 @@ LOCAL_MODULE := audio.a2dp.default
> >  include $(BUILD_SHARED_LIBRARY)
> >  
> >  #
> > +# SCO audio
> > +#
> > +
> > +include $(CLEAR_VARS)
> > +
> > +LOCAL_SRC_FILES := bluez/android/hal-sco.c
> > +
> > +LOCAL_C_INCLUDES = \
> > +	$(call include-path-for, system-core) \
> > +	$(call include-path-for, libhardware) \
> > +
> > +LOCAL_SHARED_LIBRARIES := \
> > +	libcutils \
> > +
> > +LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
> > +
> > +LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
> > +LOCAL_MODULE_TAGS := optional
> > +LOCAL_MODULE := audio.sco.default
> 
> I changed hsp to sco, I think this is not a good idea here since hsp is
> mentioned in audio_policy.conf

Here:
https://github.com/android-ia/device_intel_mixins/blob/master/audio/hsw_alc282/audio_policy.conf

  hsp {
    outputs {
      hsp {
        sampling_rates 44100
        channel_masks AUDIO_CHANNEL_OUT_STEREO
        formats AUDIO_FORMAT_PCM_16_BIT
        devices AUDIO_DEVICE_OUT_ALL_SCO
      }
    }
    inputs {
      hsp {
        sampling_rates 44100
        channel_masks AUDIO_CHANNEL_IN_MONO
        formats AUDIO_FORMAT_PCM_16_BIT
        devices AUDIO_DEVICE_IN_BLUETOOTH_SCO_HEADSET
      }
    }
  }


Best regards 
Andrei Emeltchenko 

