Return-Path: <cyrus@holtmann.org>
Date: Mon, 29 Nov 2010 17:02:00 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Removed unused define
Message-ID: <20101129150200.GA19157@jh-x301>
References: <1291037054-22247-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291037054-22247-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Mon, Nov 29, 2010, Claudio Takahasi wrote:
> ---
>  src/device.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/src/device.c b/src/device.c
> index 77353a4..65acc08 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -57,7 +57,6 @@
>  #include "storage.h"
>  #include "btio.h"
>  
> -#define DEFAULT_XML_BUF_SIZE	1024
>  #define DISCONNECT_TIMER	2
>  #define DISCOVERY_TIMER		2

Pushed upstream. Thanks.

Johan
