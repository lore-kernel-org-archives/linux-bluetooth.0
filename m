Return-Path: <cyrus@holtmann.org>
Message-ID: <1346943469.21200.112.camel@aeonflux>
Subject: Re: [PATCH v2] Bluetooth: mgmt: Implement support for passkey
 notification
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 06 Sep 2012 07:57:49 -0700
In-Reply-To: <1346918998-8642-1-git-send-email-johan.hedberg@gmail.com>
References: <1346832850-25061-1-git-send-email-johan.hedberg@gmail.com>
	 <1346918998-8642-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds support for Secure Simple Pairing with devices that have
> KeyboardOnly as their IO capability. Such devices will cause a passkey
> notification on our side and optionally also keypress notifications.
> Without this patch some keyboards cannot be paired using the mgmt
> interface.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v2: Make the keypress switch statement consistent with the rest of the code
> 
>  include/net/bluetooth/hci.h      |   18 ++++++++++
>  include/net/bluetooth/hci_core.h |    5 +++
>  include/net/bluetooth/mgmt.h     |    7 ++++
>  net/bluetooth/hci_event.c        |   67 ++++++++++++++++++++++++++++++++++++++
>  net/bluetooth/mgmt.c             |   16 +++++++++
>  5 files changed, 113 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 0f28f70..76b2b6b 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1249,6 +1249,24 @@ struct hci_ev_simple_pair_complete {
>  	bdaddr_t bdaddr;
>  } __packed;
>  
> +#define HCI_EV_USER_PASSKEY_NOTIFY	0x3b
> +struct hci_ev_user_passkey_notify {
> +	bdaddr_t	bdaddr;
> +	__le32		passkey;
> +} __packed;
> +
> +#define HCI_KEYPRESS_STARTED		0
> +#define HCI_KEYPRESS_ENTERED		1
> +#define HCI_KEYPRESS_ERASED		2
> +#define HCI_KEYPRESS_CLEARED		3
> +#define HCI_KEYPRESS_COMPLETED		4
> +
> +#define HCI_EV_KEYPRESS_NOTIFY		0x3c
> +struct hci_ev_keypress_notify {
> +	bdaddr_t	bdaddr;
> +	__u8		type;
> +} __packed;
> +
>  #define HCI_EV_REMOTE_HOST_FEATURES	0x3d
>  struct hci_ev_remote_host_features {
>  	bdaddr_t bdaddr;
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index fa807a3..b998b9c 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -303,6 +303,8 @@ struct hci_conn {
>  	__u8		pin_length;
>  	__u8		enc_key_size;
>  	__u8		io_capability;
> +	__u32		passkey_notify;
> +	__u8		passkey_entered;
>  	__u16		disc_timeout;
>  	unsigned long	flags;
>  
> @@ -1016,6 +1018,9 @@ int mgmt_user_passkey_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
>  				     u8 link_type, u8 addr_type, u8 status);
>  int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
>  					 u8 link_type, u8 addr_type, u8 status);
> +int mgmt_user_passkey_notify(struct hci_dev *hdev, bdaddr_t *bdaddr,
> +			     u8 link_type, u8 addr_type, u32 passkey,
> +			     u8 entered);
>  int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>  		     u8 addr_type, u8 status);
>  int mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status);
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 1b48eff..22980a7 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -478,3 +478,10 @@ struct mgmt_ev_device_unblocked {
>  struct mgmt_ev_device_unpaired {
>  	struct mgmt_addr_info addr;
>  } __packed;
> +
> +#define MGMT_EV_PASSKEY_NOTIFY		0x0017
> +struct mgmt_ev_passkey_notify {
> +	struct mgmt_addr_info addr;
> +	__le32	passkey;
> +	__u8	entered;
> +} __packed;

you need to add this to mgmt_events[] as well.

And we need an extra follow on patch that increases the API revision.
However only one of the revision increases per kernel release please.

Otherwise this looks fine to me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


