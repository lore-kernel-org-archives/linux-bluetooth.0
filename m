Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933CC14658E
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864504; cv=none; b=PLc3O+/4Xl5LU9HsIlK8YTcqRVUC6ZzPrPYdxZ5nMzbyk1TXl+oebQO/0atcXBrHVRbvKuGP6VIXqD78CEuQ9kciXmWhZBTsGIgQFcAHKO4V5SBjhi2VeCB9YECFuW+rXvJoOHYGR6A/rpvdY8s0FBCgxaaxZ7KwsURX252BYKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864504; c=relaxed/simple;
	bh=JnNVVNb3IZU4skbapC9iRAU52F0SyxiFF2eGVJ8ecWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JiBP+SFCDvpLh/kwWI+F7BqsMUdRSo/1U+InqTFXJsUi2rtNtDK4SctXLXjBKugb/Lhu2DRmNffJNCm+bLmYQsx3mPaq8YOli5msHde3VpkY3D3RgpnLQWHtnbIgfcJsvQ27SrKZPDhM413YCwIzT/kJVrip9+tpcoXkVOnFiHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.56] (g56.guest.molgen.mpg.de [141.14.220.56])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CCD6E61E5FE38;
	Thu, 16 May 2024 15:01:22 +0200 (CEST)
Message-ID: <f42caf85-6a43-4d18-b14d-b5a3c55af0d3@molgen.mpg.de>
Date: Thu, 16 May 2024 15:01:22 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] Bluetooth: btintel_pcie: Print Firmware Sequencer
 information
To: Kiran K <kiran.k@intel.com>
Cc: ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
 vijay.satija@intel.com, linux-bluetooth@vger.kernel.org
References: <20240516123938.891523-1-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240516123938.891523-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Kiran,


Am 16.05.24 um 14:39 schrieb Kiran K:
> From: Kiran <kiran.k@intel.com>

Should this be Kiran K?

> Firmware sequencer (FSEQ) is a common code shared across Bluetooth
> and Wifi. Printing FSEQ will help to debug if there is any mismatch

So, make `btintel_print_fseq_info()` public, and call it in btintel_pci.

> between Bluetooth and Wifi FSEQ.

Please paste one example message.

> Signed-off-by: Kiran <kiran.k@intel.com>
> ---
>   drivers/bluetooth/btintel.c      | 3 ++-
>   drivers/bluetooth/btintel.h      | 5 +++++
>   drivers/bluetooth/btintel_pcie.c | 2 ++
>   3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 0c855c3ee1c1..2c434ff9c47c 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2713,7 +2713,7 @@ void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
>   }
>   EXPORT_SYMBOL_GPL(btintel_set_msft_opcode);
>   
> -static void btintel_print_fseq_info(struct hci_dev *hdev)
> +void btintel_print_fseq_info(struct hci_dev *hdev)
>   {
>   	struct sk_buff *skb;
>   	u8 *p;
> @@ -2825,6 +2825,7 @@ static void btintel_print_fseq_info(struct hci_dev *hdev)
>   
>   	kfree_skb(skb);
>   }
> +EXPORT_SYMBOL_GPL(btintel_print_fseq_info);
>   
>   static int btintel_setup_combined(struct hci_dev *hdev)
>   {
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index b5fea735e260..796953547932 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -244,6 +244,7 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
>   				 struct intel_version_tlv *ver);
>   int btintel_shutdown_combined(struct hci_dev *hdev);
>   void btintel_hw_error(struct hci_dev *hdev, u8 code);
> +void btintel_print_fseq_info(struct hci_dev *hdev);
>   #else
>   
>   static inline int btintel_check_bdaddr(struct hci_dev *hdev)
> @@ -373,4 +374,8 @@ static inline int btintel_shutdown_combined(struct hci_dev *hdev)
>   static inline void btintel_hw_error(struct hci_dev *hdev, u8 code)
>   {
>   }
> +
> +static void btintel_print_fseq_info(struct hci_dev *hdev)
> +{
> +}
>   #endif
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 5b6805d87fcf..8d282ee2322c 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -1197,9 +1197,11 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
>   		bt_dev_err(hdev, "Unsupported Intel hw variant (%u)",
>   			   INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
>   		err = -EINVAL;
> +		goto exit_error;
>   		break;
>   	}
>   
> +	btintel_print_fseq_info(hdev);
>   exit_error:
>   	kfree_skb(skb);
>   


Kind regards,

Paul
