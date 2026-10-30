Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793385867;
	b=UrCbWH86Bc4jWphKPtbf0G/ull1CKQF0XlX3oKPvq/iQ0TLhrliLBeTuq3/6I2VFshCi
	 /IedWARfo0B3xKrYJTmZjzQ+/1R26Jf1fBGtswMqK8j7OlYsnb2S+tOJAECFn12hwlpSd
	 6QL9IukK2WWRy0jvXEud2MrUGIk7Gm8uAPpYa7qn+QcPYNHmPq9PfOWRvYAIgB/h+ZbSE
	 mxnVF7BGiBa3JVbYmWIlrlyEG2nYchSWPFlM9LlTGuK/9skHQ7r27P9nwJ54ylugSFD8u
	 CAeGhjkHLRsSa0vY5CK0OIWCWKla075PrZd2cmsIrJj9TUvnwMlUJtaY9Q9lqCt9tSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385867;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:DKIM-Signature;
	bh=WqvK1oXV/PoqCN/uHmXaJj+eN8mJrD0A3RAa0dua+lo=;
	b=wf9S+VLaC/7U8jR1shxtwDgfEF+mEBoKqVHymvGvjauBAQ3/0Qc1+4/Ng1fGPKDSMWSr
	 r/PczIkxQR7C9c6wZeqKoQ725vs/TtIm5nIHA9xktkmzFMHU2wNSmWYzn0OmuXiWKzzoI
	 ihtsu7Hf5dVZLl18xXwSTYPQqNla/Fsthr43nFzA3I6liVsUYOmUS9FkY6ORcmtkPOBtJ
	 y/dR0daxnC4+qIL28G0nTZ6z7auMQ+aqgSs2nNKKk1xA9BwxUU2fVhnJbdgZwlKAo32tl
	 fjuygsq4ysrRgrAQ8ArhbaBGMTZNo4fhO3gFlCpXDbL8X/PGDeuYxBO528Tbnv7WS9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=molgen.mpg.de;
	spf=pass smtp.mailfrom=molgen.mpg.de;
	dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=ODlm5Bbb;
	arc=none smtp.remote-ip=141.14.17.11
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6843606A31A
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 18:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6843606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=ODlm5Bbb
Received: from [10.0.41.209] (unknown [62.214.191.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 328514C442F982;
	Fri, 30 Oct 2026 19:44:05 +0100 (CET)
Message-ID: <d10df07d-03fe-446a-b462-0d956ced4e8a@molgen.mpg.de>
Date: Fri, 30 Oct 2026 19:44:04 +0100
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
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Set MAC_INIT in
 get_mac_access()
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com,
 chandrashekar.devegowda@intel.com
References: <20261030142907.139369-1-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20261030142907.139369-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de; s=20260906; 
	t=1793385845; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=WqvK1oXV/PoqCN/uHmXaJj+eN8mJrD0A3RAa0dua+lo=; 
	b=ODlm5BbbzMYb3tMwge9IHY/D9XUu/M6aYbq+UJlVV0KDEKpMN+seRfepvVpoBRMbgmWQpXKAXadm
	X39ihodiN22qr3bXv1hzaWQ0HIV/QylvjvPglb2YDssXwFwQHllSGAQ6S2/F4UdDDG33Koc/zto4rQ
	vqEF5UGc9MpcG8x4B+K0sE08e9D+SA9P0CtzcasVazprJKC87xBRKkfe7dRTBv/2RC7HQ5bxW2I4oq
	EUw7tMYUP1lLJVhqUVZoKyUMsUyV8MlboeMhDUsrr4VVCboATdEkkIB6m+SHBySsuj4DfbFwe1d/YB
	+tE8AcyXcL8tCZ2744a3eLS2FuBVuKKA==

Dear Kiran,


Thank you for your patch.

Am 30.10.26 um 15:29 schrieb Kiran K:
> Every caller that read device memory had to call
> btintel_pcie_mac_init() before btintel_pcie_get_mac_access().

I’d use present tense: Currently, every caller reading device memory has 
to call …

> Fold the MAC_INIT handling into btintel_pcie_get_mac_access() and drop the
> separate helper along with its three call sites.

 From the diff, it’s not clear, why moving it to 
`btintel_pcie_mac_init()` does not change behavior.

> Unlike btintel_pcie_mac_init(), which also modified FUNC_ENA, FUNC_INIT,
> BUS_MASTER_DISCON, and SW_RESET, leave those bits untouched as they are
> not needed for MAC access. Set only MAC_INIT and MAC_ACCESS_REQ with a
> single register write when either bit is not already set.

I’d make it two commits.

> Fixes: b9465e6670a2 ("Bluetooth: btintel_pcie: Read hardware exception data")
> Assisted-by: Copilot:Gemini 4 Argon
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>   drivers/bluetooth/btintel_pcie.c | 31 ++++++-------------------------
>   1 file changed, 6 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 7d84c8106cf1..025c4c64d020 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -989,31 +989,18 @@ static int btintel_pcie_reset_bt(struct btintel_pcie_data *data)
>   	return reg == 0 ? 0 : -ENODEV;
>   }
>   
> -static void btintel_pcie_mac_init(struct btintel_pcie_data *data)
> -{
> -	u32 reg;
> -
> -	/* Set MAC_INIT bit to start primary bootloader */
> -	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
> -	reg &= ~(BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT |
> -			BTINTEL_PCIE_CSR_FUNC_CTRL_BUS_MASTER_DISCON |
> -			BTINTEL_PCIE_CSR_FUNC_CTRL_SW_RESET);
> -	reg |= (BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_ENA |
> -			BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT);
> -	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
> -}
> -
>   static int btintel_pcie_get_mac_access(struct btintel_pcie_data *data)
>   {
> -	u32 reg;
> +	u32 reg, val;
>   	int retry = 15;
> +	const u32 req = BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT |
> +			BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ;
>   
>   	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
>   
> -	if (!(reg & BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ)) {
> -		reg |= BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ;
> -		btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
> -	}
> +	val = reg | req;
> +	if (val != reg)
> +		btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, val);
>   
>   	do {
>   		reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
> @@ -1951,8 +1938,6 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
>   	if (!buffer)
>   		return -ENOMEM;
>   
> -	btintel_pcie_mac_init(data);
> -
>   	err = btintel_pcie_read_device_mem(data, buffer, tbl_addr,
>   					   buffer_len);
>   	if (err)
> @@ -2643,8 +2628,6 @@ static void btintel_pcie_read_hwexp(struct btintel_pcie_data *data)
>   	if (!buf)
>   		goto exit_on_error;
>   
> -	btintel_pcie_mac_init(data);
> -
>   	err = btintel_pcie_read_device_mem(data, buf, addr, len);
>   	if (err)
>   		goto exit_on_error;
> @@ -2732,8 +2715,6 @@ static int btintel_pcie_dump_fwtrigger_event(struct btintel_pcie_data *data)
>   	if (!buf)
>   		return -ENOMEM;
>   
> -	btintel_pcie_mac_init(data);
> -
>   	err = btintel_pcie_read_device_mem(data, buf, data->debug_evt_addr,
>   					   len);
>   	if (err)


Kind regards,

Paul
