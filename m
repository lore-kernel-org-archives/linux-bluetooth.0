Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B783B775B;
	Tue,  7 Apr 2026 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580293; cv=none; b=hLKlP3DzPnPd9Vwg2FUWAzhXKI0PNsOcVpZ7zf9Q65F7S4kuI9LXiJ57g4FEQfLghoNDmJPuWz3caNqXb9bk07RIwO5K1HK/mF/xBkO+MGm53kbeQ0BzwrRFMKaS8EuSDOL2MadkWW2OfRTIyPxRFy7rvB9CTsFmI0TwwXgimMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580293; c=relaxed/simple;
	bh=h00MzRooAOsXbISBuNVcteDoihjKyHmNQ/zr0I6ZB+k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CK7fAsUBYtjAcsb3TDX+z/eIy1R8otMZHp77tqurpy4jbVkpFtiMJXRI4xrsg8ewZ5RTvOZHlAkI1kw4Fd11JzLWWPbHOlafZkfNvkMxI9Ml6SGYRG/ViviU1+sWq8OqlbuSEaY7bGknXFoSkXb3IrynIX88gi/YoNdIXXcY2eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.229] (p5dc55707.dip0.t-ipconnect.de [93.197.87.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id DB1C04C2C37D55;
	Tue, 07 Apr 2026 18:44:37 +0200 (CEST)
Message-ID: <4d20d421-9a17-4447-88fb-ef867e468138@molgen.mpg.de>
Date: Tue, 7 Apr 2026 18:44:36 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH] Bluetooth: BNEP: validate control header bytes before
 reading them
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260404101002.2-bnep-pengpeng@iscas.ac.cn>
Content-Language: en-US
In-Reply-To: <20260404101002.2-bnep-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Pengpeng,


Thank you for your patch. Just a note, that the date/time mismataches:

     Received: from 0002-bnep.eml (unknown [111.196.245.197])
     	by APP-05 (Coremail) with SMTP id zQCowACHFwsG0dBp_7RzDA--.49444S2;
     	Sat, 04 Apr 2026 16:51:18 +0800 (CST)
     From: Pengpeng Hou <pengpeng@iscas.ac.cn>
     Date: Fri, 3 Apr 2026 16:56:12 +0800

Am 03.04.26 um 10:56 schrieb Pengpeng Hou:
> `bnep_rx_frame()` pulls the first byte from the skb and immediately reads
> the control type from the remaining data. Short control packets can leave
> no bytes in the skb at that point.
> 
> The later control-message pull logic also reads `skb->data + 1` before
> proving that the length byte or 16-bit filter length is actually present.
> 
> Validate the required control-header bytes before each dereference and
> drop malformed frames through the existing bad-frame path.

Do you have by chance a reproducer?

> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   net/bluetooth/bnep/core.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
> index d44987d4515c..0e7a7fb758c9 100644
> --- a/net/bluetooth/bnep/core.c
> +++ b/net/bluetooth/bnep/core.c
> @@ -299,18 +299,27 @@ static int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
>   {
>   	struct net_device *dev = s->dev;
>   	struct sk_buff *nskb;
> -	u8 type, ctrl_type;
> +	u8 type;
>   
>   	dev->stats.rx_bytes += skb->len;
>   
> +	if (!skb->len)
> +		goto badframe;
> +
>   	type = *(u8 *) skb->data;
>   	skb_pull(skb, 1);
> -	ctrl_type = *(u8 *)skb->data;
>   
>   	if ((type & BNEP_TYPE_MASK) >= sizeof(__bnep_rx_hlen))
>   		goto badframe;
>   
>   	if ((type & BNEP_TYPE_MASK) == BNEP_CONTROL) {
> +		u8 ctrl_type;
> +
> +		if (!skb->len)
> +			goto badframe;
> +
> +		ctrl_type = *(u8 *)skb->data;
> +
>   		if (bnep_rx_control(s, skb->data, skb->len) < 0) {
>   			dev->stats.tx_errors++;
>   			kfree_skb(skb);
> @@ -326,12 +335,16 @@ static int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
>   		switch (ctrl_type) {
>   		case BNEP_SETUP_CONN_REQ:
>   			/* Pull: ctrl type (1 b), len (1 b), data (len bytes) */
> +			if (skb->len < 2)
> +				goto badframe;

gemini/gemini-3.1-pro-preview commented on this hunk.

https://sashiko.dev/#/patchset/20260404101002.2-bnep-pengpeng%40iscas.ac.cn

>   			if (!skb_pull(skb, 2 + *(u8 *)(skb->data + 1) * 2))
>   				goto badframe;
>   			break;
>   		case BNEP_FILTER_MULTI_ADDR_SET:
>   		case BNEP_FILTER_NET_TYPE_SET:
>   			/* Pull: ctrl type (1 b), len (2 b), data (len bytes) */
> +			if (skb->len < 3)
> +				goto badframe;
>   			if (!skb_pull(skb, 3 + *(u16 *)(skb->data + 1) * 2))
>   				goto badframe;
>   			break;


Kind regards,

Paul
