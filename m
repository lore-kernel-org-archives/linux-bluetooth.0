Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E540F2C21E1
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Sep 2025 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908267; cv=none; b=aqItYLhWvbeqiT59VSPcBjj9YNHiUYp8OJoalFP43NsCsWMNlCZRBb0hxGHffkVSqM6npWUYSxpxh8lAXyNx97fgKFluNJ4i9n8gx1fJyPq4ZS2y/6se/QhyrbqFi37bhpqywSZ5YDrvBs5jRHDH69uC1/tYXS3/MNhTbneuUcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908267; c=relaxed/simple;
	bh=HgKKOGM2p63WpTkYbbwVnU+fdtUN9eIMh2AP+3aa/Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dT0lZyawfdfamf8sXTffJ0sOgvetrwSOiLKkOUYVg0t0uzY3plzXS4V9bv4JKeho51LmajOzolQdXeVdJtsUU176P927kV80nRZ1EbA4znNKA44KF4v94mG/uNNJoBx+gVHJGD2tzsI0lTyIMWe/sHaVOgzszZSCFxmd5Xapwoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=f/orEjsS; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="f/orEjsS"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77256e75eacso3365428b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Sep 2025 07:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1756908264; x=1757513064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DF7NNzOTfeAplUyiGrcXUnjULOlHRrGxxOTtvokNWdo=;
        b=f/orEjsSGkyP5357H91a8EY4DoXe+/5FxdDNYgTjisODdd9/lOajJ0sjbGVeRHqT7o
         sNiLztIa3p5/21lMVn+tb8oPOL4ib0pzIGKrAVCjMS+6RQ/UZbtTXyD8ckRBaEi65F7X
         rPlBT934raTNK73i/SiCtkdBkE6yHNZdSKEJ0lNFxMMEs7r1jO8b7Nkks9otHkeRp3Ky
         koOZyQ0imK2FATfs4b1A4pmaUmfdYhTvAUg0uy8Mlq9uAOJl8IuBFEuTMlSKVESI0b34
         XwSWr2VdDCqPuNKUrKhXcIObChmndKKuZXh7J3rYAW/r5kP1bMSp0WsoeTBcPYPU4iAV
         h0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756908264; x=1757513064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DF7NNzOTfeAplUyiGrcXUnjULOlHRrGxxOTtvokNWdo=;
        b=lCC5vios7Z06Rz4ude6WUsEzXbRD0GegdBBhsoo9kCg+vbr/roh74npz1NHqbNVd7+
         aPFillkHe17u4E0mPvzCRu6pA+g2CuxWjrwLsKomhL4kRFRKt6L8RoonSP612A0ugMdF
         D7gTFaNmfnt3OK0WdBTq20uSyfsANDaFuBt5OqZGnvhyC8RbwSSfnOsp90dlyH3jDjhS
         TDOzI//ckM3vUZvHpzgUgSqHajTAbcCWMrK2IBem78GBt3gdjCWw0GgT9m5gkHV10NST
         yOan8ybRYv9k8e85v6vnZEOC8hDubZuCwUv+j//UD7cIiRrwQGyk6ZZUueVzsWCV2T9d
         Dc9g==
X-Forwarded-Encrypted: i=1; AJvYcCVZG0pmq3+G8YhV0aGIAUtFDSeOQK19+Numm8BgeY5tGrTwz2wxodTED/IJ2Vjml5Fvs8fS1PvCc1cbeURQGDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfBB/MUbVcZEZY9O0T1hpdNcr22+smsTyMTAg1V52fEMGgClss
	d+rXHyfyzHUnWRjapwOT9OCbaGoYEssOYtmGAbkvLNFa14Nsnl/G61YdSs+BssYu2OY=
X-Gm-Gg: ASbGncs3kYcWqL83woqYjVACI63qgQHihr5kWOQYjNB4LtuYIZmGD7gr0VhLkZXg3iF
	TSUetpaC74MX3nbmGxwrlqHqSr2ysUW4BLV/pFdXXDWCYu5t0euibiM/438ZyGDNzybRRfUvP1B
	hURfg1a6RVOwE1EOXVriHsrpJtOZb6dsTqo3HaymTecoE7riAZacYFIMypDM2HBOMEOadtNFB8J
	JmSeGWtWz1J/omBte2QJSPL8QrJZc/TdNq1yE3SMPR0x+p/BoxeuXKP5rUQzTs63iQgra8zICG4
	L8yvgFlnaONwKH40uC/qIF8jmAqQUArd+bo4uDkwqQjSHCRtaPwgiN27RO6FCIUElmDh4CSPQs6
	IGMF6sURu8Sc5DmwFQOI3UZ5v
X-Google-Smtp-Source: AGHT+IFBlpLNtgdmmoa5SdWAbPJh9KJ+b6IiZlofc2uxPPTjS7ICUieyCle+dJztVNFLBP++9ETglw==
X-Received: by 2002:a05:6a00:1a8f:b0:772:4759:e433 with SMTP id d2e1a72fcca58-7724759e59emr18474843b3a.2.1756908263633;
        Wed, 03 Sep 2025 07:04:23 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b65a2sm16961841b3a.34.2025.09.03.07.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:04:23 -0700 (PDT)
Date: Wed, 3 Sep 2025 07:04:23 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	oe-kbuild-all@lists.linux.dev,
	Marcel Holtmann <marcel@holtmann.org>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-mediatek@lists.infradead.org, naresh.kamboju@linaro.org
Subject: Re: [PATCH v2] Bluetooth: Fix build after header cleanup
Message-ID: <aLhK5wEHgxc3BIgb@mozart.vkv.me>
References: <202508300413.OnIedvRh-lkp@intel.com>
 <b78a4255d17adbb74140aa23f89cb7653af96c75.1756513671.git.calvin@wbinvd.org>
 <84fd4012-966b-4983-b015-ffce06509b5e@molgen.mpg.de>
 <aLNRvzXE4O9dKZoN@mozart.vkv.me>
 <CABBYNZJBDgQHwmx82H2XJ-LCeOsxc77PPo6NA4zzT0dt7Uxddw@mail.gmail.com>
 <aLcQsE3x9o4BzXxp@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aLcQsE3x9o4BzXxp@mozart.vkv.me>

On Tuesday 09/02 at 08:43 -0700, Calvin Owens wrote:
> Some Kconfig dependencies are needed after my recent cleanup, since
> the core code has its own option.
> 
> Since btmtksdio does not actually call h4_recv_buf(), move the
> definitions it uses outside the BT_HCIUART_H4 gate in hci_uart.h to
> avoid adding a dependency for btmtksdio.
> 
> The rest I touched (bpa10x, btmtkuart, and btnxpuart) do really call
> h4_recv_buf(), so the dependency is required, add it for them.
> 
> Fixes: 74bcec450eea ("Bluetooth: remove duplicate h4_recv_buf() in header")

Hi all,

My fixes tag was wrong and Stephen's automation caught it in linux-next.
I'll send a v3 in response to this with a correct tag, it should be:

Fixes: 0e272fc7e17d ("Bluetooth: remove duplicate h4_recv_buf() in header")

Thanks,
Calvin

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508300413.OnIedvRh-lkp@intel.com/
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> ---
>  drivers/bluetooth/Kconfig    | 6 ++++++
>  drivers/bluetooth/hci_uart.h | 8 ++++----
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 4ab32abf0f48..7df69ccb6600 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -312,7 +312,9 @@ config BT_HCIBCM4377
>  
>  config BT_HCIBPA10X
>  	tristate "HCI BPA10x USB driver"
> +	depends on BT_HCIUART
>  	depends on USB
> +	select BT_HCIUART_H4
>  	help
>  	  Bluetooth HCI BPA10x USB driver.
>  	  This driver provides support for the Digianswer BPA 100/105 Bluetooth
> @@ -437,8 +439,10 @@ config BT_MTKSDIO
>  
>  config BT_MTKUART
>  	tristate "MediaTek HCI UART driver"
> +	depends on BT_HCIUART
>  	depends on SERIAL_DEV_BUS
>  	depends on USB || !BT_HCIBTUSB_MTK
> +	select BT_HCIUART_H4
>  	select BT_MTK
>  	help
>  	  MediaTek Bluetooth HCI UART driver.
> @@ -483,7 +487,9 @@ config BT_VIRTIO
>  
>  config BT_NXPUART
>  	tristate "NXP protocol support"
> +	depends on BT_HCIUART
>  	depends on SERIAL_DEV_BUS
> +	select BT_HCIUART_H4
>  	select CRC32
>  	select CRC8
>  	help
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index 5ea5dd80e297..cbbe79b241ce 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -121,10 +121,6 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable);
>  void hci_uart_set_speeds(struct hci_uart *hu, unsigned int init_speed,
>  			 unsigned int oper_speed);
>  
> -#ifdef CONFIG_BT_HCIUART_H4
> -int h4_init(void);
> -int h4_deinit(void);
> -
>  struct h4_recv_pkt {
>  	u8  type;	/* Packet type */
>  	u8  hlen;	/* Header length */
> @@ -162,6 +158,10 @@ struct h4_recv_pkt {
>  	.lsize = 2, \
>  	.maxlen = HCI_MAX_FRAME_SIZE \
>  
> +#ifdef CONFIG_BT_HCIUART_H4
> +int h4_init(void);
> +int h4_deinit(void);
> +
>  struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
>  			    const unsigned char *buffer, int count,
>  			    const struct h4_recv_pkt *pkts, int pkts_count);
> -- 
> 2.47.2
> 
