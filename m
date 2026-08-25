Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266733DFC8F;
	Tue, 25 Aug 2026 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647453; cv=none; b=lWzWHI9n9dSylow26y6zcUn0n7WPPsOPHG8sziU4K+fl7wlhKv25z7lAmwe3bJOCL4FGhBz+WXrJckUvfJlR7nJdEl9dDUc3Z1RLyyyymRlHZ8ut9L1VGG4ScX3mWAKBrBiRje9mL3nu2O1ukiI5BzGeLiF2QoEIhkiDZxb1Od4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647453; c=relaxed/simple;
	bh=W34HlTwtKiHsnUX4+mdTnxBYYF658ZhXEQT1XVXZgi4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mken+5gqTCw/QuqD17uR2DVKPwAVnM5ZQ0WxeVB53b3lxdU2mc7LisfkqBDBOy9og6Y6xR1UzccqJZ2AHzHit5m/69Xf6Brel4qdoVFlzcIkP+jyOSql9wcP79XnXKghIPxwoaByf8b8SMVYzxL9NJumlS3dRm5jmkSs5+in5CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=a3soZNMF; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="a3soZNMF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=sg
	jngM2YY8QYFIO3DGUdz0BGYzZgLDfC5zwZT59AEn4=; b=a3soZNMFB21v2pFuAs
	J+EQ8h0rA77oiJm9pWBy3GTtT1zdx8Y4f60/FqIqv0Rn0T/5JEy+USGbUBMC9vwu
	BcLhtb8MpVmFMx2q8/VCYQ5hMdT1eC+mdlGeuxQP7DE7KGcF+cliBsXYSvi0sdQk
	Wzc7xWppNA25LwgslHMLhz+0w=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDHvR2wVY1qjXFCOA--.63912S2;
	Tue, 25 Aug 2026 16:43:29 +0800 (CST)
From: Gongwei Li <13875017792@163.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Chen <mark-yw.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Gongwei Li <ligongwei@kylinos.cn>
Subject: [PATCH] Bluetooth: btmtksdio: Do not fail probe on wakeup init failure
Date: Tue, 25 Aug 2026 16:43:21 +0800
Message-Id: <20260825084321.3544900-1-13875017792@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDHvR2wVY1qjXFCOA--.63912S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF43GrW3uryDGr45Ar4ktFb_yoW8Aw4xpa
	98GF90kFWDurWUKw4kXFWfJFyY9w1FgayjkryYyryY9rZ5JrWFyF1ftryYqwn7CrWkt3WY
	vF4Fqrn5WF1xGaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbAwsUUUUU=
X-CM-SenderInfo: rprtmlyvqrllizs6il2tof0z/xtbC4hF-OmqNVbELtAAA3K

From: Gongwei Li <ligongwei@kylinos.cn>

devm_device_init_wakeup() merely marks the device as wakeup-capable;
it is only consulted later through device_may_wakeup() in the ->wakeup
callback to decide whether wake-on-bluetooth can be used.  When it
fails, the controller itself still works normally and only the ability
to wake up the system is lost.  Therefore the failure is not fatal for
probe(), which is why the existing code only logs the error instead of
bailing out.

However, the negative error code returned by devm_device_init_wakeup()
is never cleared, so if the subsequent devm_gpiod_get_optional()
succeeds, probe() ends up returning the stale error even though
probing actually succeeded and the HCI device has already been
registered.  The SDIO core then wrongly treats the function as broken
and unbinds the driver.

Make the non-fatal semantics explicit: clear the error after logging
it and keep probing.

Fixes: ce64b3e94919 ("Bluetooth: mt7921s: Support wake on bluetooth")
Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
---
 drivers/bluetooth/btmtksdio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 63d81341bd94..c918202f6c3a 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1454,8 +1454,11 @@ static int btmtksdio_probe(struct sdio_func *func,
 	pm_runtime_put_noidle(bdev->dev);
 
 	err = devm_device_init_wakeup(bdev->dev);
-	if (err)
+	if (err) {
+		/* failure is not fatal, keep probing */
 		bt_dev_err(hdev, "failed to initialize device wakeup");
+		err = 0;
+	}
 
 	restore_node = false;
 	if (!of_device_is_compatible(bdev->dev->of_node, "mediatek,mt7921s-bluetooth")) {
-- 
2.25.1

