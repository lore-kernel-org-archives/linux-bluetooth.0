Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/5] Spec constants for Extended Inqiory Response field
 types
From: Marcel Holtmann <marcel@holtmann.org>
To: Inga Stotland <ingas@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
	johan.hedberg@gmail.com
In-Reply-To: <1279662974-16454-2-git-send-email-ingas@codeaurora.org>
References: <1279662974-16454-1-git-send-email-ingas@codeaurora.org>
	 <1279662974-16454-2-git-send-email-ingas@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 21 Jul 2010 01:43:59 -0700
Message-ID: <1279701839.3035.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

>  src/sdpd.h |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/src/sdpd.h b/src/sdpd.h
> index e93b0b6..7b0b3be 100644
> --- a/src/sdpd.h
> +++ b/src/sdpd.h
> @@ -34,6 +34,19 @@
>  #define SDPDBG(fmt...)
>  #endif
>  
> +#define EIR_DATA_LENGTH  240
> +
> +#define EIR_UUID16_SOME             0x02  /* 16-bit UUID, more available */
> +#define EIR_UUID16_ALL              0x03  /* 16-bit UUID, all listed */
> +#define EIR_UUID32_SOME             0x04  /* 32-bit UUID, more available */
> +#define EIR_UUID32_ALL              0x05  /* 32-bit UUID, all listed */
> +#define EIR_UUID128_SOME            0x06  /* 128-bit UUID, more available */
> +#define EIR_UUID128_ALL             0x07  /* 128-bit UUID, all listed */
> +#define EIR_NAME_SHORT              0x08  /* shortened local name */
> +#define EIR_NAME_COMPLETE           0x09  /* complete local name */
> +#define EIR_DEVICE_ID               0x10  /* device ID */
> +#define EIR_TX_POWER                0x0A  /* Transmit power level */
> +

I don't wanna be picky, but 0x0A comes before 0x10 actually.

Regards

Marcel


