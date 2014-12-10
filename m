Return-Path: <cyrus@holtmann.org>
From: "An, Tedd" <tedd.an@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Johan
 Hedberg <johan.hedberg@gmail.com>
Subject: Re: [RFC v2 4/4] Bluetooth: Add support Intel Bluetooth bootloader
 device
Date: Wed, 10 Dec 2014 01:57:53 +0000
Message-ID: <D0ACDE57.44B1%tedd.an@intel.com>
References: <20141208152500.6fef57ae@tedd-test>
 <91440EF0-0729-4962-AFC6-56E322B48183@holtmann.org>
In-Reply-To: <91440EF0-0729-4962-AFC6-56E322B48183@holtmann.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 12/8/14, 10:11 PM, "Marcel Holtmann" <marcel@holtmann.org> wrote:

>Hi Tedd,
>
>> +		if (ret < 0) {
>> +			BT_ERR("%s: sending DATA section failed", hdev->name);
>> +			return ret;
>> +		}
>> +
>> +		fw_ptr +=3D read_len;
>> +		remain -=3D read_len;
>> +	}
>
>And here you already have the fragmentation as a more generic approach.
>As I said, lets put that all into btusb_setup_intel_send_sec. Then this
>becomes nice and simple code.
>
>I even get the feeling that btusb_setup_intel_sec_patching can then be
>removed and the handling of the 4 sections folded into
>btusb_setup_intel_boot2 directly.

Got it. I will try above approach first then try to see if I can remove
btusb_setup_intel_sec_patching.

>
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Send Intel Reset command to the device to enable the operational
>>firmware.
>> + * Because the device will not send CC event for Intel Reset command,
>> + * the command is sent with btusb_send_frame() instead of
>>__hci_cmd_sync() so
>> + * the host won't wait for event.
>> + */
>
>Why :(
>
>These are the things that does frustrate me sometimes. Is it too much to
>ask from the bootloader to acknowledge that it received the command and
>only then go and reset everything in the device.
>
>I mean you start using a well defined transport protocol and then you
>start violating it whenever you please because it is some tiny shortcut.
>It means that the host stack now has to do extra work and we can never
>tell when the device actually does a reset or if something fails. I mean
>how would we know if some of the firmware verification fails?

I knew that you won=B9t like it. :)
This is currently on discussion and this implementation is based on the
current spec and firmware design.
I will update you in a few days.

>
>> +static int btusb_setup_intel_send_reset(struct hci_dev *hdev)
>> +{
>> +	int ret;
>
>Use int err and normally we have these last in the variable list.
>
>> +	int len, plen;
>> +	struct hci_command_hdr *hdr;
>> +	struct sk_buff *skb;
>> +
>> +	u8 intel_reset[] =3D { 0x00, 0x00, 0x00, 0x01, 0x00, 0x08, 0x04, 0x00 =
};
>
>Make these const at least.
>
>> +
>> +	plen =3D sizeof(intel_reset);
>> +
>> +	len =3D HCI_COMMAND_HDR_SIZE + plen;
>> +	skb =3D bt_skb_alloc(len, GFP_ATOMIC);
>> +	if (!skb) {
>> +		BT_ERR("%s: failed to allocate sk_buff", hdev->name);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	hdr =3D (struct hci_command_hdr *) skb_put(skb, HCI_COMMAND_HDR_SIZE);
>> +	hdr->opcode =3D cpu_to_le16(0xfc01);
>> +	hdr->plen   =3D plen;
>> +
>> +	memcpy(skb_put(skb, plen), intel_reset, plen);
>> +
>> +	bt_cb(skb)->pkt_type =3D HCI_COMMAND_PKT;
>> +	bt_cb(skb)->opcode =3D 0xfc01;
>> +
>> +	ret =3D btusb_send_frame(hdev, skb);
>> +	if (ret < 0) {
>> +		BT_ERR("%s: sending Intel Reset failed (%d)", hdev->name, ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int btusb_setup_intel_boot2(struct hci_dev *hdev)
>> +{
>> +	struct btusb_data *data =3D hci_get_drvdata(hdev);
>> +	const struct firmware *fw;
>> +	int err;
>> +
>> +	BT_DBG("%s", hdev->name);
>> +
>> +	/*
>> +	 * During the setup, the specific HCI command (INTE_SEC_SEND) and its
>> +	 * correspond event are sending/receiving via bulk endpoint instead of
>> +	 * control ep and interrupt in order to improve the FW downlaoding
>> +	 * speed. So, it sending and receiving routines needs to be set to
>> +	 * custom ones during this time and it will set back to generic ones
>> +	 * after.
>> +	 */
>> +	hdev->send =3D btusb_send_frame_intel;
>> +	data->recv_bulk =3D btusb_recv_bulk_intel;
>
>I actually prefer that we do not mess with these pointers in a registered
>device. These should be set in the probe function and then stay there.
>
>> +
>> +	fw =3D btusb_setup_intel_get_fw(hdev, INTEL_FW_MODE_BL);
>> +	if (!fw) {
>> +		err =3D 0;
>> +		goto exit_error;
>> +	}
>> +
>> +	/* Start to download the firmware */
>> +	err =3D btusb_setup_intel_sec_patching(hdev, fw);
>> +	if (err < 0) {
>> +		BT_ERR("%s: downloading firmware failed (%d)", hdev->name, err);
>> +		goto exit_release;
>> +	}
>> +
>> +	/* Send Intel Reset to enable the downloaded operational firmware */
>> +	err =3D btusb_setup_intel_send_reset(hdev);
>> +	if (err < 0) {
>> +		BT_ERR("%s: sending Intel Reset failed (%d)", hdev->name, err);
>> +		goto exit_release;
>> +	}
>> +
>> +	BT_INFO("%s: Intel firmware downloading is completed", hdev->name);
>> +
>> +exit_release:
>> +	release_firmware(fw);
>> +
>> +	/* extra time after resetting the device */
>> +	msleep(200);
>
>So this now gets execute as generic error path. I think this timeout
>should be actually in the btusb_setup_intel_send_reset function. Since
>that is the only time it needs to wait for some magic time to turn the
>device back.
>
>> +
>> +	/*
>> +	 * Once the device is running with operational firmware, send device
>> +	 * specific configuration parameter with legacy way.
>> +	 */
>> +	err =3D btusb_setup_intel(hdev);
>> +	if (err < 0) {
>> +		BT_ERR("%s: configuring Intel BT device failed (%d)",
>> +		       hdev->name, err);
>> +		goto exit_error;
>> +	}
>> +
>> +	BT_INFO("%s: Intel Bluetooth device configuration is completed",
>> +		hdev->name);
>> +
>> +exit_error:
>> +	/*
>> +	 * After this point, All events will come from interrupt endpoint.
>> +	 * So, put back the bulk_recv routine to generic one
>> +	 */
>> +	BT_INFO("%s: Reset the send and receive routines", hdev->name);
>> +
>> +	data->recv_bulk =3D btusb_recv_bulk;
>> +	hdev->send =3D btusb_send_frame;
>> +
>> +	return err;
>> +}
>> +
>> +
>> static int btusb_set_bdaddr_intel(struct hci_dev *hdev, const bdaddr_t
>>*bdaddr)
>> {
>> 	struct sk_buff *skb;
>> @@ -2079,6 +2432,9 @@ static int btusb_probe(struct usb_interface *intf,
>> 		hdev->set_bdaddr =3D btusb_set_bdaddr_intel;
>> 	}
>>=20
>> +	if (id->driver_info & BTUSB_INTEL_BOOT2)
>> +		hdev->setup =3D btusb_setup_intel_boot2;
>> +
>
>This should include btusb_set_bdaddr_intel as well.
>
>And you also want to set the special btusb_send_frame_intel here as well.
>And same for the internal bulk handler.
>
>> 	if (id->driver_info & BTUSB_MARVELL)
>> 		hdev->set_bdaddr =3D btusb_set_bdaddr_marvell;
>
>Regards
>
>Marcel
>
>--
>To unsubscribe from this list: send the line "unsubscribe
>linux-bluetooth" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

Regards,
Tedd
