Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979913769E9;
	Mon, 10 Aug 2026 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357433; cv=none; b=cn6l75B2uBLeLMHRV4Png91wE3Zqa5rZfYrAeo/XY/yX4NmXGhWQnOAC4cRaIYZhAwzkcsH2wpiGGNLS1AkyQTacIbO8Deyl2jKqro1+4iX7E9CzlKo+RXU+U8tdlgQYmWHsdAsu/O1vxqFoCHlfgO0PqwFa086G/ssj4Xjxb3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357433; c=relaxed/simple;
	bh=q4o4FsHLtMV/ZYL4GJgMuU5STZ9FDo08kFBuAg8iTzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opqewp52KCoKtLICbuSFgEWWl4pjbGCdQYpQhSEAcwdgIGxKEoVcVOkPU7QcUp69IUKKYJaFicArZMH+qxmjk1/aK76mO9UmZ42bpG0LPjLRYESAtYD+FSGF4KolJnBOTJ2W+Vz2pibB/Sdr4JfJ3tXQx74Q+0JdkQSvTtQ6L80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=UTRaja9F; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="UTRaja9F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1786357373;
	bh=UaiKz12rre+TEb0L0zwF2Ar518hheHMHyzdiIuPJmqA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UTRaja9Fq7Z6GXoKunTgh2glOTKaW5WALQ8Qr27kWrQArwk4FVx9YnzpuNpwP7qHp
	 4EbTPKh16zSrgIYWuUK9W8Itq1GgVA/ijqxlQxqWI+VEne7nCDjz+Q5DhMtUaUjPy6
	 1Wqp7XGWFxVpV+27st0pgkOR7e10TsSBeSKDdH0A=
X-QQ-mid: esmtpsz19t1786357368t5ddead0c
X-QQ-Originating-IP: Ai5nYPNeALjmEVvXxU8/ax7XOt7XYVRi8rRRc3K6A4w=
Received: from PEN002676 ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 10 Aug 2026 18:22:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17557001589291606295
EX-QQ-RecipientCnt: 9
From: ZhaoJinming <zhaojinming@uniontech.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	ZhaoJinming <zhaojinming@uniontech.com>
Subject: [PATCH v2] Bluetooth: btmtksdio: fix deadlock in close and reset paths
Date: Mon, 10 Aug 2026 18:22:38 +0800
Message-ID: <81B94E6D2ACC0BFD+20260810-btmtksdio-deadlock-fix-v2-1-0eb31f9066d6@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CABBYNZK1VKSthhfEi_BRJSX90W_c3sAqCSdsFm3Z6wXYDcWaVA@mail.gmail.com>
References: <CABBYNZK1VKSthhfEi_BRJSX90W_c3sAqCSdsFm3Z6wXYDcWaVA@mail.gmail.com>
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
X-QQ-XMAILINFO: M4zpSD2yH9t0vRrXbfSFaR6ew+yVCD2QGLZ5y+G4m0OuDL/1u5FW43q0
	DgeKIksj4OQZCZNeVrCnGZJUviWUr1BrJl1Mss6V6DSJ2KmvNectLWiWNRHDfjoiC7iFEp9
	j3mpaR/2/RdghVJpCxwotGIGgdjGS1spKqaa4HvIlzZ7hQkmqBa0m2kvDw0a7DOBhaVFOKu
	jBTcuSz9+W446LYGoBwRAb5Y0h+1b8TDc9e616DBvld2CMnIOoKb4mrDeMZ14MurKXjE1x8
	PKwl1tEQHS/8yOLCbflZbSxMAIjoSofwUXCQuNy8EG0F4IiCNs3BB35tNiB/cQ/ORW2JrGh
	TjeCavYRJbYfZ1fWAHTm01/Ga09cE2RQ90WSzpTkNr3WsP2NSPEuIfkq+N/svhWLiM9fc0g
	KrH0VfqV3+R5Sja/Rmwduj1oP6dx8uI/JQVdUmEW3dwlm21FSNH8xHFcIHexgq03UGcDs3x
	r0sxGIeSmz/YhfyVbA/sMSrpn0xZ/f63aa5BVPUOa13Jkhxqv+tuxR+UAvNCNnPgTgJjzXa
	KAJuQfZGwT2W/JqMmtFuICRV+zH0u2742NjKmh4E6WTneTMEvN5p981eokniFtyAGwk0PIe
	CtRYDoT97fhbLM85tooLa07q5uAoLBgY7vZbQcxjQjBmQ2EAxhyJt/7kpoYWUEyIERK7ypI
	fPJg4HkoswhQExuecRmkTRwlp8zLWmDvHb2DzsBS6meKwla0gr9XhHu1ipwOwBD6H/UplN9
	nfLSdIf7ti4ZmnBy+8+TpS3V7RpXmXbyWQJqxe7JqErgYUCLsmrs/ltyYYH6yGUP54Jucuy
	/ygGjD45TjYa9NGnGXQNzbE8G+LqVEB5SaX4bD45Nsap+dCe+iQHb4z1XccePOwbmMS3FbH
	SiMdhdX0ft5bYVoxNidyx7jwRnN0xLhCK8QlhoTa5etsniJSJ5uwknefAFh5RRD4oGSta3y
	D89BdyC/+8FserlF6ZsS7ecKgmQCyx5YheQQihwmC27x2EZggHneSdJEYAKMnxJyO1UKaiG
	lOarOgaJGAT5+cUHxrTKiRtZto5fWtW1zmmPTi/Jj0IsXQ1Jw03qGMJI1/UBUH9KCnVc1fF
	KxlbTh+78cg3Axn4RJaZqA=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

btmtksdio_close() and btmtksdio_reset() call cancel_work_sync() on
bdev->txrx_work while holding the sdio host lock, which is also acquired
by btmtksdio_txrx_work().  If txrx_work is queued when close/reset runs,
a worker thread may start it after the host lock is taken and block in
sdio_claim_host(), while cancel_work_sync() waits for the work to
finish.  The host lock is only released after cancel_work_sync()
returns, so both sides wait forever, deadlocking close/reset.

Fix this by releasing the sdio host lock before calling
cancel_work_sync(), then re-acquiring it afterwards.

In btmtksdio_close() the interrupt is already disabled by
sdio_release_irq(), which also unregisters the IRQ handler, so no new
work can be scheduled and cancel_work_sync() fully quiesces txrx_work.

btmtksdio_reset() must additionally unregister the IRQ handler before
dropping the host lock: btmtksdio_txrx_work() unconditionally re-enables
the device interrupt (C_INT_EN_SET) when the handler is still registered,
so an in-flight worker would re-enable interrupts and be rescheduled
while the device is being reset, defeating the cancellation.  The IRQ is
re-claimed by btmtksdio_open() when the HCI device is re-opened after
the reset.

This mirrors the pattern already used by btmtksdio_flush(), which
cancels the work without holding the host lock.

Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
Changes in v2:
- Unregister the IRQ handler in btmtksdio_reset() before dropping the
  host lock, so a concurrent txrx_work cannot re-enable the device
  interrupt (C_INT_EN_SET) and be rescheduled during reset.
---
 drivers/bluetooth/btmtksdio.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index c6f80c419e901e71b21e550449250a5a6755d100..23650df4fb06114ab7be1f0b30eb61a15322b288 100644
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
@@ -1293,8 +1301,22 @@ static void btmtksdio_reset(struct hci_dev *hdev)
 
 	sdio_writel(bdev->func, C_INT_EN_CLR, MTK_REG_CHLPCR, NULL);
 	skb_queue_purge(&bdev->txq);
+
+	/* Unregister the IRQ before releasing the host lock so that a
+	 * concurrently running btmtksdio_txrx_work() cannot re-enable the
+	 * device interrupt (C_INT_EN_SET) and be rescheduled while the device
+	 * is being reset. btmtksdio_txrx_work() also claims the host, so the
+	 * work must be cancelled outside the sdio host lock to avoid a
+	 * deadlock. The IRQ is re-claimed by btmtksdio_open() when the HCI
+	 * device is re-opened after the reset.
+	 */
+	sdio_release_irq(bdev->func);
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
