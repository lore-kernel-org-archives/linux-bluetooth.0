Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5C53D88E6;
	Thu,  4 Jun 2026 11:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573632; cv=none; b=de4Bt8yJkLAvRPcvNXQd1DkJ9mVwzx9o4fhtAK3+N3ZJk3hif3/PNOiLWXfmJ2cuTW0DTCRH2U+NRScXuLt5CvyDiXV1pIqMub3Pix5i479DVGZvmoGuFSmfeZjxcc3Kw4omXpKOZBLHLFbK3bgPf+44iPs9pPSqTj2wE6sy5U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573632; c=relaxed/simple;
	bh=v6USZPrjoNFVI2HUgcteTPa6R/nsMxOMi7kUZy6QeGg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=QGA4/bUUFSiGXBYCvIsomyObSIw1GaKyjQyt3xc34lEqEDnxt6Wwy+bsnAp6ZJWFw3kGslTDYFga+CuNhznMpTSfskbM2UoS/WYapV37zNwdGsnao1X873TV+5DobCOYj4pVJ4sN7+qQ3gQoRvhGx+FfYR5EGCPu/PSOGCEqmsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=eQhcxFOP; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="eQhcxFOP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1780573619;
	bh=iEDTrzvd1YSAtoS4E67q83sAXUipD/sEqa3irMmfxhE=;
	h=From:To:Cc:Subject:Date;
	b=eQhcxFOPTUZ7qNRRRB8ND8uQ2NECgWzUyvQqD7t5Y724hM6p9GTP/Rb4xD6hErEkK
	 ZkgbXyA2dznB16+ZQwXxmTEUDweLWoBFEgcXwdgEfYJnR/eUlVUlLUqeDCV+IWqWa9
	 wTyOB5UdvvPo5WOCLXptkq6AHgpuifABY4sT0rnY=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id BB91DE88; Thu, 04 Jun 2026 19:46:57 +0800
X-QQ-mid: xmsmtpt1780573617tj3sl85rw
Message-ID: <tencent_DDA5BDF30EAC58E68647B4C37D20A3C7A505@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUAKg2qFL+JNHYqYXpQFU7vZh5WM/qP1cJDz1EAGPGhVajTMqJigT
	 pxnLW28fLLhhTyeAnk/QY6Gu6XlQXs9ZSvYr9ifawec2Hoac7rfHr91kOx2aoCbNstzKbSriv05F
	 8J9RYwrupH7ofRG0D/AD6jlvW3zIwMHUrwqAfufULWvrUgYJyYc6piOCPnK0cbFtTCQB0XsSNPMb
	 GjqU8qHFSFGrmonRih9zkVclNJAsq/Lq6r563hAqPUL8srldZZ/Ja8METBRofIRQUfF2WxcXUWg+
	 iTgFwUjGhiKQNc15VFj4cZMz6JaGaJoLh63hGS0PT1WclSXp6+FAfYcdXv5fijC88n8WeWLrNmf7
	 7CWDBc6qUm2FAXpTXR3hnerDHCs/v/HILgOQ4l6Bxs5QCmK55bVJ2mVShZh7WSpVobrLk1NgtVkH
	 UrU4/QKFNVgg29pv7mWLe4Tmf5myazmDciEOU36FiOWOKSbkz29WRjT/41YPxK/R7EowZcIBlps9
	 3+3OjwvBL257l4ckqIeUqod+TxyhRrQ0jZppygO+2PGXFncb50cBLSog3hXOlLRU9rLnVQziKuaQ
	 u5GZFybwz/X58jlgiU1SrqINBdUoElqD2QRU+xO3mc5yOTYLbujXNWq0hHQfZa4svz06jcQDQn0G
	 RLMfBnGsnuNjEbkqzJvw8diFNgg3krFGcPhYtbMoG6gQ8Wx3jlHhkS0LchmLWgv2wppbTKvRQLzR
	 AHgS5zzwGYXyKyD1wdtKpvjYTflu0cybeX7E9x/4s+8H+Wb5ysaIq1ZFJKfG1TYkGw5gAILdMJ9n
	 urW4tZyvNkFPB4j7p2g+SE11YFh/lb9vUPAG7jAbf/RY46WAhYXg/37wQKNXJtT0tNX4/SHw4dr/
	 ny5gKWqQQi7BV5rgcO9lLG5AcOb/KxpekxCxAoGvMkr1j4r11YvB5skqT3yZQxDkVtedmYAPd4Be
	 3nGELMaCqMGq/2nU11h0G06ZnvXqSP2yL+iR/V4uc6Iq8s8dO4agRQA+HtrxNOMDjn1v73nNMKaM
	 o11tixJ1EmwGx+sjqoHu06F1Y5CrM=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Zhao Dongdong <winter91@foxmail.com>
To: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>
Subject: [PATCH] Bluetooth: btmtk: fix URB leak in alloc_mtk_intr_urb error path
Date: Thu,  4 Jun 2026 19:46:40 +0800
X-OQ-MSGID: <20260604114640.1190040-1-winter91@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhao Dongdong <zhaodongdong@kylinos.cn>

When btmtk_isopkt_pad() fails, the previously allocated URB is not freed,
leaking the urb structure. Add usb_free_urb() before returning the error.

Fixes: ceac1cb0259d ("Bluetooth: btusb: mediatek: add ISO data transmission functions")
Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
---
 drivers/bluetooth/btmtk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 8ff66b276af0..c29e1841b2b3 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1074,8 +1074,10 @@ struct urb *alloc_mtk_intr_urb(struct hci_dev *hdev, struct sk_buff *skb,
 	if (!urb)
 		return ERR_PTR(-ENOMEM);
 
-	if (btmtk_isopkt_pad(hdev, skb))
+	if (btmtk_isopkt_pad(hdev, skb)) {
+		usb_free_urb(urb);
 		return ERR_PTR(-EINVAL);
+	}
 
 	pipe = usb_sndintpipe(btmtk_data->udev,
 			      btmtk_data->isopkt_tx_ep->bEndpointAddress);
-- 
2.25.1

