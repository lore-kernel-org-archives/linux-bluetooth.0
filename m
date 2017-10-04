Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.6\))
Subject: Re: [PATCH BlueZ] gatt: Remove support of ATT over BR/EDR
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20171003122556.18437-1-luiz.dentz@gmail.com>
Date: Wed, 4 Oct 2017 21:03:32 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6905BCAA-E12E-4650-8D4B-823B0A63659E@holtmann.org>
References: <20171003122556.18437-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> ATT over BR/EDR requires bearer specific access types in order to pass
> tests such as:
> 
>  4.5.71 TP/GAR/CL/BI-34-C [Read Characteristic Value – Invalid Transport
>  Access over BR/EDR]
>  Verify Generic Attribute Profile client behavior when an attempt to use
>  BR/EDR transport to execute the Read Characteristic Value procedure on
>  a characteristic contained within a service defined for use only over
>  LE transport.
> 
> On top of that the CCC are considerer bearer specific so for each bearer
> supported we would have to maintain different storages:
> 
>  In the case where multiple ATT bearers from the same device are supported
>  by the GATT server, each ATT bearer shall be considered to have a separate
>  GATT client instance. Therefore each GATT client shall have a separate
>  Client Characteristic Configuration.
> ---
> src/gatt-database.c | 120 ----------------------------------------------------
> 1 file changed, 120 deletions(-)

I do not understand this patch. Why would we be removing support for GATT over BR/EDR?

Regards

Marcel

