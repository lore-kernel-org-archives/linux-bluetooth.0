Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F9627C84E;
	Wed,  3 Sep 2025 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913433; cv=none; b=IYIfx/ct/f32bJRtIear2Bobgy6mxw8tqkFrEW9EVTFufKHMh8/co24V5p8g1WQCCcpc2NS17tkawxwk15uZuJNswABH/UB60J4xF56up0w9gDNkwp6V1A5bunZ8yyBmIFL01KcNWrBmRYq92dEw14v8mp1ubzq0IiqssaE9JDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913433; c=relaxed/simple;
	bh=ckvd7eniKu7DFcSuwjibc3qsbueGYz1Inqnn96GoEjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TseKzdtXZNU2DsEleQ9xCIABkdGu0/+2jQOoBhUAntYe/KTq2CIOd71hr/L4z0REJQdhKc0u0Xe1+IX8mMO0wRxWHHVItMwgfa6B1Isg5DFEfxLHnMRdnxA1cVcPkckzPma1IX18yx3adWewN7peGosQDAIsFOFN1B2GDVrpgto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.5] (ip5f5af7fc.dynamic.kabel-deutschland.de [95.90.247.252])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id DB90A60213AFF;
	Wed, 03 Sep 2025 17:29:43 +0200 (CEST)
Message-ID: <6afa0585-1903-4a56-b433-1087897519bf@molgen.mpg.de>
Date: Wed, 3 Sep 2025 17:29:41 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: Fix build after header cleanup
To: Calvin Owens <calvin@wbinvd.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 oe-kbuild-all@lists.linux.dev, Marcel Holtmann <marcel@holtmann.org>,
 Sean Wang <sean.wang@mediatek.com>, linux-mediatek@lists.infradead.org,
 naresh.kamboju@linaro.org
References: <202508300413.OnIedvRh-lkp@intel.com>
 <b78a4255d17adbb74140aa23f89cb7653af96c75.1756513671.git.calvin@wbinvd.org>
 <84fd4012-966b-4983-b015-ffce06509b5e@molgen.mpg.de>
 <aLNRvzXE4O9dKZoN@mozart.vkv.me>
 <CABBYNZJBDgQHwmx82H2XJ-LCeOsxc77PPo6NA4zzT0dt7Uxddw@mail.gmail.com>
 <aLcQsE3x9o4BzXxp@mozart.vkv.me> <aLhK5wEHgxc3BIgb@mozart.vkv.me>
 <aLhLTiIMRnjHfvOn@mozart.vkv.me>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <aLhLTiIMRnjHfvOn@mozart.vkv.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Calvin,


Thank you for the patch.

Am 03.09.25 um 16:06 schrieb Calvin Owens:
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
> Fixes: 0e272fc7e17d ("Bluetooth: remove duplicate h4_recv_buf() in header")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508300413.OnIedvRh-lkp@intel.com/
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> ---
>   drivers/bluetooth/Kconfig    | 6 ++++++
>   drivers/bluetooth/hci_uart.h | 8 ++++----
>   2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 4ab32abf0f48..7df69ccb6600 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -312,7 +312,9 @@ config BT_HCIBCM4377
>   
>   config BT_HCIBPA10X
>   	tristate "HCI BPA10x USB driver"
> +	depends on BT_HCIUART
>   	depends on USB
> +	select BT_HCIUART_H4
>   	help
>   	  Bluetooth HCI BPA10x USB driver.
>   	  This driver provides support for the Digianswer BPA 100/105 Bluetooth
> @@ -437,8 +439,10 @@ config BT_MTKSDIO
>   
>   config BT_MTKUART
>   	tristate "MediaTek HCI UART driver"
> +	depends on BT_HCIUART
>   	depends on SERIAL_DEV_BUS
>   	depends on USB || !BT_HCIBTUSB_MTK
> +	select BT_HCIUART_H4
>   	select BT_MTK
>   	help
>   	  MediaTek Bluetooth HCI UART driver.
> @@ -483,7 +487,9 @@ config BT_VIRTIO
>   
>   config BT_NXPUART
>   	tristate "NXP protocol support"
> +	depends on BT_HCIUART
>   	depends on SERIAL_DEV_BUS
> +	select BT_HCIUART_H4
>   	select CRC32
>   	select CRC8
>   	help
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index 5ea5dd80e297..cbbe79b241ce 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -121,10 +121,6 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable);
>   void hci_uart_set_speeds(struct hci_uart *hu, unsigned int init_speed,
>   			 unsigned int oper_speed);
>   
> -#ifdef CONFIG_BT_HCIUART_H4
> -int h4_init(void);
> -int h4_deinit(void);
> -
>   struct h4_recv_pkt {
>   	u8  type;	/* Packet type */
>   	u8  hlen;	/* Header length */
> @@ -162,6 +158,10 @@ struct h4_recv_pkt {
>   	.lsize = 2, \
>   	.maxlen = HCI_MAX_FRAME_SIZE \
>   
> +#ifdef CONFIG_BT_HCIUART_H4
> +int h4_init(void);
> +int h4_deinit(void);
> +
>   struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
>   			    const unsigned char *buffer, int count,
>   			    const struct h4_recv_pkt *pkts, int pkts_count);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
