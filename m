Return-Path: <cyrus@holtmann.org>
Message-ID: <4A795CEB.1000808@gmail.com>
Date: Wed, 05 Aug 2009 12:20:27 +0200
From: Karl Beldan <karl.beldan@gmail.com>
MIME-Version: 1.0
To: marcel@holtmann.org
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix typo in stats for hci_uart
References: <4A6F2A12.8020201@gmail.com>
In-Reply-To: <4A6F2A12.8020201@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Are you considering applying this trivial one ?


Karl Beldan wrote:
> s/stat.cmd_tx++/stat.sco_tx++ for HCI_SCODATA_PKT
> 
> Signed-off-by: Karl Beldan <karl.beldan@mobile-devices.fr>
> ---
>  drivers/bluetooth/hci_ldisc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index 4895f0e..a08b207 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -101,7 +101,7 @@ static inline void hci_uart_tx_complete(struct hci_uart *hu, int pkt_type)
>  		break;
>  
>  	case HCI_SCODATA_PKT:
> -		hdev->stat.cmd_tx++;
> +		hdev->stat.sco_tx++;
>  		break;
>  	}
>  }
> 
