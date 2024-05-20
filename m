Received: from msa.smtpout.orange.fr (smtp-83.smtpout.orange.fr [80.12.242.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC6812B8B;
	Mon, 20 May 2024 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716190940; cv=none; b=IrME58nnxlOKMfJ+qE3Q9qjBkj3sSz0+SZviaoXiq+iy17gn2DmVlQSnigcicT7pZI76QXQTbqhXuyTI4CcDji4gBui5aFEZnNW+qOwF11IJ+ElbUNc2hEVxcPxBM4+rmDkPxEZe2SOdskLlOJ5FfxiySknF5kQdBTkpx5slFIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716190940; c=relaxed/simple;
	bh=k4k9NEelRcoi98SI9g7103KMZ9H3Z/pFf+PgoWGfjy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HZscgJqH5i4WVKZFKzdtwfoMARRvkW/54r3Fozqle8EsssbqWA2bl4mbLjgL8BD33GaDE45Plx4wnHU8joE+fLvtRxTWgqt9VPTWxGbIAGW5uJ7hm5A8NEd/cY3MW2enk2yi5NzmFZpe1rcPZHRdgFJevQacmLO3chInj2uV3fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=t+8vRIjd; arc=none smtp.client-ip=80.12.242.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="t+8vRIjd"
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 8xeqsglyjml3s8xersCxfy; Mon, 20 May 2024 09:42:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1716190930;
	bh=bdxbRY6DhIfGliSzM5MbeLiBdRI38zgyGW9MM+5fHeE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=t+8vRIjdGyNISv2Dq+QABq/jhNPkpgpmtCbCrZAauIfXEEJEm4/kSoSCe2uw1oE9H
	 k3jvy8TEzmnOPH2k5pjGrM89Pv3MKBvuG2rOC84uZ2NAdsMRR5iMI80IommRPUFKdT
	 vs8xkqHkDt+1H7wfBfFej7bXLLGEYVu2CuLVmdf7wQlHMwd8L7VK5yTYB/gsbbVyXU
	 whAvKBMETZ7KKN7ftm6kOqBjwohTVXGGvLcFhay5ypfK9OL1CRPJKQcWSR9/z+/Hp/
	 FmEPifZ8kgskWWoj6sQP0Vz2HY/1t08Qq1JTvG7hDluDPgw93lVKDxHq6v26KtdeRb
	 oO6h4KFyha2ew==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 20 May 2024 09:42:10 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Tedd Ho-Jeong An <tedd.an@intel.com>,
	Kiran K <kiran.k@intel.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel_pcie: Fix the error handling path of btintel_pcie_probe()
Date: Mon, 20 May 2024 09:41:57 +0200
Message-ID: <692b4749f4267436363a5a8840140da8cd8858a1.1716190895.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some resources freed in the remove function are not handled by the error
handling path of the probe.

Add the needed function calls.

Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
Maybe incomplete.
---
 drivers/bluetooth/btintel_pcie.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 5b6805d87fcf..d572576d0dbc 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1280,17 +1280,17 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 
 	err = btintel_pcie_config_pcie(pdev, data);
 	if (err)
-		goto exit_error;
+		goto exit_destroy_worqueue;
 
 	pci_set_drvdata(pdev, data);
 
 	err = btintel_pcie_alloc(data);
 	if (err)
-		goto exit_error;
+		goto exit_free_irq_vectors;
 
 	err = btintel_pcie_enable_bt(data);
 	if (err)
-		goto exit_error;
+		goto exit_free_pcie;
 
 	/* CNV information (CNVi and CNVr) is in CSR */
 	data->cnvi = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_HW_REV_REG);
@@ -1299,17 +1299,25 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 
 	err = btintel_pcie_start_rx(data);
 	if (err)
-		goto exit_error;
+		goto exit_free_pcie;
 
 	err = btintel_pcie_setup_hdev(data);
 	if (err)
-		goto exit_error;
+		goto exit_free_pcie;
 
 	bt_dev_dbg(data->hdev, "cnvi: 0x%8.8x cnvr: 0x%8.8x", data->cnvi,
 		   data->cnvr);
 	return 0;
 
-exit_error:
+exit_free_pcie:
+	btintel_pcie_free(data);
+
+exit_free_irq_vectors:
+	pci_free_irq_vectors(pdev);
+
+exit_destroy_worqueue:
+	destroy_workqueue(data->workqueue);
+
 	/* reset device before exit */
 	btintel_pcie_reset_bt(data);
 
-- 
2.45.1

