Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [PATCH] android: Disable format warnings in Android
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1383129043-30582-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Wed, 30 Oct 2013 12:25:17 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <4CC7C56D-693D-4E1B-8E8B-3BE4A76A9722@holtmann.org>
References: <1383129043-30582-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Android's bionic library has bug defining ssize_t (which is fixed in
> Android 4.3). This seems to be the most appropriate solution until
> we move to Android 4.3.
> ---
> android/Android.mk |    4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index fc1b276..db55d37 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -12,6 +12,10 @@ BLUEZ_COMMON_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
> # Disable warnings enabled by Android but not enabled in autotools build
> BLUEZ_COMMON_CFLAGS += -Wno-pointer-arith
> 
> +# Disable warning: format '%zd' expects argument of type 'signed size_t',
> +# but argument 4 has type 'ssize_t'
> +BLUEZ_COMMON_CFLAGS += -Wno-format

this disables now all format warnings. Even the useful ones. I am not in favor of doing this since it just leads to more error that otherwise the compiler would have caught.

Regards

Marcel

