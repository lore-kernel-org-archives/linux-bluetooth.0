Return-Path: <cyrus@holtmann.org>
From: "Fry, Don" <don.fry@intel.com>
To: "An, Tedd" <tedd.an@intel.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
CC: marcel <marcel@holtmann.org>,
	"Hedberg, Johan" <johan.hedberg@intel.com>
Subject: Re: [RFC] Bluetooth: Add support for Intel Bluetooth device
 [8087:07dc]
Date: Wed, 10 Apr 2013 15:40:13 +0000
Message-ID: <CD8AD196.1D35%don.fry@intel.com>
In-Reply-To: <1640417.GJq4DRhhap@tedd-ubuntu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Just a couple comments inline.  I know outlook munges whitespaces, so I
don't comment on those.
Don

On 4/9/13 7:44 PM, "An, Tedd" <tedd.an@intel.com> wrote:

>From: Tedd Ho-Jeong An <tedd.an@intel.com>
>
>This patch adds support for Intel Bluetooth device by adding
>btusb_setup_intel() routine that updates the device with ROM patch
>during HCI_SETUP.

<DF> snip

>
>+	/* Get bseq file name */
>+	snprintf(pfile, 32, "intel/%02x%02x%02x%02x%02x%02x%02x%02x%02x.bseq",
>+				skb->data[1], skb->data[2], skb->data[3],
>+				skb->data[4], skb->data[5], skb->data[6],
>+				skb->data[7], skb->data[8], skb->data[9]);

<DF> Is the length of the data always 9 bytes?  If less data is returned
garbage will be used.

>+	kfree_skb(skb);
>+	BT_DBG("%s patch file: %s", hdev->name, pfile);
>+
>
<DF> snip
>
>+		/* Send command based on the evt */
>+		if (evt->evt == HCI_EV_CMD_COMPLETE) {
>+			/* Command Complete Event */
>+			skb = __hci_cmd_sync(hdev, cmd->opcode, cmd->plen,

<DF> use le16_to_cpu(cmd->opcode) for big endian systems

>+					(void *)param,
>+					HCI_INIT_TIMEOUT);
>+			if (IS_ERR(skb)) {
>+				BT_ERR("__hci_cmd_sync(patch): %ld",
>+						PTR_ERR(skb));
>+				m_off_code = m_off_1;
>+				goto exit_mfg;
>+			}
>+
>+			/* Check the event status */
>+			if (skb->data[0]) {
>+				BT_ERR("%s patch failed(%02x)", hdev->name,
>+						skb->data[0]);
>+				m_off_code = m_off_1;
>+				kfree_skb(skb);
>+				goto exit_mfg;
>+			}
>+		} else {
>+			/* Non Command Complete Event */
>+			skb = __hci_cmd_sync_ev(hdev, cmd->opcode, cmd->plen,

<DF> same as above le16_to_cpu()

>+					(void *)param, evt->evt,
>+					HCI_INIT_TIMEOUT);
>+			if (IS_ERR(skb)) {
>+				BT_ERR("__hci_cmd_sync_ev(patch): %ld",
>+						PTR_ERR(skb));
>+				m_off_code = m_off_1;
>+				goto exit_mfg;
>+			}
>+

<DF> the length (skb->len) is not checked before this memcmp

>+			/* Checking the returned event */
>+			if (memcmp(skb->data, evt_param, evt->plen)) {
>+				BT_ERR("%s patch event doesn't match!!",
>+						hdev->name);
>+				m_off_code = m_off_1;
>+				kfree_skb(skb);
>+				goto exit_mfg;
>+			}
>+		}

<DF> The two cases above can be combined and treated identically.
Just call __hci_cmd_sync_ev with evt->evt and then both can verify the
returned
data is what was expected.

>+		BT_DBG("%s patch cmd succeeded %d of %d",
>+				hdev->name, patch_curr - fw->data, fw->size);
>+		kfree_skb(skb);
>
<DF> snip
>
>+
> static int btusb_setup(struct hci_dev *hdev)
> {
> 	struct btusb_data *data = hci_get_drvdata(hdev);
> 
> 	BT_DBG("%s", hdev->name);
> 
>+	if (data->driver_info & BTUSB_INTEL) {
>+		return btusb_setup_intel(hdev);

<DF> with Marcel's latest patch, setting hdev->setup in the probe routine
removes this test

>+	}
>+
> 	if (data->driver_info & BTUSB_BCM92035) {
> 		struct sk_buff *skb;
> 		__u8 val = 0x00;
>-- 
>1.7.9.5
>
>

