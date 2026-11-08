Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794170000;
	b=KdOdLuXIdMTys4F0nDQNI+tja1jOqy85Lr9+3/A87yMzXChS0mnAIA9JrkKR7bjVWwid
	 UyJc1AuDE39YSUZFGxETcp/UKjguMStSoBT56RqCkNgIJkMybwCBNmoriGpbj9q9jlX1y
	 i3fwP35GkYk77T9skP3TJxBI1i1huEH+yHm43uZXoUxJV0v2xHnduH/WiYFcvSqfdg0iB
	 pbHfC25iJj62GuSI8QlVcdhZ1YjmMTICsqQzUnWGSPDtldRFej0pWW3I2PK2PgLIvHEn3
	 axPlcpQexKbeaHHqGIWQ4sx8K8a9Q5J/zj8lOrkbsfe1NQG2/75gnxSY3gCWKr1BYGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794170000;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:DKIM-Signature;
	bh=CHNU6TVdfpx5qtMonYlFb8sP6BeJ7WGKp6V6CxBDrgg=;
	b=GBov9AWSrbCN5m4GVYRsj4I9RgMz4DQr7mLPazWZx+8FB4ZdNp36r/ypjMBonkNOlhpS
	 NNn873Sh4G+tk5OgO73nUyTZwlz+VvIYIaqll5uCMok/GH3evFptiMmoD1nqJshuqRT1n
	 f4dISGw6T7Bs+sXxOoc+jXhsyhdhArzjiTP4tAMLHehVTQi9yM3DrQzEw3yyrsTEZOx5e
	 zX7GDjFd8iA0PJrJoP2M0zKEslijG3OxuKRjigtvxbJocCve3wbau4TdPbpD3RnHHSP6K
	 wyPzTPjjt4JsmORi4rdeU3hsedWyS0ArX+RrRmrDyiuj3VbMpl0lqHusOPTi/YFkTqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=molgen.mpg.de;
	spf=pass smtp.mailfrom=molgen.mpg.de;
	dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=DmwCM2z3;
	arc=none smtp.remote-ip=141.14.17.11
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA029606D805
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Nov 2026 20:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA029606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=DmwCM2z3
Received: from [192.168.44.92] (unknown [185.238.219.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B9CDD4C2F4012D;
	Sun, 08 Nov 2026 21:32:58 +0100 (CET)
Message-ID: <4f6fa558-eb22-447c-ba2b-72929bb2562c@molgen.mpg.de>
Date: Sun, 8 Nov 2026 21:32:53 +0100
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: btintel: Add UEFI standalone static SAR
 support
To: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Cc: kiran.k@intel.com, linux-bluetooth@vger.kernel.org,
 chethan.tumkur.narayan@intel.com
References: <20261107085847.2866615-1-aluvala.sai.teja@intel.com>
 <20261108093656.3857961-1-aluvala.sai.teja@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20261108093656.3857961-1-aluvala.sai.teja@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de; s=20260906; 
	t=1794169979; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=CHNU6TVdfpx5qtMonYlFb8sP6BeJ7WGKp6V6CxBDrgg=; 
	b=DmwCM2z3s+oq0ao3lsKzguyw4hPhLE9p53m78oS0xtZsu550p5Fs/NJ0LqoW3LTkDDxLCCM8kQ2i
	S+M5sbCv38qACBNRhrVcMMkUnVcytz0NAzHZc0zKCpiLNcXV0hB4SjXxvanQEh9emIri0pouFEzylP
	eEj8TozJsMcpVPXg6moNOGDbsgOsyeNcA+q7ga3hwtTfwDFtqb+FaXHabPp01Fypwdv5QMfqzD1hh/
	nF8rGEk0K+ApOL7/nA1SCfMDoL6tkoVdXu/zX+gFZo1G0qKHycj0kaX78WU4y6JNs5Zk2v0rmcZvyL
	DB6G7ofkEOfLGTYhYf9Kf/IMMzKMueRQ==

Dear Sai,


Thank you for patch.

Am 08.11.26 um 10:36 schrieb Sai Teja Aluvala:
> Scorpius Peak2 and later platforms, excluding BlazarI and BlazarIW,
> provide standalone static SAR limits through the UefiCnvBtBSSS
> variable. Applying these limits requires SAR to be enabled in
> UefiCnvBtBRDS as well as in BSSS.

For non-UEFI elaborating what BSSS is would be helpful.

> Read the revision 2 UEFI BRDS and BSSS variables using their shared
> layout. Program the BRDS 2.4 GHz limits, then enable standalone SAR
> and write the BSSS per-chain sub-band limits. Send SAR initialization
> complete after the DDC writes.
> 
> Reuse the existing SAR DDC helpers and configure UEFI SAR before
> running the existing ACPI BRDS path. Keep the ACPI platform and

Why before and not after?

> revision checks unchanged, independently of the UEFI result.

Please add how you tested this, including how to manually read the 
variables and possible new log message.

> Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
> ---
> Changes in v2:
> Address all six findings from the netdev Sashiko cross-review:
> - Attempt SAR initialization complete after any UEFI DDC attempt,
>    including error paths, while preserving the original error.
> - Clarify the other five findings with firmware-confirmed comments on
>    BRDS/BSSS DDC semantics, initial mode independence, ACPI coexistence
>    and CNVr coverage.
> 
>   drivers/bluetooth/btintel.c | 173 ++++++++++++++++++++++++++++++++----
>   1 file changed, 156 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index a0aa110f4cdd..3612d8da81e5 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -29,6 +29,21 @@
>   #define ECDSA_HEADER_LEN	320
>   
>   #define BTINTEL_EFI_DSBR	L"UefiCnvCommonDSBR"
> +#define BTINTEL_EFI_BRDS	L"UefiCnvBtBRDS"
> +#define BTINTEL_EFI_BSSS	L"UefiCnvBtBSSS"
> +
> +static efi_guid_t btintel_efi_sar_guid =
> +	EFI_GUID(0x42780dd5, 0x9a7d, 0x404c,
> +		 0x80, 0xe4, 0x7f, 0x70, 0x94, 0x36, 0x03, 0x94);
> +
> +/* BRDS and BSSS revision 2 use the same 19-byte UEFI layout. */
> +struct btintel_uefi_sar {
> +	u8 revision;
> +	__le32 mode;
> +	__le32 inc_power_mode;
> +	u8 chain_a[5];
> +	u8 chain_b[5];
> +} __packed;
>   
>   enum {
>   	DSM_SET_WDISABLE2_DELAY = 1,
> @@ -3093,6 +3108,8 @@ static union acpi_object *btintel_acpi_get_bt_pkg(union acpi_object *buffer)
>   	return ERR_PTR(-ENOENT);
>   }
>   
> +#endif /* CONFIG_ACPI */
> +
>   static int btintel_send_sar_ddc(struct hci_dev *hdev, struct btintel_cp_ddc_write *data, u8 len)
>   {
>   	struct sk_buff *skb;
> @@ -3107,6 +3124,24 @@ static int btintel_send_sar_ddc(struct hci_dev *hdev, struct btintel_cp_ddc_writ
>   	return 0;
>   }
>   
> +/* btintel_send_sar_rev2_band - send DDC command for one Rev2 sub-band

Follow comment style from Linux coding style?

/*
  * …

> + *
> + * Each DDC 0x0311-0x0316 carries 2 bytes: [ChainA_value, ChainB_value].
> + * cmd->len = 4  (2 id + 2 data)
> + * HCI total  = 5 bytes (1 len + 4)
> + */
> +static int btintel_send_sar_rev2_band(struct hci_dev *hdev,
> +				      struct btintel_cp_ddc_write *cmd,
> +				      u16 id, u8 chain_a, u8 chain_b)
> +{
> +	cmd->len = 4;
> +	cmd->id = cpu_to_le16(id);
> +	cmd->data[0] = chain_a;
> +	cmd->data[1] = chain_b;
> +	return btintel_send_sar_ddc(hdev, cmd, 5);
> +}
> +
> +#ifdef CONFIG_ACPI
>   static int btintel_send_edr(struct hci_dev *hdev, struct btintel_cp_ddc_write *cmd,
>   			    int id, struct btintel_sar_inc_pwr *sar)
>   {
> @@ -3260,23 +3295,6 @@ static int btintel_set_mutual_sar(struct hci_dev *hdev, struct btintel_sar_inc_p
>   	return 0;
>   }
>   
> -/* btintel_send_sar_rev2_band - send DDC command for one Rev2 sub-band
> - *
> - * Each DDC 0x0311-0x0316 carries 2 bytes: [ChainA_value, ChainB_value].
> - * cmd->len = 4  (2 id + 2 data)
> - * HCI total  = 5 bytes (1 len + 4)
> - */
> -static int btintel_send_sar_rev2_band(struct hci_dev *hdev,
> -				      struct btintel_cp_ddc_write *cmd,
> -				      u16 id, u8 chain_a, u8 chain_b)
> -{
> -	cmd->len = 4;
> -	cmd->id = cpu_to_le16(id);
> -	cmd->data[0] = chain_a;
> -	cmd->data[1] = chain_b;
> -	return btintel_send_sar_ddc(hdev, cmd, 5);
> -}
> -
>   static int btintel_set_sar_rev2(struct hci_dev *hdev,
>   				struct btintel_sar_rev2 *sar)
>   {
> @@ -3544,9 +3562,130 @@ static int btintel_acpi_set_sar(struct hci_dev *hdev, struct intel_version_tlv *
>   }
>   #endif /* CONFIG_ACPI */
>   
> +static int btintel_uefi_read_sar(struct hci_dev *hdev, efi_char16_t *name,
> +				 struct btintel_uefi_sar *sar)
> +{
> +	unsigned long size = sizeof(*sar);
> +	efi_status_t status;
> +
> +	if (!IS_ENABLED(CONFIG_EFI) ||
> +	    !efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
> +		return -EOPNOTSUPP;
> +
> +	status = efi.get_variable(name, &btintel_efi_sar_guid, NULL, &size, sar);
> +	if (status == EFI_NOT_FOUND)
> +		return -ENOENT;
> +	if (status == EFI_BUFFER_TOO_SMALL)
> +		return -EOPNOTSUPP;
> +	if (status != EFI_SUCCESS) {
> +		bt_dev_warn(hdev, "Failed to read UEFI SAR variable: 0x%lx",

Mention what the user should do in this case?

> +			    status);
> +		return -EIO;
> +	}
> +
> +	if (size != sizeof(*sar))
> +		return -EINVAL;
> +	if (sar->revision != BTINTEL_SAR_REV2)
> +		return -EOPNOTSUPP;
> +	if (!(le32_to_cpu(sar->mode) & BIT(0)))
> +		return -EOPNOTSUPP;

Log at least debug messages for al the above error cases?

> +
> +	return 0;
> +}
> +
> +static int btintel_set_uefi_sar(struct hci_dev *hdev)
> +{
> +	/* 5G8 and 5G9 share a limit but have separate DDC identifiers. */
> +	static const struct {
> +		u16 id;
> +		u8 band;
> +	} bands[] = {
> +		{ 0x0311, 0 },
> +		{ 0x0312, 1 },
> +		{ 0x0313, 2 },
> +		{ 0x0314, 2 },
> +		{ 0x0315, 3 },
> +		{ 0x0316, 4 },
> +	};
> +	u8 buffer[sizeof(struct btintel_cp_ddc_write) + 2];
> +	struct btintel_cp_ddc_write *cmd = (void *)buffer;
> +	struct btintel_uefi_sar sar;
> +	struct sk_buff *skb;
> +	u8 enable = 1;
> +	int ret, i;
> +
> +	ret = btintel_uefi_read_sar(hdev, BTINTEL_EFI_BRDS, &sar);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * UEFI BRDS uses only the 2.4 GHz limits; BSSS supplies sub-band limits.
> +	 * Firmware accepts this BRDS write regardless of the existing 0x019e
> +	 * value, including a value previously set by the DDC configuration.
> +	 */
> +	ret = btintel_send_sar_rev2_band(hdev, cmd, 0x0311,
> +					 sar.chain_a[0], sar.chain_b[0]);
> +	if (ret)
> +		goto complete;
> +
> +	/* Standalone limits require both BRDS and BSSS to be enabled. */
> +	ret = btintel_uefi_read_sar(hdev, BTINTEL_EFI_BSSS, &sar);
> +	if (!ret) {
> +		cmd->len = 3;
> +		/* UEFI BSSS requires 0x019e = 1; inc_power_mode is not used here. */
> +		cmd->id = cpu_to_le16(0x019e);
> +		cmd->data[0] = enable;
> +		ret = btintel_send_sar_ddc(hdev, cmd, sizeof(*cmd) + 1);
> +		if (ret)
> +			goto complete;
> +
> +		/* In this UEFI sequence, firmware interprets these writes as BSSS limits. */

What is an “UEFI sequence”?

> +		for (i = 0; i < ARRAY_SIZE(bands); i++) {
> +			ret = btintel_send_sar_rev2_band(hdev, cmd, bands[i].id,
> +							 sar.chain_a[bands[i].band],
> +							 sar.chain_b[bands[i].band]);
> +			if (ret)
> +				goto complete;
> +		}
> +	} else if (ret != -ENOENT && ret != -EOPNOTSUPP) {
> +		goto complete;
> +	} else {
> +		ret = 0;
> +	}
> +
> +complete:
> +	skb = __hci_cmd_sync(hdev, 0xfe25, sizeof(enable), &enable,
> +			     HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_warn(hdev, "Failed to complete UEFI SAR setup (%ld)",
> +			    PTR_ERR(skb));
> +		return ret ? ret : PTR_ERR(skb);

Should `ret` be added to the warning, should it exist?

> +	}
> +
> +	kfree_skb(skb);
> +	return ret;
> +}
> +
>   static int btintel_set_specific_absorption_rate(struct hci_dev *hdev,
>   						struct intel_version_tlv *ver)
>   {
> +	u8 hw_variant = INTEL_HW_VARIANT(ver->cnvi_bt);
> +	int ret;
> +
> +	/* Supported SCP2+ platforms use this UEFI DDC map regardless of CNVr. */
> +	if (hw_variant >= BTINTEL_HWID_SCP2 &&
> +	    hw_variant != BTINTEL_HWID_BZRI &&
> +	    hw_variant != BTINTEL_HWID_BZRIW) {
> +		ret = btintel_set_uefi_sar(hdev);
> +		if (ret && ret != -ENOENT && ret != -EOPNOTSUPP)
> +			bt_dev_warn(hdev, "Failed to configure UEFI SAR (%d)", ret);

Two warnings are logged now?

> +	}
> +
> +	/*
> +	 * Firmware preserves BSSS configuration across subsequent ACPI BRDS
> +	 * programming, including writes to the shared DDC IDs and 0x019e.
> +	 * Keep ACPI BRDS handling independent of the UEFI result.
> +	 */
>   #ifdef CONFIG_ACPI
>   	return btintel_acpi_set_sar(hdev, ver);
>   #endif

Is it possible that SAR programming is done twice now?


Kind regards,

Paul
