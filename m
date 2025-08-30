Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0635B1A76DE
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Aug 2025 00:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756515048; cv=none; b=KurNHuJ/i/Xr5vnqjkdiSGOm5Hqn6isqjD58mou4kIDkW7GI7l/patob3EPMHSVhexlKhrW0y/4AkVs3H7OpUPb2AswlUJQwlRSdhst+iqUUVqLpmVmYgN1uidQolN8bCNLVkpq8TkbCvUKKhA8qUyLj+kTjqUNGG/K4q1hhloU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756515048; c=relaxed/simple;
	bh=nyBd3svYSA8ZWsKGuTLD0ccws/tYPuOWANWLsrbj49M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cALAHt4Zj/GRkvDTnph0pLnF2CGH2rmy6tWkGgkUEJJiDPXEF0UO47kKH9+/0oyqHf4xVoWYfAzo4G3s/EGR9c6A5gMHUyE6m8H2mZpisiP3vf5/UKBq+jItkjbNFU2dWsP9JV/d7069lhC5tscAtpc4GrS76iyNhtSwAY/VUGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=UAvKffAU; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="UAvKffAU"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2445824dc27so23080205ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Aug 2025 17:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1756515046; x=1757119846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2SbNmp2jN3W5ifKkr2ZRQIsE+bXPrNXTTlRWUPsyEw=;
        b=UAvKffAUMg8b8oHs4FRXEAuqUKfnu/CfcPw9r7GWdLx41PAVJYXLc+h3JgR/CPYSBx
         vU9EEUpvr/8z+nGuTrwtKYAl2pXIRfD2iKT/uT2Kt2RiMrlQJlfsMQqDMW1FkcahQEYm
         aYQDp9zUX9Fx6Elf4IY/cACL49Wm4J9QW0YFuZIKixdqMZ96O3E8I1vEDZl43UDV/RJI
         flaA7fo/iQtEhlsYB6B8FSKeqZXHv+iimTyW7NB8k+nODUE6/3166TbFHd1Lujr89sq1
         FzJEgPUanHLNrKipa3qVhjUdG5P8vg8pqZbhg2HPHoHjOzNaMHHJJgbeHqXCQr4FMAe3
         BD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756515046; x=1757119846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2SbNmp2jN3W5ifKkr2ZRQIsE+bXPrNXTTlRWUPsyEw=;
        b=bOfhEntA4xmZPYVpjU0vJwwJxPoCuNzI3IO+7BRLt/evr21SQV2OOAT7iawYOIVitG
         9vfAhWeJJTWXtQ6lFaFnae80hKRm0nvYnWM0VdqUowcknzTv7L8w8BoNy5zRFEG12Pa2
         5d3O+J05czCmoIjn+VSlw9NUQThWirjmAb44g5jz1bCB/cjqsAc4/L6s+okOG8txh2QP
         mh3GtrUAKC++p45MD5nVRUnmVYq2CUokQ4WEFapuAzgHLLpRw7xihNOQ4Voops46eIur
         jTA0rQnDx727Dy3CRpQ9537KRHiNHM0x2uVZC3oujaMuLx/S0iYrjDDV4ehk1vTbklUn
         DBbA==
X-Gm-Message-State: AOJu0Yz7Jca0TR8Omi4xPS6O1ipx0LKai5naMlgEuLGbV5bXatd/rwwX
	vFiSnQ6UP6O98ZDveeGQUGTR0krf37r9LGFT8gbwnFnujmoHQbpeIrQdBHXAIpLlncY=
X-Gm-Gg: ASbGncuUfMY1Xzj8Zh1h/jXhCA8/mt6DT/8F7zPm0NnJ4AsnbgvU/9jPoWeILeV+Z46
	K1Hkplj3GziRIZ2IoJpzQutMmosvxg+KdB2Z0kK/blsC8toAoCNe9lYtDF/HQ51YbElhnXhzDyM
	POe/xDxMhpbyv4+BXsPeOuY2sOQDQ8G8aLonWJwfGrg7xLAw8CKOU2kdxZT1LerL2dNraMfW4w8
	ICPEtIXyC54JereuE7IHLjVqP1/lqsVGaUJM+WmmUX2Eo3gHjkUlcD0hL/EqAmQBGh8muBdc+AR
	7ZiZ9VAugApendRjucw1sL7fWpKaKLVKRDE3nruVaU8Ixl2fx6R5OJ4dT/Bh3g2y+lNIhZMeNAV
	Bf5Ra1eae6eH1Na0hR3m3r5jr
X-Google-Smtp-Source: AGHT+IEgjacSF3MiNjBgqMzAV1pQjZuDMZIwv0mu4RkXIH4CsWBoPGHGROsvLiA4PPniQpoHC2qUVQ==
X-Received: by 2002:a17:903:190:b0:246:e8cc:8cef with SMTP id d9443c01a7336-24944870a4emr8537915ad.3.1756515046144;
        Fri, 29 Aug 2025 17:50:46 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249063961desm37008335ad.103.2025.08.29.17.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 17:50:45 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	oe-kbuild-all@lists.linux.dev,
	Marcel Holtmann <marcel@holtmann.org>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] Bluetooth: btmtksdio: Fix build after header cleanup
Date: Fri, 29 Aug 2025 17:50:29 -0700
Message-ID: <b78a4255d17adbb74140aa23f89cb7653af96c75.1756513671.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <202508300413.OnIedvRh-lkp@intel.com>
References: <202508300413.OnIedvRh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Syzbot found a randconfig which fails after my recent patch:

    drivers/bluetooth/btmtksdio.c:442:33: error: array type has incomplete element type ‘struct h4_recv_pkt’
      442 | static const struct h4_recv_pkt mtk_recv_pkts[] = {
          |                                 ^~~~~~~~~~~~~
    drivers/bluetooth/btmtksdio.c:443:11: error: ‘H4_RECV_ACL’ undeclared here (not in a function)
      443 |         { H4_RECV_ACL,      .recv = btmtksdio_recv_acl },
          |           ^~~~~~~~~~~
    drivers/bluetooth/btmtksdio.c:444:11: error: ‘H4_RECV_SCO’ undeclared here (not in a function)
      444 |         { H4_RECV_SCO,      .recv = hci_recv_frame },
          |           ^~~~~~~~~~~
    drivers/bluetooth/btmtksdio.c:445:11: error: ‘H4_RECV_EVENT’ undeclared here (not in a function)
      445 |         { H4_RECV_EVENT,    .recv = btmtksdio_recv_event },

...because we can have BT_MTKSDIO=y with BT_HCIUART_H4=n, and the
definitions used here are gated on BT_HCIUART_H4 in hci_uart.h.

I think the simplest way to fix this is to remove the gate on the
definitions in hci_uart.h. Since the constants are macros, there's no
runtime cost to doing so, and nothing seems to rely on their absence in
the BT_HCIUART_H4=n case.

I let randconfig builds run for awhile in drivers/bluetooth/ and didn't
hit anything else, so hopefully this was the only fallout.

Fixes: 74bcec450eea ("Bluetooth: remove duplicate h4_recv_buf() in header")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508300413.OnIedvRh-lkp@intel.com/
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 drivers/bluetooth/hci_uart.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 5ea5dd80e297..fd0624988aba 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -121,7 +121,6 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable);
 void hci_uart_set_speeds(struct hci_uart *hu, unsigned int init_speed,
 			 unsigned int oper_speed);
 
-#ifdef CONFIG_BT_HCIUART_H4
 int h4_init(void);
 int h4_deinit(void);
 
@@ -165,7 +164,6 @@ struct h4_recv_pkt {
 struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
 			    const unsigned char *buffer, int count,
 			    const struct h4_recv_pkt *pkts, int pkts_count);
-#endif
 
 #ifdef CONFIG_BT_HCIUART_BCSP
 int bcsp_init(void);
-- 
2.49.1

