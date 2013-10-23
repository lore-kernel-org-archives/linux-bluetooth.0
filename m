Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1382535737-9757-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1382535737-9757-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Wed, 23 Oct 2013 17:41:37 +0300
Message-ID: <CABBYNZJ25yHrqSYCmTP1jUhdHJUYdKHS7j0cs3pZQrfe3A8jVw@mail.gmail.com>
Subject: Re: [PATCH] android: Use helper function for finding headers
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Oct 23, 2013 at 4:42 PM, Andrei Emeltchenko
<andrei.emeltchenko@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Using helper function allows us to overcome possible location
> change in future Android releases. This was inspired by
> Szymon Janc's comment to my previous patch.
> ---
>  android/Android.mk | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/android/Android.mk b/android/Android.mk
> index dd9c36d..1f20e57 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -75,7 +75,7 @@ LOCAL_SRC_FILES := \
>         hal-av.c \
>
>  LOCAL_C_INCLUDES += \
> -       system/core/include \
> +       $(call include-path-for, system-core) \
>
>  LOCAL_SHARED_LIBRARIES := \
>         libcutils \
> --
> 1.8.1.2

Pushed, thanks.

-- 
Luiz Augusto von Dentz
