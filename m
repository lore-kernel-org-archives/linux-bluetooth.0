Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9303F1AAD
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 05:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789622506; cv=none; b=DWW9SgBvXQotWpWp3cAA45hMWCYDFHTXRoNlaLu1FXQab92QnhvpamMPztjqTviwgD5/qkxdQrtFIhSGJNQ8Z731VxhvlwzIGW9ZOhk0Ev0+jYwOKkO53oEFnjPHGGQyul7GoQ0zPoDnhlCMtshaqFs9UO7au0iRZfZerVdXlus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789622506; c=relaxed/simple;
	bh=tHQnlaNnIhflWs6DGeQyyNsrKir/ABIuh2HIQiTNH1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OZpcEg+KDi+RCRTjrM0H7yS8YOk0y65/PTFpTNh7iXLY5HA1qxObjeZstGffsLWuO9L659GeWFAXbLmr3HrS1JCpBr6RMGh7RBm27KloErcGH1VhHD29e7c9acBknCuhZ1HYoq2Fmd/0vG1ALFfkLlOwRskNXC16if/IIb3aVTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; dkim=pass (2048-bit key) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.b=EP2sEfnm; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.b="EP2sEfnm"
Received: from [192.168.2.217] (p5dc55dbb.dip0.t-ipconnect.de [93.197.93.187])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2C2714C442F90F;
	Thu, 17 Sep 2026 07:21:19 +0200 (CEST)
Message-ID: <2547d76b-98a9-4fc4-b240-d8cfb25cbffe@molgen.mpg.de>
Date: Thu, 17 Sep 2026 07:21:15 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btintel: read ROM debug registers on FW
 download failure
To: Ravindra <ravindra@intel.com>
Cc: chethan.tumkur.narayan@intel.com, kiran.k@intel.com,
 linux-bluetooth@vger.kernel.org
References: <20260917040853.2719484-1-ravindra@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260917040853.2719484-1-ravindra@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de; s=20260906; 
	t=1789622479; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=dCNt0cdvWdec6J0Phqn1KHiLOxlK4X5WgIgq85W/c6o=; 
	b=EP2sEfnmCd+E72HYy9BTLZktTYdUknvPnIHxLDlvcYfEPCOMVGN2e7RiBhhYkV+1ecEFsHxy/BiN
	dwp2F/AxFMGWX0qFzdU8jqzzjidk6fKuYGNy2FRjZ8ZffgnjYR7outgM9b2sMc2FWpc1y3qCyuC+1b
	EoKkocOd7rHcNtyoQxN2iDWPyiBKro9uS8c8P/4QdY80ghqHWyuIthhCBVhy7JYOpXIOmJS43nP5Pu
	hapqF1AHv3DUpkkWTjspK8GKDbrYopYB2Q+u+Ys7VqZW+P4S6B+CJixBNSnWugGK6sc+QcatiWKHA3
	PG6vuEyf7L4zZ0POnpWDlkw9fC1SkJ6A==

Dear Ravindra,


Thank you for your patch.

Am 17.09.26 um 06:08 schrieb Ravindra:
> The bootloader records init sequence progress and debug information in
> four core debug registers, which helps debugging FW download failures.
> 
> Add btintel_get_rom_debug_info() to issue the vendor-specific HCI
> command BTINTEL_GET_ROM_DEBUG_INFO (0xfcde) and log these registers, and
> invoke it from the error path in btintel_prepare_fw_download_tlv()
> before resetting to the bootloader.

Please paste an example to the commit message.

> Signed-off-by: Ravindra <ravindra@intel.com>
> ---
>   drivers/bluetooth/btintel.c | 40 +++++++++++++++++++++++++++++++++++++
>   drivers/bluetooth/btintel.h |  9 +++++++++
>   2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 964d2de30e65..15366a6b54c6 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -963,6 +963,43 @@ int btintel_send_intel_reset(struct hci_dev *hdev, u32 boot_param)
>   }
>   EXPORT_SYMBOL_GPL(btintel_send_intel_reset);
>   
> +static void btintel_get_rom_debug_info(struct hci_dev *hdev)
> +{
> +	struct btintel_rp_get_rom_debug_info *rom_debug_info;
> +	struct sk_buff *skb;
> +
> +	skb = __hci_cmd_sync(hdev, BTINTEL_GET_ROM_DEBUG_INFO, 0, NULL,
> +			     HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "Failed to send intel get rom debug info command (%ld)",
> +			   PTR_ERR(skb));
> +		return;
> +	}
> +
> +	if (skb->len != sizeof(*rom_debug_info)) {
> +		bt_dev_err(hdev, "Intel get rom debug info command parameters size mismatch");

Please add both sizes to the log message.

> +		kfree_skb(skb);
> +		return;
> +	}
> +
> +	rom_debug_info = (struct btintel_rp_get_rom_debug_info *)skb->data;
> +
> +	if (rom_debug_info->status) {
> +		bt_dev_err(hdev, "Intel get rom debug info command failed (%02x)",
> +			   rom_debug_info->status);
> +		kfree_skb(skb);
> +		return;
> +	}
> +
> +	bt_dev_info(hdev, "Intel get rom debug info: dr0:0x%08x dr1:0x%08x dr2:0x%08x dr3:0x%08x",
> +		    le32_to_cpu(rom_debug_info->debug_reg0),
> +		    le32_to_cpu(rom_debug_info->debug_reg1),
> +		    le32_to_cpu(rom_debug_info->debug_reg2),
> +		    le32_to_cpu(rom_debug_info->debug_reg3));
> +
> +	kfree_skb(skb);
> +}
> +
>   int btintel_read_boot_params(struct hci_dev *hdev,
>   			     struct intel_boot_params *params)
>   {
> @@ -2465,6 +2502,9 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
>   			goto done;
>   		}
>   
> +		/* FW download failed, hence collecting rom debug info */

Use imperative mood: collecting → collect

> +		btintel_get_rom_debug_info(hdev);
> +
>   		/* When FW download fails, send Intel Reset to retry
>   		 * FW download.
>   		 */
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index c00f793d9dc8..dedda3e77487 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -178,6 +178,15 @@ struct hci_ppag_enable_cmd {
>   	__le32	ppag_enable_flags;
>   } __packed;
>   
> +#define BTINTEL_GET_ROM_DEBUG_INFO	0xFCDE
> +struct btintel_rp_get_rom_debug_info {
> +	__u8	status;
> +	__le32	debug_reg0;
> +	__le32	debug_reg1;
> +	__le32	debug_reg2;
> +	__le32	debug_reg3;
> +} __packed;
> +
>   #define INTEL_TLV_TYPE_ID		0x01
>   
>   #define INTEL_TLV_SYSTEM_EXCEPTION	0x00

With my comments addressed, feel free to add:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
