Return-Path: <cyrus@holtmann.org>
Message-ID: <4EB86A27.1030403@codeaurora.org>
Date: Mon, 07 Nov 2011 15:30:47 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: johan.hedberg@gmail.com
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Add address type fields to mgmt messages
 that need them
References: <1320700419-4665-1-git-send-email-johan.hedberg@gmail.com> <1320700419-4665-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1320700419-4665-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 11/7/2011 1:13 PM, johan.hedberg@gmail.com wrote:
> From: Johan Hedberg<johan.hedberg@intel.com>
>
> This patch adds address type info (typically BR/EDR vs LE) to management
> messages that need this. This also ensures conformance to the latest
> management API specification.
>
> Signed-off-by: Johan Hedberg<johan.hedberg@intel.com>
> ---
>   include/net/bluetooth/hci_core.h |   10 ++++----
>   include/net/bluetooth/mgmt.h     |   23 ++++++++++--------
>   net/bluetooth/hci_event.c        |   20 +++++++++-------
>   net/bluetooth/mgmt.c             |   47 ++++++++++++++++++++++++++++---------
>   4 files changed, 64 insertions(+), 36 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 4ebc882..e6071d0 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -912,10 +912,10 @@ int mgmt_discoverable(u16 index, u8 discoverable);
>   int mgmt_connectable(u16 index, u8 connectable);
>   int mgmt_write_scan_failed(u16 index, u8 scan, u8 status);
>   int mgmt_new_link_key(u16 index, struct link_key *key, u8 persistent);
> -int mgmt_connected(u16 index, bdaddr_t *bdaddr, u8 link_type);
> -int mgmt_disconnected(u16 index, bdaddr_t *bdaddr);
> +int mgmt_connected(u16 index, bdaddr_t *bdaddr, u8 type);
> +int mgmt_disconnected(u16 index, bdaddr_t *bdaddr, u8 type);
>   int mgmt_disconnect_failed(u16 index);
> -int mgmt_connect_failed(u16 index, bdaddr_t *bdaddr, u8 status);
> +int mgmt_connect_failed(u16 index, bdaddr_t *bdaddr, u8 type, u8 status);
>   int mgmt_pin_code_request(u16 index, bdaddr_t *bdaddr, u8 secure);
>   int mgmt_pin_code_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status);
>   int mgmt_pin_code_neg_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status);
> @@ -928,8 +928,8 @@ int mgmt_auth_failed(u16 index, bdaddr_t *bdaddr, u8 status);
>   int mgmt_set_local_name_complete(u16 index, u8 *name, u8 status);
>   int mgmt_read_local_oob_data_reply_complete(u16 index, u8 *hash, u8 *randomizer,
>   								u8 status);
> -int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 *dev_class, s8 rssi,
> -								u8 *eir);
> +int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 type, u8 *dev_class,
> +							s8 rssi, u8 *eir);
>   int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name);
>   int mgmt_inquiry_failed(u16 index, u8 status);
>   int mgmt_discovering(u16 index, u8 discovering);
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index fa33bc6..3e320c9 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -128,10 +128,20 @@ struct mgmt_rp_disconnect {
>   	bdaddr_t bdaddr;
>   } __packed;
>
> +#define MGMT_ADDR_BREDR			0x00
> +#define MGMT_ADDR_LE			0x01
> +#define MGMT_ADDR_BREDR_LE		0x02
> +#define MGMT_ADDR_INVALID		0xff

What would you think about overloading this Address type with the 
Public/Random flag?

We are already seeing devices in the marketplace with Random Addresses, 
effectively giving LE addresses 7 significant octets of address 
information, rather than the standard 6 octet "MAC" addresses.


> +
> +struct mgmt_addr_info {
> +	bdaddr_t bdaddr;
> +	__u8 type;

I would also support adding an additional octet here, which would be 
essentially the "Address Type" as used in the HCI LE Connect Command, 
and in the SMP LE Pairing protocol.

I have stated elsewhere, that I think this to be crucial information to 
store with Long Term KEYs (LTKs) as well as future LE Signing keys, and 
in future Address Resolution solutions. The earlier we get this bit of 
information into the MGMT interface, the better IMO.

> [....]


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
