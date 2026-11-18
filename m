Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029090;
	b=kFvAIk/G/frgUxCWzGd1FdezwPsQnTwQ3Ym2xSqUuowOQzMtNtBdg8PvAdxPDFcTDzxH
	 I5EQUqzhsUurjLH+nPar0k787bBH4z1Ibk/ZuXeK1sBGbh4JiuN9ROf/+rJaVV2WLjkco
	 lwCduMnoorDyzUuHTwHLLwFj2YqkDxTbp8SZDCAgnjO+nxGmfAyNfeZcLehh/A7+q1qNV
	 nRAS2KY7MlDtgY104gZ3JJnUtWGckEkXR6ssC+0E/BGML5aTKF9hF2+og572WLquZns5F
	 59/1BdKWs1jlFhl49jnghmglMlRVY2ZGyx4V+TM7QXbvr3yPQqgs9jGJuHCTOZ3JVow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029090;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vtxpwpuGtInRr5gt07Rg6EoXYRMP/GTxLvl77pRX2aw=;
	b=a+L4q8BhjfGdDVURxB5n9xY2J8c/hRomG6Nqt/Sv0Zd6L32JrThEcsUw+JLJ1u46ymcj
	 OU9Y9GkEAO4OAVZgp3WjarRmzN5549jhgNyrn8s95rpgC5jM0UXfEP7uc8qftmGNiNB6K
	 mXFFQViUXCegrABaO1Dll6TRO5HLzH1u49L4PkPRjt+dqbTjcnsrUxV+xugIx/ahNYDva
	 h/4xigIXSvCk3CJaxCSn2D+oHCLYw984qHnJtN+OOcK8L6FQKr3ce03Z994X2pmrjQQmn
	 zCC5uTyKMliEV3HvgWKFyVRwtZqo91iyHHMmJit11xe8SEgxjK6rPIAcjyJkGmx1k3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yi6AUyfN;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F61606A325
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41F61606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yi6AUyfN
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5eac01ff101so512219e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795029089; x=1795633889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vtxpwpuGtInRr5gt07Rg6EoXYRMP/GTxLvl77pRX2aw=;
        b=yi6AUyfNc2PkWzMlF2JPE2cyYIrThud3yeJrSGdxxK2zYw28mb7Nkd0R0c/LF3dfeJ
         UsQ/eS+Zgnq2HqS/eTO3QKJ0RANx63TV/L5+bL438Gc3gpVjov6T805c1IxM4Qae+C6w
         QoPHNwNFB0V0z8oQCwAu1p3pHPs1RuyyJZKX7Lx2egKk3lqx6WmIsLmC0B6njLDtm8ZK
         rvsKGMVJRKyTWx/RoRPYBwCnpA5Xg1SgHVjQryCsflIbgEITYaVXFjOJaxIkZKA9rVWt
         OWOaqODkQYuPDHJ/y5c7B/BCchVEzMXRFtep8gRYG0ildX2zs2PMQiosX2Shq1kSLVeB
         aXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795029089; x=1795633889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vtxpwpuGtInRr5gt07Rg6EoXYRMP/GTxLvl77pRX2aw=;
        b=VBGUD7iY2jP3AY48NzMCVr81Y5BLrIwgJ3WfeoqxGeIB2g1eF3GnmOL3mK2Rku8vwQ
         iHYq75bg6x/+/DOvAMewXRXFajxk8LMYHFYf4zknmqEeUa+z9rmCRetb+d3xnzxHbM45
         oRA5fsSqBvRjUJQliAe5YocLCYH2zZgrqACUFZqwum/sNIq1dYMA2dLjg8kjlH9g2qe0
         YnOkrFl0l3DZiDxpD/AMwDqXzftVZvjCFgeMWorZC5SJNMFFPZeYPwLPSq3gQBkdmpUz
         iLVpTHIxwrXliydrRLxD6ZSvzsl5qB+p5fKNf7N9apUdpCEsgsfHPBF0xl/RwXsTMFOi
         xYOw==
X-Gm-Message-State: APuU4Z+CpiBC7vZyeFq0r0Sn83EoWMPvfRdG43aYBCaPQXapRveWvSmF
	m5c6NvJ31c7BoRayHuOD8rZXQEE82tmy2fOkccLHq0D6vGoszcaQasqlsW5a9yzh
X-Gm-Gg: AYBFou2tZM4a/1hleUHS1QtyhIUKvNy2lfjTG+7+qT7MkK6/u4DP7Hx92sw6ChmOBca
	66ODr9t1QcRyJY7huN+rIOXlKNFDGdXzXcPVaYwLw3ZeLQcdntUoRhWslF1aNBrypaX30/vyyf6
	OgWyGAHddIOEy0BON8DTYbLfY4U1YR0euINsGiCIMw+drfhoSzYBqa6n6+UyX3bgbcqnPNqDnhO
	1w7/v+h/8jE8sJH7ELM0YXsk546b/zTpiRBRD0WjJhZ9J+tMqsKdXL3S3ABJ3Frll8+idUyWT28
	3Eu3l6BUWDGDhF2ezkWZg1V9Wnatfexn/oaX9HF2EhBl6F8VH0P4Q1x3KuMXRnRuv/7+mBX3QpR
	E6+ECZ5aWsZmJCIN6NfWh6zDjclG6rK+wYmzjpPEiUC8plMN8J0XNSTR5EqILrjitz7sSxfD4gv
	UO0BMKfF8BG2LzKHfEwt3QoA5wJA8QBWCTP4FsMQIbIM2CN1vhdRUkcUY2qUxoTLx2a95fgx8ar
	hJgD1oUXCpMGgP5BP9gKxQr05JBVcYNmSHb1uQkmq0zP4+DUUDr7jCf8jw3QOx/THsEe4XYDXiI
	A+gSpO6EUw4dOpRq1qDGrh5868FYLhru5SVhS10ETmt59JQrjRijM9ryShEqAQbXsWNJbxtGbgv
	lY+WkQfVb1gIEDOUSQNxOBgJevBaCo2cyFctkyg+U7mIjCM5uCfeCOAYuEnLKHAmz0D4fUkXN/c
	CbMNU=
X-Received: by 2002:a05:6122:1801:b0:5ec:4112:6839 with SMTP id 71dfb90a1353d-5ee647160b9mr1780314e0c.15.1795029089118;
        Wed, 18 Nov 2026 11:11:29 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64c1801fsm2479672e0c.0.2026.11.18.11.11.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:11:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 08/17] Bluetooth: hci_event: Validate sent command length in LE Set Ext Adv Enable
Date: Wed, 18 Nov 2026 14:11:09 -0500
Message-ID: <20261118191118.318779-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118191118.318779-1-luiz.dentz@gmail.com>
References: <20261118191118.318779-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_cc_le_set_ext_adv_enable() read num_of_sets and the set entries from
the last sent command without checking its length.

Reported-by: sashiko.dev (linux-42bcc244-62e6-4295-802c-f9a512ca49a3)
Fixes: de181e887ac2 ("Bluetooth: Impmlement extended adv enable")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7908d920c67f..ab875b90a143 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1685,14 +1685,16 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 	struct hci_cp_ext_adv_set *set;
 	struct adv_info *adv = NULL, *n;
 	struct hci_ev_status *rp = data;
+	size_t len;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
 
 	if (rp->status)
 		return rp->status;
 
-	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE);
-	if (!cp)
+	cp = hci_sent_cmd_data_len(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE, &len);
+	if (!cp || len < sizeof(*cp) ||
+	    len < sizeof(*cp) + cp->num_of_sets * sizeof(*set))
 		return rp->status;
 
 	set = (void *)cp->data;
-- 
2.56.0

