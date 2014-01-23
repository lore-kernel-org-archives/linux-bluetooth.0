Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1390493791-23043-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1390493791-23043-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Thu, 23 Jan 2014 20:09:06 +0200
Message-ID: <CABBYNZJq5uro0deeooehGhfcGqqbQZ+NQng=BVEvWrOa11HjkA@mail.gmail.com>
Subject: Re: [PATCH] android/audio: Fix for loading audio lib
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Thu, Jan 23, 2014 at 6:16 PM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> Issue visible when haltest loads audio.a2dp.default.so
>
>> HAL E: load:
>> module=/home/rymanluk/devel/kitkat/external/bluetooth/bluez/android/.libs/audio.a2dp.default.so
> /home/rymanluk/devel/kitkat/external/bluetooth/bluez/android/.libs/audio.a2dp.default.so:
> undefined symbol: clock_gettime
> hw_get_module_by_class returned -22
>
> ---
>  android/Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/android/Makefile.am b/android/Makefile.am
> index e9d9db1..f85de20 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -152,7 +152,7 @@ android_audio_a2dp_default_la_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
>  android_audio_a2dp_default_la_LIBADD = @SBC_LIBS@
>
>  android_audio_a2dp_default_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
> -                                       -no-undefined -pthread
> +                                       -no-undefined -pthread -lrt
>
>  endif
>
> --
> 1.8.4

Applied, just had to fix a little but the description to state why
-lrt is needed.


-- 
Luiz Augusto von Dentz
