Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672971;
	b=bwqcCCz4oKUi/sXbLqNG3cKKqK140qfQekE5ioE+aNf30cLgKt1Ensm1aTxoQ3d2Qpav
	 7C0iu6v5yEf8X0OKep5niEg1xGjo1OvCuhzY8p8unAoD63MzvuxqZIo1vS0jwWGhfJ48J
	 yRNnlFu4G+KzeCic+IClI1c+/+eaeexrJOOm2yH191/3UmlTgjdwnn+D85Rf1U+LhNa8l
	 aVPp+QNKoMjFiPYWOiUj80MSIX/cP3HdEndZQoWW2Sp/BAC3CEy9UCsRy6MUTel70MrfG
	 pGG5CV6fd9fscf1gOlna/V1K8scZNhhA9DbxwUuC7OkYE3sQoByfiXWyQjpNd/23JPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672971;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Date:
	 Subject:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ApmNo1VyKCyxdEAUvkrRU2wuXDxWxgVe5Q7ZRn02jfY=;
	b=QwTRFTWSSeJyyNJJz2jb3DxwvdfQ/bzeSPm7wV+KbqUaHvQNo/5MVueD+ia86ir4tQ10
	 CFndbbYq6OXH7G5xTDg7op+8jxJynUuyvnT8CsxsX8ArEk5DU4D4vWEINbflq5SQuayFF
	 6Lt6FNbdPoOUP4M9xQwbsPTQQEjsl2w7wLWbtrCY2LDckZacM43UOcloEX7gLBbT20ABM
	 ZIZeXEG9uP8s85LUB6XkFGXBER6zNIM8mr1vk4JOSmbmY2MKCV4RVx2jiH64Ww+rMiwCV
	 LEbjANvU1HadlqAvXTilVfbavY5dawISo4m+HIFvEI4OYrC7i3KtNYARs7NWK5T8QJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelmcallister.org;
	spf=pass smtp.mailfrom=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=LN4dySTH;
	arc=none smtp.remote-ip=185.70.43.171
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C6C606A329
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 16:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68C6C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=LN4dySTH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=michaelmcallister.org; s=protonmail2; t=1794672968; x=1794932168;
	bh=ApmNo1VyKCyxdEAUvkrRU2wuXDxWxgVe5Q7ZRn02jfY=;
	h=From:To:Cc:Date:Subject:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=LN4dySTHaRijHL91eaR7cDLl8RLg2YMfXB2cO+sPtPajBR4SKBp2fRs00u8Sd4UdJ
	 z1W5XRTxMi9vnPOBbdMBXCoyKGt6RRH5wJhCdRonIUbBUEBWWK5fSgD6QqC0xXlmSy
	 6sBFpeWd1Thq6gkrTSG+r8L9vK/BRP97i+VckTWbal9Zqj/iTMSOx+lKhZWiSMTm+S
	 Jh8vMx1oZBsQu/ElGoBLjg7TfsvFvLj3GWpX15p7uCWZfMBFY2YEHoIMAN1PcmodRn
	 DGm57TbzTieO0ryntqrxYizLOEI+Q8gEO2lU7dcSmSVlVcHQWKs0ZWmXw2G9tNEGF9
	 PqBloHMn8/FXg==
X-Pm-Submission-Id: 4jRfPf4Ckvz2ScmC
From: Michael McAllister <me@michaelmcallister.org>
To: markus.probst@posteo.de, luiz.dentz@gmail.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 14 Nov 2026 16:15:55 +0000
Subject:
 [PATCH 1/1] Bluetooth: hci_mrvl: Leave the serdev port lifetime to hci_serdev
Message-ID: <179467295519.97469.5747232754111917783.marvell-serdev-v1-1@michaelmcallister.org>
In-Reply-To: <179467295518.97469.12346516231160594592.marvell-serdev-v1-0@michaelmcallister.org>
References: <341e56b1ff7d8a5b109e26e30dfed61faa54d603.camel@posteo.de> <179467295518.97469.12346516231160594592.marvell-serdev-v1-0@michaelmcallister.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

hci_uart_register_device_priv() opens the port before calling mrvl_open(),
so Marvell opens it twice. Likewise, mrvl_close() closes it before the
transport closes it again during unregister or registration error cleanup.

Remove the extra calls and let hci_serdev own the port lifetime. This also
avoids failing probe when serdev rejects a second open with -EALREADY.

Fixes: be70e5e774a6 ("Bluetooth: hci_mrvl: Add serdev support")
Reported-by: Markus Probst <markus.probst@posteo.de>
Closes: https://lore.kernel.org/341e56b1ff7d8a5b109e26e30dfed61faa54d603.camel@posteo.de/
Assisted-by: LLM
Signed-off-by: Michael McAllister <me@michaelmcallister.org>
---
 drivers/bluetooth/hci_mrvl.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/bluetooth/hci_mrvl.c b/drivers/bluetooth/hci_mrvl.c
index 5798a8db0..def19907c 100644
--- a/drivers/bluetooth/hci_mrvl.c
+++ b/drivers/bluetooth/hci_mrvl.c
@@ -57,7 +57,6 @@ struct hci_mrvl_pkt {
 static int mrvl_open(struct hci_uart *hu)
 {
 	struct mrvl_data *mrvl;
-	int ret;
 
 	BT_DBG("hu %p", hu);
 
@@ -75,17 +74,7 @@ static int mrvl_open(struct hci_uart *hu)
 
 	hu->priv = mrvl;
 
-	if (hu->serdev) {
-		ret = serdev_device_open(hu->serdev);
-		if (ret)
-			goto err;
-	}
-
 	return 0;
-err:
-	kfree(mrvl);
-
-	return ret;
 }
 
 static int mrvl_close(struct hci_uart *hu)
@@ -94,9 +83,6 @@ static int mrvl_close(struct hci_uart *hu)
 
 	BT_DBG("hu %p", hu);
 
-	if (hu->serdev)
-		serdev_device_close(hu->serdev);
-
 	skb_queue_purge(&mrvl->txq);
 	skb_queue_purge(&mrvl->rawq);
 	kfree_skb(mrvl->rx_skb);
-- 
2.39.5

