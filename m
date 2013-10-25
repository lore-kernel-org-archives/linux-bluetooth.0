Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1382624561-9294-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1382624561-9294-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 25 Oct 2013 11:11:53 +0300
Message-ID: <CABBYNZJhrM_+9UzxO7_pZcteVrT03hjv5MyE-i_EZPREo_KcNg@mail.gmail.com>
Subject: Re: [PATCH] android: Make haltest and bluetoothd depend on HAL lib
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Oct 24, 2013 at 5:22 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> The patch makes haltest and bluetoothd depend on bluetooth.default target
> which is already defined. glib dependency Android resolves itself.
> Fixes issue that for the fresh build only bluetooth.default.so is built.
> ---
>  android/Android.mk |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/android/Android.mk b/android/Android.mk
> index aac5c67..7049a20 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -84,6 +84,7 @@ LOCAL_MODULE := bluetooth.default
>  LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
>  LOCAL_MODULE_TAGS := optional
>  LOCAL_MODULE_CLASS := SHARED_LIBRARIES
> +LOCAL_REQUIRED_MODULES := haltest bluetoothd
>
>  include $(BUILD_SHARED_LIBRARY)
>
> --
> 1.7.10.4

Applied, thanks.


-- 
Luiz Augusto von Dentz
