Return-Path: <cyrus@holtmann.org>
Date: Sat, 19 Oct 2013 16:34:12 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Add support for setting SSP debug mode
Message-ID: <20131019133412.GG11607@x220.p-661hnu-f1>
References: <1382174000-18946-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382174000-18946-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Oct 19, 2013, Marcel Holtmann wrote:
> +static int ssp_debug_mode_set(void *data, u64 val)
> +{
> +	struct hci_dev *hdev = data;
> +	struct sk_buff *skb;
> +	__u8 mode;
> +
> +	if (val != 0 && val != 1)
> +		return -EINVAL;
> +
> +	if (!test_bit(HCI_UP, &hdev->flags))
> +		return -ENETDOWN;
> +
> +	hci_req_lock(hdev);
> +	mode = val;
> +	skb = __hci_cmd_sync(hdev, HCI_OP_WRITE_SSP_DEBUG_MODE, sizeof(mode),
> +			     &mode, HCI_CMD_TIMEOUT);
> +	hci_req_unlock(hdev);
> +
> +	if (IS_ERR(skb))
> +		return PTR_ERR(skb);
> +
> +	if (skb->data[0]) {
> +		u8 status = skb->data[0];
> +		kfree_skb(skb);
> +		return -bt_to_errno(status);
> +	}
> +
> +	hci_dev_lock(hdev);
> +	hdev->ssp_debug_mode = val;
> +	hci_dev_unlock(hdev);
> +
> +	return 0;
> +}

Looks like skb is being leaked here if the HCI command succeeds.

Johan
