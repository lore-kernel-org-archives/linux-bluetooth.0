Return-Path: <cyrus@holtmann.org>
Message-ID: <1333457466.1870.281.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Fix packet type for ESCO Link
From: Marcel Holtmann <marcel@holtmann.org>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org,
	Naresh Gupta <naresh.gupta@stericsson.com>,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Date: Tue, 03 Apr 2012 05:51:06 -0700
In-Reply-To: <1333446416-8129-1-git-send-email-hemant.gupta@stericsson.com>
References: <1333446416-8129-1-git-send-email-hemant.gupta@stericsson.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

> This patch fixes the packet type for ESCO Link which was incorrectly
> set for EDR ESCO Packet Types.
> 
> Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
> ---
>  net/bluetooth/hci_conn.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 947172b..bff6bc1 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -396,7 +396,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
>  			conn->pkt_type = hdev->pkt_type & SCO_PTYPE_MASK;
>  		break;
>  	case ESCO_LINK:
> -		conn->pkt_type = hdev->esco_type & ~EDR_ESCO_MASK;
> +		conn->pkt_type = hdev->esco_type ^ ~EDR_ESCO_MASK;
>  		break;
>  	}
>  

please have a commit messages that actually describes the problem. I
honestly don't see what is broken and what you are trying to fix here.

Regards

Marcel


