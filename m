Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C453B42C2;
	Mon, 13 Jul 2026 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783935526; cv=none; b=V+F7BMMqkPdHiml1CgKg68rztUbd5KJG03Oacuk7GeHH2Nu22a8xJCypFxdp8fE52lAx8juQO1Lo03XIzijUhf/7GKhGei+76PMnpKpPWpyBh195ZxXzPedlI3SnS8OFKMzrWqXgr0MM9kx6UQml0OlYtJH/VyHHwsuEVWSne+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783935526; c=relaxed/simple;
	bh=bPcrT+Tg7YD6yhcrHBRzXYiThoOZ4NWXVppGZnjmZVo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=fZ7X/1aAqLHcWLQr9zxzT8vkXVcvu/APaijArmpYLhTbq+TjVNNYdz5LnMZal8WJA944cg6fPwJ1qkuOyVitNu140E85z3vJwqpetHkLtgn2SseUQZAKC7rFkASWaX/3O8ZmPAo+NawcFyb5rQoyxWFng28gN/coZ5FE5rSwZ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=d2uVbAle; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="d2uVbAle"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1783935517;
	bh=8Wjj2nFh1/eA2LCw0fmBvTWRNHY54TXI1rsxSWwH0hI=;
	h=From:To:Cc:Subject:Date;
	b=d2uVbAleYZlNleiEQ3+p82//xCcCVsIHE0Fu5pRjYsxb5sxYKyNLEVkLE2jPf27fP
	 EsgcsamRG3R0HYQBSac2XI/6+xQoLSoE/BnMxMWDA+5hkY8Z572SpYP4+HjrBEDvq4
	 lc3mM5yc+r7KXqVdjVkVAtIxuvDl59yYWf77L/AE=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 9A316CBE; Mon, 13 Jul 2026 17:38:35 +0800
X-QQ-mid: xmsmtpt1783935515tce1lowq4
Message-ID: <tencent_44ED865C14DA3D3823CA85AE1DF2CEBC1805@qq.com>
X-QQ-XMAILINFO: MZtEYADUG4AgCymIC1dY7kLkaTeDl1gVe0aEsp7rWmbrVpp4POOP64PJ+rMEky
	 jCWe/wsAFBS+0cHYJHJ5RZWwf8fu8c9rH0SZULkRyxRhX/M1g+DE4Cp+3mL26qDX1CIERa7xL9mQ
	 qgxuPVUAVIhIlpvKxhVCh3e9QvUGXGSuM4ZSfG6XWUbogqxX9kWOcia56+mjwGl21WpIkTXKLXcc
	 0CzxFKU8k1QrDcuw4qK3r9aOB4TJihx0bcCmBBkiI2Ak1zVj8u6eoEsf43XMfnKH80fZKssTYCIm
	 j1Xm1E/S6pyr1bwxHFXMdyKRNL+kaMPdc4zvxRnxIvF/Pu8Pk+MynZBalK7q+lCN1o0pyHJ+6l+m
	 n15p+nVdWBqet364tm7FIaSLBa91GB+nGHYtUUP9v2EbO0R0ttMVPYWjD4L2eVu7E1DX1mz7Z/JI
	 +tkLIeH6SBRVZoy1l4xCqjukCf3aMEyhAHRHaS1o+M4f9NHHOfGag3q/9vLZ/YcTF/wtrggSaSGS
	 PJv8ze/OfiJepoyqGQnPYnQobESLqYQaSC473ncZLz/g15ytETpfV8zFhh85TXeYBZDaRzsgiS55
	 x4TAdKGj3h/rGkQkldmfUyupcY2ERmGzmgNv2PL0GA/fHYgKcwgwR5VryZGy0jSr4WCU7DImtZmQ
	 n+E85705SXM7yNLIqEgKhA/YJo2adQQakYzr6bf+T+8g/j5kxv5y/LY+CFbFGxBJILsnIkzwjQpP
	 JdOlR+4xzmcsf/vqt3OWXoGgOO/mxttVfujqE7S6pBqQTfaVp3YnWCrTvjSXTeyHeTbOerUYbJvt
	 Lp5b6c9cvzBMnpsdYXEVQ7/PXf3O7CVQ/aUa+EWKZZF4EiczUfvnH1XghsMnh98Q66fD8l8gh688
	 RRM4ws7LFBBXfe36kaBNwuUTdbym2K1t11VbIutv21/cOIthsk0Ltp0Gv8TLKvBVFqrCTByM5+yY
	 0chAfltOnjqYkTGhuzdnO+dJrk1BIV4h6tna2lWwhnpiEDZmsCVNC707+Rwg2hRV/AF0Wn3JhW9X
	 sYwtfCI6FGzMzjo3+GcI9jT69ZKYE=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Zhao Dongdong <winter91@foxmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>
Subject: [PATCH] Bluetooth: btintel_pcie: Fix DMA memory leak on probe failure
Date: Mon, 13 Jul 2026 17:38:33 +0800
X-OQ-MSGID: <20260713093833.484005-1-winter91@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhao Dongdong <zhaodongdong@kylinos.cn>

In btintel_pcie_probe(), when btintel_pcie_alloc() succeeds but a
later step (btintel_pcie_enable_bt, btintel_pcie_start_rx, or
btintel_pcie_setup_hdev) fails, the DMA buffers and descriptors
allocated by btintel_pcie_alloc() are not freed. The exit_error
path only resets the device and destroys workqueues, causing a
DMA memory leak.

Fix this by introducing an exit_error_free label that calls
btintel_pcie_free(data) to release all DMA buffers and the DMA
pool before proceeding to the common exit_error path. Error paths
after successful allocation jump to exit_error_free, while the
allocation failure itself (which is already cleaned up internally
by btintel_pcie_alloc) jumps directly to exit_error.

Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
---
 drivers/bluetooth/btintel_pcie.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 9e39327dc1fe..b672ce376e9d 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2896,7 +2896,7 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 
 	err = btintel_pcie_enable_bt(data);
 	if (err)
-		goto exit_error;
+		goto exit_error_free;
 
 	/* CNV information (CNVi and CNVr) is in CSR */
 	data->cnvi = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_HW_REV_REG);
@@ -2905,16 +2905,20 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 
 	err = btintel_pcie_start_rx(data);
 	if (err)
-		goto exit_error;
+		goto exit_error_free;
 
 	err = btintel_pcie_setup_hdev(data);
 	if (err)
-		goto exit_error;
+		goto exit_error_free;
 
 	bt_dev_dbg(data->hdev, "cnvi: 0x%8.8x cnvr: 0x%8.8x", data->cnvi,
 		   data->cnvr);
 	return 0;
 
+exit_error_free:
+	/* Free DMA buffers and descriptors allocated in btintel_pcie_alloc() */
+	btintel_pcie_free(data);
+
 exit_error:
 	/* reset device before exit */
 	btintel_pcie_reset_bt(data);
-- 
2.25.1

