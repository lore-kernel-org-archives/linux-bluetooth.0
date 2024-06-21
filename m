Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F6616B3A5
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jun 2024 07:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718954192; cv=none; b=C/EW/tx+dUwVAs/0c5uYccOOtlc2yBgNOpHsc3WkM3C8xTHxwN8pFQSTqgZakPHbzHmnW+POz6IX34LYInVHXrHlmz47RYe/tveZmkrHDwUUA5INyEmrKdGbqKYTleDyOGkpXWjpPw5j7hKsf9LlRnfKE+brzcWxejItHP6pFz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718954192; c=relaxed/simple;
	bh=mYIPbYoNPRgVVVO47kYWM6/XSuDPvg7+KaK6R+uJW0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iY8De0Wwxvrntws58LJYR69c6IADUtpi3h7Y6bm1H7OOK/JVk1bsB2J1aPfpp4H0jwhSIzjKAuk38VmD4SiQ3QIKcd438hNTLwcvZL99LhODeNrUE6zBuhmjuJ/TbM7IhjG08oNHP+O5/LQIUK+sIBhbiownyS3XlMrz50f23R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af243.dynamic.kabel-deutschland.de [95.90.242.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1C7B761E5FE01;
	Fri, 21 Jun 2024 09:16:01 +0200 (CEST)
Message-ID: <82e46c4b-10ba-426e-8d54-9670c8fb6373@molgen.mpg.de>
Date: Fri, 21 Jun 2024 09:16:00 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: btintel: Allow lowering of drive strength
 of BRI
To: Kiran K <kiran.k@intel.com>
Cc: ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
 chandrashekar.devegowda@intel.com, vijay.satija@intel.com,
 linux-bluetooth@vger.kernel.org
References: <20240621064419.2185652-1-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240621064419.2185652-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kiran,


Thank you for the patch.


Am 21.06.24 um 08:44 schrieb Kiran K:
> BRI (Bluetooth Radio Interface) traffic from CNVr to CNVi was found
> causing cross talk step errors to WiFi.

Interesting. Can you please elaborate how that can be detected?

> As a workaround, driver needs to
> reduce the drive strength of BRI. During *setup*, driver reads the drive
> strength value from efi variable and passes it controller via vendor

Where is this EFI variable described?

… passes it *to the* controller …

> specific command with opcode 0xfc0a.

Please document your test system and also add the new log messages.

> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>   drivers/bluetooth/btintel.c | 114 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 114 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 5d735391545a..3dc557aac43d 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -12,6 +12,8 @@
>   #include <linux/acpi.h>
>   #include <acpi/acpi_bus.h>
>   #include <asm/unaligned.h>
> +#include <linux/efi.h>
> +
>   
>   #include <net/bluetooth/bluetooth.h>
>   #include <net/bluetooth/hci_core.h>
> @@ -49,6 +51,38 @@ static const guid_t btintel_guid_dsm =
>   	GUID_INIT(0xaa10f4e0, 0x81ac, 0x4233,
>   		  0xab, 0xf6, 0x3b, 0x2a, 0xc5, 0x0e, 0x28, 0xd9);
>   
> +static void *btintel_uefi_get_variable(efi_char16_t *name, efi_guid_t *guid)
> +{
> +	void *data;
> +	efi_status_t status;
> +	size_t data_size = 0;
> +
> +	if (!IS_ENABLED(CONFIG_EFI))
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	status = efi.get_variable(name, guid, NULL, &data_size, NULL);
> +
> +	if (status != EFI_BUFFER_TOO_SMALL || !data_size)
> +		return ERR_PTR(-EIO);
> +
> +	data = kmalloc(data_size, GFP_KERNEL);
> +
> +	if (!data)
> +		return ERR_PTR(-ENOMEM);
> +
> +	status = efi.get_variable(name, guid, NULL, &data_size, data);
> +
> +	if (status != EFI_SUCCESS) {
> +		kfree(data);
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	return data;
> +}
> +
>   int btintel_check_bdaddr(struct hci_dev *hdev)
>   {
>   	struct hci_rp_read_bd_addr *bda;
> @@ -2615,6 +2649,80 @@ static u8 btintel_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
>   	return hci_skb_pkt_type(skb);
>   }
>   
> +static int btintel_set_dsbr(struct hci_dev *hdev, struct intel_version_tlv *ver)

Add a comment, what dsbr is?

> +{
> +	struct btintel_dsbr_cmd {
> +		u8 enable;
> +		u8 dsbr;
> +	} __packed;
> +
> +	struct btintel_dsbr {
> +		u8 header;
> +		u32 dsbr;
> +	} __packed;
> +
> +	struct btintel_dsbr *dsbr;
> +	struct btintel_dsbr_cmd cmd;
> +	struct sk_buff *skb;
> +	u8 status;
> +	efi_guid_t guid = EFI_GUID(0xe65d8884, 0xd4af, 0x4b20, 0x8d, 0x03,
> +				   0x77, 0x2e, 0xcc, 0x3d, 0xa5, 0x31);
> +
> +	memset(&cmd, 0, sizeof(cmd));
> +	dsbr = btintel_uefi_get_variable(L"UefiCnvCommonDSBR", &guid);
> +	if (IS_ERR(dsbr)) {
> +		/* If efi variable is not present, driver still needs to send
> +		 * 0xfc0a command with default values
> +		 */
> +		bt_dev_dbg(hdev, "Error reading efi DSBR (%ld)",

Maybe: Error reading EFI variable UefiCnvCommonDSBR (%ld)

> +			   PTR_ERR(dsbr));
> +		dsbr = NULL;
> +	}
> +
> +	if (dsbr) {
> +		/* bit0: 0 - Use firmware default value
> +		 *       1 - Override firmware value
> +		 * bit3:1 - Reserved
> +		 * bit7:4 - DSBR override values
> +		 * bt31:7 - Reserved
> +		 */
> +		cmd.enable = dsbr->dsbr & BIT(0);
> +		if (cmd.enable)
> +			cmd.dsbr = dsbr->dsbr >> 4 & 0xF;
> +		kfree(dsbr);
> +	}
> +
> +	bt_dev_info(hdev, "dsbr: enabled: 0x%2.2x value: 0x%2.2x", cmd.enable,
> +		    cmd.dsbr);
> +
> +	skb = __hci_cmd_sync(hdev, 0xfc0a, sizeof(cmd), &cmd,  HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "Failed to send Intel DSBR command (%ld)",
> +			   PTR_ERR(skb));
> +		return -bt_to_errno(PTR_ERR(skb));
> +	}
> +
> +	status = skb->data[0];
> +	kfree_skb(skb);
> +
> +	if (status) {
> +		bt_dev_err(hdev, "Set DSBR failed 0x%2.2x", status);
> +		return -bt_to_errno(status);
> +	}
> +	return 0;
> +}
> +
> +static int btintel_apply_dsbr(struct hci_dev *hdev,
> +			      struct intel_version_tlv *ver)
> +{
> +	/* For BlazarI + B0 step, DSBR command needs to be sent just after
> +	 * downloading IML firmware

Add the section of the datasheet?

> +	 */
> +	return ver->img_type == BTINTEL_IMG_IML &&
> +		((ver->cnvi_top & 0xfff) == BTINTEL_CNVI_BLAZARI) &&
> +		INTEL_CNVX_TOP_STEP(ver->cnvi_top) == 0x01;
> +}
> +
>   int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
>   				 struct intel_version_tlv *ver)
>   {
> @@ -2649,6 +2757,12 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
>   	if (err)
>   		return err;
>   
> +	if (btintel_apply_dsbr(hdev, ver)) {
> +		err = btintel_set_dsbr(hdev, ver);
> +		if (err)
> +			return err;
> +	}
> +
>   	/* If image type returned is BTINTEL_IMG_IML, then controller supports
>   	 * intermediae loader image
>   	 */


Kind regards,

Paul
