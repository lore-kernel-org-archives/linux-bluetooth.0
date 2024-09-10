Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21C8176FAC;
	Tue, 10 Sep 2024 07:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953481; cv=none; b=N5roEd5aq8iY4JT9WNquRCg7HU9OR1GXpfUQaQXQ4d20yTofpM+0K9fUNwc/PCuxISS2EHd4vSix8VZQRgaZm93Snijo+gNxqyXDYwLf6pYT+n+b2dmdaWNpm3pNuw95M1xHoMguoelk7KCgLP8vCllLpBkwP+7tMbRQWaOf7Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953481; c=relaxed/simple;
	bh=vsENJtQxSNfJwmUEDsr6Qasi3X0eOWGN4uKDgjXBL9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=FiNZHC02X/Qm5y8fpMhEI3OWqJ7Gco/OORAOnjZxoZnhObYXNCDlZkJmceIQQGS6U4+P73YOmviPskz4kkdJHn7JJL9XZAi9+l16gPBndoKmqunhYQGCbwVu1/8YCfxoC6nWmcffjgnpaDq676aRXxJm0dmsqf09gGpCa9gfAIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.12.127] (g127.RadioFreeInternet.molgen.mpg.de [141.14.12.127])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id F22E361E5FE07;
	Tue, 10 Sep 2024 09:31:13 +0200 (CEST)
Message-ID: <1a2b267a-8d9f-44e6-880d-2383f8b5369b@molgen.mpg.de>
Date: Tue, 10 Sep 2024 09:31:13 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btusb: Fix not handling ZPL/short-transfer
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20240909205152.2397337-1-luiz.dentz@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240909205152.2397337-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Luiz,


Thank you for your patch.

Am 09.09.24 um 22:51 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Requesting transfers of the exact same size of wMaxPacketSize may result
> in ZPL/short-transfer since the USB stack cannot handle it as we are
> limiting the buffer size to be the same as wMaxPacketSize.
> 
> Also, in terms of throughput this change has the same effect to
> interrupt endpoint as 290ba200815f "Bluetooth: Improve USB driver throughput

(*interrupt* would fit on the line above.)

> by increasing the frame size" had for the bulk endpoint, so users of the
> advertisement bearer (e.g. BT Mesh) may benefit from this change.

Do you have a benchmark script, that can be run?

> Fixes: 5e23b923da03 ("[Bluetooth] Add generic driver for Bluetooth USB devices")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   drivers/bluetooth/btusb.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 36a869a57910..83df387aea92 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1341,7 +1341,10 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
>   	if (!urb)
>   		return -ENOMEM;
>   
> -	size = le16_to_cpu(data->intr_ep->wMaxPacketSize);
> +	/* Use maximum HCI Event size so the USB stack handles
> +	 * ZPL/short-transfer automatically.
> +	 */
> +	size = HCI_MAX_EVENT_SIZE;
>   
>   	buf = kmalloc(size, mem_flags);
>   	if (!buf) {


Kind regards,

Paul

Kind regards,

Paul
