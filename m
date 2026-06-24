Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935FB233947;
	Wed, 24 Jun 2026 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782304258; cv=none; b=nG5tIeK03zCNPzOUxNUcLfbu4FqWULwFGr6MBAF9xFEJaqmDNK5WiSWOK/aw0IMYn9Jk34IaBqJsze5o/gxBgn1rAcRvynk4Zr22uDRX3ge2p0/fUWCSpG7573cBGxOw4DFzELPvg5bmwJd5eOHHHr7QNoUdWMRlCQZO5Rug6Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782304258; c=relaxed/simple;
	bh=7bWAolRetDET6aCNZlUXme7/YEJxFa0vRg7alUITGao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a9uIFm0SY5Ek7MOtAiIuQ1mVEniqYvmIFWI0qQ0B22Auq5mdT7G4czk8yGfFg5nq3WUZeLqi9B91eXMxFPHNFlqCNiv/Ci9jXcN8ZxXZMxzHHxGzxl8h+/G2IWwjEhtjaZt9Xa44ll+7d2eAIlv5O8XpARZMZx31v3fwnM4vDiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4DF144C28871A7;
	Wed, 24 Jun 2026 14:30:38 +0200 (CEST)
Message-ID: <42a5c2a4-bd1f-48da-9634-04ad03923923@molgen.mpg.de>
Date: Wed, 24 Jun 2026 14:30:37 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] Bluetooth: btbcm: Add Synaptics 4384 chip support
To: Kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kaihsin Chung <kaihsin.chung@synaptics.com>
References: <20260624081947.2495351-1-kaihsin.chung@synaptics.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260624081947.2495351-1-kaihsin.chung@synaptics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Kaihsin,


Thank you for your patch. Just a note, that your given name should also 
start with a capital letter.

Am 24.06.26 um 10:19 schrieb kaihsin Chung:
> Add support for the Synaptics 4384 Bluetooth controller
> by adding the corresponding chip IDs.

Please mention the source for the ids, like a datasheet name.

Also, please document in the commit message, how you tested this.

> Signed-off-by: Kaihsin Chung <kaihsin.chung@synaptics.com>
> ---
>   drivers/bluetooth/btbcm.c   | 6 +++++-
>   drivers/bluetooth/hci_bcm.c | 1 +
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 463d59890bef..1caa1c9468d8 100644
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
> +	{ 0x2128, "BCM4384A0" },/* 001.001.040 */
> +	{ 0x4119, "BCM4384B0"},/* 002.001.025 */

Please align everything with the existing lines (} and /*).

>   	{ }
>   };
>   
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 1a4fc3882fd2..d306da6a46ff 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -1594,6 +1594,7 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
>   	{ .compatible = "brcm,bcm4335a0" },
>   	{ .compatible = "cypress,cyw4373a0-bt", .data = &cyw4373a0_device_data },
>   	{ .compatible = "infineon,cyw55572-bt", .data = &cyw55572_device_data },
> +	{ .compatible = "brcm,bcm4384-bt" },

Put it two lines above below the existing brcm line?

>   	{ },
>   };
>   MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);


Kind regards,

Paul
