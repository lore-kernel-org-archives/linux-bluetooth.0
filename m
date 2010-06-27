Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Sun, 27 Jun 2010 03:50:07 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Cody Rester <codyrester@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: bluetooth: bluecard_cs.c: Fixed include
 error, changed to linux/io.h
Message-ID: <20100627065006.GA32318@vigoh>
References: <1277619142-10751-1-git-send-email-codyrester@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1277619142-10751-1-git-send-email-codyrester@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

* Cody Rester <codyrester@gmail.com> [2010-06-27 02:12:22 -0400]:

> Fixed include error, changed to linux/io.h
> 
> Signed-off-by: Cody Rester <codyrester@gmail.com>
> ---
>  drivers/bluetooth/bluecard_cs.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
> index d9bf87c..89a4455 100644
> --- a/drivers/bluetooth/bluecard_cs.c
> +++ b/drivers/bluetooth/bluecard_cs.c
> @@ -37,7 +37,7 @@
>  #include <linux/wait.h>
>  
>  #include <linux/skbuff.h>
> -#include <asm/io.h>
> +#include <linux/io.h>
>  
>  #include <pcmcia/cs_types.h>
>  #include <pcmcia/cs.h>
> -- 
> 1.7.0.4

Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

-- 
Gustavo F. Padovan
http://padovan.org
