Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A167B1B87EB
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 21:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739915029; cv=none; b=U11lNmVS+BwtpifgBNRIChtyEcKt7RJbPIxvlT0WW+cGo9robV6wCqX4QZ5CDm+YvuKL98FfE+PacDglEaxC958Ol2ZlZgy567N9GyGnGRT6ZTWFVvIxebaTuChpJsAmbnMWQDi+LppK83QL4+W8liknmi4F0rX8BMxG11na+ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739915029; c=relaxed/simple;
	bh=fDRKys+ir8i1cwHL7NC/gNBlVHy0tjpMGtIcTrVa/l0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iAxasQETWHQ6n2wGPzg4Yi3+XGj0oGuoBpRe6VDX9xRnYENwZtOwXQ7lsgMKl5CjGbnfvRo8wVr+zWdE437ssHcg7k2IcWtL/ZvTld/crx3t9AlooX1dFScy8NaIlbD5H1UwHPxud8B8p9qArh/7vnfdVyriU8duJ82ZGy+raCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVnVs/AQ; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVnVs/AQ"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f4bc408e49so47094117b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 13:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739915026; x=1740519826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lz9UKSUTd3lPaP/eK4rwOvoMuKUL3i+41YQQFOvT9MU=;
        b=WVnVs/AQ48HqKj6/HZKpNmKQ1uE7H1Vpi7DEtQR8aUxJvxYyK0fh02geZfecZti/RO
         VTlAJZnuXb4QtqRzDoqKemui/MHSlhHufB4Os/2F9WVo7R9H4joOH3+2wGvqZROMEeas
         Bc35pD/thHFvPCH9v3TU8OGdn3GQWTcbNIx61GaSjYlt3dZxE8c+4OJpe0d/jU+Q/QiE
         Fk3Mj3k1faNf/GsGy842LaD3s4mV/IrTZoWCVi4DF4C/QZ8jnU9axq8VJ1IYZEFVTtpy
         HfgzEuupNMWhkNJAyzo7z1Q4r7+t6ZBNsstiHWw1Fz9UO1hMU3ulZaH68naBiutIesd8
         Kv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739915026; x=1740519826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lz9UKSUTd3lPaP/eK4rwOvoMuKUL3i+41YQQFOvT9MU=;
        b=WQGA6WyPbASPTUb0V4baNiOA/FCz1ODKnM7udTKa6PXJtxTfeV677PXie0/waWTlhp
         yy58CR0cyfMJT1pOi1I6Nj+LAyhoiZow6YLGjbj6tbkE04Sm2FvBzdRTpA05DWK+GDDH
         7mw0fjJmHoezDaCg10+CCxEMYjoo+vkqobrMOGIwdON4vZKJure/99uGk6G9HPs6uwT+
         4FWcMNITq8w7+mBf6wRw3pXCfuXMyDvDgoQJ2KFoMlUvveP8b8WW3GkZQNMftRu8iELH
         5XpafA1oNwk06xY7hkbJtJgK51zQv/Q4H+tB1iSi/5FVxuXfO3394XsKs4wtoRYiki2U
         NAUA==
X-Gm-Message-State: AOJu0YwQh08hv8Gi5PUrG4TL7bqnnuzvHToXcFrk1Gry48KtTJFMrTMi
	U/TyyC+Km15wG0cS36teBIcISz3+RZmCbralBvci/DP7qbW5e/Z7tvMd0Q==
X-Gm-Gg: ASbGncsXVZxB1mxmOwxmMke/AnRDA9WYBQmIrW//ECSCAfnYH+uf8otGJ49BFXpoXF/
	WEysf7fw/BtCmktc5Z71GKIOT1PwgGEwzqzFGdU95syDHM+nu1dNFPypPHpQfGg2/9ZOARQQHr5
	x5OOHI/0gauz2tdFc2ZAyZfkoUhgQL6Q/0Nn0m1X2ZYURRkGLNHcaJTs3cbfRBhfx7x5UhOUWhd
	hXpUtEEMvGvOwAfYMfNzOLm8x1FZ1ttG+KFBbfC0/bgsyPT7fRkvt+c0/+xnxIFfsMX4rNuwc5X
	//IQ78+f0UcT0H+f4OTzGP41y9BmxYkDJf/sCb276yWSc1bcB7ViV1zsmVVLfuE=
X-Google-Smtp-Source: AGHT+IEN3LVIHv/zYfHK9tjF2N8uA025B0EunqjfgFr2ycZTdhBkB5UK6ARNo5bDwlgtzP+VzllbdA==
X-Received: by 2002:a05:690c:3703:b0:6f7:56f7:2398 with SMTP id 00721157ae682-6fba56589bbmr15521357b3.7.1739915025757;
        Tue, 18 Feb 2025 13:43:45 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb47ab7a1asm23015667b3.72.2025.02.18.13.43.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 13:43:45 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
Date: Tue, 18 Feb 2025 16:43:44 -0500
Message-ID: <20250218214344.1519862-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables buffer flow controler for SCO/eSCO which apparently for
some reason has not been in use up until now which caused sco_cnt to
never be updated, but recently this has caused the following problem:

< HCI Command: Read Buffer Size (0x04|0x0005) plen 0
> HCI Event: Command Complete (0x0e) plen 11
      Read Buffer Size (0x04|0x0005) ncmd 1
        Status: Success (0x00)
        ACL MTU: 1021 ACL max packet: 5
        SCO MTU: 240  SCO max packet: 8
...
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
> HCI Event: Hardware Error (0x10) plen 1
        Code: 0x0a

Fixes: 7fedd3bb6b77 ("Bluetooth: Prioritize SCO traffic")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e7ec12437c8b..5c88d3816c6a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3564,6 +3564,7 @@ static void hci_sched_sco(struct hci_dev *hdev)
 			BT_DBG("skb %p len %d", skb, skb->len);
 			hci_send_frame(hdev, skb);
 
+			hdev->sco_cnt--;
 			conn->sent++;
 			if (conn->sent == ~0)
 				conn->sent = 0;
@@ -3588,6 +3589,7 @@ static void hci_sched_esco(struct hci_dev *hdev)
 			BT_DBG("skb %p len %d", skb, skb->len);
 			hci_send_frame(hdev, skb);
 
+			hdev->sco_cnt--;
 			conn->sent++;
 			if (conn->sent == ~0)
 				conn->sent = 0;
-- 
2.48.1

