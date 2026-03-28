Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD1533B95B
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Mar 2026 20:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774728600; cv=none; b=SksoEj8GLAs8sDgD03BtJ+q/csHh86GO5IlSQzhACqhSoQjT3Syut+RXP2wqi87Q2dtIyQqebhTykXjbxxrBgGN+pLfUptJ+LMrSbYTa/j3E2PQwJkb5s+8ZS7r9otjWJx4O9nOXCwNv9vBVk4l1eMMCFFCNwqVybQOtYagzwO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774728600; c=relaxed/simple;
	bh=GxviuNMaKLLkHWLE6NwvP8CHcnvy5HbE2KoMTrTrxeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prHdjoaFCgK+Td7/uHAKBs2vwfaYUlUqy2BEQPBB37ApCLVQw1Sa5wuBXLBbtXw7toyHNlwoPHiqe7ITJ4wG+MQmHu46Bp4aeVOtukgXVEIFe2BKKAK7oFKE8bDp87zujThZea5xMob3FEni0mnt7w6ftsyg4F2UBrMBY90fivE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnTRzqQP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnTRzqQP"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82c20b9fb16so1317071b3a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Mar 2026 13:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774728597; x=1775333397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ne6ohxmFK8CKmixyfoQQWL+dvvk4ukAUm4iPHOxaK4=;
        b=hnTRzqQPvdz94ZiFhhEetc5ordP88h1yuT3HziiIlX+vk3gUzaGZclYNZsp3ccO9Wy
         CNeqLInrS3hSiZbLCNbQIpUoJq0xGhbBFG+oQRwgfwWz8fxkt1O3A+uKHCbECCpLmmO2
         d/SLGG4uhAQcNByNSZ4l1/fCsVBnnB/64ZREwx0byFZaD/TlSRqyGstwF7Zz5Jqjk/5m
         cvWr42xk9XLB22F6oAr/6Is5CWN+dhw1fDduPtETbI46oPThUNTCTcZhoKHfPyIGMYmD
         yMrxmG0h3nMxni45lzUtCM3lvUW7rTPcCYUSoBeanunWXprtBVD5CNGjFx2A7k93LfX0
         R9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774728597; x=1775333397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ne6ohxmFK8CKmixyfoQQWL+dvvk4ukAUm4iPHOxaK4=;
        b=oWVtNGQSdoXcxHd5oMm4s6q16setTBaiJdyU2pH/a+adveGseE4eLnm5QCq4pyuGWa
         v8Ck1vRuTmuNLx83orjU+hyPqwL3VY2D0Egv4mvMlr32CbRZWy4TOlsjvQco4Uoa861K
         cthnJ2KXwlVHJ8d7SRg8GWX0zmPTcfLzCU82RzdLiWF8XTUp/fZdqV+BFOLBb0l4Ctnl
         5asW17/f+/HrLsbUjLcUl8EIhXL3/qrUQAmyBn6LDPytnEtAdqpdCRdBU4xG+AE/zFSw
         RnUJytFAxtAD5PHGFpq2uW2O+rp+lTZfPgwKRzsI17iJk2FuMe7vA8lO5GQUW5//ULD0
         LmSQ==
X-Gm-Message-State: AOJu0YxBMf7NRk1jv2XBHdDZd59NR6u8aw7nSUtdWPF1seFX6EceNhw4
	HNzdgdX3glYZcjgGnTTKoL3+a7g1PzZ/AE3a1//jiVgTD0PJZvAr28P8ABfDWR4TitCHUg==
X-Gm-Gg: ATEYQzxekccBqqb3HpCgkoKDl/pVPaDhWCl2pxU8SORhs/3tj7ZN/v2XRR3qLOcljOt
	WNG+XxpJf+gi5aBFN7L7FT0shJjOZ7FctqyAxa6qhjR05DHAytm4xfnWIWLoN6cENdKqpnw1FdU
	YfqBYIz8++R1NFvSq8CYU8VD2Ch9JTstWexwkTj+Gc7/SuGxaEdknwOM5/7xaGkohUHT68M5pDh
	dW52q342lxvn+2nJjMmxxpyt/CvTpEd2NFaQ4VnP8Lcgv/eQ5hZtO9G2Sj4kM1vJStfQhSv2iUc
	cWyymTyh0GaoTTTiLLbtWGXwDBcZbuRTBaB66zfrDNRhFn0gTue1vbyouZ5/dSxif+9w05flMqf
	flKQZ3rSUxmOmF2UA0t4MUOTvG7DpiDBB0LCMGKiLToHn7VSBBZXeTPaMjhCMSoBVhT/vqlP/qL
	Y1Na2N4iBNp8S0dCsGQQ==
X-Received: by 2002:a05:6a00:1a89:b0:81f:be3c:9c9e with SMTP id d2e1a72fcca58-82c9600659cmr6163581b3a.33.1774728597308;
        Sat, 28 Mar 2026 13:09:57 -0700 (PDT)
Received: from kfuzz ([202.120.234.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82caa8be173sm2329605b3a.55.2026.03.28.13.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:09:56 -0700 (PDT)
From: Kangzheng Gu <xiaoguai0992@gmail.com>
To: gregkh@linuxfoundation.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	luiz.von.dentz@intel.com,
	xiaoguai0992@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: ISO: validate ISO_END fragments
Date: Sat, 28 Mar 2026 20:09:38 +0000
Message-ID: <20260328200938.140528-1-xiaoguai0992@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAKvcANPiqdO_Re3+06DWhb7uyKP+gCODJpo35sq5-x62gYJUPw@mail.gmail.com>
References: <CAKvcANPiqdO_Re3+06DWhb7uyKP+gCODJpo35sq5-x62gYJUPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A malformed ISO_END fragment can trigger a NULL pointer dereference
due to missing validation before processing. An oversized end fragment
should also be rejected.

Add the same validation for ISO_END as for ISO_CONT, and reset the
in-progress reassembly state when malformed input is detected.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Cc: stable@vger.kernel.org
Signed-off-by: Kangzheng Gu <xiaoguai0992@gmail.com>
---
 net/bluetooth/iso.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index be145e2736b7..8707f3c4b103 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2587,6 +2587,27 @@ int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb, u16 flags)
 		break;
 
 	case ISO_END:
+		BT_DBG("End: frag len %d (expecting %d)", skb->len,
+		       conn->rx_len);
+
+		if (!conn->rx_len) {
+			BT_ERR("Unexpected end frame (len %d)",
+			       skb->len);
+			kfree_skb(conn->rx_skb);
+			conn->rx_skb = NULL;
+			conn->rx_len = 0;
+			goto drop;
+		}
+
+		if (skb->len > conn->rx_len) {
+			BT_ERR("Fragment is too long (len %d, expected %d)",
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
2.50.1

