Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473EE44E027
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526659; cv=none; b=ckQszgYRj7utH58u+T9J1KYpUmj//mW/qjiYZestneZ7yP9aGLKbHktlNbv9CPfCM4tAY/+k8L9e4BWUupPxgiaxAv9eL/1qL9x9OXfyQ0FakyvquXL4Hr5cNP5JqVkrIklgOKhJuQNWelV6piBS5jR5Nq9VAueUGBQV4BLHENs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526659; c=relaxed/simple;
	bh=TE7SRsvUGeCuYcTtgtODB8BKTPzWjEYyXd7Y3NBvNRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5UXICDIPe93UAVfwOQwMgyNhLOtrXrfuVOc8Fm7w0gaouDK2lWxxtizlnCTfZvU4OE+HK9z+P+CJzRx1QF0wEN/8EnebP7HHbx/2nrLKUO6QOHpOu6iqgLfYshL0GzAKir4YUs7bDVrrFqHlST7DIslgnRdy7pgbhXtK/17DvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (unknown [95.90.247.101])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CA9514C1511A17;
	Mon, 11 May 2026 21:10:38 +0200 (CEST)
Message-ID: <4c1fb760-55b5-4392-9c89-7c8a3ce5201c@molgen.mpg.de>
Date: Mon, 11 May 2026 21:10:38 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Simplify MAC access
 request/release
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com
References: <20260511133932.1217624-1-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260511133932.1217624-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kiran,


Thank yuo for your patch.

Am 11.05.26 um 15:39 schrieb Kiran K:
> Drop the STOP_MAC_ACCESS_DIS and XTAL_CLK_REQ bit manipulations from
> btintel_pcie_get_mac_access() and btintel_pcie_release_mac_access().
> These bits are no longer required to be toggled by the host driver for
> MAC access on the supported parts; the controller manages them
> internally.

Does the “no longer” refer to some controller firmware update? Please 
elaborate. (I personally prefer that as much as possible is done outside 
the firmware.) Also, maybe be explicit, and mention, if having the code 
has any practical downsides.

> Also fix the idempotency check in btintel_pcie_get_mac_access(): only
> assert MAC_ACCESS_REQ if it is not already set, instead of keying the
> read-modify-write off the MAC_ACCESS_STS bit (which reflects grant,
> not request, state).

*Also* is a good indicator to make something a separate commit. Any 
reason to not do it?

> Remove the now-unused STOP_MAC_ACCESS_DIS and XTAL_CLK_REQ register
> defines from btintel_pcie.h.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>

No Fixes: tag? At least the second issue sounds like something to backport.

> ---
>   drivers/bluetooth/btintel_pcie.c | 10 +---------
>   drivers/bluetooth/btintel_pcie.h |  3 ---
>   2 files changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index fda474406003..53a4ad80b871 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -594,9 +594,7 @@ static int btintel_pcie_get_mac_access(struct btintel_pcie_data *data)
>   
>   	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
>   
> -	reg |= BTINTEL_PCIE_CSR_FUNC_CTRL_STOP_MAC_ACCESS_DIS;
> -	reg |= BTINTEL_PCIE_CSR_FUNC_CTRL_XTAL_CLK_REQ;
> -	if ((reg & BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_STS) == 0)
> +	if (!(reg & BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ))
>   		reg |= BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ;
>   
>   	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
> @@ -622,12 +620,6 @@ static void btintel_pcie_release_mac_access(struct btintel_pcie_data *data)
>   	if (reg & BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ)
>   		reg &= ~BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ;
>   
> -	if (reg & BTINTEL_PCIE_CSR_FUNC_CTRL_STOP_MAC_ACCESS_DIS)
> -		reg &= ~BTINTEL_PCIE_CSR_FUNC_CTRL_STOP_MAC_ACCESS_DIS;
> -
> -	if (reg & BTINTEL_PCIE_CSR_FUNC_CTRL_XTAL_CLK_REQ)
> -		reg &= ~BTINTEL_PCIE_CSR_FUNC_CTRL_XTAL_CLK_REQ;
> -
>   	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
>   }
>   
> diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
> index 2db85f71b2f8..7fc8c46ed689 100644
> --- a/drivers/bluetooth/btintel_pcie.h
> +++ b/drivers/bluetooth/btintel_pcie.h
> @@ -34,9 +34,6 @@
>   #define BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_STS	(BIT(20))
>   
>   #define BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ	(BIT(21))
> -/* Stop MAC Access disconnection request */
> -#define BTINTEL_PCIE_CSR_FUNC_CTRL_STOP_MAC_ACCESS_DIS	(BIT(22))
> -#define BTINTEL_PCIE_CSR_FUNC_CTRL_XTAL_CLK_REQ		(BIT(23))
>   
>   #define BTINTEL_PCIE_CSR_FUNC_CTRL_BUS_MASTER_STS	(BIT(28))
>   #define BTINTEL_PCIE_CSR_FUNC_CTRL_BUS_MASTER_DISCON	(BIT(29))

The diff looks good.


Kind regards,

Paul
