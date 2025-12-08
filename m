Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6253148D0
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765200749; cv=none; b=D9bpUjpAbmyQMsQ8le8f8VyUiZIEW1TufJNOrGZCF5OQdEaJ7DuSAA0fpO6x5QspKWT/S16NZYMCnGCDR2NJ7rgbU29lkmi59EpwIJLZHqvIty5Y7PrHXTJ/RjeugEa61Sv27i/odoySGms3Q5GNKxUFYPZ9A8RJkJ2tuz2aSlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765200749; c=relaxed/simple;
	bh=cX9uhFg0WLkP+zWZmB0FtKadciTYc65cNRJRGeuX5cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4UCl3iVFK/bwmtzzS+Vn23x6z3Ku5k+p71n4U8gvTkNja9F5MdYYhcPZebvJQGq4CbujtI4FslodBqmZlyXMAgoRNFztrXt+HHgFkkucz3R5TOziMdpvgaLs+Rmr9vDWhA32tt1EgWeS91aB58Si5K6xJ+QxkuzafBHvt3JDc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 38FCF617C4F8B;
	Mon, 08 Dec 2025 14:32:20 +0100 (CET)
Message-ID: <069caee5-1169-4ae3-a501-d873cb4ed0bb@molgen.mpg.de>
Date: Mon, 8 Dec 2025 14:32:19 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] Bluetooth: hci_conn: fix WARNING in hci_conn_timeout
To: Wang Yaxin <wang.yaxin@zte.com.cn>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, xu.xin16@zte.com.cn,
 yang.yang29@zte.com.cn, qiu.yutan@zte.com.cn, chen.junlin@zte.com.cn,
 jiang.kun2@zte.com.cn
References: <20251208203404000bLAos3jnZFMsLDRmqZb_S@zte.com.cn>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251208203404000bLAos3jnZFMsLDRmqZb_S@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Yaxin, dear Yutan,


Thank you for your patch.

Am 08.12.25 um 13:34 schrieb wang.yaxin@zte.com.cn:
> From: Qiu Yutan <qiu.yutan@zte.com.cn>
> 
> The warning is triggered when conn->refcnt is decremented to a negative value.

Please past the warning (no line wrapping for pastes required).

> Since atomic_dec_if_positive(&conn->refcnt) only decrements the value by 1
> when conn->refcnt is positive, the resulting value will be greater than or equal to zero,
> preventing this warning from reoccurring.

Please re-flow for 75 characters per line.

> Signed-off-by: Qiu Yutan <qiu.yutan@zte.com.cn>
> Signed-off-by: Wang Yaxin <wang.yaxin@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>

Please start the names with a capital letter.

> Signed-off-by: Chen Junlin <chen.junlin@zte.com.cn>
> ---
>   include/net/bluetooth/hci_core.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 5e01e6c501c1..2b306115add4 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1635,7 +1635,7 @@ static inline void hci_conn_drop(struct hci_conn *conn)
>   	trace_hci_conn_drop(conn);
>   	BT_DBG("hcon %p orig refcnt %d", conn, atomic_read(&conn->refcnt));
> 
> -	if (atomic_dec_and_test(&conn->refcnt)) {
> +	if (atomic_dec_if_positive(&conn->refcnt) == 0) {
>   		unsigned long timeo;
> 
>   		switch (conn->type) {

This patch looks unrelated from the trace point patch. Could you send it 
in separately? Also, why did you mark it as RFC?


Kind regards,

Paul
