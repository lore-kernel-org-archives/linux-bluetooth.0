Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH v2 03/11] Bluetooth: Split HCI init sequence into three stages
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1362472150-30965-4-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 5 Mar 2013 09:01:55 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BCAA5170-33A1-48D7-A8FD-F670A12E8252@holtmann.org>
References: <1362472150-30965-1-git-send-email-johan.hedberg@gmail.com> <1362472150-30965-4-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Having conditional command sending during a request has always been
> problematic and caused hacks like the hdev->init_last_cmd variable. This
> patch removes these conditionals and instead splits the init sequence
> into three stages, each with its own __hci_req_sync() call.
> 
> This also paves the way to the upcoming asynchronous request support
> swhich will also benefit by having a simpler implementation if it
> doesn't need to cater for requests that change on the fly.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c  |  274 ++++++++++++++++++++++++++++++++++++++++++++-
> net/bluetooth/hci_event.c |  255 +----------------------------------------
> 2 files changed, 274 insertions(+), 255 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index cd4e5cd..e5ee219 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -193,6 +193,9 @@ static void bredr_init(struct hci_dev *hdev)
> 
> 	/* Read Local Version */
> 	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL);
> +
> +	/* Read BD Address */
> +	hci_send_cmd(hdev, HCI_OP_READ_BD_ADDR, 0, NULL);
> }
> 
> static void amp_init(struct hci_dev *hdev)
> @@ -209,7 +212,7 @@ static void amp_init(struct hci_dev *hdev)
> 	hci_send_cmd(hdev, HCI_OP_READ_DATA_BLOCK_SIZE, 0, NULL);
> }
> 
> -static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
> +static void hci_init1_req(struct hci_dev *hdev, unsigned long opt)
> {
> 	struct sk_buff *skb;
> 
> @@ -246,6 +249,273 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
> 	}
> }
> 
> +static void bredr_setup(struct hci_dev *hdev)
> +{
> +	struct hci_cp_delete_stored_link_key cp;
> +	__le16 param;
> +	__u8 flt_type;
> +
> +	/* Read Buffer Size (ACL mtu, max pkt, etc.) */
> +	hci_send_cmd(hdev, HCI_OP_READ_BUFFER_SIZE, 0, NULL);
> +
> +	/* Read Class of Device */
> +	hci_send_cmd(hdev, HCI_OP_READ_CLASS_OF_DEV, 0, NULL);
> +
> +	/* Read Local Name */
> +	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_NAME, 0, NULL);
> +
> +	/* Read Voice Setting */
> +	hci_send_cmd(hdev, HCI_OP_READ_VOICE_SETTING, 0, NULL);
> +
> +	/* Clear Event Filters */
> +	flt_type = HCI_FLT_CLEAR_ALL;
> +	hci_send_cmd(hdev, HCI_OP_SET_EVENT_FLT, 1, &flt_type);
> +
> +	/* Connection accept timeout ~20 secs */
> +	param = __constant_cpu_to_le16(0x7d00);
> +	hci_send_cmd(hdev, HCI_OP_WRITE_CA_TIMEOUT, 2, &param);
> +
> +	bacpy(&cp.bdaddr, BDADDR_ANY);
> +	cp.delete_all = 1;
> +	hci_send_cmd(hdev, HCI_OP_DELETE_STORED_LINK_KEY, sizeof(cp), &cp);
> +}

I know this is not your fault, but please while at it, use 0x01 for all of the values that go directly onto the wire.

Regards

Marcel

