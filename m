Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAF37F9
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 May 2024 04:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715142734; cv=none; b=SaKSqqRHIKLLoHjAFfU4EaWPjqLhQZzuB3dNp/irl1GLHc9gYDN6xXpK3lbc3HM0a7vPofYsHGWpHpRxPP6G92bGntOxKFiGFT64nJ3DRNfbkYqmuclNhWEgmBKqvOXBlyih1gmZtUEDhiA07svH+OdaVEN/2/HDVIt/xVOpEeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715142734; c=relaxed/simple;
	bh=T/H5bRBT9c7tk68vJr/ewrylbPkjKY61M89hkJGoVpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQ8B+oxJa6KY4Kssu7uls0mdceAkbBx0ma4m40UZTgDDHvj9seHuLVVW7Cnl301eeFIu99uys3gNeU0Gpvc4HOt0Lv0ltFDzNIb6/q+Q2ZMPClWNAjMxjeEbZ3YP87nWZDq0NOvcjMSm76uM18ytjzf9DHSb096neQ7/Li0YNrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5ae97e.dynamic.kabel-deutschland.de [95.90.233.126])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A859C61E5FE01;
	Wed,  8 May 2024 06:31:52 +0200 (CEST)
Message-ID: <227efce5-a69c-482c-b29c-c0ac25ca5054@molgen.mpg.de>
Date: Wed, 8 May 2024 06:31:51 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Fix compiler warnings
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 kernel test robot <lkp@intel.com>
References: <20240508010431.25687-1-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240508010431.25687-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kiran,


Thank you for your patch.

Am 08.05.24 um 03:04 schrieb Kiran K:
> Fix compiler warnings reported by kernel bot.

It’d be great, if you added the warnings:

 >> drivers/bluetooth/btintel_pcie.c:184:6: warning: variable 'reg' set 
but not used [-Wunused-but-set-variable]
            u32 reg;
                ^
 >> drivers/bluetooth/btintel_pcie.c:192:26: warning: shift count >= 
width of type [-Wshift-count-overflow]
                                  data->ci_p_addr >> 32);
                                                  ^  ~~
 >> drivers/bluetooth/btintel_pcie.c:458:15: warning: variable 'frbd' 
set but not used [-Wunused-but-set-variable]
            struct frbd *frbd;
                         ^
    3 warnings generated.

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405080647.VRBej6fA-lkp@intel.com/
> Signed-off-by: Kiran K <kiran.k@intel.com>

Please add a Fixes: tag.

(I personally would also prefer one commit per warning.)


Kind regards,

Paul


> ---
>   drivers/bluetooth/btintel_pcie.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index e9bc4b673424..2853ab80079d 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -251,7 +251,6 @@ static void btintel_pcie_reset_bt(struct btintel_pcie_data *data)
>   static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
>   {
>   	int err;
> -	u32 reg;
>   
>   	data->gp0_received = false;
>   
> @@ -259,7 +258,7 @@ static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
>   	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_CI_ADDR_LSB_REG,
>   			      data->ci_p_addr & 0xffffffff);
>   	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_CI_ADDR_MSB_REG,
> -			      data->ci_p_addr >> 32);
> +			      (u64)data->ci_p_addr >> 32);
>   
>   	/* Reset the cached value of boot stage. it is updated by the MSI-X
>   	 * gp0 interrupt handler.
> @@ -267,7 +266,7 @@ static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
>   	data->boot_stage_cache = 0x0;
>   
>   	/* Set MAC_INIT bit to start primary bootloader */
> -	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
> +	btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
>   
>   	btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG,
>   				  BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT);
> @@ -285,7 +284,7 @@ static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
>   				  BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_ENA |
>   				  BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT);
>   
> -	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
> +	btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
>   
>   	/* wait for interrupt from the device after booting up to primary
>   	 * bootloader.
> @@ -525,7 +524,6 @@ static void btintel_pcie_msix_rx_handle(struct btintel_pcie_data *data)
>   	u16 cr_hia, cr_tia;
>   	struct rxq *rxq;
>   	struct urbd1 *urbd1;
> -	struct frbd *frbd;
>   	struct data_buf *buf;
>   	int ret;
>   	struct hci_dev *hdev = data->hdev;
> @@ -550,8 +548,6 @@ static void btintel_pcie_msix_rx_handle(struct btintel_pcie_data *data)
>   		urbd1 = &rxq->urbd1s[cr_tia];
>   		ipc_print_urbd1(data->hdev, urbd1, cr_tia);
>   
> -		frbd = &rxq->frbds[urbd1->frbd_tag];
> -
>   		buf = &rxq->bufs[urbd1->frbd_tag];
>   		if (!buf) {
>   			bt_dev_err(hdev, "RXQ: failed to get the DMA buffer for %d",
