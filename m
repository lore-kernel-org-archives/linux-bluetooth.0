Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC842DE1FC
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Aug 2025 19:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756582341; cv=none; b=Z7/QwxQCO6kJQqTSmB8emffr7ZbPEDARlf5I3ykbNAgi/yWSAyjcQdQgRRa+oORZfsgjQuwybVjmnQ8YBuM0BG0QpX/o023K0qYk9orBx+oF+ebFVIn7fTQGJLZ+InYn7DKIjZUjfURN4JegWFdqYe7qwpFVX5LSvPGgmC6HwWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756582341; c=relaxed/simple;
	bh=A7kOwLXfXYTqy6VkkzPnhYvUhmrg8KJbNZ7bE1IEsE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7aFKWwf9lKhJOP58ALP6Toq8TA+UFieCFmvs8NLG56oWDbw9tI4Kn1yBFFIFJNSDoFmpbPDkK5K3Zh3hX2NtU42/caa2CKR1pk4OxySudIVnQf29lZCJL47vPiue6oyqGFirlIYHUOnkKOdEbO8Gp6y/o6oQLDY75A9FogZhzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=h/6JcrGn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="h/6JcrGn"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24457f581aeso27546035ad.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 30 Aug 2025 12:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1756582339; x=1757187139; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XHChkfQMkbV7SjUtwakYhLoytq+CyhHZTNbhfb0dUvg=;
        b=h/6JcrGnse1Mp0iw65iCsiiT72hHFcS6W9+o/iHUpXmLtUQXcvikjKZaj1WtYXHHjr
         ftSQ1D6FkoXEN61T9QdLGlazmgdG0jR8VdXlk7P7NGnfDH2lyOgXWMxRVTi2EMqll6/j
         //ulEanWKPs0z7fE32y5yFWrmGL2rMyJ9ZBlKBZ9o8iq8wQwMghKwLFE0+6fal3wknu3
         ezdUvEoODTv2+4BYmdd3x2tt+5mzfR/fouNCHWRlBlqByEsUREtB+Qn/n7A386/ew8vG
         RpmRBZaH/Czgvc8k+ulZQkEnf8ZIAzgAfYQW4OAmBVAPvdiQ3+9RKClvIjrgLMin+9Ii
         D6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756582339; x=1757187139;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHChkfQMkbV7SjUtwakYhLoytq+CyhHZTNbhfb0dUvg=;
        b=FFx4eZZFcR7Aj9q5ETLxNF8t1apamrCgc1dzDHjNlYwxNN8lxZgozditi/jPAI77jg
         SpLY9wLIFGsGEMhTZXZ68/Y2WbAQ0PBP3OIz9+9Z22QPPV6PnN/yJx4uQK87lunliTLy
         x7HNB/X/Eqn7Xg5309qYeFo5DO8tWnmloBSKTA+G9ddV/Hll2r+OZUN7iqtrhKDoPzr4
         TcajhyOQ05N3QVkfIEnmf8ED4y19GU26kZE9EsaTyVps80GZnrbl985Y/VxFKSB87Ah2
         LhmViZ3tOSlgGsODuaq9vNCP4MaWG/+t4SkiJbIpD+hizBLGf+IofvC6w9oTb49v/70a
         1PhA==
X-Forwarded-Encrypted: i=1; AJvYcCU9H4Y9l+KouyD36PBetWiGp9CxwLssYoCAJLu7nM4wxufNrPxaHNmbH/FIst3dIaoIz5pw4axOZ4JQnscmjKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKdoOXQDV6NSJroWp2DPWnrwsDjOYKoA/jWpATzKCU9LnsEjO4
	idPcyrj12uAv8EFuFmgaeTk7uZLtc0oPfp257zzE1llwPbyQDVAln5+aHXwwYrmFODo=
X-Gm-Gg: ASbGnctg9cMe9MyFRrLVfEA+h07DRl0XZYebsC7m1R6hHoOA+OZ9w6SZMSCvOjOk5TY
	n672zhrBQDwi8mFfQhQDGfQyTAAsJtlqM2WPS2M1sm1XGeqnh039kzHfvBppLI7PdZU3AGbTSUB
	8DkuWJCyBE1bm4KAqYB+ykHCCjUES0Z1nQ+bgBBmihRJ9fctPo1mHn9ZPxmPtQrQeWQoxo/jxyl
	nXMmbJtTGn61nna5X8Sbwl6/kHqY0wk3v7HewMhMh4aIe2ypDJbVUPJp+vk35QZiDIWw59qP77x
	utsspvVrGnzD2wYGxLwF2Ovp4bRJKWgN22jhAJlY8govJG6d9tl27GMkF8mI4uncl1HNNY36kxu
	SgycK2uHMTpU7igggTRDXrjUcXNQ595e2iZ8=
X-Google-Smtp-Source: AGHT+IH+3miFeIR6tQUL0wfehVSxT31HOSJPjvKC8CX71Xx5VWWJuBvRY0vS/CA50IGWE4dB1x1ywg==
X-Received: by 2002:a17:902:ebc9:b0:246:b15f:8d9d with SMTP id d9443c01a7336-24944a1ca58mr35922805ad.14.1756582338796;
        Sat, 30 Aug 2025 12:32:18 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903702396sm59584335ad.14.2025.08.30.12.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 12:32:18 -0700 (PDT)
Date: Sat, 30 Aug 2025 12:32:15 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	oe-kbuild-all@lists.linux.dev,
	Marcel Holtmann <marcel@holtmann.org>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] Bluetooth: btmtksdio: Fix build after header cleanup
Message-ID: <aLNRvzXE4O9dKZoN@mozart.vkv.me>
References: <202508300413.OnIedvRh-lkp@intel.com>
 <b78a4255d17adbb74140aa23f89cb7653af96c75.1756513671.git.calvin@wbinvd.org>
 <84fd4012-966b-4983-b015-ffce06509b5e@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84fd4012-966b-4983-b015-ffce06509b5e@molgen.mpg.de>

On Saturday 08/30 at 07:11 +0200, Paul Menzel wrote:
> Dear Calvin,
> 
> 
> Thank you for your patch, and addressing the regression right away.
> 
> Am 30.08.25 um 02:50 schrieb Calvin Owens:
> > Syzbot found a randconfig which fails after my recent patch:
> > 
> >      drivers/bluetooth/btmtksdio.c:442:33: error: array type has incomplete element type ‘struct h4_recv_pkt’
> >        442 | static const struct h4_recv_pkt mtk_recv_pkts[] = {
> >            |                                 ^~~~~~~~~~~~~
> >      drivers/bluetooth/btmtksdio.c:443:11: error: ‘H4_RECV_ACL’ undeclared here (not in a function)
> >        443 |         { H4_RECV_ACL,      .recv = btmtksdio_recv_acl },
> >            |           ^~~~~~~~~~~
> >      drivers/bluetooth/btmtksdio.c:444:11: error: ‘H4_RECV_SCO’ undeclared here (not in a function)
> >        444 |         { H4_RECV_SCO,      .recv = hci_recv_frame },
> >            |           ^~~~~~~~~~~
> >      drivers/bluetooth/btmtksdio.c:445:11: error: ‘H4_RECV_EVENT’ undeclared here (not in a function)
> >        445 |         { H4_RECV_EVENT,    .recv = btmtksdio_recv_event },
> > 
> > ...because we can have BT_MTKSDIO=y with BT_HCIUART_H4=n, and the
> > definitions used here are gated on BT_HCIUART_H4 in hci_uart.h.
> 
> The drivers below seem to be affected:
> 
>     drivers/bluetooth/bpa10x.c:     { H4_RECV_EVENT,   .recv =
> hci_recv_frame },
>     drivers/bluetooth/btmtksdio.c:  { H4_RECV_EVENT,    .recv =
> btmtksdio_recv_event },
>     drivers/bluetooth/btmtkuart.c:  { H4_RECV_EVENT,    .recv =
> btmtkuart_recv_event },
>     drivers/bluetooth/btnxpuart.c:  { H4_RECV_EVENT,        .recv =
> hci_recv_frame },
>
> > I think the simplest way to fix this is to remove the gate on the
> > definitions in hci_uart.h. Since the constants are macros, there's no
> > runtime cost to doing so, and nothing seems to rely on their absence in
> > the BT_HCIUART_H4=n case.
> 
> Looking at the implementation, it looks like they only work with the H4
> protocol? So maybe, that should be denoted in the Kconfig files?

Thanks for looking Paul.

Yes, my fix will cause a link error with other randconfigs, which my
'make randconfig drivers/bluetooth/' test loop missed after I made the
function prototype always defined, whoops.

We do need the dependencies here, as you note. The btmtksdio case syzbot
found is the odd one out because it only uses the constants, and doesn't
call h4_recv_buf().

Hopefully this gets it all:

-----8<-----
From: Calvin Owens <calvin@wbinvd.org>
Subject: [PATCH v2] Bluetooth: Fix build after header cleanup

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

