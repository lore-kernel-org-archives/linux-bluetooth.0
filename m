Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAC32FF648
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143853; cv=none; b=nydkKaPDMiTOTL4ptfKBdf3YDfRWl1/nGQIBHPkhI715ko86bawZuJVm3AHJi5Q3xql7ltvEVqfQCeFITXAL4SAE4rqY8YrAUYgCMiA++UAmiHXcoUAVjkW1pz2D5S/sbD732JY48qbgcazmmX4cyHogSaO8xrpkvoTPM6IszJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143853; c=relaxed/simple;
	bh=RM4hh8TxYWiNblhgG+/WJQSCB17kcPUgES4/h8Ivc4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=piC1BcMPQv+0cYsjHQm562EzMdbXcT/lMDx/xtSyuatLjt0eme51A499BUdD/yTZeh1f9h9XJ1xPRIduvnYv2AMiKWP/JlfonJc6wNTZp8TdOmKAIHVmZMTgZ3PkbpKmk7kxboxyPjaNWAxVmb3VYjR84joLN49yXA0FPYOF9hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.5] (ip5f5af7f1.dynamic.kabel-deutschland.de [95.90.247.241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 377EF6028826D;
	Mon, 25 Aug 2025 19:44:04 +0200 (CEST)
Message-ID: <56e1103c-fa6c-4549-b720-02cb3abc9420@molgen.mpg.de>
Date: Mon, 25 Aug 2025 19:44:03 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Fixup quirk for reading ext features on
 some Barrot controllers
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
References: <20250825172504.339117-1-arkadiusz.bokowy@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250825172504.339117-1-arkadiusz.bokowy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Arkadiusz,


Thank you for your patch. For the summary, just a small nit to use a 
statement: Add quirk to fix up reading ext features on some Barrot 
controllers

Am 25.08.25 um 19:25 schrieb Arkadiusz Bokowy:
> Apparently, some Barrot based USB Bluetooth dongles erroneously sent one

s/sent/send/

> extra random byte for the HCI_OP_READ_LOCAL_EXT_FEATURES command. The
> consequence of that is that the next HCI transfer is misaligned by one
> byte causing undefined behavior. In most cases the response event for the
> next command fails with random error code.
> 
> Since the HCI_OP_READ_LOCAL_EXT_FEATURES command is used during HCI
> controller initialization, the initialization fails rendering the USB
> dongle not usable.
> 
>> [59.464099] usb 1-1.3: new full-speed USB device number 11 using xhci_hcd
>> [59.561617] usb 1-1.3: New USB device found, idVendor=33fa, idProduct=0012, bcdDevice=88.91
>> [59.561642] usb 1-1.3: New USB device strings: Mfr=0, Product=2, SerialNumber=0
>> [59.561656] usb 1-1.3: Product: UGREEN BT6.0 Adapter
>> [61.720116] Bluetooth: hci1: command 0x1005 tx timeout
>> [61.720167] Bluetooth: hci1: Opcode 0x1005 failed: -110

Although in the log, maybe mention, that you tested with the 33fa:0012 
device.

> This patch was not tested with the 33fa:0010 device, however, Internet
> search suggest that the cause for the issue with this particular device
> is exactly the same, e.g.: https://github.com/bluez/bluez/issues/1326

You could use:

Link: https://github.com/bluez/bluez/issues/1326

> Signed-off-by: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
> ---
>   drivers/bluetooth/btusb.c   | 30 ++++++++++++++++++++++++++++++
>   include/net/bluetooth/hci.h |  9 +++++++++
>   2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 8085fabad..b89efe482 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -66,6 +66,7 @@ static struct usb_driver btusb_driver;
>   #define BTUSB_INTEL_BROKEN_INITIAL_NCMD BIT(25)
>   #define BTUSB_INTEL_NO_WBS_SUPPORT	BIT(26)
>   #define BTUSB_ACTIONS_SEMI		BIT(27)
> +#define BTUSB_BARROT			BIT(28)
>   
>   static const struct usb_device_id btusb_table[] = {
>   	/* Generic Bluetooth USB device */
> @@ -810,6 +811,10 @@ static const struct usb_device_id quirks_table[] = {
>   	{ USB_DEVICE(0x0cb5, 0xc547), .driver_info = BTUSB_REALTEK |
>   						     BTUSB_WIDEBAND_SPEECH },
>   
> +	/* Barrot Technology Bluetooth devices */
> +	{ USB_DEVICE(0x33fa, 0x0010), .driver_info = BTUSB_BARROT },
> +	{ USB_DEVICE(0x33fa, 0x0012), .driver_info = BTUSB_BARROT },
> +
>   	/* Actions Semiconductor ATS2851 based devices */
>   	{ USB_DEVICE(0x10d7, 0xb012), .driver_info = BTUSB_ACTIONS_SEMI },
>   
> @@ -1120,6 +1125,21 @@ static void btusb_qca_reset(struct hci_dev *hdev)
>   	btusb_reset(hdev);
>   }
>   
> +static int btusb_barrot_urb_quirk(struct btusb_data *data, struct sk_buff *skb)
> +{
> +	struct hci_dev *hdev = data->hdev;
> +	struct hci_ev_cmd_complete *ev;
> +
> +	if (hci_test_quirk(hdev, HCI_QUIRK_FIXUP_LOCAL_EXT_FEATURES_URB_BUFFER) &&
> +	    hci_event_hdr(skb)->evt == HCI_EV_CMD_COMPLETE) {
> +		ev = (struct hci_ev_cmd_complete *)(hci_event_hdr(skb) + 1);
> +		if (__le16_to_cpu(ev->opcode) == HCI_OP_READ_LOCAL_EXT_FEATURES)
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
>   static inline void btusb_free_frags(struct btusb_data *data)
>   {
>   	unsigned long flags;
> @@ -1192,6 +1212,13 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
>   		}
>   
>   		if (!hci_skb_expect(skb)) {
> +			/* Discard one extra byte sent by some Barrot USB
> +			 * controllers. Otherwise, the rest of the transfer
> +			 * will be misaligned by one byte.
> +			 */
> +			if (btusb_barrot_urb_quirk(data, skb) && count == 1)
> +				count = 0;
> +
>   			/* Complete frame */
>   			btusb_recv_event(data, skb);
>   			skb = NULL;
> @@ -4218,6 +4245,9 @@ static int btusb_probe(struct usb_interface *intf,
>   		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_WRITE_AUTH_PAYLOAD_TIMEOUT);
>   	}
>   
> +	if (id->driver_info & BTUSB_BARROT)
> +		hci_set_quirk(hdev, HCI_QUIRK_FIXUP_LOCAL_EXT_FEATURES_URB_BUFFER);
> +
>   	if (!reset)
>   		hci_set_quirk(hdev, HCI_QUIRK_RESET_ON_CLOSE);
>   
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index df1847b74..ec9b47a39 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -351,6 +351,15 @@ enum {
>   	 */
>   	HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE,
>   
> +	/*
> +	 * When this quirk is set, the URB buffer with response event for the
> +	 * HCI_OP_READ_LOCAL_EXT_FEATURES command needs to be trimmed by one byte.
> +	 * This is required for some Barrot controllers which erroneously transfer
> +	 * an extra random byte at the end of the buffer which misaligns the rest
> +	 * of the HCI communication.
> +	 */
> +	HCI_QUIRK_FIXUP_LOCAL_EXT_FEATURES_URB_BUFFER,
> +
>   	/*
>   	 * When this quirk is set, the reserved bits of Primary/Secondary_PHY
>   	 * inside the LE Extended Advertising Report events are discarded.

Great patch.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
