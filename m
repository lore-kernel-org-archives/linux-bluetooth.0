Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2604C81;
	Mon,  6 Jul 2026 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783334940; cv=none; b=ddJygIUbAHWJgHYIuQ/4ntYzzE0a7V9bQ9zVLgGAb5BJ90efA+Kr9fhL5sPvZas+bm8F63OdQOX57ZAhBE/g7YSopJzic9R4/ZOC64JkSN6FHQ06hWCnBytXHMPjHgqbEtZtMn2PDJA5q+QUBiL+yuXn7uvMrqoY9+hc2m7dX3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783334940; c=relaxed/simple;
	bh=WFBmdF91fpWPKJwSHspRefmC522wM2qFsTXRQfxIb34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iFxZy7jDB0peMmvC9bGqfEyAT3nyRG+Y4y46c7ywCiWmQ6EvCRaU0uWAWOkFBExK55QJuEFOzxDkBeveijOgc1wDKRJVVMaVwcqW7HtlLl1DG37cUIhUx9t+U0SHRoQVOCiJxqTV/ySxqKlS6l1I4i0X8DOA/OtIzXWi6LfMuQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 82A8F4C1F29982;
	Mon, 06 Jul 2026 12:48:37 +0200 (CEST)
Message-ID: <814abeef-ef9b-41f4-8cb8-d94d9bfff6c9@molgen.mpg.de>
Date: Mon, 6 Jul 2026 12:48:37 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: validate Realtek vendor event length
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260706091618.77442-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260706091618.77442-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Pengpeng,


Thank you for your patch.

Am 06.07.26 um 11:16 schrieb Pengpeng Hou:
> btusb_recv_event_realtek() inspects skb->data[2] when checking
> for a Realtek coredump subevent.

(Minor thing, that *for a* would fit on the line above.)

Also the sentence mislead me a little, as skb->data[0] is also checked.

> Require the packet to contain the HCI event header and the subevent byte
> before treating it as a coredump event. Short packets keep following the
> normal hci_recv_frame() path.

Could you give an example packet, that was/would be misdetected?

Please add a Fixes: tag.

> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   drivers/bluetooth/btusb.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 08c0a99a62c5..8f7ed469cac6 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2782,7 +2782,9 @@ static int btusb_setup_realtek(struct hci_dev *hdev)
>   
>   static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *skb)
>   {
> -	if (skb->data[0] == HCI_VENDOR_PKT && skb->data[2] == RTK_SUB_EVENT_CODE_COREDUMP) {
> +	if (skb->len >= HCI_EVENT_HDR_SIZE + 1 &&
> +	    skb->data[0] == HCI_VENDOR_PKT &&
> +	    skb->data[2] == RTK_SUB_EVENT_CODE_COREDUMP) {
>   		struct rtk_dev_coredump_hdr hdr = {
>   			.code = RTK_DEVCOREDUMP_CODE_MEMDUMP,
>   		};


Kind regards,

Paul
