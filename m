Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1057930DD1A
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Sep 2025 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827830; cv=none; b=Vj2OJ3XcOv7X6zAfEzIcdr3mz/1s2SZmP0sfEekNrJA3fbORIG/kXxQ348eeqtRoVzAaoQ1SAul5n7WX54gmH1mykqh34qyjp/Pa8C72gjJH+i/S5jgbKTJM0KHD+xg29GZEtCkWGa8n7m1eaU8aHQeZdTCvqHmOy6YGMpIunWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827830; c=relaxed/simple;
	bh=uBSaj1nJUmnyVjV9iB6505ljdKzXL6ViqWhA8JBUUkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOGJZdRs3yTmRE1X+BsZh6osskp8DY94UwKQrVMaHSbRnUd/Jy8IWZPG9krvaeT9O1lwwW+oGeGk6ETO3Puu59V5O6TZmPl+cC8okjZ78FFITIMVpIiNNQgaZf/3zh4dQUv2raqFeAgGkp0UeTlBwAIf28L4hxlwR2lyGaiaSmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=TqzUt202; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="TqzUt202"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24a9cc916b3so25594305ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Sep 2025 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1756827828; x=1757432628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gkt6jh8He1kXHojoNOHUR+RVSUvV3fJpjiiQf61S0dw=;
        b=TqzUt202I/3OgqvIesp8LshIGsRPIkBWcPaRzsaoaoDX/SEGCl38NpAqljofb1YAlB
         aOR+l1xAn/YGz0RLFjwjsG/l5yGkIHmXciuCGTAJ5E/ZSs6dZ1lMvvwkJJ21B04lXE79
         h56vVyyNuST0dBesqxtKRebrU31TQXVIF9wsACX3la4a4ZU3Sv2nmqhGWVRNJNRC9vjh
         T+pCZLRVX3/ME92cQoPxozzsuJLciIqy2KX3Xe7xSQe0L4PRv5ELtsZQUt5E259fo0oG
         Wsb0D3bAVrYXaZSOmAEdc2XwmL9sigePq9TopohNQFT9c0g9PrqeBcKLLnkdm1GBLTKm
         JvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756827828; x=1757432628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkt6jh8He1kXHojoNOHUR+RVSUvV3fJpjiiQf61S0dw=;
        b=sCcspwH8GzVI8GdFXTbJi38Kizsy2i9wtEPppRUK3xEWPE82/6aTo2Ncnm+zlFvZYT
         i/BscLoMvK40u82rWArDkJNU7ALkuUAHi1pws7z+jjJKKEthPcgZDNKdSGwWHBGTeOSY
         a/NcPiJxrCLXJapvqAvtsh67fNi0jGySavDZmuIGJvprqZfy0tIOz6J/Ac6kGetnEeeX
         dQq5ugaD9awfMfiZwRRDQMqGxzaIJiPT2eIuA4QZBhq7W/XWZkOxbA0SeYxCNcJNvWL9
         lFGRW9ZNv4Ie6M1lCxD+Bpwh715wEjbN/OQQU241726jLEL2TtwrjyCMGwgYDXssI/Ff
         QuBw==
X-Forwarded-Encrypted: i=1; AJvYcCUeaG5ONyI9MfNslziJ4AVX0G/4CuqpY3OCnOP/uGHnsO3P87dTXp5BqIF3PiHOKuuHB+kd0x7b8xR2LAmtY1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOkwTLIjNkXyyGJJ8P54dC5N2FxY/y57OWHDG5BCZ5vWM6nCzx
	kSbNvAuafsDEw+TnMJh5Mpbwx1qTHCIzmsoeV0N3Y/FdGdkElon05acujcWFokb76gI=
X-Gm-Gg: ASbGnct9+zRSvQ8s15WlJmb4t4FF62RZ2Wx52bERMzD3On/EfGxddRg11it86Hy4xrT
	Ygfmal2ZKlCPsrVWgbo6i6WAiCLlu7xEBIsQ6KHqsKMmrc19+AdpoP5d9D/103d+mkI8sbGYR/r
	vBdoh9HFAI7DB+i+PlxdtsLxlRWCRm2lVpAbaDNeBFsgbqXpMrwjE9CLtlg71QU7/8aDciIjEMo
	cxyw9NjZaxb3RcPFtm1wIdZxQu9A3mriGBq//NaR7DdZGDkjEDNbQZAmRBDrGF15GqW4Tv2zsrN
	lsEqfOstWqcM4N4rWPjAcBqEPYI+TRqhFVQ9LGzob68RXKwJyPRSv+H6ua53KCz8lUmyTAoHVCq
	ao0YTO0FFlhx/uVnPJUdIpmAESLhp0qTqw3XJlwlNp1ElmA==
X-Google-Smtp-Source: AGHT+IGlZIJUkPm51/UzPGDsdAct3krCic7IzLREXEY9/oW76ewvmB7K7S3GcX3yQJ4WmturI/w3dQ==
X-Received: by 2002:a17:903:186:b0:248:6d1a:430f with SMTP id d9443c01a7336-24944a173famr145263995ad.25.1756827828044;
        Tue, 02 Sep 2025 08:43:48 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3278f881f21sm9364227a91.2.2025.09.02.08.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 08:43:47 -0700 (PDT)
Date: Tue, 2 Sep 2025 08:43:44 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	oe-kbuild-all@lists.linux.dev,
	Marcel Holtmann <marcel@holtmann.org>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-mediatek@lists.infradead.org, naresh.kamboju@linaro.org
Subject: [PATCH v2] Bluetooth: Fix build after header cleanup
Message-ID: <aLcQsE3x9o4BzXxp@mozart.vkv.me>
References: <202508300413.OnIedvRh-lkp@intel.com>
 <b78a4255d17adbb74140aa23f89cb7653af96c75.1756513671.git.calvin@wbinvd.org>
 <84fd4012-966b-4983-b015-ffce06509b5e@molgen.mpg.de>
 <aLNRvzXE4O9dKZoN@mozart.vkv.me>
 <CABBYNZJBDgQHwmx82H2XJ-LCeOsxc77PPo6NA4zzT0dt7Uxddw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABBYNZJBDgQHwmx82H2XJ-LCeOsxc77PPo6NA4zzT0dt7Uxddw@mail.gmail.com>

Some Kconfig dependencies are needed after my recent cleanup, since
the core code has its own option.

Since btmtksdio does not actually call h4_recv_buf(), move the
definitions it uses outside the BT_HCIUART_H4 gate in hci_uart.h to
avoid adding a dependency for btmtksdio.

The rest I touched (bpa10x, btmtkuart, and btnxpuart) do really call
h4_recv_buf(), so the dependency is required, add it for them.

Fixes: 74bcec450eea ("Bluetooth: remove duplicate h4_recv_buf() in header")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508300413.OnIedvRh-lkp@intel.com/
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 drivers/bluetooth/Kconfig    | 6 ++++++
 drivers/bluetooth/hci_uart.h | 8 ++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 4ab32abf0f48..7df69ccb6600 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -312,7 +312,9 @@ config BT_HCIBCM4377
 
 config BT_HCIBPA10X
 	tristate "HCI BPA10x USB driver"
+	depends on BT_HCIUART
 	depends on USB
+	select BT_HCIUART_H4
 	help
 	  Bluetooth HCI BPA10x USB driver.
 	  This driver provides support for the Digianswer BPA 100/105 Bluetooth
@@ -437,8 +439,10 @@ config BT_MTKSDIO
 
 config BT_MTKUART
 	tristate "MediaTek HCI UART driver"
+	depends on BT_HCIUART
 	depends on SERIAL_DEV_BUS
 	depends on USB || !BT_HCIBTUSB_MTK
+	select BT_HCIUART_H4
 	select BT_MTK
 	help
 	  MediaTek Bluetooth HCI UART driver.
@@ -483,7 +487,9 @@ config BT_VIRTIO
 
 config BT_NXPUART
 	tristate "NXP protocol support"
+	depends on BT_HCIUART
 	depends on SERIAL_DEV_BUS
+	select BT_HCIUART_H4
 	select CRC32
 	select CRC8
 	help
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 5ea5dd80e297..cbbe79b241ce 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -121,10 +121,6 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable);
 void hci_uart_set_speeds(struct hci_uart *hu, unsigned int init_speed,
 			 unsigned int oper_speed);
 
-#ifdef CONFIG_BT_HCIUART_H4
-int h4_init(void);
-int h4_deinit(void);
-
 struct h4_recv_pkt {
 	u8  type;	/* Packet type */
 	u8  hlen;	/* Header length */
@@ -162,6 +158,10 @@ struct h4_recv_pkt {
 	.lsize = 2, \
 	.maxlen = HCI_MAX_FRAME_SIZE \
 
+#ifdef CONFIG_BT_HCIUART_H4
+int h4_init(void);
+int h4_deinit(void);
+
 struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
 			    const unsigned char *buffer, int count,
 			    const struct h4_recv_pkt *pkts, int pkts_count);
-- 
2.47.2

