Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965763C9880
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901868; cv=none; b=NssGcEz+Cx15UA+/7WADPo2jVg1lQDuE7S0dsOQjbEepkql6yJHYJ1S7XUWaQTG19W7nSr5v9YIzELEhVsScotS/CwrOOtkalziXcojvsIx645kU6X5fd9zwoGJuKcDQSbM6I+p0u591PmLPht6STgkcUwFpopWJcjQvowaZHUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901868; c=relaxed/simple;
	bh=ZBdXw1WoDcwiCjaUv4MZLM0wbiCftyZoNgtoRmvAeEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDGsjF7uj8d4a/40yG3jUPxJ4dcZiWcM0H3sBVcA/U8mopmNTihriclDYVmM+z0kQsSj28UF3EEUn6eXlvpsj0nrbQznS59LBW12NlLfmeY/Ms3Ben64Mo8/SxlmRCNJW0mFQSNB6wAkGGeBxefM1BAIaG2VP/a67XAY7fwWQaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuNgpwud; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuNgpwud"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e2406so6565425e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 14:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788901865; x=1789506665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sMHh5XXdQcxwm528CdURMvQM1pvniFLZf/cfKJK1eCE=;
        b=KuNgpwudimnhm4cKsMoNKz7X99aV33vhTSlduzB5NmlCh7/2QXnOFI9vcC4Fhc5C6P
         stpyolMOwsllTl55nVenw10khksTrh8zOy8eWYzlJd4GpYXX+bw63DAAR+S0WxAaJy1L
         uLaKfICBDcpT7Xflcv0obw1ZKWKgcT98Oe5Zl4FKn9PUYZ7bTOfkHMtuXmcgA+OODcyj
         k2IhkUX4tmneLt5HqroGSY6R/NNltSUOXRTxMxNQ/HA1JadSi8/w5gcFG+2M/IsubATy
         VD22O4VpYYzYcfT2673cS6ZI1DdkwtlmMFyBEFQkJvQd3vHwxyTuNJ7fteze2TjMZP8W
         WazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788901865; x=1789506665;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sMHh5XXdQcxwm528CdURMvQM1pvniFLZf/cfKJK1eCE=;
        b=VzG5/mk1qddufK2n93RtcjwQQDMt85tKHky9XsFp/7lDQYBtFfF4SZu8NC9DxMnKi6
         vjoLDGggi8Z1z0ufRiJ4/ldtaKENxx4Y5T4rJwYXeeSG7p7YVq2Dz2Y4neKomhdPD8Sh
         jZkMtH6uBEEggSwuPU0QUn2DWC5HUnpvZ+ECLHQljoFhICbKalpUGoEljzUm6Ilap/TX
         ccRLgxqJjF8yVF5PFcSq88dvSFKzZ3+tWFM41nKoEK8rWBgkfUcfaabsjj1o6VmKaKyh
         Rp0QveX5FJ5IYsguOQX1eb2mc4yJQcm+odpLowpOWiE8Oje05NKhHsjsPOgi4Xhcw2CP
         Xt5g==
X-Forwarded-Encrypted: i=1; AKwUvBwf7eqA3ewtH7CB7fRMJlwDJO0/X6xTtuMTiWoUOnIoOAbhmH1HaoKYFtQRDIjuFnvfB/835LVJ9TQtI9szh7A=@vger.kernel.org
X-Gm-Message-State: AFuF++khOBx082E4YR0fHBBgAXiw88bMfl6B1n75jfyYC8Fvxuti+s4L
	n5O0BGrQXKnEaR2Zasz/SsFxy2+CFrHiIuRh92ChtU55ph75E7S19L9m
X-Gm-Gg: AYBFou1yc7+Vp5kUB1E8838xJp+oUl1iFBYYa0PvaIgrPKibvHEcC6/ocMXN4KttYev
	SpvcD+2JKUHLmFG5kXiTy85WWqLEWEizo9U4IDkRCHLWoPB3Sm630ydV9yMyjpVjelYRLrnEam/
	W/WjYagyluQHWKFW64CFGB94EF00kx1+0CArrmDhBDcLrrHGif4jDesVqR3eOC+GcHZylfK9NZe
	rtqO94K8B30TPb4i3H8iBKcSE3D17fpCm8ymXNbPgQa4w0envK4/YsdGgLiisY74BmD7GjH7iNw
	Dt/Wm1Ol32A+bd4ZlU2ZwrZH0CU9lgUp9AO9/lLvU3+MMNBZVbeM+gZ1Za5ds2ylXX3i3jao0Ow
	dq/rNeGBwvff0Yn4pOuC0YczLXxCVRLhHwSeGtOaZ853I/tL5blvBPQpvVSU9qCx5XPag2GQK/G
	djoPNhKS7DmE+I54LrJ0RsbVeD40qa97DT4FdN/WL1JBSnGFH+bnhKa7hi+GRre5tTizcLDr8IF
	UzZ8s2u6vTzeVuvZFneRtWQc3hMgFJnCCJz
X-Received: by 2002:a05:600c:1908:b0:49c:f13e:e4f with SMTP id 5b1f17b1804b1-49d1757b03dmr84949105e9.12.1788901864599;
        Tue, 08 Sep 2026 14:11:04 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20daed8esm3377285e9.2.2026.09.08.14.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 14:11:04 -0700 (PDT)
Date: Tue, 8 Sep 2026 22:11:03 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Xuhua Zhang <zhangxuhua@kylinsec.com.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_bcsp: Use the shared CRC-CCITT byte
 helper
Message-ID: <20260908221103.44c6559b@pumpkin>
In-Reply-To: <D667F392AF7221D8+20260907151015.13522-1-zhangxuhua@kylinsec.com.cn>
References: <D667F392AF7221D8+20260907151015.13522-1-zhangxuhua@kylinsec.com.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Sep 2026 23:10:15 +0800
Xuhua Zhang <zhangxuhua@kylinsec.com.cn> wrote:

> bcsp_crc_update() processes each byte as two nibbles, requiring two
> dependent table lookups for every header and payload byte when CRC is
> enabled.
> 
> The existing crc_ccitt_byte() helper implements the same reflected
> polynomial with one lookup per byte. Use it instead of the private
> nibble-based implementation and select CRC_CCITT for BCSP-only UART
> configurations as well. The initial CRC value and final bit reversal
> remain unchanged.
> 
> This replaces the private 16-entry table with the shared 256-entry table,
> trading table size for fewer dependent lookups. An exhaustive comparison
> of all 65536 CRC states and 256 input bytes matches both the old code and
> a bitwise reference implementation.

How about this version?
static inline u16 crc_ccitt_byte(u16 crc, u8 c)
{
    c ^= crc;
    c ^= c << 4;
    return crc >> 8 ^ c << 8 ^ c << 3 ^ c >> 4;
}
Does the standard crc used for hdlc (etc).
Avoids the data cache misses associated with the array lookup
(which can make the nibble version faster than the byte one for short buffers).
A modern cpu will execute some of the instructions in parallel,
but you lose a clock because gcc converts (a ^ b) ^ (c ^ d) into
a ^ ( b ^ (c ^ d)) lengthening the register dependency chain by one.

David


> 
> Signed-off-by: Xuhua Zhang <zhangxuhua@kylinsec.com.cn>
> ---
>  drivers/bluetooth/Kconfig    |  1 +
>  drivers/bluetooth/hci_bcsp.c | 26 +++-----------------------
>  2 files changed, 4 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 4e8c24d757e9..2d6a3117e387 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -151,6 +151,7 @@ config BT_HCIUART_BCSP
>  	bool "BCSP protocol support"
>  	depends on BT_HCIUART
>  	select BITREVERSE
> +	select CRC_CCITT
>  	help
>  	  BCSP (BlueCore Serial Protocol) is serial protocol for communication
>  	  between Bluetooth device and host. This protocol is required for non
> diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
> index 0323db21c428..ef71a349e777 100644
> --- a/drivers/bluetooth/hci_bcsp.c
> +++ b/drivers/bluetooth/hci_bcsp.c
> @@ -25,6 +25,7 @@
>  #include <linux/ioctl.h>
>  #include <linux/skbuff.h>
>  #include <linux/bitrev.h>
> +#include <linux/crc-ccitt.h>
>  #include <linux/unaligned.h>
>  
>  #include <net/bluetooth/bluetooth.h>
> @@ -75,34 +76,13 @@ struct bcsp_struct {
>  
>  /* ---- BCSP CRC calculation ---- */
>  
> -/* Table for calculating CRC for polynomial 0x1021, LSB processed first,
> - * initial value 0xffff, bits shifted in reverse order.
> - */
> -
> -static const u16 crc_table[] = {
> -	0x0000, 0x1081, 0x2102, 0x3183,
> -	0x4204, 0x5285, 0x6306, 0x7387,
> -	0x8408, 0x9489, 0xa50a, 0xb58b,
> -	0xc60c, 0xd68d, 0xe70e, 0xf78f
> -};
> -
>  /* Initialise the crc calculator */
>  #define BCSP_CRC_INIT(x) x = 0xffff
>  
> -/* Update crc with next data byte
> - *
> - * Implementation note
> - *     The data byte is treated as two nibbles.  The crc is generated
> - *     in reverse, i.e., bits are fed into the register from the top.
> - */
> +/* Update crc with next data byte */
>  static void bcsp_crc_update(u16 *crc, u8 d)
>  {
> -	u16 reg = *crc;
> -
> -	reg = (reg >> 4) ^ crc_table[(reg ^ d) & 0x000f];
> -	reg = (reg >> 4) ^ crc_table[(reg ^ (d >> 4)) & 0x000f];
> -
> -	*crc = reg;
> +	*crc = crc_ccitt_byte(*crc, d);
>  }
>  
>  /* ---- BCSP core ---- */

