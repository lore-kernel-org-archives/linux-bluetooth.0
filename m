Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 May 2014 13:55:19 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv6 07/11] android/audio: Add resampler support
Message-ID: <20140513105441.GA27218@aemeltch-MOBL1>
References: <1399885029-6358-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1399885029-6358-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <48B10FF8-C2D8-4528-AF0D-497D96546A5B@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48B10FF8-C2D8-4528-AF0D-497D96546A5B@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, May 12, 2014 at 06:29:40PM -0700, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > The patch adds support for resampling audio in host and Android. There
> > are Android wrappers for SPEEXDSP library added to host.
> > ---
> > android/Android.mk              |   2 +
> > android/Makefile.am             |   6 +-
> > android/audio_utils/resampler.c | 265 ++++++++++++++++++++++++++++++++++++++++
> > android/audio_utils/resampler.h | 109 +++++++++++++++++
> > configure.ac                    |   7 ++
> > 5 files changed, 388 insertions(+), 1 deletion(-)
> > create mode 100644 android/audio_utils/resampler.c
> > create mode 100644 android/audio_utils/resampler.h
> > 
> > diff --git a/android/Android.mk b/android/Android.mk
> > index 6d0169b..cc0f8f5 100644
> > --- a/android/Android.mk
> > +++ b/android/Android.mk
> > @@ -282,9 +282,11 @@ LOCAL_SRC_FILES := bluez/android/hal-sco.c
> > LOCAL_C_INCLUDES = \
> > 	$(call include-path-for, system-core) \
> > 	$(call include-path-for, libhardware) \
> > +	$(call include-path-for, audio-utils) \
> > 
> > LOCAL_SHARED_LIBRARIES := \
> > 	libcutils \
> > +	libaudioutils \
> > 
> 
> where is this coming from? Why this directory? Why this name?

This is standard Android library and directory name. You can search it in
Android AOSP.

> Why not use compile it directly into the SCO audio module and use a name like android/audio_resampler.[ch].

This is standard Android library used also by other projects.

Best regards 
Andrei Emeltchenko 
