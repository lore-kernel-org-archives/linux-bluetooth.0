Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Jan 2013 09:36:36 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ 6/6] gas: Move all the code to only one file
Message-ID: <20130125073636.GB19244@x220>
References: <1359083227-13122-1-git-send-email-vinicius.gomes@openbossa.org>
 <1359083227-13122-7-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359083227-13122-7-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Jan 25, 2013, Vinicius Costa Gomes wrote:
> Our Generic Attribute/Access Service plugin is small and simple enough
> to be kept in only one file.
> ---
>  Makefile.plugins        |  4 +--
>  profiles/gatt/gas.c     | 46 ++++++++++++++++++++++++++++
>  profiles/gatt/main.c    | 47 -----------------------------
>  profiles/gatt/manager.c | 79 -------------------------------------------------
>  profiles/gatt/manager.h | 24 ---------------
>  5 files changed, 47 insertions(+), 153 deletions(-)
>  delete mode 100644 profiles/gatt/main.c
>  delete mode 100644 profiles/gatt/manager.c
>  delete mode 100644 profiles/gatt/manager.h
> 
> diff --git a/Makefile.plugins b/Makefile.plugins
> index faab011..f497782 100644
> --- a/Makefile.plugins
> +++ b/Makefile.plugins
> @@ -69,9 +69,7 @@ builtin_sources += profiles/health/mcap_lib.h profiles/health/mcap_internal.h \
>  endif
>  
>  builtin_modules += gatt
> -builtin_sources += profiles/gatt/main.c profiles/gatt/manager.h \
> -			profiles/gatt/manager.c profiles/gatt/gas.h \
> -			profiles/gatt/gas.c
> +builtin_sources += profiles/gatt/gas.c

You seem to have forgotten to remove gas.h in this patch. You remove it
from Makefile.plugins but it's still in the tree and gas.c includes it.
You'll also want to make gas_register/unregister static together with
removing the header file.

Johan
