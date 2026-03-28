Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8AD1F5858
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Mar 2026 03:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774670297; cv=none; b=jT/IG7RyodydXBezhnsoxTBt3s5yTudQ/M7MOIyHs2+DqP7QbbhCuYBpkQgenboJfwF34CsOfOtsPFgwkXqCc5K6JwuDwPPeRlce0qTTNXIkY5XmDKJ7x7Fu3r5sb/6dS55hLdtM87OQSUIQzk1JbhBSioWJ4xJ58D7flWjRd0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774670297; c=relaxed/simple;
	bh=mSy4RoaBT39xTSvc+8yUlqjxtU8HoyAOY5FwrcPr75Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TbrY7hftTMFfGm3T8HjfJn0CoYx72bnS/ED9kEpWawzh30ngJPSUZ3LegewZMrhDNrXgmK4igJe7acsYPCiRKTTcBx5UsjLMELDuksVIOqXtRP+OT87ywKXJVTkKNUcdkkJvHi5th3vEDKAwQpFsxQPwk0WGD+Zal84WW8Ll5+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/4rJ1OW; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/4rJ1OW"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cfbbf35354so387244685a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2026 20:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774670294; x=1775275094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DBblOHPwIcVybXPXeTa1HXY+6r7rBi60EfIfdS+sSzY=;
        b=M/4rJ1OWtFZPA0PHYOeZiFQEguoQP8Koy1ONfG2NZoucbMz/f1gKdoHHd61CnCWPr8
         bKjlFJKRDeLPtcrO1PKGZfalNBvIbFeJS1/i1ukZ561+PJkAC5g2cAJdC0HmM65ii9/m
         SaJqPRItB+4pEluHjfJQVyNUBElEuWolCVUk3YHTS/EGQtaem+wKYOVGEmenfWyZWaTW
         gPvgEQIACmVhCydY09KqqngptN06JVqi08bBvw+abSbgsZjBA6MUG60gxjvA4d4S05z6
         a6ocedyz4SA8DVmHy7MZV0y9mtHls2sTxBz+RthOoQSZ6Y+mCzC0vGcRueS9ScjUPnHj
         9mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774670294; x=1775275094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBblOHPwIcVybXPXeTa1HXY+6r7rBi60EfIfdS+sSzY=;
        b=H8XBSEwSPFXm5tBk6Zz2Di8JqxP+w5ODPKv2nUE/CO6/nl880ZIpWKACbncsyer8UJ
         WRq9nXYePROcTEVmmKkAGd/9r0/RfqJTOFQ1mR8DldYwhaMYadCGmwEl/t38uvaYFXz5
         azUy6rqZY81ACAZ8qs+K62TI9ynvjy9gCWPdrq2tO5UiA7CsR4efF7a2TVNws6uIXfdy
         6UW/98NaeuV8IZETPID3ttd3zovESgkAdEqTnvHOsf3Zmfec0TGR+/iXgxluCdZ6YLdD
         isgK6Hg//Bt3sqJD+kinsWmW5vMPRtMmXHB2Co6CeFCODjZ0lMefQ7D9mS6HQU9w90Bc
         qusg==
X-Gm-Message-State: AOJu0YyndAVX6WW90yksRC3wiuOUjQsH0X5Nz1DHr4R5mM07MHiPNpUH
	JDdLz47BtBxjhFVw9NMdQx9gtWTPYbiv8xoCrx0jU760gzn57Mw+QLQNC6nMfKSxccYj5g==
X-Gm-Gg: ATEYQzxwYNKccbE54TJI8o2M8V18EcNO/96dkGyye2IRgS1j7SDJxVf+dfUu6AvT0Zf
	65rwiy2pfe3/bKPkNWnPIA3wKHP2xqLTvMXzQvwKjjEIx5wBQ2mwBPOsv/1PBLPoFaB74C0GeDp
	3XfiF6/jgnm1SBKpQo6CEWC//pFHuINpMruWekZMVr4jVxGzlrIrNNxKVO5eiC3h0Tl6Kf5sW8J
	2szV/0sn0BnSISCqjijgPOXkzGkmbmvXESxL9pUX39YBqiPSlu+vwvuVfkw/OovycQJ63uuMaIY
	t5V+0R6wPMxnc6JmSYfyhQFfiAoNrX26qSNodta5aCJEVbtFZQsCPqBqqpwxHECwPz99OSwoHit
	ZxKeEOVhTbPvLBaG2c8o0wWCUVvU6EZJ4ZiSwo3eM4Y1Dw8Y2imokAa1Dr3rFt+qoLbqdE1FtyV
	FtFUvPDJG7+G1j+2E5k4Ak8sA4HeUXzDaNgGX31zoAT4VUMg53cd8N/MnGkZV1RDvQwmydRTpfk
	bz1m5ya7HGNKvLxx+RlWA==
X-Received: by 2002:a05:620a:4625:b0:8cf:bbf0:ff52 with SMTP id af79cd13be357-8d01c7d86eemr698785385a.63.1774670294490;
        Fri, 27 Mar 2026 20:58:14 -0700 (PDT)
Received: from mango-teamkim.. ([129.170.197.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d028044bdcsm84452585a.28.2026.03.27.20.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 20:58:14 -0700 (PDT)
From: Nathan Rebello <nathan.c.rebello@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	stable@vger.kernel.org,
	kyungtae.kim@dartmouth.edu,
	Nathan Rebello <nathan.c.rebello@gmail.com>
Subject: [PATCH] Bluetooth: ISO: fix NULL deref in iso_recv() ISO_END handling
Date: Fri, 27 Mar 2026 23:58:13 -0400
Message-ID: <20260328035813.296410-1-nathan.c.rebello@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ISO_CONT case in iso_recv() properly checks for unexpected
continuation frames (!conn->rx_len) and oversized fragments
(skb->len > conn->rx_len) before accessing conn->rx_skb. The
ISO_END case lacks both checks.

When an ISO_END packet arrives without a preceding ISO_START:
  - conn->rx_skb is NULL (never allocated)
  - skb_put(conn->rx_skb, ...) dereferences NULL -> kernel crash

When an ISO_END fragment is larger than the remaining expected
length:
  - skb_put() extends past conn->rx_skb->end
  - triggers skb_over_panic -> kernel BUG

KASAN confirmed the NULL-deref on kernel 7.0.0-rc5 via VHCI:

  general protection fault, probably for non-canonical address 0xdffffc0000000018
  KASAN: null-ptr-deref in range [0x00000000000000c0-0x00000000000000c7]
  CPU: 0 UID: 0 PID: 72 Comm: kworker/u9:0 Not tainted 7.0.0-rc5
  Workqueue: hci0 hci_rx_work
  RIP: 0010:skb_put+0x27/0x1a0
  Call Trace:
   <TASK>
   iso_recv+0x5e0/0xee0
   hci_rx_work+0x226/0x730
   process_one_work+0x633/0x1060
   worker_thread+0x45b/0xd10
   kthread+0x2c6/0x3b0
   ret_from_fork+0x38d/0x5c0
   </TASK>
  Kernel panic - not syncing: Fatal exception

Fix by adding the same validation that ISO_CONT already has:
reject unexpected end frames and oversized fragments.

Fixes: ccf74f2390d6 ("Bluetooth: Add ISO Socket")
Cc: stable@vger.kernel.org
Signed-off-by: Nathan Rebello <nathan.c.rebello@gmail.com>
---
 net/bluetooth/iso.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index be145e273..97b5fc9da 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2587,6 +2587,20 @@ int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb, u16 flags)
 		break;
 
 	case ISO_END:
+		if (!conn->rx_len) {
+			BT_ERR("Unexpected end frame (len %d)", skb->len);
+			goto drop;
+		}
+
+		if (skb->len > conn->rx_len) {
+			BT_ERR("End fragment is too long (len %d, expected %d)",
+			       skb->len, conn->rx_len);
+			kfree_skb(conn->rx_skb);
+			conn->rx_skb = NULL;
+			conn->rx_len = 0;
+			goto drop;
+		}
+
 		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
 					  skb->len);
 		conn->rx_len -= skb->len;
-- 
2.43.0

