Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1417619433-32413-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1417619433-32413-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Thu, 4 Dec 2014 09:38:15 +0100
Message-ID: <CAA4A+aDJ9u-83fCTosA5vxPzHOXTVBocAyh8hYh2jXRUncAYfA@mail.gmail.com>
Subject: Re: [PATCH] android/build: Convert LOCAL_MODULE_PATH to LOCAL_MODULE_RELATIVE_PATH
From: Szymon Janc <szymon.janc@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Dec 3, 2014 at 4:10 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> LOCAL_MODULE_PATH needs to be replaced for multiarch builds like for
> example for Nexus 9 (volantis) target.
> ---
>  android/Android.mk | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/android/Android.mk b/android/Android.mk
> index 20a1494..9ee2fc9 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -376,7 +376,7 @@ LOCAL_SHARED_LIBRARIES := \
>  LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS) -Wno-declaration-after-statement
>  LOCAL_LDFLAGS := -ldl
>
> -LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
> +LOCAL_MODULE_RELATIVE_PATH := hw
>  LOCAL_MODULE_TAGS := optional
>  LOCAL_MODULE := audio.a2dp.default
>
> @@ -402,7 +402,7 @@ LOCAL_SHARED_LIBRARIES := \
>
>  LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS) -Wno-declaration-after-statement
>
> -LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
> +LOCAL_MODULE_RELATIVE_PATH := hw
>  LOCAL_MODULE_TAGS := optional
>  LOCAL_MODULE := audio.sco.default
>

Applied, thanks.

-- 
pozdrawiam
Szymon K. Janc
szymon.janc@gmail.com
