Return-Path: <cyrus@holtmann.org>
From: "Poulain, Loic" <loic.poulain@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] Bluetooth: Ignore H5 non-link packets in non-active
 state
Date: Mon, 23 Jun 2014 14:47:07 +0000
Message-ID: <50C3158CF44D924791C15F1437EF2EC62438004B@HASMSX104.ger.corp.intel.com>
References: <1403528983-9314-1-git-send-email-loic.poulain@intel.com>,<9B6ECBFE-E31A-4C5B-9892-F383F180F350@holtmann.org>
In-Reply-To: <9B6ECBFE-E31A-4C5B-9892-F383F180F350@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Sorry, but I omitted to precise that this patch fixes a NULL pointer derefe=
rence.=0A=
Indeed, h5->rx_skb was freed in h5_reset_rx and dereferenced in the next =
=0A=
h5_rx_payload call. So I think it should go to stable tree.=0A=
=0A=
Regards,=0A=
Loic=0A=
________________________________________=0A=
From: linux-bluetooth-owner@vger.kernel.org [linux-bluetooth-owner@vger.ker=
nel.org] on behalf of Marcel Holtmann [marcel@holtmann.org]=0A=
Sent: Monday, June 23, 2014 3:35 PM=0A=
To: Poulain, Loic=0A=
Cc: Gustavo F. Padovan; Johan Hedberg; linux-bluetooth@vger.kernel.org=0A=
Subject: Re: [PATCH] Bluetooth: Ignore H5 non-link packets in non-active st=
ate=0A=
=0A=
Hi Loic,=0A=
=0A=
> Fix missing return in the non-link packet detection.=0A=
>=0A=
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>=0A=
> ---=0A=
> drivers/bluetooth/hci_h5.c | 1 +=0A=
> 1 file changed, 1 insertion(+)=0A=
=0A=
patch has been applied to bluetooth-next tree.=0A=
=0A=
Regards=0A=
=0A=
Marcel=0A=
=0A=
--=0A=
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" =
in=0A=
the body of a message to majordomo@vger.kernel.org=0A=
More majordomo info at  http://vger.kernel.org/majordomo-info.html=0A=
