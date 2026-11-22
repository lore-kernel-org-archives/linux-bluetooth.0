Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795336081;
	b=Ui3nGj8CIUZ+FOQ3VSuDcsPS7gTc2dmjsyXfERMVPwicUe+eYjjl6Kk8NzWJ0ANMwsVv
	 u5XJNtHtAkQ6A5wiMYXjAfAYYUkRQdW99E1Z5znvjyTW1euRL3VJAqssznJAyoLTBNO4H
	 ghzY9orRN+UX7BvqtAjhtbhi+pNP2KRY8vEq/EfbkVy/TGXY6V+CZSOvSp64d0GZnsQWo
	 gXyXNiobMACv8cyQfTxIQnpFJfX+1kRhrJkP99kU7rKmEPHa6MGaY4a1sxlrv5qgr13BX
	 5WE9KMZpI0AyfkcMw40cpybP0I42NLHtmZyjoILMnBnvd0bM+VjjgtrbachoBxrE/eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795336081;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:DKIM-Signature;
	bh=ihgvkoYQucaTgXWNPyV2fI7OOChbPQerR0cBOt/hVyc=;
	b=aA/eD9UzR7PlPh4qltaMdCthCqyq4o2NNKyeeVRIqv4RbBMPffl4GN7ogjOi5aO9CiSg
	 V6DWZTAveZix+UhlbD1J4si2uGMs24qyv3q8xqyZ+VF1kPtrlex90rJzj6EB047KKOuOr
	 GK//RP/p6bOJPMAtC62gSzrWi72SmUqrJNsUjwYqijV+eCwwE1wPXm88IiWGmzqx3siV6
	 +XtWaI09gfnIFJefWy3/n6xXjEeAJxsKUpwejDwOm4O+14vIdq//6icG1d4AN74Nhq03n
	 ieNjvntJoAHlkQ+Ut9vDi0eS2E1C/cD6uqx6zCAnXOp/Yz+cyavIv8daLUcFzIxPuDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=molgen.mpg.de;
	spf=pass smtp.mailfrom=molgen.mpg.de;
	dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=Ip862n04;
	arc=none smtp.remote-ip=141.14.17.11
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11B9606A320;
	Sun, 22 Nov 2026 08:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F11B9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=Ip862n04
Received: from [192.168.2.223] (p5b13a22d.dip0.t-ipconnect.de [91.19.162.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id EBA4E4C442F7ED;
	Sun, 22 Nov 2026 09:27:50 +0100 (CET)
Message-ID: <6f0b4dfc-4bb3-45f9-81ae-347e345cbe33@molgen.mpg.de>
Date: Sun, 22 Nov 2026 09:27:48 +0100
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btbcm: Add entries for BCM4364B3 UART
 Bluetooth
To: Jason Perlow <jperlow@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <4a1efe5e-ec67-4caa-bb84-35759e66ef42@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <4a1efe5e-ec67-4caa-bb84-35759e66ef42@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de; s=20260906; 
	t=1795336071; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=ihgvkoYQucaTgXWNPyV2fI7OOChbPQerR0cBOt/hVyc=; 
	b=Ip862n04nEPgSLwCvclmQNC6TFaBrUFKTcgLR0dp32fNXdOTEiMxGMIOwRM0NfbsSeyPQQ49UZdo
	emi37oSX60Xe+P0eSb0+u2HDQ7EekpijgdlNA1ciq7bJveRlu1+s4XAhexpmUqsUh30TxIvdQkzFnB
	swcPqg3BBfD/lXdfXMxTdPaeyEpXVWmS6t1+IMrhUarDolDoJTTSLbtZ4OCVm/+ERqXKC7XgYLAI+m
	zBJFM72uLYYSwu4N2XBnSQoRgeCO5seaGUyVwYRB0DIF1MH/+rz9bGMqLkhBfXzgBBAd6cJU10a84Z
	pqoc86pb0PQ9MzbHPpOY46XTynKYFEqw==

Dear Jason,


Thank you for your patch.

Am 16.11.26 um 22:38 schrieb Jason Perlow:
> The BCM4364B3 combo chip on Apple T2 Macs, e.g. the MacBookPro16,1, has a
> UART Bluetooth controller that reports LMP subversion 0x3032 (001.016.050)
> on some units and 0x305b (001.016.091) on others.  Neither has an entry in
> bcm_uart_subver_table, so the controller is logged without a name:
> 
>    Bluetooth: hci0: BCM4364B3 Trinidad Olympic GEN (MFG)
>    Bluetooth: hci0: BCM (001.016.091) build 0115
> 
> and the firmware lookup only tries the generic "brcm/BCM.hcd".
> 
> Add both subversions so the controller is named and its firmware is looked
> up as "brcm/BCM4364B3.hcd" first.  Tested on two MacBookPro16,1 with a
> v7.4-rc3 based kernel carrying an equivalent change, one reporting 0x3032
> and one reporting 0x305b.  They now log:
> 
>    Bluetooth: hci0: BCM4364B3 (001.016.050) build 0082
>    Bluetooth: hci0: BCM4364B3 (001.016.091) build 0115

Is this only about the logs, or does functionality also change, that BT 
starts working, or did it work before already?

> Signed-off-by: Jason Perlow <jperlow@gmail.com>
> ---
>   drivers/bluetooth/btbcm.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 065536d4ec..92ba7aeac3 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -519,6 +519,8 @@ static const struct bcm_subver_table 
> bcm_uart_subver_table[] = {
>       { 0x2119, "BCM4373A0"    },    /* 001.001.025 */
>       { 0x2128, "BCM4384A0"    },    /* 001.001.040 */
>       { 0x4119, "BCM4384B0"    },    /* 002.001.025 */
> +    { 0x3032, "BCM4364B3"    },    /* 001.016.050 */
> +    { 0x305b, "BCM4364B3"    },    /* 001.016.091 */

Sort it?

>       { }
>   };

With my comments addressed, feel free to add:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
