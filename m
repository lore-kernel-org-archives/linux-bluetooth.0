Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Arend Van Spriel" <arend@broadcom.com>
Subject: RE: [PATCH v2 4/5] Support the BCM4354 Bluetooth UART device
Date: Fri, 12 Jun 2015 16:26:57 +0000
Message-ID: <E0D3336E15B58B4294723AC879BA5E942615F8@IRVEXCHMB15.corp.ad.broadcom.com>
References: <1433966720-17482-1-git-send-email-ifaenson@broadcom.com>
 <1433966720-17482-5-git-send-email-ifaenson@broadcom.com>
 <C6CF4337-66BB-4DEB-93DA-B04A8ACA8B54@holtmann.org>
In-Reply-To: <C6CF4337-66BB-4DEB-93DA-B04A8ACA8B54@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]=20
Sent: Friday, June 12, 2015 4:47 AM
To: Ilya Faenson
Cc: linux-bluetooth@vger.kernel.org; Arend Van Spriel
Subject: Re: [PATCH v2 4/5] Support the BCM4354 Bluetooth UART device

Hi Ilya,

> The ability to run over the BCM4354 while we are awaiting
> the Bluetooth UART firmware map file introduction.
>=20
> Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
> ---
> drivers/bluetooth/btbcm.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 8e2f6b6..1849db2 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -243,6 +243,7 @@ static const struct {
> } bcm_uart_subver_table[] =3D {
> 	{ 0x410e, "BCM43341B0"	},	/* 002.001.014 */
> 	{ 0x4406, "BCM4324B3"	},	/* 002.004.006 */
> +	{ 0x610c, "BCM4354_003.001.012.0306.0659"}, /* 003.001.012 */

Please shorten this to BCM4354 here. I know what you are trying to do, but =
we fix that different way with a manifest file.

IF: Okay, will do.

Regards

Marcel
