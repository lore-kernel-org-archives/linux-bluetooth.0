Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1383862220-29968-3-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383862220-29968-1-git-send-email-ravikumar.veeramally@linux.intel.com>
	<1383862220-29968-3-git-send-email-ravikumar.veeramally@linux.intel.com>
Date: Fri, 8 Nov 2013 07:44:06 +0100
Message-ID: <CAHCYCox_Zk=3VHoc_hib8ytaF3EUWhoLDNW+17kaDqCtCMe+Yw@mail.gmail.com>
Subject: Re: [PATCH_v2 02/11] android/hid: Add a ascii2hex utility
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi

On 7 November 2013 23:10, Ravi kumar Veeramally
<ravikumar.veeramally@linux.intel.com> wrote:
> Data from few interfaces on HAL is in ascii format but it should be
> in hex format. This conversion utility does that job.
> ---
>  android/Android.mk  |  1 +
>  android/Makefile.am |  2 +-
>  android/utils.c     | 41 +++++++++++++++++++++++++++++++++++++++++
>  android/utils.h     |  3 +++
>  4 files changed, 46 insertions(+), 1 deletion(-)
>  create mode 100644 android/utils.c
>
> diff --git a/android/Android.mk b/android/Android.mk
> index 51037a7..628b2f9 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -27,6 +27,7 @@ LOCAL_SRC_FILES := \
>         ipc.c ipc.h \
>         a2dp.c \
>         pan.c \
> +       utils.c \
>         ../src/log.c \
>         ../src/shared/mgmt.c \
>         ../src/shared/util.c \
> diff --git a/android/Makefile.am b/android/Makefile.am
> index 073edc8..6063a3a 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -9,7 +9,7 @@ noinst_PROGRAMS += android/bluetoothd
>  android_bluetoothd_SOURCES = android/main.c \
>                                 src/log.c \
>                                 android/hal-msg.h \
> -                               android/utils.h \
> +                               android/utils.h android/utils.c \
>                                 src/sdpd-database.c src/sdpd-server.c \
>                                 src/sdpd-service.c src/sdpd-request.c \
>                                 src/glib-helper.h src/glib-helper.c \
> diff --git a/android/utils.c b/android/utils.c
> new file mode 100644
> index 0000000..48d6c38
> --- /dev/null
> +++ b/android/utils.c
> @@ -0,0 +1,41 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2013  Intel Corporation. All rights reserved.
> + *
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include "utils.h"
> +
> +void ascii2hex(const uint8_t *ascii, int ascii_len, uint8_t *hex)
> +{
> +       int i;
> +
> +       if (!ascii || !hex)
> +               return;
> +
> +       for (i = 0; i < ascii_len / 2; i++)
> +               sscanf((char *) &ascii[i * 2], "%02x",
> +                                               (unsigned int *) &hex[i]);

Use hh in format instead of cast.

> +
> +}
> diff --git a/android/utils.h b/android/utils.h
> index 5b009bc..d424968 100644
> --- a/android/utils.h
> +++ b/android/utils.h
> @@ -21,6 +21,7 @@
>   *
>   */
>
> +#include "lib/bluetooth.h"
>
>  static inline void android2bdaddr(const void *buf, bdaddr_t *dst)
>  {
> @@ -31,3 +32,5 @@ static inline void bdaddr2android(const bdaddr_t *src, void *buf)
>  {
>         baswap(buf, src);
>  }
> +
> +void ascii2hex(const uint8_t *ascii, int ascii_len, uint8_t *hex);
> --
> 1.8.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Jerzy
