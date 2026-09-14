Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFADF2C15AC;
	Mon, 14 Sep 2026 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379276; cv=none; b=B4yusHBGClkkpVfEBmo9T7NcG97EGwwjCrcPEQl6xLO98QSA6+zlAOzKCCxk4qKPTRzLwFBy/6/lWjUpa4VrlYpEPvbtwU3sKH4UDEJxo6QqAZJvvvpgc5HJAzVUqD4+irBHTgNt31xHCgfUxgGeQLar4LIAAzdc4cfWysZKeMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379276; c=relaxed/simple;
	bh=KMPSY4cwSu6373LyLoo/p4PM6VCfp8K5K1rFGXAGewY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O6NCtRUfKSVZ7rCVnc7aUfiaCezDK0MLX8lar/Pqo4g7HitVC0fItL7opKNLf+erScyeM1onpYe6C32NV0K6mR7tTJCsWFACZMMTSMOJ3jbDj02cZcU2fp7XxowAmNNYU+6qc2fMs7h8vHKL5MB3kDQp+VSrBjdAD2yTyNP0d2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qu6RkjLL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qu6RkjLL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912511F000FF;
	Mon, 14 Sep 2026 09:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789379275;
	bh=gTLwRHwiUe7+GvIFtClrzL61I2xfkUvMQEXH2OCtR3Y=;
	h=From:To:Cc:Subject:Date;
	b=Qu6RkjLLZ+IgAX/zpNZO3mSIF/XxeqsnBsMgLi66Op5TRLV1ejriB9fdDnb7na3Qk
	 P0rTVsLTrZedZ0e39Eis2dEsv8Nzvasl9CZgYs7h5AW9JkkT0MiJyU2efqVZJ0uRS/
	 Fy1z1+us365hzB3w7uVSXIRxa305zBUXO+Suozw20H69lCHzm6pwfp19xTlfdpO/Z+
	 javBuNhCVt0qm2QkbFvv8Xd3Fnws0+1lADHwdcjxBsnk3tmGRXkjN9qXhd3Nd+gR1D
	 7wkRYzhPt+HHvcvYv1b52uvPHbwbpAHf0LcsGtOg10ySCw4I6JjQm2Ex8q23W5teZY
	 EaBJGJ/yeJY2w==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	tzungbi@kernel.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH] Bluetooth: btmtksdio: Fix PM runtime reference leak in shutdown
Date: Mon, 14 Sep 2026 09:47:29 +0000
Message-ID: <20260914094729.3222624-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In btmtksdio_shutdown(), pm_runtime_get_sync() is called at the
beginning of the function.  However, if sending the WMT function
control command fails later, the driver returns early.

It bypasses the corresponding pm_runtime_put_noidle() and
pm_runtime_disable() calls, leaking the PM usage counter and leaving PM
runtime enabled indefinitely.

Fall through to execute the PM runtime cleanup block even if WMT errors.

Fixes: 7f3c563c575e ("Bluetooth: btmtksdio: Add runtime PM support to SDIO based Bluetooth")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/bluetooth/btmtksdio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index fe4ca9395aa3..b7db15268904 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1249,10 +1249,8 @@ static int btmtksdio_shutdown(struct hci_dev *hdev)
 	wmt_params.status = NULL;
 
 	err = mtk_hci_wmt_sync(hdev, &wmt_params);
-	if (err < 0) {
+	if (err < 0)
 		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
-		return err;
-	}
 
 ignore_wmt_cmd:
 	pm_runtime_put_noidle(bdev->dev);
-- 
2.55.0.1007.g17ff1f9808-goog

