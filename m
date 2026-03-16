Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BF833121F
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696047; cv=none; b=Zz/pElbkdRFJnQFywYkmQh4W4ko7V64ftgriKCRLwWDDAt4CgN4u+OwlWLodPLbcbZIA+z1RMxtBRh5P0iWBB4PKgt3HxsTtr9luUzvNhiybW5VKGTsgwJaUaXD3m9Ll5mLQUlqCwaHY7OjAxw/Uz9ADeHGU/eWljDgBjv0Owm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696047; c=relaxed/simple;
	bh=lHN/Z3XzQIzN1cBXjJabkXtXywtbiFSqaxgPMWMdoWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=YB502MHR7W+QqM3q84+on/8dGXJtztl4EWYYwdM/8P1CbHwH0iltEqsfwraK+c/ZA6zUAmraGU+8NQ/WeaGDrVbU19OW5KeofD3qiDqEwGvVGpOVSsiezhoM2QYsyErX26UbIontLKufDuL0JbUmZ8LRCkJF6KsL/UgmURql4oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af127.dynamic.kabel-deutschland.de [95.90.241.39])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6F1054C2C37D45;
	Mon, 16 Mar 2026 22:20:38 +0100 (CET)
Message-ID: <c85b4432-fdf3-4b50-a7a1-18a58ed35e33@molgen.mpg.de>
Date: Mon, 16 Mar 2026 22:20:33 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Bluetooth: L2CAP: Fix printing wrong information
 if SDU length exceeds MTU
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20260316190957.8433-1-luiz.dentz@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260316190957.8433-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Luiz,


Thank you for your patch.

Am 16.03.26 um 20:09 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The code was printing skb->len and sdu_len in the places where it should
> be sdu_len and chan->imtu respectively to match the if conditions.

Maybe add the URL of the message with the review comments?

Link: 
https://lore.kernel.org/linux-bluetooth/20260315132013.75ab40c5@kernel.org/T/#m1418f9c82eeff8510c1beaa21cf53af20db96c06

> Fixes: fa768fce4aae ("Bluetooth: LE L2CAP: Disconnect if received packet's SDU exceeds IMTU")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   net/bluetooth/l2cap_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 4c63c949d839..6394cbcc838b 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -6705,7 +6705,7 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
>   
>   		if (sdu_len > chan->imtu) {
>   			BT_ERR("Too big LE L2CAP SDU length: len %u > %u",
> -			       skb->len, sdu_len);
> +			       sdu_len, chan->imtu);
>   			l2cap_send_disconn_req(chan, ECONNRESET);
>   			err = -EMSGSIZE;
>   			goto failed;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
