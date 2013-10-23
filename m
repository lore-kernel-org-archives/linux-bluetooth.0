Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Oct 2013 09:40:26 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, andrei.emeltchenko@intel.com,
	szymon.janc@tieto.com
Subject: Re: [PATCH] android: Fix build error for Android
Message-ID: <20131023064026.GA31875@x220.p-661hnu-f1>
References: <1382482413-9324-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382482413-9324-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Wed, Oct 23, 2013, Lukasz Rymanowski wrote:
> ---
>  android/main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/android/main.c b/android/main.c
> index 988d08b..606baf2 100644
> --- a/android/main.c
> +++ b/android/main.c
> @@ -52,6 +52,10 @@
>  #include "hal-msg.h"
>  #include "ipc.h"
>  
> +#if defined(ANDROID)
> +#include <sys/capability.h>
> +#endif
> +
>  static GMainLoop *event_loop;
>  static struct mgmt *mgmt_if = NULL;

You're going to have to do a lot more explaining for this one.
Firstly, you should quote the error you get in the commit message.
Secondly, the patch doesn't seem to agree with the subject since the
conditional you're adding shouldn't change anything for the android
build. Thirdly, if there are some quirks with Android (bionic) includes
there should be a proper code comment explaining this so that the piece
of code doesn't by mistake get removed in the future.

Johan
