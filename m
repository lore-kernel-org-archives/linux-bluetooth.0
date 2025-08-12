Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BBD27AC34;
	Tue, 12 Aug 2025 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755007003; cv=none; b=tvsJ4PvKb7Sx93JBwtWM176tvGmEgqNWrKW50g+eFS1HD3jGT9DdPi1YXLYT+X/Kd6R5+CQ0IoIXp8b4k/XuMrN7YAo0FIrSwicDGBYHXrpcYvO0YH50K4QAdU3Z6cmzl5zd5ncLKLMGXUmyEdhZEOn3wo7wK8k7wtL3L6/nxxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755007003; c=relaxed/simple;
	bh=YNZ9KhQlxLUmgiFFY3KpI9/DE+fx+F7ITHQsaAe31fU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnUcbEZe65HFR+9G0sQk6aVnkWk3kgGqPuANfs9i2K0awkAue4tIbNwkfzTpKwDIsAczWDJfBQafpY6O4mo+rX2NXrCywL1mBtss4P6TIVja6Tl7YUCZoeehnOkW03w3BX+AxRTD/hiiq6lLkKM15wahTFyakcASOjT04KkHxzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 51AC361E647BA;
	Tue, 12 Aug 2025 15:56:17 +0200 (CEST)
Message-ID: <d002d395-6196-4879-905b-24168c691786@molgen.mpg.de>
Date: Tue, 12 Aug 2025 15:56:16 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btintel_pcie: Remove duplicate
 BTINTEL_PCIE_MAGIC_NUM definition
To: Wentao Guan <guanwentao@uniontech.com>
Cc: luiz.dentz@gmail.com, kiran.k@intel.com, vijay.satija@intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jun Zhan <zhanjun@uniontech.com>
References: <20250812124308.2504833-1-guanwentao@uniontech.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250812124308.2504833-1-guanwentao@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Wentao,


Thank you for your patch.

Am 12.08.25 um 14:43 schrieb Wentao Guan:
> Remove the duplicate definition of BTINTEL_PCIE_MAGIC_NUM macro.
> The macro is defined twice with the same value (0xA5A5A5A5) which
> is redundant and should be cleaned up.
> 
> Fixes: b9465e6670a2 ("Bluetooth: btintel_pcie: Read hardware exception data")
> Signed-off-by: Jun Zhan <zhanjun@uniontech.com>
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> 
> ------
> PS: I don`t know why not show a gcc redefined warning or error?

Macros are processed by the preprocessor, and are no variables. But 
maybe I am wrong.

> ------
> ---
>   drivers/bluetooth/btintel_pcie.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 6e7bbbd35279..758fbf3fb55a 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -65,8 +65,6 @@ struct btintel_pcie_dev_recovery {
>   #define BTINTEL_PCIE_SCP_HWEXP_SIZE		4096
>   #define BTINTEL_PCIE_SCP_HWEXP_DMP_ADDR		0xB030F800
>   
> -#define BTINTEL_PCIE_MAGIC_NUM	0xA5A5A5A5
> -
>   #define BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER	0x17A2
>   #define BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT		0x1E61
>   

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
