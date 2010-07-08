Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/3] Support for adding UUID128 to extended inquiry
 response
From: Marcel Holtmann <marcel@holtmann.org>
To: Inga Stotland <ingas@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
	rshaffer@codeaurora.org
In-Reply-To: <1278540518-18620-2-git-send-email-ingas@codeaurora.org>
References: <1278540518-18620-1-git-send-email-ingas@codeaurora.org>
	 <1278540518-18620-2-git-send-email-ingas@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Jul 2010 14:17:32 -0300
Message-ID: <1278609452.10421.31.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

>  void register_public_browse_group(void)
> diff --git a/src/sdpd.h b/src/sdpd.h
> index e93b0b6..8fd8bbe 100644
> --- a/src/sdpd.h
> +++ b/src/sdpd.h
> @@ -6,6 +6,7 @@
>   *  Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
>   *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
>   *  Copyright (C) 2002-2003  Stephen Crane <steve.crane@rococosoft.com>
> + *  Copyright (C) 2010, Code Aurora Forum. All rights reserved.

I prefer that we actually see major code contributions that justify a
copyright here before you start adding it. And so let the maintainers
worry about that later on. I don't wanna see just random copyright
additions for obvious fixes or changes that are most likely even derived
from existing code.
 
> +#define EIR_DATA_LENGTH  240
> +
> +#define EIR_UUID16_SOME             0x02  /* 16-bit UUID, more available */
> +#define EIR_UUID16_ALL              0x03  /* 16-bit UUID, all listed */
> +#define EIR_UUID128_SOME            0x06  /* 128-bit UUID, more available */
> +#define EIR_UUID128_ALL             0x07  /* 128-bit UUID, all listed */
> +#define EIR_NAME_SHORT              0x08  /* shortened local name */
> +#define EIR_NAME_COMPLETE           0x09  /* complete local name */
> +#define EIR_DEVICE_ID               0x10  /* device ID */
> +#define EIR_TX_POWER                0x0A  /* Transmit power level */
> +

If you wanna do this, then this is a separate patch up-front. Don't
intermix this with adding support for UUID-128 entries. I want proper
splits here.

Regards

Marcel


