Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501512E36F8
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 06:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753251709; cv=none; b=s8J8MsA5hZWV8gH6Qb5wATX05Okg5k1p2y7+9Jmx6DstibKtdJQFFIaCrgBnYJyLmra2NAkDdQ9LtZDs9Itr1ZN6uBzrex/v0I4EuO8bMWXeakPTECzYofsnvtv3j3iIBs5P7l/w7Y0qSsGV9CJenpCpaichdZlw7JCo2LY/BQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753251709; c=relaxed/simple;
	bh=RPSBAA6NuGZl/Z9sMKJmAkEEhuqjL+136PRKUgQEmNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6Iupr8cMnKhdAheq/iKyTwZVmP7DKUuHqYky2rKFPI8tCUbbu0lo1iQhUc6JRqdImHsYBgjmEiXr7o0rKprMC5EWbaEMsQWN+bx4XM1ucAvd2oHh8GDjaFHDzJhL80UiKTBnQXZMvVJkXKn7TsM2TBHeIpOdArlvpl7siuG7uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.202] (p5dc55044.dip0.t-ipconnect.de [93.197.80.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 44B9A61E647A3;
	Wed, 23 Jul 2025 08:21:26 +0200 (CEST)
Message-ID: <f8bf5700-6589-46e7-8630-865e21a59d26@molgen.mpg.de>
Date: Wed, 23 Jul 2025 08:21:25 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btintel: Add support for BlazarIW core
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 Vijay Satija <vijay.satija@intel.com>
References: <20250723062644.1296860-1-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250723062644.1296860-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kiran,


Am 23.07.25 um 08:26 schrieb Kiran K:
> Need to add support for BlazarIW Bluetooth core used in Wildcat Lake
> platform.

Need to … sounds strange for a commit message.

Where is the id from? It’d be great if you added the datasheet name and 
revision.

Also, how did you test this?

> Signed-off-by: Vijay Satija <vijay.satija@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>   drivers/bluetooth/btintel.c      | 3 +++
>   drivers/bluetooth/btintel_pcie.c | 1 +
>   2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index be69d21c9aa7..ea1521c6b2d3 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -484,6 +484,7 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
>   	case 0x1d:	/* BlazarU (BzrU) */
>   	case 0x1e:	/* BlazarI (Bzr) */
>   	case 0x1f:      /* Scorpious Peak */
> +	case 0x22:	/* BlazarIW (BzrIW */

Missing closing ).

>   		break;
>   	default:
>   		bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%x)",
> @@ -3253,6 +3254,7 @@ void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
>   	case 0x1d:
>   	case 0x1e:
>   	case 0x1f:
> +	case 0x22:
>   		hci_set_msft_opcode(hdev, 0xFC1E);
>   		break;
>   	default:
> @@ -3593,6 +3595,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>   	case 0x1d:
>   	case 0x1e:
>   	case 0x1f:
> +	case 0x22:
>   		/* Display version information of TLV type */
>   		btintel_version_info_tlv(hdev, &ver_tlv);
>   
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 6e7bbbd35279..d08f59ae7720 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -2149,6 +2149,7 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
>   	switch (INTEL_HW_VARIANT(ver_tlv.cnvi_bt)) {
>   	case 0x1e:	/* BzrI */
>   	case 0x1f:	/* ScP  */
> +	case 0x22:	/* BzrIW */
>   		/* Display version information of TLV type */
>   		btintel_version_info_tlv(hdev, &ver_tlv);
>   

The rest looks good.


Kind regards,

Paul
