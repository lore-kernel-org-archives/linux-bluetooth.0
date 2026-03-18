Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD56739F169;
	Wed, 18 Mar 2026 09:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773825192; cv=none; b=ruTo7NvPBFLnYMgK7QUCGWye3eSSf2NS5DJG4IVpMHlH7lWEK4R+1oEC0plXowIb5k3KO6VKvj1u1tpcbdiT2jSTAo4kpf9lBDhy+8BvWXsan7ckQRY6++ELwjGLi4p6EyxxqUL22JOZJPXjQlHC1Vbvd6x+zhDhqNm9COUed8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773825192; c=relaxed/simple;
	bh=eaAdgV/XYEx7DblPHVCOb0iy/Too10DwP8gs+p5HNG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEYmzSIGQbD/eSffKzWxpH60nH+1Q/gyWWPPVwn6A1L1afAvfql1Xhb09UGN5B3JNINrOaX9Tn+dXN5yDs+YtpHisDfrc6bg/PtMAv5frEbXWbcwrPwvKlfBM+iKSXXeCFCMffhUw3PUMEElejXYj0kPwcRpU2cudNsXC1LqT64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.200.145.11] (unknown [213.235.133.113])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id EA8F44C4430FC9;
	Wed, 18 Mar 2026 10:12:37 +0100 (CET)
Message-ID: <9135f7c8-73d2-4cdd-ab82-25945d3324ae@molgen.mpg.de>
Date: Wed, 18 Mar 2026 10:12:35 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btintel_pcie: validate RX packet length
 against buffer size
To: moonafterrain@outlook.com
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Kiran K <kiran.k@intel.com>,
 Tedd Ho-Jeong An <tedd.an@intel.com>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
References: <SYBPR01MB7881DD95CE054BC53AED4A21AF41A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <SYBPR01MB7881DD95CE054BC53AED4A21AF41A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Junrui,


Thank you for your patch. It be great if you configured your name in the 
author line – currently it only contains the address:

     From: moonafterrain@outlook.com

No idea, why b4 is not doing it.

Am 17.03.26 um 07:04 schrieb moonafterrain@outlook.com:
> btintel_pcie_submit_rx_work() reads packet_len from an rfh_hdr in
> DMA-coherent memory and uses it as the length for skb_put_data() without
> upper bound validation. Since packet_len is a 16-bit field (0-65535) but
> each RX DMA buffer is only BTINTEL_PCIE_BUFFER_SIZE (4096) bytes, a
> malicious or malfunctioning firmware could set a large packet_len,
> causing an out-of-bounds read beyond the buffer into adjacent kernel
> heap memory.
> 
> Add a check that packet_len does not exceed the available payload space
> alongside the existing zero-length check.

Do you have a reproducer or test case for this issue?

> Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>   drivers/bluetooth/btintel_pcie.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 37b744e35bc4..9dd02e8af2a0 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -1360,7 +1360,8 @@ static int btintel_pcie_submit_rx_work(struct btintel_pcie_data *data, u8 status
>   	rfh_hdr = buf;
>   
>   	len = rfh_hdr->packet_len;
> -	if (len <= 0) {
> +	if (len <= 0 ||
> +	    len > BTINTEL_PCIE_BUFFER_SIZE - sizeof(*rfh_hdr)) {
>   		ret = -EINVAL;

As this seems a broken or malicious firmware, no idea, if it’d make 
sense to log it.

>   		goto resubmit;
>   	}

The diff looks good:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
