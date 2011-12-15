Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Dec 2011 13:59:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/4] mcap_sync.c: Fix include paths
Message-ID: <20111215115942.GA9850@x220>
References: <1323857512-5626-1-git-send-email-sancane@gmail.com>
 <1323857512-5626-2-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323857512-5626-2-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Wed, Dec 14, 2011, Santiago Carot-Nemesio wrote:
> ---
>  health/mcap_sync.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/health/mcap_sync.c b/health/mcap_sync.c
> index 5545cea..e2d7715 100644
> --- a/health/mcap_sync.c
> +++ b/health/mcap_sync.c
> @@ -28,8 +28,8 @@
>  #include <stdlib.h>
>  #include <bluetooth/bluetooth.h>
>  #include <bluetooth/l2cap.h>
> -#include "../src/adapter.h"
> -#include "../src/manager.h"
> +#include <adapter.h>
> +#include <manager.h>
>  #include <sys/ioctl.h>
>  
>  #include "config.h"

There's more to fix here than this. config.h should come before anything
else (and should be inside a #ifdef HAVE_CONFIG_H) and we sort the libc
includes first, then dbus,glib,etc and finally the bluez internal
includes.

Johan
