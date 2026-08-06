Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C53DD87F;
	Thu,  6 Aug 2026 06:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998225; cv=none; b=ehiaZhZGvDJLZloEh90mU1Fh2UaE8/cB6/AOrtUxs/Uj6rMk2jidQ9jkakBMrpRmI5Dk6XiaMUPhOZwQ7uBCVovpKLx3WUhy9GPNMtT2mqgm5sZm0faZnYWHT8krbYJDbDGCE2ty1+V8t52b6prRcAoBMXOYmpkfn/szf1QW7vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998225; c=relaxed/simple;
	bh=UtZEdM1X81hEwX7/VeFHRFAm9tX4z31suDUqyoer+rM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ek6DhOCj9KpOQjqLErGLXoOJlpas7bTReEgCfF4SgpfjW5VCqcnac7dNRMqMzHhaATb+1O4ejAA5Swx8xmTjkW1bKSbBFeNmsyFj0wFSfzAtPnd2ceP3uvOJYQCDlfSpaqIk1OqD8Nbe1PjEGXTQyPkqbMTixB0/D228mCmLFyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=XF7HG/Zz; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="XF7HG/Zz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785998144;
	bh=3aCaFbKDjbrgsWA9pX65sno3g8y9yQszPJrQTiaiiUo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=XF7HG/ZzWcaBrI5Tx+atc6SAPN0SaKr2z9E3gpU0wxNZPziECnhvJYJK4Ru6KRQ8y
	 6gL2HFfO8Dws50/hx8MSt5/TezFk1aSrq2S8mY2686Qc539b5wDzz//EJWoRIWVhw2
	 MVifQNmg1U/r/rACA5DGNRFUr1T/O/FQQ804M+X0=
X-QQ-mid: esmtpsz18t1785998139t713a1b3e
X-QQ-Originating-IP: meHIFHb/eE+sKBjPiO2vnCjlJI5G19NMZP2xmTBwoyQ=
Received: from PEN002676 ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Aug 2026 14:35:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7208643304580338951
EX-QQ-RecipientCnt: 9
From: ZhaoJinming <zhaojinming@uniontech.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	ZhaoJinming <zhaojinming@uniontech.com>
Subject: [PATCH] Bluetooth: btmtksdio: fix deadlock in close and reset paths
Date: Thu,  6 Aug 2026 14:35:21 +0800
Message-ID: <FD5D03449312D17C+20260806-btmtksdio-deadlock-fix-v1-1-3a2d4392d117@uniontech.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260806-btmtksdio-deadlock-fix-f9421f1a7879
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MwhIHrVefHZTbIQJW/yOT8KZgKpd1+0ZMDcoJ5Hltu8eO0TmTrGEAKU9
	TfGtNIWDK4iuVZVkdNTzXdPpl7RKAL0DXK5bCqEFsr9JqSVG4VhikSxbF4HhjlVQyiTFi2G
	FnjavN4fnRF9DepxgMkm5fovaWikDrPfP/1Pko4YHmGFqqjEdW7vDsfyWUN7gO/eAmBGKq6
	ryan8rEp8xz8LhE1qVxhqm8IQ839NP2b5PWWVAmBBVwjtfu3L9Owq1B/OfARA+2Mra6tfrg
	KoGzF/912hOIz1oYq0C4kfOLiMM4AJapNplMOKywUbIAn6u0e1krhwiNUsPtQEKn5f/a/xI
	ZTrvvruC2Ihvp4RlC9nt6pUjU3mnzq6xh5+rTENA7/9V7DZkwALKBzxtfCnJre3HyqMlin0
	2IbFApJGlFT+T0OObqEIcnuafnjddMYRHDpebYQPGq1rduKOg3SFDMoaco+F0w5lyNQXejh
	k4YcJDhC6QyuFOmYd3bNTFXjI8yI/IdwjJBIjG/QBCpDvyJw2caavRtp1KY40UCt8sZszOb
	1Hw5lrM9whz3wjmcyuKBroAKeCaHb+fSeYAYCnoju3xMeyYj6q+CIX9o82b5MQ77C1iqmQG
	ntwGNoIGqCJoJFlVpFVEmCc3cLNx8vlxbUts39XXhH1xf+MFip0bTY8os9QwCYOj8uaRy7S
	TmwSiJIScE3IQo9vTsqNjlC85ojVXVu4NEOeN5xZeAfuveW3chylamadq3HyBJHdUgun58H
	MM8/jV38dFAnt/oo78qjaU9ZTQFg2pO09ZvjLLRxFDJkuKBsTJnrEjnExSeThNV/avuUDzb
	QImo0K14fIoe84NIe5H0b6zG8a4C1JqjPKkyY5pfPFcbO+5OIL+4x4FSVINUUE9Kz858EYh
	IpurnPMeJ7BbzuP0N8OvBbHT65VGtvssrJB05yUtUUz7V6WvXIsiNfOyeCCWZv1+jjklFSx
	eJAA+AjxzhiYTAPwEv6httCKsVijBxGWu49CiS/bB1YGM/fdQAGqCmssG03gDKxnAES8+rD
	a5V6QmwQIdnrnONtj0
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

btmtksdio_close() and btmtksdio_reset() call cancel_work_sync() on
bdev->txrx_work while holding the sdio host lock, which is also acquired
by btmtksdio_txrx_work().  If txrx_work is queued when close/reset runs,
a worker thread may start it after the host lock is taken and block in
sdio_claim_host(), while cancel_work_sync() waits for the work to
finish.  The host lock is only released after cancel_work_sync()
returns, so both sides wait forever, deadlocking close/reset.

Fix this by releasing the sdio host lock before calling
cancel_work_sync(), then re-acquiring it afterwards.  The interrupt is
already disabled (sdio_release_irq() in close, C_INT_EN_CLR in reset)
before the work is cancelled, so no new work can be scheduled and
cancel_work_sync() fully quiesces txrx_work before the device is torn
down.  This mirrors the pattern already used by btmtksdio_flush(),
which cancels the work without holding the host lock.

Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
btmtksdio_close() and btmtksdio_reset() call cancel_work_sync() on
bdev->txrx_work while holding the sdio host lock that
btmtksdio_txrx_work() also acquires. If txrx_work is queued at that
point, a worker thread can start it and block in sdio_claim_host(),
while cancel_work_sync() waits for the work to finish and the host lock
is only released afterwards - a deadlock.

This series releases the host lock around cancel_work_sync() so the work
can always complete, mirroring the pattern already used by
btmtksdio_flush().
---

---
 drivers/bluetooth/btmtksdio.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index c6f80c419e901e71b21e550449250a5a6755d100..879d580226d25ad398105a158de1545dace33718 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -746,8 +746,16 @@ static int btmtksdio_close(struct hci_dev *hdev)
 
 	sdio_release_irq(bdev->func);
 
+	/* No new work can be scheduled after sdio_release_irq(), so cancel the
+	 * work outside the sdio host lock. btmtksdio_txrx_work() also claims
+	 * the host, so canceling it while holding the lock would deadlock.
+	 */
+	sdio_release_host(bdev->func);
+
 	cancel_work_sync(&bdev->txrx_work);
 
+	sdio_claim_host(bdev->func);
+
 	btmtksdio_fw_pmctrl(bdev);
 
 	clear_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state);
@@ -1293,8 +1301,18 @@ static void btmtksdio_reset(struct hci_dev *hdev)
 
 	sdio_writel(bdev->func, C_INT_EN_CLR, MTK_REG_CHLPCR, NULL);
 	skb_queue_purge(&bdev->txq);
+
+	/* With the interrupt disabled, the SDIO IRQ handler can no longer
+	 * schedule txrx_work. Cancel the work outside the sdio host lock;
+	 * btmtksdio_txrx_work() also claims the host, so canceling it while
+	 * holding the lock would deadlock.
+	 */
+	sdio_release_host(bdev->func);
+
 	cancel_work_sync(&bdev->txrx_work);
 
+	sdio_claim_host(bdev->func);
+
 	gpiod_set_value_cansleep(bdev->reset, 1);
 	msleep(100);
 	gpiod_set_value_cansleep(bdev->reset, 0);

---
base-commit: 0d839570765118029aa8bf4a95444c6a11aacf85
change-id: 20260806-btmtksdio-deadlock-fix-f9421f1a7879

Best regards,
-- 
ZhaoJinming <zhaojinming@uniontech.com>
