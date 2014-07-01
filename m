Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Jul 2014 13:36:27 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel Drake <drake@endlessm.com>
Cc: marcel@holtmann.org, gustavo@padovan.org,
	linux-bluetooth@vger.kernel.org, Larry.Finger@lwfinger.net
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek 8723/8761 support
Message-ID: <20140701103627.GC4781@t440s.lan>
References: <1404205896-25742-1-git-send-email-drake@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404205896-25742-1-git-send-email-drake@endlessm.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Tue, Jul 01, 2014, Daniel Drake wrote:
> +static int rtk_read_eversion(struct hci_dev *hdev)
> +{
> +	struct rtk_eversion_evt *eversion;
> +	struct sk_buff *skb;
> +
> +	/* Read RTK ROM version command */
> +	skb = __hci_cmd_sync(hdev, 0xfc6d, 0, NULL, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		BT_ERR("Read ROM version failed (%ld)", PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +
> +	if (skb->len != sizeof(*eversion)) {
> +		BT_ERR("RTK version event length mismatch");
> +		kfree_skb(skb);
> +		return -EIO;
> +	}
> +
> +	eversion = (struct rtk_eversion_evt *) skb->data;
> +	BT_DBG("eversion status=%x version=%x",
> +	       eversion->status, eversion->version);
> +	if (eversion->status)
> +		return 0;
> +	else
> +		return eversion->version;
> +}

Looks like you're leaking skb here.

> +static bool rtk_fw_upload_needed(struct hci_dev *hdev, enum rtk_variant variant)
> +{
> +	struct hci_rp_read_local_version *resp;
> +	u16 lmp_version = rtk_fw_info[variant].lmp_sub;
> +	struct sk_buff *skb;
> +
> +	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
> +			     HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		BT_ERR("rtk fw version read command failed (%ld)",
> +		       PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +
> +	if (skb->len != sizeof(*resp)) {
> +		BT_ERR("rtk version event length mismatch");
> +		kfree_skb(skb);
> +		return -EIO;
> +	}
> +
> +	resp = (struct hci_rp_read_local_version *) skb->data;
> +	if (resp->status) {
> +		BT_ERR("rtk fw version event failed (%02x)", resp->status);
> +		kfree_skb(skb);
> +		return bt_to_errno(resp->status);
> +	}
> +
> +	BT_DBG("rtk fw: lmp_subver=%x vs %x", resp->lmp_subver, lmp_version);
> +
> +	/* Firmware upload is only needed when the running version matches the
> +	 * one listed in the driver. If versions differ, we assume that no
> +	 * firmware update is necessary. */
> +	return resp->lmp_subver == lmp_version;
> +}

Same here.

Johan
