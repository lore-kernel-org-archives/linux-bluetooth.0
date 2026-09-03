Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F383515D1
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420474; cv=none; b=n+vdRLhu4AeQk8AxShLGHDY33irduZBQ8OwH6d6kHVVxDWIoyqNVBICpq8w5cnedA+u5Fqy43bh2NrC18TxUcDSIueUkdoUQbvmFHkhIHl/+H+NwjAMQcBiijzjSY8czpFE16K5kdwhD/om7ljeSsB6xMddefTGokS/Cqh01hcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420474; c=relaxed/simple;
	bh=gYSJAcm1O2hErIPqZKkCSo1ZaEJ4/uuxWU67xlYe50Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t24WlVVRGRNGTTnlgJtlWtmDIWbzw7SHzQ1SWvs4tTRF2Kbtl3xn4/xrrhNKN2YqPs/jcrE6F/6c2/1NvaLzJSxIzBfPoGzJmQx9XJpC2PtpG1GyTlRteqxZ7jCUMbKJ5HlUK1ySX67thf3VOKJHBoQw0Wz0u7+0sjhAiHt+26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.150] (ip5f5af1de.dynamic.kabel-deutschland.de [95.90.241.222])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4F8754C2C37F01;
	Thu, 03 Sep 2026 09:27:40 +0200 (CEST)
Message-ID: <f97c5109-2620-4f41-bb9a-cc569bc599b9@molgen.mpg.de>
Date: Thu, 3 Sep 2026 09:27:39 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Bluetooth: btintel_pcie: validate packet_len
 before skb_put_data
To: Kiran K <kiran.k@intel.com>
Cc: ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
 chandrashekar.devegowda@intel.com, linux-bluetooth@vger.kernel.org
References: <20260902131830.35502-1-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260902131830.35502-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kiran,


Thank you for your patch.

Am 02.09.26 um 15:18 schrieb Kiran K:
> btintel_pcie_submit_rx_work() reads packet_len from rfh_hdr without
> checking if it exceeds the RX buffer size. An oversized packet_len
> can lead to an out-of-bounds read in skb_put_data().
> 
> Validate packet_len to ensure it is non-zero and does not exceed
> BTINTEL_PCIE_BUFFER_SIZE - sizeof(*rfh_hdr), logging an error when
> invalid.

Can this case be forced somehow? Please document how.

Did a tool find this case or did you experience it during 
testing/review? If a tool, please document it.

> Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>   drivers/bluetooth/btintel_pcie.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 30923eaabed7..1eabb0c8326f 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -1954,7 +1954,8 @@ static int btintel_pcie_submit_rx_work(struct btintel_pcie_data *data, u8 status
>   	rfh_hdr = buf;
>   
>   	len = rfh_hdr->packet_len;
> -	if (len <= 0) {
> +	if (len == 0 || len > BTINTEL_PCIE_BUFFER_SIZE - sizeof(*rfh_hdr)) {
> +		bt_dev_err(data->hdev, "Invalid packet_len %d", len);

What about negative values for `len` as was checked before?

To have a more useful log, I’d also log the value of 
`BTINTEL_PCIE_BUFFER_SIZE` and `sizeof(*rfh_hdr)`.

>   		ret = -EINVAL;
>   		goto resubmit;
>   	}


Kind regards,

Paul
