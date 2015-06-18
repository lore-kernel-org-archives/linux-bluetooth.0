Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>, Frederic Danis
	<frederic.danis@linux.intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] Bluetooth: hci_uart: Fix speed selection
Date: Thu, 18 Jun 2015 12:14:19 +0000
Message-ID: <E0D3336E15B58B4294723AC879BA5E942639B8@IRVEXCHMB15.corp.ad.broadcom.com>
References: <1434624207-393-1-git-send-email-frederic.danis@linux.intel.com>
 <EB2E54C5-9A7F-4067-8C35-C4399FB45B40@holtmann.org>
In-Reply-To: <EB2E54C5-9A7F-4067-8C35-C4399FB45B40@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel and Fred,

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@v=
ger.kernel.org] On Behalf Of Marcel Holtmann
Sent: Thursday, June 18, 2015 7:49 AM
To: Frederic Danis
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_uart: Fix speed selection

Hi Fred,

> hu->proto->*speed will always be used for all device where it is set.
> But hu->*speed should be used if exist, so the test should be swapped.
>=20
> The equivalent change is needed in bcm_setup() of hci_bcm.c.
>=20
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> drivers/bluetooth/hci_bcm.c   | 29 +++++++++++++++++++++++------
> drivers/bluetooth/hci_ldisc.c | 12 ++++++------
> 2 files changed, 29 insertions(+), 12 deletions(-)

patch has been applied to bluetooth-next tree.

IF: I've just checked the latest hci_ldisc.c speed selection logic against =
what I submitted yesterday. They are functionally the same so you have my b=
lessing if you need it. :-) Still, having speed configuration in two places=
 is obviously an invitation to some confusion.

Regards

Marcel

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
