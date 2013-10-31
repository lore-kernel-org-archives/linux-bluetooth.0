Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 Oct 2013 10:42:35 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Use Android headers instead of local ones
Message-ID: <20131031084235.GD1271@x220.p-661hnu-f1>
References: <1383148285-20937-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383148285-20937-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Oct 30, 2013, Andrei Emeltchenko wrote:
> Add path to Android libhardware library headers
> ---
>  android/Android.mk |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index fc1b276..88dff4b 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -86,6 +86,7 @@ LOCAL_SRC_FILES := \
>  
>  LOCAL_C_INCLUDES += \
>  	$(call include-path-for, system-core) \
> +	$(call include-path-for, libhardware) \
>  
>  LOCAL_SHARED_LIBRARIES := \
>  	libcutils \

Applied. Thanks.

Johan
