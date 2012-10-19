Return-Path: <cyrus@holtmann.org>
Message-ID: <1350667223.1785.2.camel@aeonflux>
Subject: Re: [PATCH 2/6] Bluetooth: Fix LE MTU reporting for HCIGETDEVINFO
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 19 Oct 2012 10:20:23 -0700
In-Reply-To: <1350666911-6334-3-git-send-email-johan.hedberg@gmail.com>
References: <1350666911-6334-1-git-send-email-johan.hedberg@gmail.com>
	 <1350666911-6334-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch fixes the use of le_mtu and le_pkts values in the
> HCIGETDEVINFO ioctl for LE-only controllers.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_core.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 23359ef..b5a2be2 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1025,8 +1025,13 @@ int hci_get_dev_info(void __user *arg)
>  	di.type     = (hdev->bus & 0x0f) | (hdev->dev_type << 4);
>  	di.flags    = hdev->flags;
>  	di.pkt_type = hdev->pkt_type;
> -	di.acl_mtu  = hdev->acl_mtu;
> -	di.acl_pkts = hdev->acl_pkts;
> +	if (lmp_bredr_capable(hdev)) {
> +		di.acl_mtu  = hdev->acl_mtu;
> +		di.acl_pkts = hdev->acl_pkts;
> +	} else {
> +		di.acl_mtu  = hdev->le_mtu;
> +		di.acl_pkts = hdev->le_pkts;
> +	}
>  	di.sco_mtu  = hdev->sco_mtu;
>  	di.sco_pkts = hdev->sco_pkts;
>  	di.link_policy = hdev->link_policy;

shouldn't we ensure that di.sco_mtu and di.sco_pkts is set to 0 for LE
only devices. I rather make this explicit here instead of relying that
it is zeroed at controller creation. In theory there still is a code
path that might set these.

Regards

Marcel


