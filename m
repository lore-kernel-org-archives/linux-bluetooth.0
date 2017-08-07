Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] bluecard_cs: Always enable LEDs (fix for Anycom
 CF-300)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170805193445.16411-1-linux@rainbow-software.org>
Date: Mon, 7 Aug 2017 08:37:30 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D0F7A0AA-5469-4654-A9E7-529362D90DE1@holtmann.org>
References: <20170805193445.16411-1-linux@rainbow-software.org>
To: Ondrej Zary <linux@rainbow-software.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ondrej,

> Anycom CF-300 (HP C8249A) has both power and activity LEDs.
> However the id read in bluecard_open() is 0x73 so the driver does not
> enable the LEDs.
> Remove the CARD_HAS_PCCARD_ID check to enable LEDs.
> 
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
> ---
> drivers/bluetooth/bluecard_cs.c | 24 ++++++------------------
> 1 file changed, 6 insertions(+), 18 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

