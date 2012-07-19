Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Jul 2012 11:45:32 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [RFC v1] Bluetooth: mgmt: Add device disconnect reason
Message-ID: <20120719144532.GD5141@joana>
References: <1342679661-2444-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342679661-2444-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

* Mikel Astiz <mikel.astiz.oss@gmail.com> [2012-07-19 08:34:21 +0200]:

> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> 
> MGMT_EV_DEVICE_DISCONNECTED will now expose the disconnection reason to
> userland, providing the following possible values:
> 
> 	0x00	Reason unspecified
> 	0x01	Connection timeout
> 
> Signed-off-by: Mikel Astiz <mikel.astiz@bmw-carit.de>
> ---
> This second proposal replaces the original HCI disconnect reason with a new enum type, to be used in the management socket. Currently just "Connection timeout" is being distinguished.
> 
> During the BlueZ meeting in Brazil it was proposed to add two more values to this enum: "Connection terminated by local host" and "Connection terminated by remote host". However, after some testing, it seems the result can be quite misleading. Therefore and given that there are no known use-cases that need this information (local vs remote disconnection), these two values have been dropped.
> 
> Useland patches to be used for testing will be submitted soon.
> 
>  include/net/bluetooth/hci.h      |    1 +
>  include/net/bluetooth/hci_core.h |    2 +-
>  include/net/bluetooth/mgmt.h     |    4 ++++
>  net/bluetooth/hci_event.c        |   12 ++++++++++--
>  net/bluetooth/mgmt.c             |    9 +++++----
>  5 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index ccd723e..9fed9d4 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -293,6 +293,7 @@ enum {
>  
>  /* ---- HCI Error Codes ---- */
>  #define HCI_ERROR_AUTH_FAILURE		0x05
> +#define HCI_ERROR_CONNECTION_TIMEOUT	0x08
>  #define HCI_ERROR_REJ_BAD_ADDR		0x0f
>  #define HCI_ERROR_REMOTE_USER_TERM	0x13
>  #define HCI_ERROR_LOCAL_HOST_TERM	0x16
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 475b8c0..5a35912 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1012,7 +1012,7 @@ int mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>  			  u8 addr_type, u32 flags, u8 *name, u8 name_len,
>  			  u8 *dev_class);
>  int mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
> -			     u8 link_type, u8 addr_type);
> +			     u8 link_type, u8 addr_type, u8 reason);
>  int mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
>  			   u8 link_type, u8 addr_type, u8 status);
>  int mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 4348ee8..30c06d1 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -406,6 +406,10 @@ struct mgmt_ev_device_connected {
>  } __packed;
>  
>  #define MGMT_EV_DEVICE_DISCONNECTED	0x000C
> +struct mgmt_ev_device_disconnected {
> +	struct mgmt_addr_info addr;
> +	__u8	reason;
> +} __packed;
>  
>  #define MGMT_EV_CONNECT_FAILED		0x000D
>  struct mgmt_ev_connect_failed {
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 41ff978..f53dbd2 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1909,9 +1909,17 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  		if (ev->status != 0)
>  			mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
>  					       conn->dst_type, ev->status);
> -		else
> +		else {
> +			u8 reason;
> +
> +			if (ev->reason ==  HCI_ERROR_CONNECTION_TIMEOUT)

There is a extra space after ==

> +				reason = 0x01;
> +			else
> +				reason = 0x00;

I would prefer if you set reason to 0x00 in the beginning of the else, the
just change it here if the reason was a timeout. No need for this else.

	Gustavo
