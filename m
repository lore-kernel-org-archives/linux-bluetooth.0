Return-Path: <cyrus@holtmann.org>
Message-ID: <1328959677.28848.44.camel@aeonflux>
Subject: Re: [RFC BlueZ 02/22] lib: Add functions to storing values in
 unaligned places
From: Marcel Holtmann <marcel@holtmann.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 11 Feb 2012 12:27:57 +0100
In-Reply-To: <1328910007-25604-3-git-send-email-vinicius.gomes@openbossa.org>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
	 <1328910007-25604-3-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

>  lib/bluetooth.h |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 60 insertions(+), 0 deletions(-)
> 
> diff --git a/lib/bluetooth.h b/lib/bluetooth.h
> index e9ced19..ba241a1 100644
> --- a/lib/bluetooth.h
> +++ b/lib/bluetooth.h
> @@ -172,60 +172,120 @@ static inline uint64_t bt_get_le64(void *ptr)
>  	return bt_get_unaligned((uint64_t *) ptr);
>  }
>  
> +static inline void bt_put_le64(uint64_t val, void *ptr)
> +{
> +	bt_put_unaligned(val, (uint64_t *) ptr);
> +}
> +

and how does this work on a big endian machine?

Regards

Marcel


