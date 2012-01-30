Return-Path: <cyrus@holtmann.org>
Message-ID: <1327963360.1955.192.camel@aeonflux>
Subject: Re: [PATCH 3/8] Bluetooth: Add new structures for handling SMP Long
 Term Keys
From: Marcel Holtmann <marcel@holtmann.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 30 Jan 2012 14:42:40 -0800
In-Reply-To: <1327962558-25720-4-git-send-email-vinicius.gomes@openbossa.org>
References: <1327962558-25720-1-git-send-email-vinicius.gomes@openbossa.org>
	 <1327962558-25720-4-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

> This includes a new list for storing the keys and a new structure used
> to represent each key.
> 
> Some notes: authenticated is used to identify that the key may be used
> to setup a HIGH security link. As the same list is used to store both
> the STK's and the LTK's the type field is used so we can separate
> between those two types of keys and if the key should be used when
> in the master or slave role.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  include/net/bluetooth/hci.h      |    5 +++++
>  include/net/bluetooth/hci_core.h |   15 +++++++++++++++
>  net/bluetooth/hci_core.c         |   31 +++++++++++++++++++++++++++++++
>  3 files changed, 51 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index cb9097a..83f045a 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -274,6 +274,11 @@ enum {
>  #define HCI_LK_SMP_LTK			0x81
>  #define HCI_LK_SMP_IRK			0x82
>  #define HCI_LK_SMP_CSRK			0x83
> +/* The spec doesn't define types for SMP keys, the _MASTER suffix is implied */
> +#define HCI_SMP_STK			0x80
> +#define HCI_SMP_STK_SLAVE		0x81
> +#define HCI_SMP_LTK			0x82
> +#define HCI_SMP_LTK_SLAVE		0x83
>  
>  /* ---- HCI Error Codes ---- */
>  #define HCI_ERROR_AUTH_FAILURE		0x05
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 896d9e4..06eab3f 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -88,6 +88,18 @@ struct bt_uuid {
>  	u8 svc_hint;
>  };
>  
> +struct smp_ltk {
> +	struct list_head list;
> +	bdaddr_t bdaddr;
> +	u8 bdaddr_type;
> +	u8 authenticated;
> +	u8 type;
> +	u8 enc_size;
> +	__le16 ediv;
> +	u8 rand[8];
> +	u8 val[16];
> +} __packed;
> +
>  struct key_master_id {
>  	__le16 ediv;
>  	u8 rand[8];
> @@ -239,6 +251,8 @@ struct hci_dev {
>  
>  	struct list_head	link_keys;
>  
> +	struct list_head	ltks;
> +

I am fine with this as well, but just to discuss this, don't you think
calling this long_term_keys would be better? It makes it easier to read
and makes it similar to link_keys.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


