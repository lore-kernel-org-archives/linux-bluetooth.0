Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213E3186A
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 06:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756274647; cv=none; b=RV77Z8ZBZ0kDJJvfp60eyGC36MMIsg2raEIhPUbshpfBq9lv9a8r0BCGpJi6k1esbFbjXIsVtJJrRf86wRA7u61H7/O1Ei0FQZ34HY3XyiKPoi1RPSX0gcYpoMcUEFe7M16l8BlnvCpmNNPxUEkYak5e6HoK8DjrbTeLy0lsACI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756274647; c=relaxed/simple;
	bh=Vjh4hPIcQi89sGsSK28rWp2GMU0zdG8vt0ZX7Of6pn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=O2QM+eNcprhmmpcVFv54pUxKNRyv35vaK7JFi7y63lQS41PIuR5w/AZwH7TzXv5DDMkrs2qEoRll75Aekb6TDjTqtyDwBEc5sfRha9lELakIfHCEUitRgeAv1JcrrrKGz+a8LngBmC8SSX/fj8GLfyK0oXqCqL0IfGumWcF1uEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.202] (p5b13a549.dip0.t-ipconnect.de [91.19.165.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A6F8D60213B1D;
	Wed, 27 Aug 2025 08:04:00 +0200 (CEST)
Message-ID: <663a45c2-0fba-40e4-9ebb-bc8df60a774d@molgen.mpg.de>
Date: Wed, 27 Aug 2025 08:03:59 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: btusb: Check for unexpected bytes when
 defragmenting HCI frames
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
References: <CABBYNZLmTCh_mn7w6U31B82cBZsmLaj92dxwfK9PVWZeMqk54Q@mail.gmail.com>
 <20250826170314.352122-1-arkadiusz.bokowy@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250826170314.352122-1-arkadiusz.bokowy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Arkadiusz,


Thank you for the patch.

Am 26.08.25 um 19:03 schrieb Arkadiusz Bokowy:
> Some Barrot based USB Bluetooth dongles erroneously send one extra
> random byte for the HCI_OP_READ_LOCAL_EXT_FEATURES command. The
> consequence of that is that the next HCI transfer is misaligned by one
> byte causing undefined behavior. In most cases the response event for
> the next command fails with random error code.
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
> 
> This patch was tested with the 33fa:0012 device. Now the device is
> initialized properly:
> 
>> [43.329852] usb 1-1.4: new full-speed USB device number 4 using dwc_otg
>> [43.446790] usb 1-1.4: New USB device found, idVendor=33fa, idProduct=0012, bcdDevice=88.91
>> [43.446813] usb 1-1.4: New USB device strings: Mfr=0, Product=2, SerialNumber=0
>> [43.446821] usb 1-1.4: Product: UGREEN BT6.0 Adapter
>> [43.582024] Bluetooth: hci1: Unexpected continuation: 1 bytes
>> [43.703025] Bluetooth: hci1: Unexpected continuation: 1 bytes

As a normal user reading the logs and seeing the warning, I wouldn’t 
know what to do. So, I’d elaborate, that it’s probably a controller (of 
the dongle) issue, and, if at all, should be reported to the hardware 
vendor.

… Unexpected continuation: 1 bytes. This is likely a problem with the 
Bluetooth device and should be reported to the manufacturer.

>> [43.750141] Bluetooth: MGMT ver 1.23
> 
> Signed-off-by: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
> Tested-by: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>

I believe, the author does not need to add a dedicated Tested-by: tag, 
as it’s kind of expected. But I am not 100 % sure 
(`Documentation/process/5.Posting.rst` does not handle the case) and 
it’s not important.

> ---
>   drivers/bluetooth/btusb.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 8085fabad..24a249d1c 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1192,6 +1192,18 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
>   		}
>   
>   		if (!hci_skb_expect(skb)) {
> +			/* Each chunk should correct to at least 1 or more
> +			 * events so if there are still bytes left that doesn't
> +			 * constitute a new event this is likely a bug in the
> +			 * controller.
> +			 */
> +			if (count && count < HCI_EVENT_HDR_SIZE) {
> +				bt_dev_warn(data->hdev,
> +					"Unexpected continuation: %d bytes",
> +					count);
> +				count = 0;
> +			}
> +
>   			/* Complete frame */
>   			btusb_recv_event(data, skb);
>   			skb = NULL;


Kind regards,

Paul
