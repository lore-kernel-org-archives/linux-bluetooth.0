Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564DE42900D;
	Fri, 14 Aug 2026 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786697242; cv=none; b=pKVgOb2nQQZ5unaZh2ZcVTRYoP9dHwEM1GB/Yjz5X52lZ14kQmrQYNrYffPUgOiLGz9gfO0+5o4dd4QmBoSr8SnXe+ikPK1s93gPO4xPpNZk5RqV4BUp/RcygZj5o4hUh+xmmdUPYr+ubK8YaFVtf82FWzvYawN6Q2dNImxPQ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786697242; c=relaxed/simple;
	bh=oiXce4jUZHdnhnnSSMImustRKHT7d7yjF9oak4hI4jM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eaLtk8OLH1MlJquBCG6i7tLFq4kU/mG7+gzsQ9aVTK7PCYCI1myEe4teUi4Z+eIjkT8/pupkbevnYfLx6aG/3Mcm3VC2JmIkhHCIjIeqzj3RRckRKiEr3AIHEgPvPp70ibDzAGa+OuEHI7DkNvGrDX2VkjwX5PVs6OwxYo8AXx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.13.172] (g427.RadioFreeInternet.molgen.mpg.de [141.14.13.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 685E44C28871AD;
	Fri, 14 Aug 2026 10:46:48 +0200 (CEST)
Message-ID: <1217891c-bf57-4c1a-9963-27400f60a5cd@molgen.mpg.de>
Date: Fri, 14 Aug 2026 10:46:41 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btintel_pcie: Fix array bounds check bugs
To: Zhao Jinming <zhaojinming@uniontech.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Kiran K <kiran.k@intel.com>,
 Tedd Ho-Jeong An <tedd.an@intel.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <460316663D6D34ED+20260813103734.222955-1-zhaojinming@uniontech.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <460316663D6D34ED+20260813103734.222955-1-zhaojinming@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Zhao,


Thank you for your patch. For the summary I’d use:

Bluetooth: btintel_pcie: Check array bounds of dev controlled indices

Am 13.08.26 um 12:37 schrieb ZhaoJinming:
> Fix four array bounds issues in the Intel BT PCIe driver:
> 
> 1. btintel_pcie_send_sync(): bounds check for tfd_index uses '>' instead
>     of '>='.  When tfd_index == txq->count (32), the check passes and
>     btintel_pcie_prepare_tx() writes past the end of txq->tfds[] and
>     txq->bufs[].
> 
> 2. btintel_pcie_submit_rx(): same off-by-one on frbd_index.  When
>     frbd_index == rxq->count (64), the check passes and
>     btintel_pcie_prepare_rx() writes past the end of rxq->frbds[] and
>     rxq->bufs[].
> 
> 3. btintel_pcie_msix_tx_handle(): cr_tia (device-controlled, from
>     shared DMA memory) is used to index txq->urbd0s[] before any bounds
>     check, and the urbd0->tfd_index check uses '>' instead of '>='.
> 
> 4. btintel_pcie_msix_rx_handle(): cr_tia (device-controlled) indexes
>     rxq->urbd1s[] with no bounds check.  urbd1->frbd_tag is a 16-bit
>     device-controlled field (0-65535) used directly as an index into
>     rxq->bufs[] (64 elements).

Enumerating things in the commit message, is a good indicator to split 
the commit into smaller ones.

> Fix all four by correcting the comparison operators and adding explicit
> bounds checks on device-controlled indices before array access.
> 
> Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
> Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
> ---
>   drivers/bluetooth/btintel_pcie.c | 21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 2b7231be5973..32cfa0f5af1c 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -401,7 +401,7 @@ static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
>   
>   	tfd_index = data->ia.tr_hia[BTINTEL_PCIE_TXQ_NUM];
>   
> -	if (tfd_index > txq->count)
> +	if (tfd_index >= txq->count)
>   		return -ERANGE;
>   
>   	/* Firmware raises alive interrupt on HCI_OP_RESET or
> @@ -502,7 +502,7 @@ static int btintel_pcie_submit_rx(struct btintel_pcie_data *data)
>   
>   	frbd_index = data->ia.tr_hia[BTINTEL_PCIE_RXQ_NUM];
>   
> -	if (frbd_index > rxq->count)
> +	if (frbd_index >= rxq->count)
>   		return -ERANGE;
>   
>   	/* Prepare for RX submit. It updates the FRBD with the address of DMA
> @@ -1094,12 +1094,15 @@ static void btintel_pcie_msix_tx_handle(struct btintel_pcie_data *data)
>   	txq = &data->txq;
>   
>   	while (cr_tia != cr_hia) {
> +		if (cr_tia >= txq->count)
> +			return;
> +
>   		data->tx_wait_done = true;
>   		wake_up(&data->tx_wait_q);
>   
>   		urbd0 = &txq->urbd0s[cr_tia];
>   
> -		if (urbd0->tfd_index > txq->count)
> +		if (urbd0->tfd_index >= txq->count)
>   			return;

gemini/gemini-3.1-pro-preview comments [1]:

> If urbd0->tfd_index is invalid and we return early here, doesn't this permanently
> stall the TX completion queue?
> By returning early, cr_tia is never advanced. The next interrupt will process
> the exact same corrupted descriptor and return early again.



>   
>   		cr_tia = (cr_tia + 1) % txq->count;
> @@ -1584,9 +1587,21 @@ static void btintel_pcie_msix_rx_handle(struct btintel_pcie_data *data)
>   	 * process all received CDs in this interrupt.
>   	 */
>   	while (cr_tia != cr_hia) {
> +		if (cr_tia >= rxq->count) {
> +			bt_dev_err(hdev, "RXQ: invalid cr_tia %u (count %u)",

Maybe: RXQ: invalid cr_tia %u >= %u, contact device vendor

> +				   cr_tia, rxq->count);
> +			return;
> +		}
> +
>   		urbd1 = &rxq->urbd1s[cr_tia];
>   		ipc_print_urbd1(data->hdev, urbd1, cr_tia);
>   
> +		if (urbd1->frbd_tag >= rxq->count) {
> +			bt_dev_err(hdev, "RXQ: invalid frbd_tag %u (count %u)",

Ditto regarding the log message.

> +				   urbd1->frbd_tag, rxq->count);
> +			return;
> +		}
> +

gemini/gemini-3.1-pro-preview comments [1]:

> By returning early when urbd1->frbd_tag is invalid, we fail to advance cr_tia.
> Will this permanently stall the RX completion queue since the next interrupt
> will process the same corrupted descriptor?

>   		buf = &rxq->bufs[urbd1->frbd_tag];

gemini/gemini-3.1-pro-preview comments [1]:

> Does this introduce a Time-of-Check to Time-of-Use (TOCTOU) vulnerability?
> urbd1->frbd_tag is a bitfield inside a DMA-coherent structure. The code accesses
> it once for the bounds check (above) and again here to index the array.
> Can the compiler emit two separate memory reads, allowing the device to alter
> the value after the check passes but before the array access?

>   		if (!buf) {
>   			bt_dev_err(hdev, "RXQ: failed to get the DMA buffer for %d",


Kind regards,

Paul


[1]: 
https://sashiko.dev/#/patchset/460316663D6D34ED%2B20260813103734.222955-1-zhaojinming%40uniontech.com
