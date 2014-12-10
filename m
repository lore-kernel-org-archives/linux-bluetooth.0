Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 1/2] android/build: Fix including wrong log include header for bluetoothd
Date: Wed, 10 Dec 2014 13:22:56 +0100
Message-ID: <1550008.vIcd9N6nnq@leonov>
In-Reply-To: <1418201890-8255-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1418201890-8255-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wednesday 10 of December 2014 10:58:09 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Fixes build for Nexus 9.
> ...
> aarch64-linux-android/bin/ld:
> out/target/product/flounder/obj/EXECUTABLES/bluetoothd-main_intermediates/bl
> uez/android/a2dp-sink.o: undefined reference to symbol '__android_log_print'
> ...
> ---
>  android/a2dp-sink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/a2dp-sink.c b/android/a2dp-sink.c
> index 07508c0..7c1e1a0 100644
> --- a/android/a2dp-sink.c
> +++ b/android/a2dp-sink.c
> @@ -29,7 +29,7 @@
>  #include <glib.h>
> 
>  #include "lib/bluetooth.h"
> -#include "hal-log.h"
> +#include "src/log.h"
>  #include "hal-msg.h"
>  #include "ipc.h"
>  #include "a2dp-sink.h"

Both patches applied, thanks.

-- 
BR
Szymon Janc
