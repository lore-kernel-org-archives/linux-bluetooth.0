Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B6017997
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 May 2024 05:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714629266; cv=none; b=eD27CaLzE/F3OQv3rF6rkWwGpU1XWWEKBi9TwP6fBiq2YQWQn9aTsEquBeODmjtE03VdD9r+Op67iPNX1YBrpRVLhkeLN2phmxe+VAaGTfL9bmCOE/qjLrCfm0HSAYJB6qg0lLj1cgWQItn4IiTX3RelgS30Kt7Sa6TlxObj/Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714629266; c=relaxed/simple;
	bh=e7czDcqaCio6y2ynrPUa2cdDcEHLDdxDJFsnLZD/msI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMEyS210LKcb8wfo75O6vXCVaiwdJGfcMMRmPnvjcBR6VoBJM1Drf8liwTbxePfPSm1jjZ+c93ihWsDjNtZuSY+vyZxda/MQtzGVBN60fl6jGIi1ndFe9CqWTkzd5y6OYJ/giRwqLmicaK1iFv0TnsaK623KjFcJ4avjimCg1Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.50.1.206] (unknown [89.187.201.15])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 731C361E5FE35;
	Thu,  2 May 2024 07:53:57 +0200 (CEST)
Message-ID: <1d11ab52-2369-485d-a1cf-cca6ca836cb0@molgen.mpg.de>
Date: Thu, 2 May 2024 07:53:56 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Bluetooth: btintel: Add support for BlazarI
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com
References: <20240502052356.2630798-1-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240502052356.2630798-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kiran,


Thank you for your patch.

Am 02.05.24 um 07:23 schrieb Kiran K:
> Add support for BlazarI (cnvi) bluetooth core.

It’d be great if you documented the datasheet name and revision.

Also, it’d help people reading the diff, if you added what the support 
entails. In this case a note, that it’s a “standard device” and only the 
new id needs to be added, would be nice.

> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>   drivers/bluetooth/btintel.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index dc48352166a5..4f4bd5538b6e 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -481,6 +481,7 @@ static int btintel_version_info_tlv(struct hci_dev *hdev,
>   	case 0x19:	/* Slr-F */
>   	case 0x1b:      /* Mgr */
>   	case 0x1c:	/* Gale Peak (GaP) */
> +	case 0x1e:	/* BlazarI (Bzr) */
>   		break;
>   	default:
>   		bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%x)",
> @@ -2698,6 +2699,7 @@ static void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
>   	case 0x19:
>   	case 0x1b:
>   	case 0x1c:
> +	case 0x1e:
>   		hci_set_msft_opcode(hdev, 0xFC1E);
>   		break;
>   	default:
> @@ -3037,6 +3039,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>   	case 0x19:
>   	case 0x1b:
>   	case 0x1c:
> +	case 0x1e:
>   		/* Display version information of TLV type */
>   		btintel_version_info_tlv(hdev, &ver_tlv);


Kind regards,

Paul
