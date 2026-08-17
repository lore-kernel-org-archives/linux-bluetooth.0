Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098DA3F9F39;
	Mon, 17 Aug 2026 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786963554; cv=none; b=eHYcYXxD90exdcf4zPEHTXYqzFQjkjqCVBXwMsD+I+IpLKMfQnn09Io5Rpxpz92T6wDSe2vmA1k6apaMI7W1SFFxDpWd5THGufVdnAnn8reJVXXGVZdSWeFd/1inHmeURstMoZ5Nf87RD2Y/rFQiaAjEH6k08zXcpFT8aW+7MRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786963554; c=relaxed/simple;
	bh=XeVGDTKEG2Xuig58w6D3a2a5C5ZGZ/pNIVpyqcJ+nsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UkdcNe+MnXrWpOo36maHR0fT1gHGVV0x1awgGbdwEguhYqgqIH6ADXj4BNrm/v6pAmwgl0qlrhNmTQejCalIKjFZ99ynOpWVSivbqhIJjMulNPVwVvjFQzMSqJBHiGwkieDfLG3XRhnXPxhlzXiXGTLUVLTTT5VNE5AjihP29hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id BD9404C2C37D5E;
	Mon, 17 Aug 2026 12:45:33 +0200 (CEST)
Message-ID: <249ec9cf-a595-4e92-80ee-c47e5ea6ad73@molgen.mpg.de>
Date: Mon, 17 Aug 2026 12:45:32 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Bluetooth: btbcm: Add Synaptics 4384 chip support
To: Kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linusw@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kaihsin Chung <kaihsin.chung@synaptics.com>
References: <20260817095550.648774-1-kaihsin.chung@synaptics.com>
 <20260817095550.648774-3-kaihsin.chung@synaptics.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260817095550.648774-3-kaihsin.chung@synaptics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kaihsin,


Thank you for your patch. Please remember to version patch iterations. 
This should have been [PATCH v2 …]. `git format-patch -v2 …` would do that.

Am 17.08.26 um 11:55 schrieb Kaihsin Chung:
> Add support for the Synaptics 4384 Bluetooth controller
> by adding the corresponding chip IDs.

Please add a blank line between paragraphs.

> Verify the change on the VIM3 platform.Verified

Please add a dot after the dot/period.

> that the controller initializes successfully and
> that firmware loading and basic Bluetooth operation
> work as expected.

What is the VIM3 platform. Maybe extend a little. You could also paste 
the new message.

> Signed-off-by: Kaihsin Chung <kaihsin.chung@synaptics.com>
> ---
>   drivers/bluetooth/btbcm.c   | 6 +++++-
>   drivers/bluetooth/hci_bcm.c | 1 +
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 463d59890bef..63c4c788d9c4 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -31,6 +31,7 @@
>   #define BDADDR_BCM4334B0 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb0, 0x34, 0x43}})
>   #define BDADDR_BCM4345C5 (&(bdaddr_t) {{0xac, 0x1f, 0x00, 0xc5, 0x45, 0x43}})
>   #define BDADDR_BCM43341B (&(bdaddr_t) {{0xac, 0x1f, 0x00, 0x1b, 0x34, 0x43}})
> +#define BDADDR_BCM4384B0 (&(bdaddr_t) {{0x93, 0x76, 0x00, 0xb0, 0x84, 0x43}})
>   
>   #define BCM_FW_NAME_LEN			64
>   #define BCM_FW_NAME_COUNT_MAX		4
> @@ -130,7 +131,8 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
>   	    !bacmp(&bda->bdaddr, BDADDR_BCM4345C5) ||
>   	    !bacmp(&bda->bdaddr, BDADDR_BCM43430A0) ||
>   	    !bacmp(&bda->bdaddr, BDADDR_BCM43430A1) ||
> -	    !bacmp(&bda->bdaddr, BDADDR_BCM43341B)) {
> +	    !bacmp(&bda->bdaddr, BDADDR_BCM43341B) ||
> +	    !bacmp(&bda->bdaddr, BDADDR_BCM4384B0)) {
>   		/* Try falling back to BDADDR EFI variable */
>   		if (btbcm_set_bdaddr_from_efi(hdev) != 0) {
>   			bt_dev_info(hdev, "BCM: Using default device address (%pMR)",
> @@ -514,6 +516,8 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
>   	{ 0x4106, "BCM4335A0"	},	/* 002.001.006 */
>   	{ 0x410c, "BCM43430B0"	},	/* 002.001.012 */
>   	{ 0x2119, "BCM4373A0"	},	/* 001.001.025 */
> +	{ 0x2128, "BCM4384A0"	},	/* 001.001.040 */
> +	{ 0x4119, "BCM4384B0"	},	/* 002.001.025 */
>   	{ }
>   };
>   
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 9a103db7e355..e70b9f3fd968 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -1593,6 +1593,7 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
>   	{ .compatible = "brcm,bcm4349-bt", .data = &bcm43438_device_data },
>   	{ .compatible = "brcm,bcm43540-bt", .data = &bcm4354_device_data },
>   	{ .compatible = "brcm,bcm4335a0" },
> +	{ .compatible = "brcm,bcm4384-bt" },
>   	{ .compatible = "cypress,cyw4373a0-bt", .data = &cyw4373a0_device_data },
>   	{ .compatible = "infineon,cyw55572-bt", .data = &cyw55572_device_data },
>   	{ },

Please feel free to add:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
