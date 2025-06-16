Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC29228A738
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750105258; cv=none; b=TjNQvpIr+tZuSqw/U9yeP1A7roU1TbL7h8vujqAXVl5QYENWCTpVorayNlBbYjtt2R08ECDWg9obDPAzJmAmPCPpI8mBLvvdX/CJXzfyTAVoSRb6zfJPVHoSG4LykeW6cmHdW/9MdLRRd0mHWLmWrAzmCXDCKuUi5ZktQv/hExg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750105258; c=relaxed/simple;
	bh=6tr6AGGOhj/nQ5mV47SS4AHVN704twpF/NiiVxFmtJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ceoRVZGJppzt933Ihu6tFOzVzxJHDAwgSZHhHadihjTNaG6HXWQ8/PagQGMHebta+DqjrGgMkeR+1uIvy13SbiR0G8Uch13Q4kOCCiVBKea1pRLnrkL5bCNTl+mISmTEGaxEHUMOKKYCZgTdGWr0OZbRSR1yywlPXn7GXbcNBKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af597.dynamic.kabel-deutschland.de [95.90.245.151])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 63FAC61E647BB;
	Mon, 16 Jun 2025 22:20:35 +0200 (CEST)
Message-ID: <8b3aac45-3698-4016-a83d-efaf50ee28d6@molgen.mpg.de>
Date: Mon, 16 Jun 2025 22:20:33 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btintel: Add support for BlazarIW
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 aluvala.sai.teja@intel.com
References: <20250616162633.756567-1-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250616162633.756567-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Kiran,


Thank you for your patch. Maybe for the summary/title:

Bluetooth: btintel: Add BlazarIW TLV id

Am 16.06.25 um 18:26 schrieb Kiran K:
> Add support for Bluetooth core - BlazarIW over USB and PCIe transport.

A statement, that only ids need to be added, and that support exists, 
would be nice.

Any datasheet reference? Do you have the hardware, and were able to test 
this?

> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>   drivers/bluetooth/btintel.c      | 3 +++
>   drivers/bluetooth/btintel_pcie.c | 1 +
>   2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 55cc1652bfe4..f6805027be0a 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -484,6 +484,7 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
>   	case 0x1d:	/* BlazarU (BzrU) */
>   	case 0x1e:	/* BlazarI (Bzr) */
>   	case 0x1f:      /* Scorpious Peak */
> +	case 0x22:	/* BlazarIW */
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
> index cb3cf2b9acea..1004264128e3 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -2137,6 +2137,7 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
>   	switch (INTEL_HW_VARIANT(ver_tlv.cnvi_bt)) {
>   	case 0x1e:	/* BzrI */
>   	case 0x1f:	/* ScP  */
> +	case 0x22:	/* BlazarIW */
>   		/* Display version information of TLV type */
>   		btintel_version_info_tlv(hdev, &ver_tlv);
>   


Kind regards,

Paul
