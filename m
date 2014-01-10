Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1389356048-4333-1-git-send-email-luiz.dentz@gmail.com>
References: <1389356048-4333-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 10 Jan 2014 15:39:33 +0200
Message-ID: <CABBYNZLCj2T5=EjLYJKBuAvzHfGBmzydSUp9k0JNgF9yWFr8tw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] android: Convert libaudio-internal to a plugin
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jan 10, 2014 at 2:14 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This convert the static library libaudio-internal.la to
> audio.a2dp.default.so when building with autotools.
> ---
>  android/Makefile.am | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/android/Makefile.am b/android/Makefile.am
> index 0a32a95..97173db 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -114,18 +114,19 @@ android_android_tester_LDADD = lib/libbluetooth-internal.la \
>
>  android_android_tester_LDFLAGS = -pthread
>
> -noinst_LTLIBRARIES += android/libaudio-internal.la
> +plugin_LTLIBRARIES += android/audio.a2dp.default.la
>
> -android_libaudio_internal_la_SOURCES = android/audio-msg.h \
> +android_audio_a2dp_default_la_SOURCES = android/audio-msg.h \
>                                         android/hal-audio.c \
>                                         android/hardware/audio.h \
>                                         android/hardware/audio_effect.h \
>                                         android/hardware/hardware.h \
>                                         android/system/audio.h
>
> -android_libaudio_internal_la_CFLAGS = -I$(srcdir)/android
> +android_audio_a2dp_default_la_CFLAGS = -I$(srcdir)/android
>
> -android_libaudio_internal_la_LDFLAGS = -pthread
> +android_audio_a2dp_default_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
> +                                       -no-undefined -pthread
>
>  endif
>
> --
> 1.8.4.2

This now pushed.


-- 
Luiz Augusto von Dentz
