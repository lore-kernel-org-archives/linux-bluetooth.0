Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767B74414
	for <linux-bluetooth@vger.kernel.org>; Sun, 25 May 2025 05:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748151494; cv=none; b=rIg7Q0CVcch4BqBuX2ltC3B3g/qBJPGXsb6FP/QUiSG3FHAYl/qalQfi9Xv7EdoW7zmdjP8rsyrst7CrFPr90vcc89DMDy2v4LPU81P8MxrNP0n53THZ4qSN83zi1e8W+C8vYpK0mrDSJP0Ki1F/598QWgyahJV2P208IyFrJxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748151494; c=relaxed/simple;
	bh=swlWNTCdMV2ueip+qhj5IAEoYKr136Ty1X22I4LdFRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Biapj9bb4THjZETB6G8h1s7SrXkm3Gy0ZG1WCTGk7u6Hf1jsrCHjA6uvkDfA+oA88jznss2ZfMMM/+1vLnMIXU01s2DupQ8DXpfU+F5O8jG/DQggB1YsLMLxsRMfXQ5DJBNyyzktbNXjQnOuWm/wWB/nNzJIj0pbieDXGMbV0O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.107] (p5b13a30a.dip0.t-ipconnect.de [91.19.163.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3EA1C61E64783;
	Sun, 25 May 2025 07:37:58 +0200 (CEST)
Message-ID: <2a9f871b-504d-4a7a-9af1-8eef62982bee@molgen.mpg.de>
Date: Sun, 25 May 2025 07:37:57 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] Bluetooth: btintel_pcie: Fix driver not posting
 maximum rx buffers
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 vijay.satija@intel.com
References: <20250525053940.520283-1-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250525053940.520283-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Kiran,


Thank you for the patch.

Am 25.05.25 um 07:39 schrieb Kiran K:
> The driver was posting only 6 rx buffers, despite the maximum rx buffers
> being defined as 16.

The second part is worded strangely, as the macro, you remove, is 
defined to be 6. Was it just a typo?

> Update the driver to post the full 16 Rx buffers to
> utilize the maximum capacity and improve performance.

Please also note, that you remove the macro, because the value seems to 
be detectable.

Please also mention, how your change can be verified, for example read 
out in the logs or from /sys, and how the performance can be measured, 
and what you measured before and after. (Claimns regarding performance 
should always come with measurements.)

> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
> ---
>   drivers/bluetooth/btintel_pcie.c | 3 ++-
>   drivers/bluetooth/btintel_pcie.h | 3 ---
>   2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 50fe17f1e1d1..2c7731803c9f 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -396,8 +396,9 @@ static int btintel_pcie_submit_rx(struct btintel_pcie_data *data)
>   static int btintel_pcie_start_rx(struct btintel_pcie_data *data)
>   {
>   	int i, ret;
> +	struct rxq *rxq = &data->rxq;
>   
> -	for (i = 0; i < BTINTEL_PCIE_RX_MAX_QUEUE; i++) {
> +	for (i = 0; i < rxq->count; i++) {
>   		ret = btintel_pcie_submit_rx(data);
>   		if (ret)
>   			return ret;
> diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
> index 21b964b15c1c..5ddd6d7d8d45 100644
> --- a/drivers/bluetooth/btintel_pcie.h
> +++ b/drivers/bluetooth/btintel_pcie.h
> @@ -177,9 +177,6 @@ enum {
>   /* Doorbell vector for TFD */
>   #define BTINTEL_PCIE_TX_DB_VEC	0
>   
> -/* Number of pending RX requests for downlink */
> -#define BTINTEL_PCIE_RX_MAX_QUEUE	6
> -
>   /* Doorbell vector for FRBD */
>   #define BTINTEL_PCIE_RX_DB_VEC	513


Kind regards,

Paul
