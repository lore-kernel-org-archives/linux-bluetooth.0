Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713C0318146;
	Thu,  2 Apr 2026 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144545; cv=none; b=IYu2/a0qK/5Qs7iAzUuWNnicCoF6Hilw1oColHXASfh7PMQcMkFtM02sMYNE6SYB3DQGWrw7v5ZcbIPeX0fTPbAKiBCRUEhdZjulNa8UMTgJFZ9KD8ut35iLfZS+UZGYHTzbmMC7xLxgC11XDxu7gnol2AO840VtEK/4AJXSQdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144545; c=relaxed/simple;
	bh=1osYIspVdT+t+G8ZRj7AjtHm0wdgyKKg8w3AgCiXdhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0aljKezxbq57A5WHgmMq2BKUrpKd6rLM7GHGT9gsYzQBvNv8IXQzNUU/kHuu6UShKNuuBph6Dx71/M2N0SaIeZxKCoXP0Pnr7GyF6lPTssDO+o23ekVcA943pdzkkwkLGGHSU9S2kE31+HG4YcZF3NV0HPKx0ibjgEr6VYXyuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 307064C2C37D49;
	Thu, 02 Apr 2026 17:41:27 +0200 (CEST)
Message-ID: <4736768a-e391-4f70-9821-7386efedf3b3@molgen.mpg.de>
Date: Thu, 2 Apr 2026 17:41:25 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btmtk: hide unused btmtk_mt6639_devs[] array
To: Arnd Bergmann <arnd@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Javier Tia <floss@jetm.me>, Arnd Bergmann <arnd@arndb.de>,
 Chris Lu <chris.lu@mediatek.com>, Kees Cook <kees@kernel.org>,
 Johan Hovold <johan@kernel.org>, Sean Wang <sean.wang@mediatek.com>,
 Jiande Lu <jiande.lu@mediatek.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20260402141119.2732591-1-arnd@kernel.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260402141119.2732591-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Arnd,


Thank you for your patch.

Am 02.04.26 um 16:11 schrieb Arnd Bergmann:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When USB support is disabled, the array is not referenced anywhere,
> causing a warning:
> 
> drivers/bluetooth/btmtk.c:35:3: error: 'btmtk_mt6639_devs' defined but not used [-Werror=unused-const-variable=]
>     35 | } btmtk_mt6639_devs[] = {
>        |   ^~~~~~~~~~~~~~~~~
> 
> Move it into the #ifdef block.
> 
> Fixes: 4cdd001ff03f ("Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/bluetooth/btmtk.c | 32 ++++++++++++++++----------------
>   1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 099188bf772e..6fb6ca274808 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -25,22 +25,6 @@
>   /* It is for mt79xx iso data transmission setting */
>   #define MTK_ISO_THRESHOLD	264
>   
> -/* Known MT6639 (MT7927) Bluetooth USB devices.
> - * Used to scope the zero-CHIPID workaround to real MT6639 hardware,
> - * since some boards return 0x0000 from the MMIO chip ID register.
> - */
> -static const struct {
> -	u16 vendor;
> -	u16 product;
> -} btmtk_mt6639_devs[] = {
> -	{ 0x0489, 0xe13a },	/* ASUS ROG Crosshair X870E Hero */
> -	{ 0x0489, 0xe0fa },	/* Lenovo Legion Pro 7 16ARX9 */
> -	{ 0x0489, 0xe10f },	/* Gigabyte Z790 AORUS MASTER X */
> -	{ 0x0489, 0xe110 },	/* MSI X870E Ace Max */
> -	{ 0x0489, 0xe116 },	/* TP-Link Archer TBE550E */
> -	{ 0x13d3, 0x3588 },	/* ASUS ROG STRIX X870E-E */
> -};
> -
>   struct btmtk_patch_header {
>   	u8 datetime[16];
>   	u8 platform[4];
> @@ -483,6 +467,22 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
>   EXPORT_SYMBOL_GPL(btmtk_process_coredump);
>   
>   #if IS_ENABLED(CONFIG_BT_HCIBTUSB_MTK)
> +/* Known MT6639 (MT7927) Bluetooth USB devices.
> + * Used to scope the zero-CHIPID workaround to real MT6639 hardware,
> + * since some boards return 0x0000 from the MMIO chip ID register.
> + */
> +static const struct {
> +	u16 vendor;
> +	u16 product;
> +} btmtk_mt6639_devs[] = {
> +	{ 0x0489, 0xe13a },	/* ASUS ROG Crosshair X870E Hero */
> +	{ 0x0489, 0xe0fa },	/* Lenovo Legion Pro 7 16ARX9 */
> +	{ 0x0489, 0xe10f },	/* Gigabyte Z790 AORUS MASTER X */
> +	{ 0x0489, 0xe110 },	/* MSI X870E Ace Max */
> +	{ 0x0489, 0xe116 },	/* TP-Link Archer TBE550E */
> +	{ 0x13d3, 0x3588 },	/* ASUS ROG STRIX X870E-E */
> +};
> +
>   static void btmtk_usb_wmt_recv(struct urb *urb)
>   {
>   	struct hci_dev *hdev = urb->context;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
