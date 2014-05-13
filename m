Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCHv6 07/11] android/audio: Add resampler support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1399885029-6358-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 12 May 2014 18:29:40 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <48B10FF8-C2D8-4528-AF0D-497D96546A5B@holtmann.org>
References: <1399885029-6358-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1399885029-6358-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> The patch adds support for resampling audio in host and Android. There
> are Android wrappers for SPEEXDSP library added to host.
> ---
> android/Android.mk              |   2 +
> android/Makefile.am             |   6 +-
> android/audio_utils/resampler.c | 265 ++++++++++++++++++++++++++++++++++++++++
> android/audio_utils/resampler.h | 109 +++++++++++++++++
> configure.ac                    |   7 ++
> 5 files changed, 388 insertions(+), 1 deletion(-)
> create mode 100644 android/audio_utils/resampler.c
> create mode 100644 android/audio_utils/resampler.h
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index 6d0169b..cc0f8f5 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -282,9 +282,11 @@ LOCAL_SRC_FILES := bluez/android/hal-sco.c
> LOCAL_C_INCLUDES = \
> 	$(call include-path-for, system-core) \
> 	$(call include-path-for, libhardware) \
> +	$(call include-path-for, audio-utils) \
> 
> LOCAL_SHARED_LIBRARIES := \
> 	libcutils \
> +	libaudioutils \
> 

where is this coming from? Why this directory? Why this name?

Why not use compile it directly into the SCO audio module and use a name like android/audio_resampler.[ch].

Regards

Marcel

