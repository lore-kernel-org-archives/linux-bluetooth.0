Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5102874F5;
	Mon,  9 Feb 2026 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770661199; cv=none; b=CBaFaEHMP4M+LNPsPpVf7tYCFsvZaMum9yCJu3HVlC0ofgqdodipMlxLWXExuGtGtCA2LLPKLJQM9/Yd2uzcb6iQPVFdL8EP4TKV9vznse40BI3ISPpCt0STnJruJ3JE+pugkChlnkQkeuNNeMlJllM60MVW9cPjZ3+/CipZqtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770661199; c=relaxed/simple;
	bh=8hJ0xPB/1OnzuDYbVjC04VxlZ5MURHmxxfoa0A7quHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OoaQaRjWpKuDXDtsTbkW1IS7fxgkd8Hg6VHE3MuXwxLdOq4R/itt7dUbnFEN2RgpM2WVOsW8l+kP0MLc6jx2GWdgD4Y/HX4Cj6uDN9Hev7+8LHtAxq7JMWtdE2V+iSQY5F6FGsLIUBx5nFRQ6SGfdYjiLdzU45YnnOY1hEDGn5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.44.68] (unknown [185.238.219.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7B2B04C44302E6;
	Mon, 09 Feb 2026 19:19:31 +0100 (CET)
Message-ID: <5225311e-4cd6-4227-9d0e-8c5f6676cdb8@molgen.mpg.de>
Date: Mon, 9 Feb 2026 19:19:27 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btbcm: Add entry for BCM4343A2 UART Bluetooth
To: Marek Vasut <marex@nabladev.com>
Cc: linux-bluetooth@vger.kernel.org,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, kernel@dh-electronics.com,
 linux-kernel@vger.kernel.org
References: <20260209171158.22641-1-marex@nabladev.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260209171158.22641-1-marex@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Marek,


Thank you for your patch.

Am 09.02.26 um 18:11 schrieb Marek Vasut:
> This patch adds the device ID for the BCM4343A2 module, found e.g.
> in the muRata 1YN WiFi+BT combined device. The required firmware
> file is named 'BCM4343A2.hcd'.

Where can this file be found? In the linux-firmare archive [1], I only see:

     brcm/bcm43xx_hdr-0.fw
     brcm/bcm43xx-0.fw

Should you resend, could you paste the related log messages to the 
commit message?

> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: kernel@dh-electronics.com
> Cc: linux-bluetooth@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   drivers/bluetooth/btbcm.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 3a3a56ddbb06d..93368ef56ddc5 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -507,6 +507,7 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
>   	{ 0x6119, "BCM4345C0"	},	/* 003.001.025 */
>   	{ 0x6606, "BCM4345C5"	},	/* 003.006.006 */
>   	{ 0x230f, "BCM4356A2"	},	/* 001.003.015 */
> +	{ 0x2310, "BCM4343A2"	},	/* 001.003.016 */
>   	{ 0x220e, "BCM20702A1"  },	/* 001.002.014 */
>   	{ 0x420d, "BCM4349B1"	},	/* 002.002.013 */
>   	{ 0x420e, "BCM4349B1"	},	/* 002.002.014 */

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/
