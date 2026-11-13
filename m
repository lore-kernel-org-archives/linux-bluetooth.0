Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794561347;
	b=2PW6bjdyreR3lHytQpmuzgETQc9XIPdy27nIqVzkua9TodP4dqwrN9fo2opXGVBq29o3
	 NwHphsSTKLzFsO6rRSGmf8ltuJCid1gb/F3XLu440sjz867M/qj0uykBxiC1JvoCmhE20
	 uGvmR/sWGh7nYPHX4yrEBIqK8bhx0L9+Vo/HsJUgW+nLAbQa6m89ewJZDRXFKOhT/GlYO
	 WMDWmt6EcDvNWKm1wHVMHu2THttqfbfYJsykgqjEHvEf+zfAtwI+dpmdZCRfJ1Ns3YcfY
	 vtlbImLrndZRMuO2YEPrMWCMxv9ME5+N7ZSqYdX8jgcWbsi4MGrJ+pt48c3TCvaSJxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794561347;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:DKIM-Signature;
	bh=fU5Neoe78Mt6jA+2d9styoQFJY5fyxh/1FhK7doYsQA=;
	b=xk6wKA53rwx6DzqpoSpuOnKTqlHPnbQzvZIgqf/YyPTo/jmRqcu/5n0eHcJZh52z4S0J
	 3qSgPtm3jusrW4b16c/zKo6M7phgKm5OnBGnfU3PpL/Z6mwBapeMqcCU4lONSoW2piOAP
	 HBe31vYD4MNMMT6s5Xv2LlRxY1A7VIZ3jd/W8wg4qKPU4p0jKDh6+n9cjEUhd0FYHlKD4
	 SSQewKFq6yzIbP0XHY9qrhqZEtLqjlh15OBvJ0jpupTQrYFBjECegsq9bwjTuMA7Endb5
	 atIh1cjTpxrL/Qh8UdL400cZxVXNsS/VpMdJRY7WjmS+gdrJoNF03xxOIAKhTfmlMQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=molgen.mpg.de;
	spf=pass smtp.mailfrom=molgen.mpg.de;
	dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=LY4VcVYw;
	arc=none smtp.remote-ip=141.14.17.11
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3951A606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 09:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3951A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=LY4VcVYw
Received: from [192.168.0.32] (ip-095-090-245-070.vkd79.pools.vodafone-ip.de [95.90.245.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0B8A64C442F80D;
	Fri, 13 Nov 2026 10:15:22 +0100 (CET)
Message-ID: <d41821ea-bba9-4024-9b02-1547d3a93c90@molgen.mpg.de>
Date: Fri, 13 Nov 2026 10:15:21 +0100
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
Subject: Re: [PATCH v6 1/2] Bluetooth: btintel: Add TOP silent reset hooks
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com,
 kiran.k@intel.com
References: <20261113052538.3030771-1-chandrashekar.devegowda@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20261113052538.3030771-1-chandrashekar.devegowda@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de; s=20260906; 
	t=1794561322; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=fU5Neoe78Mt6jA+2d9styoQFJY5fyxh/1FhK7doYsQA=; 
	b=LY4VcVYwqXEZ245XBcAfYROAmeWFg8pebvnx2xkkCnZhAeUe+pDYdPgVJ26/nGrLsf6RYegWm8G4
	jQ9HlopRWhfjNv22o0MQdZKCuPJrE3dYnftr6Drv/QcD1F8dnBLOjyL3MPinX/nXcP0KIHw0ZKi6Ht
	do+f4JJ7Dsqk57xoXl2pS8wnS537XZyb3dzROsbgzI183Bs8O4Kq0gmr77voW+7ETFwWFbKfixA8Cc
	/aN1v3h4uRGxoJoIKkIFrpIuDBAyJuN6W+rsazjuHSJJUk0nEbUfWTLeqf1H8Cpw+FFURppZ1FKVfo
	DzBHMUTy8aW+gLF6qeG46yIseL275X4g==

Dear Chandrashekar,


Thank you for your patch.

Am 13.11.26 um 06:25 schrieb Chandrashekar Devegowda:
> Add an INTEL_TOP_RESET flag so btintel_boot() returns -ECANCELED and
> the transport can run its own TOP silent reset instead of the Intel
> soft reset. Cache boot_addr in struct btintel_data for the replay.

A motivation for this change would be nice to have.

> No functional change on its own.

Maybe:

No change until a transport sets INTEL_TOP_RESET.

> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> ---
>   drivers/bluetooth/btintel.c | 28 ++++++++++++++++++++++++++++
>   drivers/bluetooth/btintel.h |  2 ++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index a0aa110f4cdd..de0868504fbe 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -1281,6 +1281,12 @@ static bool btintel_firmware_version(struct hci_dev *hdev,
>   {
>   	const u8 *fw_ptr;
>   
> +	if (hdev->bus == HCI_PCI) {
> +		struct btintel_data *data = hci_get_priv(hdev);

As you also read it in the next hunk, move that assignment out of the 
loop, and remove it from the second hunk?

> +
> +		data->boot_addr = 0;

Add a comment, that the cache needs to be invalidated, when a new image 
is loaded? Maybe:

invalidate the cache, we are about to parse a different image

> +	}
> +
>   	fw_ptr = fw->data;
>   
>   	while (fw_ptr - fw->data < fw->size) {
> @@ -1298,6 +1304,12 @@ static bool btintel_firmware_version(struct hci_dev *hdev,
>   
>   			*boot_addr = le32_to_cpu(params->boot_addr);
>   
> +			if (hdev->bus == HCI_PCI) {
> +				struct btintel_data *data = hci_get_priv(hdev);
> +
> +				data->boot_addr = *boot_addr;

boot_addr == 0 now means two different things: “no BOOT_ADDR TLV in this 
image” and “transport is not PCIe”. Could that be a problem?

> +			}
> +
>   			bt_dev_info(hdev, "Boot Address: 0x%x", *boot_addr);
>   
>   			bt_dev_info(hdev, "Firmware Version: %u-%u.%u",
> @@ -2107,6 +2119,13 @@ static int btintel_boot(struct hci_dev *hdev, u32 boot_addr)
>   	ktime_t calltime;
>   	int err;
>   
> +	/* Let the transport replace the Intel soft reset for a TOP reset */
> +	if (hdev->bus == HCI_PCI &&
> +	    btintel_test_flag(hdev, INTEL_TOP_RESET)) {
> +		bt_dev_info(hdev, "TOP reset pending, skipping Intel soft reset");

Should this be a debug message, or is it interesting for users or bug 
reports, where `dmesg` output gets attached?

> +		return -ECANCELED;
> +	}
> +
>   	calltime = ktime_get();
>   
>   	btintel_set_flag(hdev, INTEL_BOOTING);
> @@ -3595,6 +3614,7 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
>   	struct intel_version_tlv new_ver;
>   	struct btintel_data *data = hci_get_priv(hdev);
>   	u8 hw_variant = INTEL_HW_VARIANT(ver->cnvi_bt);
> +	bool top_reset = btintel_test_flag(hdev, INTEL_TOP_RESET);
>   
>   	bt_dev_dbg(hdev, "");
>   
> @@ -3611,10 +3631,18 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
>   	for (int i = 0; i < __INTEL_NUM_FLAGS; i++)
>   		btintel_clear_flag(hdev, i);
>   
> +	if (top_reset)
> +		btintel_set_flag(hdev, INTEL_TOP_RESET);
> +
>   	btintel_set_flag(hdev, INTEL_BOOTLOADER);
>   
>   	data->unlocker = false;
>   
> +	if (top_reset && ver->img_type == BTINTEL_IMG_OP) {
> +		bt_dev_err(hdev, "TOP reset requested on operational image");

Elaborate, so that a normal user reading output of `dmesg` knows what’s 
wrong, and what should be done. What is an “operational image”?

> +		return -EALREADY;
> +	}
> +
>   	/* Legacy unlocker flow (BlazarI / BlazarIW / BlazarU / Gale Peak):
>   	 * Boot ROM -> unlocker.sfi -> IML -> OPFW
>   	 *
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index 372c6d7d8cbe..a59d642f096e 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -260,6 +260,7 @@ enum {
>   	INTEL_ACPI_RESET_ACTIVE,
>   	INTEL_WAIT_FOR_D0,
>   	INTEL_UNLOCKER_LOADED,
> +	INTEL_TOP_RESET,
>   
>   	__INTEL_NUM_FLAGS,
>   };
> @@ -268,6 +269,7 @@ struct btintel_data {
>   	DECLARE_BITMAP(flags, __INTEL_NUM_FLAGS);
>   	int (*acpi_reset_method)(struct hci_dev *hdev);
>   	u32 cnvi_bt;
> +	u32 boot_addr;
>   	bool	unlocker;
>   };


Kind regards,

Paul
