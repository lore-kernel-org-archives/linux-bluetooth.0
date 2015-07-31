Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 1/2] Bluetooth: btqca: Introduce generic QCA ROME
 support
To: Marcel Holtmann <marcel@holtmann.org>
References: <55BAB442.1050400@qca.qualcomm.com>
 <97E72ACB-799B-431B-B060-7126902DCA77@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>
From: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
Message-ID: <55BBAE9E.3030404@qca.qualcomm.com>
Date: Fri, 31 Jul 2015 10:21:34 -0700
MIME-Version: 1.0
In-Reply-To: <97E72ACB-799B-431B-B060-7126902DCA77@holtmann.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 07/31/15 09:27, Marcel Holtmann wrote:
> Hi Ben,
>
>> +
>> +#define VERSION "0.1"
>> +
>> +static uint8_t rome_user_baud_rate = QCA_BAUDRATE_115200;
> Why was this global again?

This is for changing NVM tag value prior to transferring NVM file. Prefer value from hci_qca.c by setting as second param in rome_uart_setup() is set to this global value and use it to rome_tlv_check_data() to change NVM tag #17. In order to remove global value, this value should go to  rome_uart_setup() -> rome_download_firmware_file() -> rome_tlv_check_data() as function params. Let me think about that new defined struct value would be efficient way by passing this to functions as params.

static void rome_tlv_check_data(u8 type, const struct firmware *fw)
{
...
            /* Update NVM tags as needed */
            switch (tag_id) {
            case 17:
            #ifndef QCA_FEATURE_UART_IN_BAND_SLEEP
                /* HCI transport layer parameters
                 * disabling software inband sleep
                 * until hci driver supports IBS
                 */
                tlv_nvm->data[0] &= ~0x80;
            #endif
                /* UART Baud Rate */
                tlv_nvm->data[2] = rome_user_baud_rate;
                break;
...
}

> +			}
> +
> +			rome_debug_dump(tlv_nvm->data, tag_len, true);
> I am actually really in favor of this rome_debug_dump and especially not as exported function. I prefer that we rather use the hex dump feature of the kernel or not bother to dump the TLVs at all here. Just report the errors.

Got it, I'll use btmon to looking at the hex dump.

> I mean, we can also a userspace utility that verifies firmwares and lets it dissect the TLVs. We are doing that for the Intel chips with the bluemoon utility. So I am would welcome that.
>
> +
> +static int rome_inject_cmd_complete(struct hci_dev *hdev, __u16 opcode,
> +				    u8 result, void *params, int len)
> +{
> +	struct sk_buff *skb;
> +	struct hci_event_hdr *hdr;
> +	struct hci_ev_cmd_complete *evt;
> +
> +	skb = bt_skb_alloc(sizeof(*hdr) + sizeof(*evt) + 1 + len, GFP_ATOMIC);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	hdr = (struct hci_event_hdr *)skb_put(skb, sizeof(*hdr));
> +	hdr->evt = HCI_EV_CMD_COMPLETE;
> +	hdr->plen = sizeof(*evt) + 1 + len;
> +
> +	evt = (struct hci_ev_cmd_complete *)skb_put(skb, sizeof(*evt));
> +	evt->ncmd = 0x01;
> +	evt->opcode = cpu_to_le16(opcode);
> +
> +	memcpy(skb_put(skb, 1), &result, 1);
> +	memcpy(skb_put(skb, len), params, len);
> +
> +	bt_cb(skb)->pkt_type = HCI_EVENT_PKT;
> +
> +	return hci_recv_frame(hdev, skb);
> +}
> Sadly, we have to do that, hence my comment with the hci_cmd_send that we might export to drivers.
>

Yeah, agree with you.

>> +
>> +void rome_debug_dump(const u8 *cmd, int size, bool outbound)
>> +{
>> +#ifdef QCA_FEATURE_DEBUG
>> +	int i;
>> +	char printout[150], hex[10];
>> +
>> +	if (outbound)
>> +		snprintf(printout, 150, "SEND -> ");
>> +	else
>> +		snprintf(printout, 150, "RECV <- ");
>> +
>> +	for (i = 0; i < size && i < 30; i++) {
>> +		snprintf(hex, sizeof(hex), " %02x", cmd[i]);
>> +		strncat(printout, hex, 150);
>> +	}
>> +
>> +	BT_INFO("%s", printout);
>> +#else
>> +	return;
>> +#endif
>> +}
>> +EXPORT_SYMBOL_GPL(rome_debug_dump);
> I am really disliking this one. Start using the kernel's hex dump support.

I'll remove that.

>> +
>> +int rome_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
>> +{
>> +	struct sk_buff *skb;
>> +	u8 cmd[9];
>> +	int err;
>> +
>> +	cmd[0] = EDL_NVM_ACCESS_SET_REQ_CMD;
>> +	cmd[1] = 0x02; 			/* TAG ID */
>> +	cmd[2] = sizeof(bdaddr_t);	/* size */
>> +	memcpy(cmd + 3, bdaddr, sizeof(bdaddr_t));
>> +
>> +	skb = __hci_cmd_sync(hdev, EDL_NVM_ACCESS_OPCODE, sizeof(cmd), cmd,
>> +			     HCI_INIT_TIMEOUT);
>> +	if (IS_ERR(skb)) {
>> +		err = PTR_ERR(skb);
>> +		BT_ERR("%s: Change address command failed (%d)",
>> +		       hdev->name, err);
>> +		return err;
>> +	}
>> +	kfree_skb(skb);
>> +
>> +	/* apply NVM changes to the controller */
>> +	rome_reset(hdev);
> This needs a bit better comment explaining why this is needed. This is different from all other controllers where the HCI_Reset that follows this command handles it.
>
> Keep in mind that hdev->set_bdaddr is property integrated with the mgmt command Set Public Address and the Unconfigured State. So the core takes care of resetting the controller via HCI_Reset.
>

I thought core didn't trigger HCI_RESET when HCI_UP is happened. I'll remove that.

> +
> +int rome_vendor_frame(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	struct hci_event_hdr *hdr = (void*)skb->data;
> +
> +	if (hdr->evt == HCI_VENDOR_PKT) {
> +		u16 opcode = 0x00;
> +		u8 *packet;
> +		int len;
> +
> +		/* Change vendor event to command complete event with
> +		 * coresponding data which will help us unblock
> +		 * __hci_cmd_sync() calls
> +		 */
> +		packet = skb->data+sizeof(*hdr);
> +		len = skb->len-sizeof(*hdr);
> +
> +		if (hdev->sent_cmd != NULL) {
> +			struct hci_command_hdr *sent;
> +			sent = (void*)hdev->sent_cmd->data;
> +			opcode = __le16_to_cpu(sent->opcode);
> +		}
> +
> +		rome_inject_cmd_complete(hdev, opcode, 0x00, packet, len);
> +
> +		kfree_skb(skb);
> +
> +		return true;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(rome_vendor_frame);
> Explain to me what is actually going on here? With these things I prefer that proper comments are added to explain what is going on so that people can follow this. Can you share the HCI vendor command documentation offline with me.
>
> Also I get the feeling that doing this via h4_recv_buf if needed is a way better approach.

When VS command is issued, controller didn't send up command complete event to the host. It has HCI_VENDOR_PKT without any opcode and results.

SEND -> 01          00 FC      01     19
            ----         --------    ---     ----
         command    opcode   len     vendor command

RECV -> 04          FF           0e     00 02 08                    00 00 00 11 01 00 03 13 00 00 00
           ------       ----         -----   ------------                  ----------------------------------------
           event    vendor_pkt   len    struct edl_event_hdr    struct rome_version

If we can wake up the __hci_cmd_sync() function after receiving vendor_pkt without injecting command complete event fakely, it would be good, because even though we're using hci_send_cmd(), driver should put wait function to receive some commands to unblock the driver call flow. If we can do it with h4_recv_buf, that would be better.

>> Regards
>>
>> Marcel
>>

Thanks for all rest of code review. I'll follow-up with your suggestion.

Thanks
-- Ben Kim
