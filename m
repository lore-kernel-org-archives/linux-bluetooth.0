Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 4/4] bluetooth: Add HCI_QUIRK_INVALID_BDADDR for
 BCM43430A0
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170708161228.24324-4-ian@mnementh.co.uk>
Date: Sat, 8 Jul 2017 19:40:49 +0200
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        sebastian.reichel@collabora.co.uk, ohad@bencohen.org
Message-Id: <F521381C-C901-483E-B84D-0E297A45222C@holtmann.org>
References: <20170708161228.24324-1-ian@mnementh.co.uk>
 <20170708161228.24324-4-ian@mnementh.co.uk>
To: Ian Molton <ian@mnementh.co.uk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ian,

> This patch adds the default BDADDR for Broadcom BCM43430A0
> Bluetooth devices.
> ---
> drivers/bluetooth/btbcm.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 9ab6cfbb831d..28eac429a2ab 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -35,6 +35,7 @@
> #define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00}})
> #define BDADDR_BCM4324B3 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb3, 0x24, 0x43}})
> #define BDADDR_BCM4330B1 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb1, 0x30, 0x43}})
> +#define BDADDR_BCM43430A0 (&(bdaddr_t) {{0xf8, 0x1a, 0x08, 0xca, 0x25, 0x00}})

isn’t this a valid address? I do not see the point here. At least to me this is not one of the Broadcom default addresses that you get when no EEPROM address is configured.

Regards

Marcel

