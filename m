Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C052D6E5C;
	Mon, 17 Aug 2026 09:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786959457; cv=none; b=cYA7KJ2nUnQGNt9WkjsNEUHYnJjJCN7IkW/l5qrh7DBfN6qGjRiJbG7OoYcfPCjEVfZAXEpgnjJBJN305CHLVV+Z+pj+fVIV9/t7pHLnwcMmnPkyVWL8InO+bN4OmH9GpcbpMMCFX/KKeWl/d4TLgiT0cImhPgijMnqRyK5EZ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786959457; c=relaxed/simple;
	bh=mIhKByX7MZ6KTXDY5LvRr5rjcXA6ez/z5mQHQ/Xegyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p7WTsEWcdBfbe88q8iD2QByVOd8/W3GXTxOCK22G3RXD2ObXJyt7NXLL1a54cbxEoSRF067B/VG+Kmqr5PBmp7XKhUQ1apzy1px7QI6WfICVHc5uMQFT2YiA18PuUnQalPjrTbjPMSpP2j1zE0C9eIfgNGepP4oZVXxb1bFUHwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9FCE84C2C37D5B;
	Mon, 17 Aug 2026 11:36:59 +0200 (CEST)
Message-ID: <26d7789c-aaf9-4e08-b90f-6cf915a5787e@molgen.mpg.de>
Date: Mon, 17 Aug 2026 11:36:57 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Bluetooth: btbcm: Add Synaptics 4384 chip support Add
 support for the Synaptics 4384 Bluetooth controller by adding the
 corresponding chip IDs.
To: kaihsin.chung@synaptics.corp-partner.google.com
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linusw@kernel.org,
 linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kaihsin.chung@synaptics.com
References: <20260817092723.637956-1-kaihsin.chung@synaptics.com>
 <20260817092723.637956-3-kaihsin.chung@synaptics.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260817092723.637956-3-kaihsin.chung@synaptics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kaihsin,


Thank you for your patch.

Am 17.08.26 um 11:27 schrieb kaihsin:
> Verify the change on the VIM3 platform

The commit message got mangled somehow, and the summary/title is too 
long. Please resend.

> Signed-off-by: kaihsin <kaihsin.chung@synaptics.com>

Please configure your full name in the author and SoB tag.

     $ git config --global user.name "…"
     $ git config --global user.email kaihsin.chung@synaptics.com
     $ git commit --amend -s --reset-author="… 
<kaihsin.chung@synaptics.com>" # probably git rebase -i HEAD~2 before

Please document how you tested this patch.

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

The diff looks good.


Kind regards,

Paul
