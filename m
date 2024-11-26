Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AA68F54;
	Tue, 26 Nov 2024 07:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732605518; cv=none; b=SnTCVl7GvFSviYwZ8jPLBP9SR0kkl13NUJfRVQrntfuB7VFLcgnrsgeGcOb8x1wTbfIFw7zPm1ygLD1kOz+ifDYttBEa0dkpoAsna/zocV6r7lL0NKpZTG1cDw5x1cwJFFhejszJq1pp9Sv6EIMiWV++OxGviZxvUrlNFrHzo0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732605518; c=relaxed/simple;
	bh=0e3nmIpCWsRh+SKje1K6fJRsRP09TmLmrPjuQjIjjq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3Y9QBRTkO4YE5GdWTxR2Tz2YyxK6eECHzR/x63RBomN7HoUBzABr6GoHllZXBDU1pjKm/UvqQDi9LAMSIW0SD6UWOd4ldK0QVhxcvxIO3/o2Kwpuq8ZqIlF4gWT1YZG+rD1hOPUcyKcfqANuUKWA7ollciTsII8zkKoo+oLBuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (unknown [95.90.242.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4005C61E5FE05;
	Tue, 26 Nov 2024 08:18:04 +0100 (CET)
Message-ID: <03bbfa8d-6a43-47ff-b075-8b38718f812f@molgen.mpg.de>
Date: Tue, 26 Nov 2024 08:18:03 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: add quirk using packet size 60
To: Hilda Wu <hildawu@realtek.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 max.chou@realtek.com, alex_lu@realsil.com.cn, kidman@realtek.com
References: <20241126070542.3828431-1-hildawu@realtek.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241126070542.3828431-1-hildawu@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Hilda,


Thank you for your patch. Some minor comments.

It’d be great if you addad the chip model to the commit message 
summary/title.


Am 26.11.24 um 08:05 schrieb Hilda Wu:
> The RTL8852BE-VT supports USB alternate setting 6.

Please add a blank line between paragraphs.

> However, its descriptor does not report this capability to the host.

Is that a firmware limitation? Is it going to be fixed in the future in 
other revisions?

> Therefore, a quirk is needed to bypass the RTL8852BE-VT's descriptor
> and allow it to use USB ALT 6 directly.

Does Linux log the application of this quirk?

> The btmon log below shows the case that WBS with the USB alternate
> setting 6.
> 
> < HCI Command: Enhanced.. (0x01|0x003d) plen 59  #2123 [hci0] 82.701813
>          Handle: 1 Address: 78:A7:EB:4C:53:4D (1MORE)
>          Transmit bandwidth: 8000
>          Receive bandwidth: 8000
>          Max latency: 13
>          Packet type: 0x0380
>            3-EV3 may not be used
>            2-EV5 may not be used
>            3-EV5 may not be used
>          Retransmission effort: Optimize for link quality (0x02)
> < ACL Data TX: Handle 1 flags 0x00 dlen 22       #2124 [hci0] 82.701825
>        Channel: 65 len 18 [PSM 3 mode Basic (0x00)] {chan 1}
>        RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
>           Address: 0x0b cr 1 dlci 0x02
>           Control: 0xef poll/final 0
>           Length: 14
>           FCS: 0x9a
>          0d 0a 2b 43 49 45 56 3a 20 32 2c 31 0d 0a 9a     ..+CIEV: 2,1..>
>> HCI Event: Command Status (0x0f) plen 4        #2125 [hci0] 82.703812
>        Enhanced Setup Synchronous Connection (0x01|0x003d) ncmd 2
>          Status: Success (0x00)
>> HCI Event: Number of Complete.. (0x13) plen 5  #2126 [hci0] 82.710834
>          Num handles: 1
>          Handle: 1 Address: 78:A7:EB:4C:53:4D (1MORE)
>          Count: 1
>          #2124: len 22 (19 Kb/s)
>          Latency: 9 msec (3-56 msec ~13 msec)
>          Channel: 65 [PSM 3 mode Basic (0x00)] {chan 1}
>          Channel Latency: 9 msec (4-27 msec ~15 msec)
>> HCI Event: Synchronous Conne.. (0x2c) plen 17  #2127 [hci0] 82.741840
>          Status: Success (0x00)
>          Handle: 2
>          Address: 78:A7:EB:4C:53:4D (1MORE)
>          Link type: eSCO (0x02)
>          Transmission interval: 0x0c
>          Retransmission window: 0x04
>          RX packet length: 60
>          TX packet length: 60
>          Air mode: Transparent (0x03)
> @ RAW Open: btmon (privileged) version 2.22          {0x0002} 82.742580
> @ RAW Close: btmon                                   {0x0002} 82.742594
>> SCO Data RX: Handle 2 flags 0x00 dlen 60       #2128 [hci0] 82.764812
> < ACL Data TX: Handle 1 flags 0x00 dlen 19       #2129 [hci0] 82.764994
>        Channel: 65 len 15 [PSM 3 mode Basic (0x00)] {chan 1}
>        RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
>           Address: 0x0b cr 1 dlci 0x02
>           Control: 0xef poll/final 0
>           Length: 11
>           FCS: 0x9a
>          0d 0a 2b 56 47 53 3a 20 36 0d 0a 9a              ..+VGS: 6...  >
>> HCI Event: Max Slots Change (0x1b) plen 3      #2130 [hci0] 82.765814
>          Handle: 1 Address: 78:A7:EB:4C:53:4D (1MORE)
>          Max slots: 1
> < SCO Data TX: Handle 2 flags 0x00 dlen 60       #2131 [hci0] 82.765897
>> HCI Event: Number of Complete.. (0x13) plen 5  #2132 [hci0] 82.771855
>          Num handles: 1
>          Handle: 1 Address: 78:A7:EB:4C:53:4D (1MORE)
>          Count: 1
>          #2129: len 19 (25 Kb/s)
>          Latency: 6 msec (3-56 msec ~10 msec)
>          Channel: 65 [PSM 3 mode Basic (0x00)] {chan 1}
>          Channel Latency: 6 msec (4-27 msec ~11 msec)
> < SCO Data TX: Handle 2 flags 0x00 dlen 60       #2133 [hci0] 82.773344
>> SCO Data RX: Handle 2 flags 0x00 dlen 60       #2134 [hci0] 82.774836
>> SCO Data RX: Handle 2 flags 0x00 dlen 60       #2135 [hci0] 82.774839
>> SCO Data RX: Handle 2 flags 0x00 dlen 60       #2136 [hci0] 82.784840
> < SCO Data TX: Handle 2 flags 0x00 dlen 60       #2137 [hci0] 82.787175
> < SCO Data TX: Handle 2 flags 0x00 dlen 60       #2138 [hci0] 82.788282
>> SCO Data RX: Handle 2 flags 0x00 dlen 60       #2139 [hci0] 82.794812
> < SCO Data TX: Handle 2 flags 0x00 dlen 60       #2140 [hci0] 82.795797
>> SCO Data RX: Handle 2 flags 0x00 dlen 60       #2141 [hci0] 82.804838
>> SCO Data RX: Handle 2 flags 0x00 dlen 60       #2142 [hci0] 82.804840
> < SCO Data TX: Handle 2 flags 0x00 dlen 60       #2143 [hci0] 82.808554
> 
> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> Signed-off-by: Hilda Wu <hildawu@realtek.com>
> 
> ---
> Change:
> V3: Fixed SubjectPrefix, use quirk instead of btrealtek_*_flag()
> v2: Use btusb_find_altsetting replace duplicating logic, add tested log.
> ---
> ---
>   drivers/bluetooth/btrtl.c |  3 ++
>   drivers/bluetooth/btrtl.h |  1 +
>   drivers/bluetooth/btusb.c | 86 ++++++++++++++++++++++++++++++---------
>   3 files changed, 70 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 83025f457ca0..7efd733f9e84 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -1312,6 +1312,9 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
>   		    btrtl_dev->project_id == CHIP_ID_8852C)
>   			set_bit(HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER, &hdev->quirks);
>   
> +		if (btrtl_dev->project_id == CHIP_ID_8852BT)
> +			btrealtek_set_flag(hdev, REALTEK_ALT6_FORCE);
> +
>   		hci_set_aosp_capable(hdev);
>   		break;
>   	default:
> diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
> index a2d9d34f9fb0..ffec2fca88ec 100644
> --- a/drivers/bluetooth/btrtl.h
> +++ b/drivers/bluetooth/btrtl.h
> @@ -105,6 +105,7 @@ struct rtl_vendor_cmd {
>   
>   enum {
>   	REALTEK_ALT6_CONTINUOUS_TX_CHIP,
> +	REALTEK_ALT6_FORCE,
>   
>   	__REALTEK_NUM_FLAGS,
>   };
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 279fe6c115fa..6acdff772ca5 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -814,6 +814,8 @@ struct qca_dump_info {
>   #define BTUSB_USE_ALT3_FOR_WBS	15
>   #define BTUSB_ALT6_CONTINUOUS_TX	16
>   #define BTUSB_HW_SSR_ACTIVE	17
> +#define BTUSB_ALT6_QUIRK	18
> +#define BTUSB_ISOC_ALT_CHANGED	19

What is BTUSB_ISOC_ALT_CHANGED needed for? For me it’d be great, if you 
mentioned it in the commit message.

>   struct btusb_data {
>   	struct hci_dev       *hdev;
> @@ -866,6 +868,7 @@ struct btusb_data {
>   	unsigned int air_mode;
>   	bool usb_alt6_packet_flow;
>   	int isoc_altsetting;
> +	u16 isoc_mps;

What is mps? Add a comment? Why not unsigned int?

>   	int suspend_count;
>   
>   	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
> @@ -2140,16 +2143,58 @@ static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
>   	}
>   }
>   
> +static struct usb_host_interface *btusb_find_altsetting(struct btusb_data *data,
> +							int alt)
> +{
> +	struct usb_interface *intf = data->isoc;
> +	int i;
> +
> +	BT_DBG("Looking for Alt no :%d", alt);
> +
> +	if (!intf)
> +		return NULL;
> +
> +	for (i = 0; i < intf->num_altsetting; i++) {
> +		if (intf->altsetting[i].desc.bAlternateSetting == alt)
> +			return &intf->altsetting[i];
> +	}
> +
> +	return NULL;
> +}
> +
>   static inline int __set_isoc_interface(struct hci_dev *hdev, int altsetting)
>   {
>   	struct btusb_data *data = hci_get_drvdata(hdev);
>   	struct usb_interface *intf = data->isoc;
>   	struct usb_endpoint_descriptor *ep_desc;
> +	struct usb_host_interface *alt;
>   	int i, err;
>   
>   	if (!data->isoc)
>   		return -ENODEV;
>   
> +	/* For some Realtek chips, they actually have the altsetting 6, but its
> +	 * altsetting descriptor is not exposed. We can activate altsetting 6 by
> +	 * replacing the altsetting 5.
> +	 */
> +	if (altsetting == 6 && !btusb_find_altsetting(data, 6) &&
> +	    test_bit(BTUSB_ALT6_QUIRK, &data->flags)) {
> +		alt = btusb_find_altsetting(data, 5);
> +		if (alt) {
> +			data->isoc_mps = 49;
> +			for (i = 0; i < alt->desc.bNumEndpoints; i++) {
> +				ep_desc = &alt->endpoint[i].desc;
> +				if (!usb_endpoint_xfer_isoc(ep_desc))
> +					continue;
> +				data->isoc_mps =
> +					le16_to_cpu(ep_desc->wMaxPacketSize);
> +				ep_desc->wMaxPacketSize = cpu_to_le16(63);
> +			}
> +			alt->desc.bAlternateSetting = 6;
> +			set_bit(BTUSB_ISOC_ALT_CHANGED, &data->flags);
> +		}
> +	}
> +
>   	err = usb_set_interface(data->udev, data->isoc_ifnum, altsetting);
>   	if (err < 0) {
>   		bt_dev_err(hdev, "setting interface failed (%d)", -err);
> @@ -2161,6 +2206,22 @@ static inline int __set_isoc_interface(struct hci_dev *hdev, int altsetting)
>   	data->isoc_tx_ep = NULL;
>   	data->isoc_rx_ep = NULL;
>   
> +	/* Recover alt 5 desc if alt 0 is set. */

Why?

> +	if (!altsetting && test_bit(BTUSB_ISOC_ALT_CHANGED, &data->flags)) {
> +		alt = btusb_find_altsetting(data, 6);
> +		if (alt) {
> +			for (i = 0; i < alt->desc.bNumEndpoints; i++) {
> +				ep_desc = &alt->endpoint[i].desc;
> +				if (!usb_endpoint_xfer_isoc(ep_desc))
> +					continue;
> +				ep_desc->wMaxPacketSize =
> +					cpu_to_le16(data->isoc_mps);
> +			}
> +			alt->desc.bAlternateSetting = 5;
> +			clear_bit(BTUSB_ISOC_ALT_CHANGED, &data->flags);
> +		}
> +	}
> +
>   	for (i = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
>   		ep_desc = &intf->cur_altsetting->endpoint[i].desc;
>   
> @@ -2223,25 +2284,6 @@ static int btusb_switch_alt_setting(struct hci_dev *hdev, int new_alts)
>   	return 0;
>   }
>   
> -static struct usb_host_interface *btusb_find_altsetting(struct btusb_data *data,
> -							int alt)
> -{
> -	struct usb_interface *intf = data->isoc;
> -	int i;
> -
> -	BT_DBG("Looking for Alt no :%d", alt);
> -
> -	if (!intf)
> -		return NULL;
> -
> -	for (i = 0; i < intf->num_altsetting; i++) {
> -		if (intf->altsetting[i].desc.bAlternateSetting == alt)
> -			return &intf->altsetting[i];
> -	}
> -
> -	return NULL;
> -}
> -
>   static void btusb_work(struct work_struct *work)
>   {
>   	struct btusb_data *data = container_of(work, struct btusb_data, work);
> @@ -2279,7 +2321,8 @@ static void btusb_work(struct work_struct *work)
>   			 * MTU >= 3 (packets) * 25 (size) - 3 (headers) = 72
>   			 * see also Core spec 5, vol 4, B 2.1.1 & Table 2.1.
>   			 */
> -			if (btusb_find_altsetting(data, 6))
> +			if (btusb_find_altsetting(data, 6) ||
> +			    test_bit(BTUSB_ALT6_QUIRK, &data->flags))
>   				new_alts = 6;
>   			else if (btusb_find_altsetting(data, 3) &&
>   				 hdev->sco_mtu >= 72 &&
> @@ -2611,6 +2654,9 @@ static int btusb_setup_realtek(struct hci_dev *hdev)
>   	if (btrealtek_test_flag(data->hdev, REALTEK_ALT6_CONTINUOUS_TX_CHIP))
>   		set_bit(BTUSB_ALT6_CONTINUOUS_TX, &data->flags);
>   
> +	if (btrealtek_test_flag(data->hdev, REALTEK_ALT6_FORCE))
> +		set_bit(BTUSB_ALT6_QUIRK, &data->flags);
> +
>   	return ret;
>   }


Kind regards,

Paul
