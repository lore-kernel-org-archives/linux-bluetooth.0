Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C8381ADA;
	Wed, 22 May 2024 11:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376946; cv=none; b=gr1iRUTN9Ta4oT8wHj3uhCsyiWtjVzyxVOnxiI49t/8l2/1MHPDN4qBdgnYtc1ZBNZZJmGH7GWhDLZEcq6IibH4aHhgFifbu13+UtIu53s69gIe8+qZoEPngjGQd3wRfQqFoMao2kIjB3Y4d/lvrrxFix/RLq9FrujqxXz9HmCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376946; c=relaxed/simple;
	bh=LUVwJ1pZJuL47lMD/FlPmXI7ySajAjBDC1CjmQ/ApVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpmwbT5pdRFxp/yA1fGzZKH1PRg0A2xnmqktZAVkL/dl2b+uR1077z51pLuGwN58p1R5DOlbUXbcZUYV+/wMv4/F1YWy45M/pDgzrsgLDBCfsYxWvDSmLUUXASe1q5iAIX4gsbsrBFjHLZK/qF34LzT7XjNb7cF9c6wwJA6WNtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.3] (ip5f5af1e5.dynamic.kabel-deutschland.de [95.90.241.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D6FE561E5FE05;
	Wed, 22 May 2024 13:22:04 +0200 (CEST)
Message-ID: <e132145c-0da9-4b2d-aba8-5d02690a5fee@molgen.mpg.de>
Date: Wed, 22 May 2024 13:22:04 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: vendor specific ISO data packet identification
 by handle
To: Ying Hsu <yinghsu@chromium.org>
Cc: chromeos-bluetooth-upstreaming@chromium.org,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240522111139.2612601-1-yinghsu@chromium.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240522111139.2612601-1-yinghsu@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Ying,


Thank you for your patch. Some minor comments.

Could you please make the summary/title a statement by using a verb (in 
imperative mood).

Am 22.05.24 um 13:11 schrieb Ying Hsu:
> When HCI raw sockets are opened, the Bluetooth kernel module doesn't
> track CIS/BIS connections. User-space applications have to identify
> ISO data by maintaining connection information and look up the mapping
> for each ACL data packet received. Besides, btsnoop log catpured in

captured

> kernel would couldn't tell ISO data from ACL data in this case.

Excessive *would*?

> By differentiating ISO data from ACL data earlier in btusb, we can
> eliminate unnecessary lookups and improve btsnoop log clarity.
> This patch enables vendor-specific differentiation between ISO and
> ACL data packets.

Make it clear, that this is only done for Intel devices?

> Signed-off-by: Ying Hsu <yinghsu@chromium.org>
> ---
> Tested LE unicast recording on a ChromeOS device with Intel AX211

I’d add that to the commit message, and also name the exact device name 
you used.

>   drivers/bluetooth/btusb.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 79aefdb3324d..543961b6c671 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -889,6 +889,8 @@ struct btusb_data {
>   	int (*recv_acl)(struct hci_dev *hdev, struct sk_buff *skb);
>   	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
>   
> +	int (*is_iso_data_pkt)(struct sk_buff *skb);
> +
>   	int (*setup_on_usb)(struct hci_dev *hdev);
>   
>   	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
> @@ -1229,6 +1231,8 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
>   
>   		if (!hci_skb_expect(skb)) {
>   			/* Complete frame */
> +			if (data->is_iso_data_pkt && data->is_iso_data_pkt(skb))
> +				hci_skb_pkt_type(skb) = HCI_ISODATA_PKT;
>   			btusb_recv_acl(data, skb);
>   			skb = NULL;
>   		}
> @@ -2539,6 +2543,13 @@ static int btusb_recv_bulk_intel(struct btusb_data *data, void *buffer,
>   	return btusb_recv_bulk(data, buffer, count);
>   }
>   
> +static int btusb_is_iso_data_pkt_intel(struct sk_buff *skb)

Why not return `bool`?

> +{
> +	__u16 handle = (__le16_to_cpu(hci_acl_hdr(skb)->handle) & 0xfff);
> +
> +	return (handle >= 0x900);

Define a macro?

> +}
> +
>   static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
>   {
>   	struct urb *urb;
> @@ -4361,6 +4372,9 @@ static int btusb_probe(struct usb_interface *intf,
>   		/* Override the rx handlers */
>   		data->recv_event = btintel_recv_event;
>   		data->recv_bulk = btusb_recv_bulk_intel;
> +
> +		/* Override for ISO data packet*/

Please add a space before */.

> +		data->is_iso_data_pkt = btusb_is_iso_data_pkt_intel;
>   	} else if (id->driver_info & BTUSB_REALTEK) {
>   		/* Allocate extra space for Realtek device */
>   		priv_size += sizeof(struct btrealtek_data);
