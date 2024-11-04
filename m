Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC2714D719;
	Mon,  4 Nov 2024 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730161; cv=none; b=OFLaHWwaaQOcxfabcMDyCKjjgKQ8EuqsC7pyc4fSPdZanBs8F6eFxsUaR6XC58K+scndQZVPSdcXkOJTpyhJogiHtBdQ6DmLhxJWCn7wSoGSy5ZmZxdOZ5DRsKtdg9Kvkg/ttA9BMBL5JhLvL618mKUY2W6n3pSOlGkbuWit7so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730161; c=relaxed/simple;
	bh=+FftvcfMX5H7grIwnS/gkOlccCzywuE6qFzx01efsNc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=V7ZCC4j6MdBCwYcvJktUL2t2teHbvNbdhx3k+uyj7ZE4J5km4mX9DJCFiqwOElpOlYLsgo3WI+DZjJHrJnAZ7et348lsM1DYHlfYkEAWBaZ6vyfq9nxpN1pTeNn7qmQtXKQLROHWH/EeL3AlkIXTSqs5ztwMB+syJFzF/kO+ax8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 09F2261E5FE05;
	Mon, 04 Nov 2024 15:22:10 +0100 (CET)
Message-ID: <d5d42409-6a10-4172-b70c-77e9f067bd94@molgen.mpg.de>
Date: Mon, 4 Nov 2024 15:22:09 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Add new HWIDs for MT7925
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Jiande Lu <jiande.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Von Dentz <luiz.dentz@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Chris Lu <chris.lu@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
 Aaron Hou <aaron.hou@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20241104131904.30447-1-jiande.lu@mediatek.com>
 <fa008e7b-92c8-440f-9e56-9d58e9b3bb93@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <fa008e7b-92c8-440f-9e56-9d58e9b3bb93@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jiande,


Also, you could add the number to the summary:

Bluetooth: btusb: Add 4 HWIDs for MT7925

Am 04.11.24 um 15:20 schrieb Paul Menzel:

> Am 04.11.24 um 14:19 schrieb Jiande Lu:
>> Add below HWIDs for MediaTek MT7925 USB Bluetooth chip.
>> VID 0x0489, PID 0xe14f
>> VID 0x0489, PID 0xe150
>> VID 0x0489, PID 0xe151
>>
>> Patch has been tested successfully and controller is recognized
>> device pair successfully.
>>
>> MT7925 module bring up message as below.
>> Bluetooth: Core ver 2.22
>> Bluetooth: HCI device and connection manager initialized
>> Bluetooth: HCI socket layer initialized
>> Bluetooth: L2CAP socket layer initialized
>> Bluetooth: SCO socket layer initialized
>> Bluetooth: hci0: HW/SW Version: 0x00000000, Build Time: 20240816133202
>> Bluetooth: hci0: Device setup in 286558 usecs
>> Bluetooth: hci0: HCI Enhanced Setup Synchronous
>> Connection command is advertised, but not supported.
> 
> No line wrapping needed.
> 
>> Bluetooth: hci0: AOSP extensions version v1.00
>> Bluetooth: BNEP (Ethernet Emulation) ver 1.3
>> Bluetooth: BNEP filters: protocol multicast
>> Bluetooth: BNEP socket layer initialized
>> Bluetooth: MGMT ver 1.22
>> Bluetooth: RFCOMM TTY layer initialized
>> Bluetooth: RFCOMM socket layer initialized
>> Bluetooth: RFCOMM ver 1.11
>>
>> Signed-off-by: Jiande Lu <jiande.lu@mediatek.com>
>> ---
>>   drivers/bluetooth/btusb.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 6dc5a7e76558..77b8500f8e9b 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -658,6 +658,12 @@ static const struct usb_device_id quirks_table[] = {
>>                                BTUSB_WIDEBAND_SPEECH },
>>       { USB_DEVICE(0x0489, 0xe139), .driver_info = BTUSB_MEDIATEK |
>>                                BTUSB_WIDEBAND_SPEECH },
>> +    { USB_DEVICE(0x0489, 0xe14f), .driver_info = BTUSB_MEDIATEK |
>> +                             BTUSB_WIDEBAND_SPEECH },
>> +    { USB_DEVICE(0x0489, 0xe150), .driver_info = BTUSB_MEDIATEK |
>> +                             BTUSB_WIDEBAND_SPEECH },
>> +    { USB_DEVICE(0x0489, 0xe151), .driver_info = BTUSB_MEDIATEK |
>> +                             BTUSB_WIDEBAND_SPEECH },
>>       { USB_DEVICE(0x13d3, 0x3602), .driver_info = BTUSB_MEDIATEK |
>>                                BTUSB_WIDEBAND_SPEECH },
>>       { USB_DEVICE(0x13d3, 0x3603), .driver_info = BTUSB_MEDIATEK |
> 
> With the small thing fixed:
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul
