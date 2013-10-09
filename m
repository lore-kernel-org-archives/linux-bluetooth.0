Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCHv3 01/15] android: Supress missing initializers warnings
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381243883-2745-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Wed, 9 Oct 2013 21:11:04 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E4E245F7-8EE6-4FE2-AC99-3246F1541C99@holtmann.org>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1381243883-2745-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1381243883-2745-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> These types of warnings are disabled in BlueZ makeifiles
> 
> main.c:67:2: warning: missing initializer [-Wmissing-field-initializers]
> main.c:67:2: warning: (near initialization for 'options[1].short_name')
> 	[-Wmissing-field-initializers]
> ---
> android/Android.mk |    3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index ec820ac..5498b41 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -23,6 +23,9 @@ LOCAL_C_INCLUDES := \
> 
> LOCAL_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
> 
> +# to suppress the "warning: missing initializer near initialization.." warning
> +LOCAL_CFLAGS += -Wno-missing-field-initializers
> +

why are we doing this and not fixing the actual warning?

Regards

Marcel

