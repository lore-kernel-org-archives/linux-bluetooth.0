Return-Path: <cyrus@holtmann.org>
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@intel.com, don.fry@intel.com, gustavo@padovan.org
Subject: Re: [PATCH v5] Bluetooth: Add support for Intel Bluetooth device [8087:07dc]
Date: Thu, 18 Apr 2013 18:44:24 -0700
Message-ID: <3182713.nDrtQtJ43E@tedd-ubuntu>
In-Reply-To: <1FD1A5F4-36D2-44E0-BBA8-BA5147C7322D@holtmann.org>
References: <1657315.CFhxFClec5@tedd-ubuntu> <1683721.rPzt6KZh0J@tedd-ubuntu> <1FD1A5F4-36D2-44E0-BBA8-BA5147C7322D@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel.

I updated the patch and sent the v6.

I will update the patch if Johan is going to change the __hci_cmd_sync to take the const array. I am sending v6 patch now in case this change is done later.

Regarding the hexdump for failed event, I will do it in the add on patch once it is in the tree.

Thanks.

Tedd

On Thursday, April 18, 2013 05:51:38 PM Marcel Holtmann wrote:
> Hi Tedd,
> 
> > I was able to update most of the code with your comments except a couple of things.
> > 
> > Please see below.
> > 
> > On Thursday, April 18, 2013 11:47:58 AM Marcel Holtmann wrote:
> >> Hi Tedd,
> >> 
> >>> +	/* If there is a command that loads a patch in the firmware
> >>> +	 * file, then enable the patch upon success, otherwise just
> >>> +	 * disable the manufacturer mode, for example patch activation
> >>> +	 * is not required when the default firmware patch file is used
> >>> +	 * because there are no patch data to load.
> >>> +	 */
> >>> +	if (*disable_patch && cmd->opcode == 0xfc8e)
> >>> +		*disable_patch = 0;
> >> 
> >> The opcodes are 16 bit. You need to swap between host endian and the endian that is in the file here. I assume the file is in little endian.
> >> 
> >>> +	cmd_param = *fw_ptr;
> >>> +	*fw_ptr += cmd->plen;
> >>> +	remain -= cmd->plen;
> >>> +
> >>> +	/* Read event */
> >>> +	while (remain > HCI_EVENT_HDR_SIZE && *fw_ptr[0] == 0x02) {
> >>> +		(*fw_ptr)++;
> >>> +		remain--;
> >>> +
> >>> +		evt = (struct hci_event_hdr *)(*fw_ptr);
> >>> +		*fw_ptr += sizeof(*evt);
> >>> +		remain -= sizeof(*evt);
> >>> +
> >>> +		if (remain < evt->plen) {
> >>> +			BT_ERR("%s Intel fw corrupted: invalid evt len",
> >>> +			       hdev->name);
> >>> +			return -EFAULT;
> >>> +		}
> >>> +
> >>> +		evt_param = *fw_ptr;
> >>> +		*fw_ptr += evt->plen;
> >>> +		remain -= evt->plen;
> >>> +	}
> >>> +
> >>> +	if (!evt || !evt_param || remain < 0) {
> >>> +		BT_ERR("%s Intel fw corrupted: invalid evt read", hdev->name);
> >>> +		return -EFAULT;
> >>> +	}
> >>> +
> >>> +	skb = __hci_cmd_sync_ev(hdev, le16_to_cpu(cmd->opcode),
> >>> +				cmd->plen, (void *)cmd_param, evt->evt,
> >>> +				HCI_INIT_TIMEOUT);
> >> 
> >> Here you do the swapping. So I propose that you fix it above with a constant version of the helper.
> > 
> > constant version means "__constant_le16_to_cpu"?
> 
> my bad that I was not clear. This one is of course correct since you don't have a constant for the cmd->opcode value. I meant the one occasion above where you missed the swapping. There you should use the __constant_le16_to_cpu function.
> 
> >>> +	if (IS_ERR(skb)) {
> >>> +		BT_ERR("%s sending Intel patch command failed (%ld)",
> >>> +		       hdev->name, PTR_ERR(skb));
> >>> +		return -PTR_ERR(skb);
> >>> +	}
> >>> +
> >>> +	/* Checking the returned event */
> >> 
> >> Please also be a bit more verbose here. You are checking first the length of the event matches and then also the content with what the firmware provides.
> >> 
> >>> +	if (skb->len != evt->plen) {
> >>> +		BT_ERR("%s mismatch event length", hdev->name);
> >>> +		kfree_skb(skb);
> >>> +		return -EFAULT;
> >>> +	}
> >>> +
> >>> +	if (memcmp(skb->data, evt_param, evt->plen)) {
> >>> +		BT_ERR("%s mismatch event parameter", hdev->name);
> >> 
> >> Personally I would print out the opcode in both cases. You want to know which command failed, right?
> >> 
> >> If you want to go the extra mile, you could also hexdump the whole command that failed with the event result. However that can be done in an add-on patch as well.
> >> 
> >>> +		kfree_skb(skb);
> >>> +		return -EFAULT;
> >>> +	}
> >>> +	kfree_skb(skb);
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int btusb_setup_intel(struct hci_dev *hdev)
> >>> +{
> >>> +	struct sk_buff *skb;
> >>> +	const struct firmware *fw;
> >>> +	const u8 *fw_ptr;
> >>> +	int disable_patch;
> >>> +	struct intel_version *ver;
> >>> +
> >>> +	u8 mfg_enable[] = { 0x01, 0x00 };
> >>> +	u8 mfg_disable[] = { 0x00, 0x00 };
> >>> +	u8 mfg_reset_deactivate[] = { 0x00, 0x01 };
> >>> +	u8 mfg_reset_activate[] = { 0x00, 0x02 };
> >> 
> >> Check if you can make these const.
> > 
> > If these becomes const, the compiler throws a warning at __hci_cmd_sync() below.
> 
> That is what I almost figured.
> 
> Johan, can you check if we can fix __hci_cmd_sync to take a const array.
> 
> Regards
> 
> Marcel
> 

-- 
Regards
Tedd Ho-Jeong An
Intel Corporation
