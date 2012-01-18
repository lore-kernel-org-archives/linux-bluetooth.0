Return-Path: <cyrus@holtmann.org>
Message-ID: <1326913969.6454.405.camel@aeonflux>
Subject: Re: [PATCH 09/15] Bluetooth: Merge boolean members of struct
 hci_conn into flags
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 18 Jan 2012 20:12:49 +0100
In-Reply-To: <1326912717-6347-10-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
	 <1326912717-6347-10-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Now that the flags member of struct hci_conn is supposed to accommodate
> any boolean type values we can easily merge all boolean members into it.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    6 +++---
>  net/bluetooth/hci_conn.c         |   15 +++++++++------
>  net/bluetooth/hci_event.c        |   21 +++++++++++++--------
>  3 files changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index c8ae176..5f6cb35 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -286,7 +286,6 @@ struct hci_conn {
>  	__u8		attempt;
>  	__u8		dev_class[3];
>  	__u8		features[8];
> -	__u8		ssp_mode;
>  	__u16		interval;
>  	__u16		pkt_type;
>  	__u16		link_policy;
> @@ -298,12 +297,10 @@ struct hci_conn {
>  	__u8		pin_length;
>  	__u8		enc_key_size;
>  	__u8		io_capability;
> -	__u8		power_save;
>  	__u16		disc_timeout;
>  	unsigned long	flags;
>  
>  	__u8		remote_cap;
> -	__u8		remote_oob;
>  	__u8		remote_auth;
>  
>  	unsigned int	sent;
> @@ -409,6 +406,9 @@ enum {
>  	HCI_CONN_MODE_CHANGE_PEND,
>  	HCI_CONN_SCO_SETUP_PEND,
>  	HCI_CONN_LE_SMP_PEND,
> +	HCI_CONN_SSP_SUPPORT,

didn't we agree on naming this SSP_ENABLED?

> +	HCI_CONN_POWER_SAVE,
> +	HCI_CONN_REMOTE_OOB,
>  };

Regards

Marcel


