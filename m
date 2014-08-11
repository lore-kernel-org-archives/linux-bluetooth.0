Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1407752016-14863-1-git-send-email-luiz.dentz@gmail.com>
References: <1407752016-14863-1-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 11 Aug 2014 18:03:55 +0300
Message-ID: <CABBYNZLifRUFZ4h4=tCVuO7cOzhvf34NmsEpNrbYDfX8FePtdA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/7] android: Fix not including shared/queue.c in
 A2DP plugin
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Aug 11, 2014 at 1:13 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This can cause the followin error:
> audio.a2dp.default.so: undefined symbol: queue_foreach
> ---
> v2: Rebase properly
>
>  android/Makefile.am | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/android/Makefile.am b/android/Makefile.am
> index ac3a766..263a506 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -198,7 +198,9 @@ android_audio_a2dp_default_la_SOURCES = android/audio-msg.h \
>                                         android/hardware/audio.h \
>                                         android/hardware/audio_effect.h \
>                                         android/hardware/hardware.h \
> -                                       android/system/audio.h
> +                                       android/system/audio.h \
> +                                       src/shared/queue.h \
> +                                       src/shared/queue.c
>
>  android_audio_sco_default_la_SOURCES = android/hal-log.h \
>                                         android/sco-msg.h \
> --
> 1.9.3
>

Pushed.

-- 
Luiz Augusto von Dentz
