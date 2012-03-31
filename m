Return-Path: <cyrus@holtmann.org>
Message-ID: <1333168753.1870.261.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Remove MGMT_ADDR_INVALID macro
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 31 Mar 2012 06:39:13 +0200
In-Reply-To: <1333148706-11008-1-git-send-email-andre.guedes@openbossa.org>
References: <1333148706-11008-1-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch removes the MGMT_ADDR_INVALID macro. If the address type
> isn't LE, we consider it is BR/EDR type.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    1 -
>  net/bluetooth/mgmt.c             |   19 +++++--------------
>  2 files changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index c8d5beb..c0b232c 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -967,7 +967,6 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
>  #define MGMT_ADDR_BREDR			0x00
>  #define MGMT_ADDR_LE_PUBLIC		0x01
>  #define MGMT_ADDR_LE_RANDOM		0x02
> -#define MGMT_ADDR_INVALID		0xff
>  
>  #define DISCOV_TYPE_BREDR		(BIT(MGMT_ADDR_BREDR))
>  #define DISCOV_TYPE_LE			(BIT(MGMT_ADDR_LE_PUBLIC) | \
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index b4f7e32..c13ea5f 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1635,20 +1635,13 @@ failed:
>  
>  static u8 link_to_mgmt(u8 link_type, u8 addr_type)
>  {
> -	switch (link_type) {
> -	case LE_LINK:
> -		switch (addr_type) {
> -		case ADDR_LE_DEV_PUBLIC:
> -			return MGMT_ADDR_LE_PUBLIC;
> -		case ADDR_LE_DEV_RANDOM:
> +	if (link_type == LE_LINK) {
> +		if (addr_type == ADDR_LE_DEV_RANDOM)
>  			return MGMT_ADDR_LE_RANDOM;
> -		default:
> -			return MGMT_ADDR_INVALID;
> -		}
> -	case ACL_LINK:
> +		else
> +			return MGMT_ADDR_LE_PUBLIC;
> +	} else {
>  		return MGMT_ADDR_BREDR;
> -	default:
> -		return MGMT_ADDR_INVALID;
>  	}
>  }
>  

and what is the reason to remove the nice switch statement here? I
prefer a default label with a nice comment that we fallback to BR/EDR.

Regards

Marcel


