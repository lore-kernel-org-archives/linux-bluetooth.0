Return-Path: <cyrus@holtmann.org>
From: "Mohanan, Rajmohan" <rajmohan.mohanan@intel.com>
To: Johan Hedberg <johan.hedberg@gmail.com>, David Herrmann
	<dh.herrmann@googlemail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"padovan@profusion.mobi" <padovan@profusion.mobi>, "marcel@holtmann.org"
	<marcel@holtmann.org>
Subject: RE: [RESEND PATCH] Bluetooth: btusb: Remove device lock on release
Date: Fri, 10 Feb 2012 05:12:47 +0000
Message-ID: <E74476E55D15D942BA0FF3CDAD73606F040719@FMSMSX102.amr.corp.intel.com>
References: <1328821115-12514-1-git-send-email-dh.herrmann@googlemail.com>
 <1328821115-12514-2-git-send-email-dh.herrmann@googlemail.com>
 <20120209212501.GB453@x220.P-661HNU-F1>
In-Reply-To: <20120209212501.GB453@x220.P-661HNU-F1>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Test mail

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@v=
ger.kernel.org] On Behalf Of Johan Hedberg
Sent: Friday, February 10, 2012 2:55 AM
To: David Herrmann
Cc: linux-bluetooth@vger.kernel.org; padovan@profusion.mobi; marcel@holtman=
n.org
Subject: Re: [RESEND PATCH] Bluetooth: btusb: Remove device lock on release

Hi David,

On Thu, Feb 09, 2012, David Herrmann wrote:
> Recently we changed the way how we release driver-data. A driver is now
> responsible of destroying the data so we no longer need the device lock
> on deinitialization in btusb driver.
>=20
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
> Acked in: Message-ID: <1327960875.1955.183.camel@aeonflux>
>=20
>  drivers/bluetooth/btusb.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)

Applied to my bluetooth-next tree. Thanks.

Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
