Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8656C30C14C;
	Wed, 15 Jul 2026 06:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784098042; cv=none; b=ijy8M375eOn/jtkROxftFuJterF8qkyd4vAx3AWBJo6vWClCKs0RK8RXVR632vj/dheLS172AnJNBgT0iXylY9DaszgtnnMNhgcwxYgLVneLqHurATYbRceBVI7H+t55ega/RTYairXB1RDSKDZSQjjknJrkv8FHjZDko81g0W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784098042; c=relaxed/simple;
	bh=ddY7iQzWSbLIwLSfK4vCU5HXL20lKYp7V3dcNbXKITM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=XHG0KISQT6MPJXrgcK/cG8rJ8NwqrRluY1Zklsg81lElPPPbujt7K79NxtIbGe4TLKPWCQfDoi43DXLNxEwqAAQBhX715QMjoaof3TqAPWbm9EDtf4z75YcDhXHMs6lhO/he2OxsuwSRH0xBQt53x2y91NeEDzkBrjWt1fm+LeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=isohuCQJ; arc=none smtp.client-ip=43.163.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="isohuCQJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784098029;
	bh=tvI6W+x3XGLfTPT072GMrBpHKu4nFseK44R9qBQ1oAc=;
	h=From:To:Cc:Subject:Date;
	b=isohuCQJ1JByqHaGu7OTHHY8m12qGtDTaxndRlM1UiCUKF4sZUquiaS6W7co0jXPd
	 RKNwNB4zlEGM8JsZVQkcd/AAvEUHKnBscsK093tdFblLoP+hyvlwb3dYik7guWoXfd
	 NTSZByCoSt5cKD7a90ZEZh7jooR9e//wz6n8nu4Q=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id BC78380E; Wed, 15 Jul 2026 14:47:07 +0800
X-QQ-mid: xmsmtpt1784098027tm2ge6bej
Message-ID: <tencent_02AC78E0C64C34C55D3AC3DAC5AE5DE20E05@qq.com>
X-QQ-XMAILINFO: OATpkVjS499u4Srxjoue32C1tzo9lAQGFyfjO/1Xz3bA02oStXQxO1dIXGM9ks
	 DGRJPp6ZUjxvCcN3fpYr62c2zIKa+UbMzxq+FvMwNKAP4sGw3R+SdQg+1vRrjJplLRd4JVBqI7Dr
	 43MGfnvnupf4qVvmDSIIj9Z/ciqefVnw0B4RtImQgIuYJqe7jFAiYm6lvSVgRhjJsw38BlnqrNpT
	 aJZbrmEp8Zcs5I0mFEPG2t195yvouGly6FwzTa2IZsBllxKRONEub3ZSk0QBgXlHziFPiOaPusSj
	 IXnyUXqSk8W7l/GUP+G5d4/LmlNsfuJGgYohzVKzsCmeE8UPvuOzjLpVJbdWgwqMa6nrcV8g090s
	 dBL7gORTvWZcdCt+FZIP7or7b1hHXBi07zmDPYVuFuC/02hH6gVXIDD4ZqhG7/PtnDIy6MTnB6LW
	 kZZL8NhbH4BdZH4qbgwpurX/y2v62FCcDfIoAYoLPp4tStsNZnwb7Wkx/qlWuiNUHPQqSeizG+cr
	 JCpjaQvPjiHVcLNbssvF2Jy50MtUx2YpXx0zRR0H/3nb8MaWoH/RenHAbJi5ShLevsv91KXyYefD
	 tkMX3ojvj+jXT9eU9TuBtPW7aHru0I+j1OqrwEW3A+xToNqu2mIIxUJc0kcY6mFWbTKqzI2fQRld
	 EQXP6fpDBiQtZcaCItcCxWXHfLNC5TC3ZeicBFLdQNVIqi5CNlaWPmyiB+I3xt/BgIT1aPhlqDVm
	 4E7cpNgpWPX1ubwgbvk9iaJkHkyN0dtWchy+sQ0225drCu23Hu3Tel8PzdAkppqCtPY81N1kWvsv
	 8HkAEv6aMKcKV8rXaveUrAM6rCBEl6s/fGuc0SBJNn8YYm9W0Kmr+VYJVMcXaf/ROTZD4U5vkXNJ
	 9WOpknAM2UhpbWKNd8N3trd5L0QHETBbg+uoov6a2gqz3k7GPt7QzG0YTOY9UhWWygEwgwvsDBGx
	 17tFuK0Jy1rVFST4s0AJbM2voBXDhM0Pkn61E3n+PnZ79lmOruAUBNtti1vUsuOeNKa+/PuibBIq
	 THhaHfKoUXO8LIp2nFBrAhfXLnFt5a51BPTBfvpaOzddykQbd1yftHYCDI/EV0+WVcDwpC053R47
	 2wp+y/ZbhaiVsrbmAOPhg5imx4kL5+e3XdoMHH
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Zhao Dongdong <winter91@foxmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>
Subject: [PATCH v3] Bluetooth: btintel_pcie: Fix DMA memory leak on probe failure
Date: Wed, 15 Jul 2026 14:46:39 +0800
X-OQ-MSGID: <20260715064639.283021-1-winter91@foxmail.com>
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

Fix this by calling btintel_pcie_free(data) after btintel_pcie_reset_bt()
to release all DMA buffers and the DMA pool. A NULL guard is added
in btintel_pcie_free() and data->dma_pool is cleared after any
partial allocation failure in btintel_pcie_alloc(), making the
unconditional free() call safe on all error paths.

Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
---
v3: Pull latest repo and fix patches.
v2: https://lore.kernel.org/linux-bluetooth/tencent_9EDB39EF4A8A9D6EF645A7DC2F32B25CA209@qq.com/
v1: https://lore.kernel.org/linux-bluetooth/tencent_44ED865C14DA3D3823CA85AE1DF2CEBC1805@qq.com/
---
 drivers/bluetooth/btintel_pcie.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 013568197a39..6d578659a689 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1982,6 +1982,9 @@ static int btintel_pcie_setup_rxq_bufs(struct btintel_pcie_data *data,
 
 static void btintel_pcie_free(struct btintel_pcie_data *data)
 {
+	if (!data->dma_pool)
+		return;
+
 	btintel_pcie_free_rxq_bufs(data, &data->rxq);
 	btintel_pcie_free_txq_bufs(data, &data->txq);
 
@@ -2042,6 +2045,7 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
 				 &p_addr);
 	if (!v_addr) {
 		dma_pool_destroy(data->dma_pool);
+		data->dma_pool = NULL;
 		err = -ENOMEM;
 		goto exit_error;
 	}
@@ -2134,6 +2138,7 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
 exit_error_pool:
 	dma_pool_free(data->dma_pool, data->dma_v_addr, data->dma_p_addr);
 	dma_pool_destroy(data->dma_pool);
+	data->dma_pool = NULL;
 exit_error:
 	return err;
 }
@@ -2989,6 +2994,7 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 exit_error:
 	/* reset device before exit */
 	btintel_pcie_reset_bt(data);
+	btintel_pcie_free(data);
 
 	destroy_workqueue(data->dump_workqueue);
 
-- 
2.25.1

