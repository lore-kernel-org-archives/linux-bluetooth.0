Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233FF437136
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837268; cv=none; b=JjIkhq3LLTQM4KtTw3IQrJUT5zG9A6IRjkmXRBGXpjBcGtBt1Aa2CmrENyzIhUoodCsxAUSQuPgnDYrtd21+dTo4dhMRqM2FoL2EzDMgTpdNw6xbEGTCqpMNGyIYa0+lUkiLAEJZUPP1cH1eRCZ8TR0J5sylIcyOg8L0U6orZdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837268; c=relaxed/simple;
	bh=GsAJjd1FiLVseU90TSbiru4JES7eF015nRJenmacNSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=lclwAWdaExpCt6mk/xRcv9qoLAdupZ2QMWI45qSIhmcmB0gfGp220nrHcs4s/eO/O+hkuoyEQKwzHy44wfj95pcuHFI0FaAwsNs/oIDFVQwULVpMGGpfM24+Z1hhtnHVdKsR8/mS+v8rmD6x/E2ITMX18zEh2JMfQNPqKyais/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=H1Tyh17T; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H1Tyh17T"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260804095422euoutp016a6c1b34f2f6af00ed0e0320765f7a34~IkYcy5Sbs0689106891euoutp01G
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 09:54:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260804095422euoutp016a6c1b34f2f6af00ed0e0320765f7a34~IkYcy5Sbs0689106891euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1785837262;
	bh=fzX2663Npf9rl2mnM07ZHQu0zDmR7AOm38pgcx4V+go=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=H1Tyh17TECbcS8IAv3YS/NUjn3gqVbem/s2Yfdv/hUXrDE+yF6BYn4OfxShg4Z+Aa
	 IxSe7TsqDiTAB5I71sYNT+n5gJT7YWvrOaAxVAmRaA2wzumIMEsTRSEjR3N8kFO16C
	 1pWc9TOkv8KLNDxlTAUk6TrkSWHF3Jc7cKe0QTlo=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260804095421eucas1p247feed9219d2aa434154fd9be676518d~IkYcRLA_C1952819528eucas1p2i;
	Tue,  4 Aug 2026 09:54:21 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260804095421eusmtip12df924e04d433062b1667397dc544ed3~IkYb6nqa-0484604846eusmtip1M;
	Tue,  4 Aug 2026 09:54:21 +0000 (GMT)
Message-ID: <0eec0c0d-636b-4e41-b578-72692b920a2e@samsung.com>
Date: Tue, 4 Aug 2026 11:54:20 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 2/5] Bluetooth: btmrvl: validate event packet lengths
To: Li Qiang <liqiang01@kylinos.cn>, linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <628bdb80b4ae352606d6cfb175180c980a8c362a.1784191283.git.liqiang01@kylinos.cn>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260804095421eucas1p247feed9219d2aa434154fd9be676518d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260804095421eucas1p247feed9219d2aa434154fd9be676518d
X-EPHeader: CA
X-CMS-RootMailID: 20260804095421eucas1p247feed9219d2aa434154fd9be676518d
References: <cover.1784191283.git.liqiang01@kylinos.cn>
	<628bdb80b4ae352606d6cfb175180c980a8c362a.1784191283.git.liqiang01@kylinos.cn>
	<CGME20260804095421eucas1p247feed9219d2aa434154fd9be676518d@eucas1p2.samsung.com>

On 16.07.2026 10:47, Li Qiang wrote:
> The Marvell event handlers access the HCI event header, command
> complete payload, and driver-specific event header before validating
> that the received skb contains them. A truncated event can consequently
> cause an out-of-bounds read.
>
> Validate each header and the command-complete payload length before
> dereferencing the corresponding fields.
>
> Signed-off-by: Li Qiang <liqiang01@kylinos.cn>

This patch landed in linux-next as commit 75e574f6a212 ("Bluetooth: btmrvl:

validate event packet lengths"). In my tests I found that it breaks bluetooth

driver operation on old Samsung Exynos SoC based Peach Pit/Pi Chromebooks.


I've sent a fix for this issue here:

https://lore.kernel.org/all/20260804094632.87581-1-m.szyprowski@samsung.com/


> ---
>  drivers/bluetooth/btmrvl_main.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
> index d6f0ad0b4b6e..aaf1614ccfd7 100644
> --- a/drivers/bluetooth/btmrvl_main.c
> +++ b/drivers/bluetooth/btmrvl_main.c
> @@ -43,10 +43,17 @@ bool btmrvl_check_evtpkt(struct btmrvl_private *priv, struct sk_buff *skb)
>  {
>  	struct hci_event_hdr *hdr = (void *) skb->data;
>  
> +	if (skb->len < sizeof(*hdr))
> +		return true;
> +
>  	if (hdr->evt == HCI_EV_CMD_COMPLETE) {
>  		struct hci_ev_cmd_complete *ec;
>  		u16 opcode;
>  
> +		if (hdr->plen < sizeof(*ec) ||
> +		    skb->len < HCI_EVENT_HDR_SIZE + sizeof(*ec))
> +			return true;
> +
>  		ec = (void *) (skb->data + HCI_EVENT_HDR_SIZE);
>  		opcode = __le16_to_cpu(ec->opcode);
>  
> @@ -74,6 +81,9 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
>  	struct btmrvl_event *event;
>  	int ret = 0;
>  
> +	if (skb->len < sizeof(*event))
> +		return -EINVAL;
> +
>  	event = (struct btmrvl_event *) skb->data;
>  	if (event->ec != 0xff) {
>  		BT_DBG("Not Marvell Event=%x", event->ec);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

