Return-Path: <cyrus@holtmann.org>
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@intel.com, don.fry@intel.com, gustavo@padovan.org
Subject: Re: [PATCH v5] Bluetooth: Add support for Intel Bluetooth device [8087:07dc]
Date: Thu, 18 Apr 2013 16:06:13 -0700
Message-ID: <1683721.rPzt6KZh0J@tedd-ubuntu>
In-Reply-To: <7AA63F25-1E5A-4449-96F9-07E307C9F9C6@holtmann.org>
References: <1657315.CFhxFClec5@tedd-ubuntu> <7AA63F25-1E5A-4449-96F9-07E307C9F9C6@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Marcel.

I was able to update most of the code with your comments except a couple of things.

Please see below.

On Thursday, April 18, 2013 11:47:58 AM Marcel Holtmann wrote:
> Hi Tedd,
> 
> > +	/* If there is a command that loads a patch in the firmware
> > +	 * file, then enable the patch upon success, otherwise just
> > +	 * disable the manufacturer mode, for example patch activation
> > +	 * is not required when the default firmware patch file is used
> > +	 * because there are no patch data to load.
> > +	 */
> > +	if (*disable_patch && cmd->opcode == 0xfc8e)
> > +		*disable_patch = 0;
> 
> The opcodes are 16 bit. You need to swap between host endian and the endian that is in the file here. I assume the file is in little endian.
> 
> > +	cmd_param = *fw_ptr;
> > +	*fw_ptr += cmd->plen;
> > +	remain -= cmd->plen;
> > +
> > +	/* Read event */
> > +	while (remain > HCI_EVENT_HDR_SIZE && *fw_ptr[0] == 0x02) {
> > +		(*fw_ptr)++;
> > +		remain--;
> > +
> > +		evt = (struct hci_event_hdr *)(*fw_ptr);
> > +		*fw_ptr += sizeof(*evt);
> > +		remain -= sizeof(*evt);
> > +
> > +		if (remain < evt->plen) {
> > +			BT_ERR("%s Intel fw corrupted: invalid evt len",
> > +			       hdev->name);
> > +			return -EFAULT;
> > +		}
> > +
> > +		evt_param = *fw_ptr;
> > +		*fw_ptr += evt->plen;
> > +		remain -= evt->plen;
> > +	}
> > +
> > +	if (!evt || !evt_param || remain < 0) {
> > +		BT_ERR("%s Intel fw corrupted: invalid evt read", hdev->name);
> > +		return -EFAULT;
> > +	}
> > +
> > +	skb = __hci_cmd_sync_ev(hdev, le16_to_cpu(cmd->opcode),
> > +				cmd->plen, (void *)cmd_param, evt->evt,
> > +				HCI_INIT_TIMEOUT);
> 
> Here you do the swapping. So I propose that you fix it above with a constant version of the helper.

constant version means "__constant_le16_to_cpu"?

> 
> > +	if (IS_ERR(skb)) {
> > +		BT_ERR("%s sending Intel patch command failed (%ld)",
> > +		       hdev->name, PTR_ERR(skb));
> > +		return -PTR_ERR(skb);
> > +	}
> > +
> > +	/* Checking the returned event */
> 
> Please also be a bit more verbose here. You are checking first the length of the event matches and then also the content with what the firmware provides.
> 
> > +	if (skb->len != evt->plen) {
> > +		BT_ERR("%s mismatch event length", hdev->name);
> > +		kfree_skb(skb);
> > +		return -EFAULT;
> > +	}
> > +
> > +	if (memcmp(skb->data, evt_param, evt->plen)) {
> > +		BT_ERR("%s mismatch event parameter", hdev->name);
> 
> Personally I would print out the opcode in both cases. You want to know which command failed, right?
> 
> If you want to go the extra mile, you could also hexdump the whole command that failed with the event result. However that can be done in an add-on patch as well.
> 
> > +		kfree_skb(skb);
> > +		return -EFAULT;
> > +	}
> > +	kfree_skb(skb);
> > +
> > +	return 0;
> > +}
> > +
> > +static int btusb_setup_intel(struct hci_dev *hdev)
> > +{
> > +	struct sk_buff *skb;
> > +	const struct firmware *fw;
> > +	const u8 *fw_ptr;
> > +	int disable_patch;
> > +	struct intel_version *ver;
> > +
> > +	u8 mfg_enable[] = { 0x01, 0x00 };
> > +	u8 mfg_disable[] = { 0x00, 0x00 };
> > +	u8 mfg_reset_deactivate[] = { 0x00, 0x01 };
> > +	u8 mfg_reset_activate[] = { 0x00, 0x02 };
> 
> Check if you can make these const.

If these becomes const, the compiler throws a warning at __hci_cmd_sync() below.

> 
> > +
> > +	BT_DBG("%s", hdev->name);
> > +
> > +	/* The controller has a bug with the first HCI command sent to it
> > +	 * returning number of completed commands as zero. This would stall the
> > +	 * command processing in the Bluetooth core
> 
> Add a . at end of a paragraph.
> 
> > +	 *
> > +	 * As a workaround, send HCI Reset command first which will reset the
> > +	 * number of completed commands and allow normal command processing
> > +	 * from now on
> 
> Add a . at the end.
> 
> > +	 */
> 
> > +	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
> > +	if (IS_ERR(skb)) {
> > +		BT_ERR("%s sending initial HCI reset command failed (%ld)",
> > +		       hdev->name, PTR_ERR(skb));
> > +		return -PTR_ERR(skb);
> > +	}
> > +	kfree_skb(skb);
> > +
> > +	/* Read Intel specific controller version first to allow selection of
> > +	 * which firmware file to load.
> > +	 *
> > +	 * The returned information are hardware variant and revision plus
> > +	 * firmware variant, revision and build number.
> > +	 */
> 
> > +	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_INIT_TIMEOUT);
> > +	if (IS_ERR(skb)) {
> > +		BT_ERR("%s reading Intel fw version command failed (%ld)",
> > +		       hdev->name, PTR_ERR(skb));
> > +		return -PTR_ERR(skb);
> > +	}
> > +
> > +	if (skb->len != sizeof(*ver)) {
> > +		BT_ERR("%s Intel version event length mismatch", hdev->name);
> > +		kfree_skb(skb);
> > +		return -EIO;
> > +	}
> > +
> 
> Regards
> 
> Marcel
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Regards
Tedd Ho-Jeong An
Intel Corporation
