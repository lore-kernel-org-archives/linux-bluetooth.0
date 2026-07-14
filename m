Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F693FFAC6;
	Tue, 14 Jul 2026 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018606; cv=none; b=aGUHKdy08pQS+Jyy6HoaefCYm6emow1lNBy8tqmoatWGKumheCDI6a+31J1nsooj9Glepbt20vT7Wk82BuFpNgNOYgjkD93gwU+eECqmVnoiTeG0vI2b8knoYYClpArcNaYydBW7u0TxOBaQzGG9TW1z09hnbSTJ7gpFTWCVmcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018606; c=relaxed/simple;
	bh=myxCmWil1LxRLAqXUKw1VUKHRSF+fYcGMgeQGTkIHXs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=GGylSMgB7bPmOXcsqikCHjIwxRshOsLef6KCfHb+OqTNPCYdtJnzFUksxcWm8kbEYSNQ4atbdtgnUwKKqilNMC9McdgTcgUDYoHNx6IZByW44vC++QL7u48FX+SNaxjKK3jG32r7KmgZ42Jl+2IHr7/PQqu+k+hvhiD3U7//wlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=yRL6Y1Zv; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="yRL6Y1Zv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784018596;
	bh=mLUpHb90XJyZ7siSeut6+6pq0zRtMZTMB5UnCqaKyt0=;
	h=From:To:Cc:Subject:Date;
	b=yRL6Y1ZvU7cNQVh8ezbPNQn4WSErU3GkuOhwOcXu7+H9eE/hQmdOiuCOhGWdmrqlj
	 vhnPxVbaHckMfdpOKZyEVJ7HjNS9w73bWCR9tCaU2iPnLGgOObsQnKgA9Qap5rsrsU
	 fZHjRo55ukZXk/D3pecJQDSa7GlqE7nPPMEPAJrQ=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id ACE2B6CB; Tue, 14 Jul 2026 16:43:14 +0800
X-QQ-mid: xmsmtpt1784018594tc8r6o986
Message-ID: <tencent_9EDB39EF4A8A9D6EF645A7DC2F32B25CA209@qq.com>
X-QQ-XMAILINFO: MKjJ7hBG/9lw06qMXC2HMvS/wFRGiwgu0IqJ1RLZzPIOkSOJXcvFZCNEFIWXIN
	 9LSYbCq/5mKocCbtUsMlYmpYL6iqUYQjb04Ho5yqBOpT4w0L2w4UYHo5cOsH6WLD0ZUNY6Mzv0sY
	 z012OSqWm2/AIeaET3A/Hqcfv2/amYQBLzZQmSVKFcZuC9FUh9G+pT5OeqePNe2EWFT7CYdAiMe7
	 bvrTN7dtCBVVUHM/AfwUWM1UEepq0gtUSpcaZgpWoAJ3rdWfXGlyVKobTgVdJtowRMTG7lpuFs/u
	 V4PzCoMyA1OxyEQzYQVhF9sL85s0tmhPqVwN5CzCzfzgOyN4bnSSeKTGA/uYgcjVYtiEjzAvs+DL
	 cN7IoTcUnUonj0BQwm0EbDSGF5S7jzcl/fogAZqiBuG1UbaigEjxJzRMAYBdiK0pXIqN5JJLwvsy
	 o92CTY14w80+aHOVY27w5IEa0B7q8UNLGttzvVdILWF/dQqt7OepWYClHqe3s2vMazVlKhKcpwRv
	 uHVOXjcfEEc/1Rih/6DnmaX9PoEEEbuum5Kcb3dbM74ns8UWvA5u+Z1cvEs/5TmU5tjfli8kt1DN
	 opOLYqigraNTghpR+Q9UQ86h1EwsLOFLPy8H6zvkgN83L09bek5nwtDMqmLjYqOmRW01NrFRqC+I
	 T5ZjuSTfqySQb35QC/W3P/L8s8S+8ezBEp0uj4GWp4xrij3Trb95bmotw4RLqSDeSlTKj/4Qa1QP
	 JlkpRVFz5qwcXzeKZj3nvWUIaX4pTKaNn77XQrtwy2e6t+stYOU2vScuINbEZj3X9gNQFIxF7fR+
	 TJokcYLyYkZvjbybe1rWwq/sbREDEuNfsoRx8oYoCpo/H/xqs0jlMjbwB0E9gNPNBX4aO0SO6rkM
	 9ZhUJFA+qhHXA5ioas8+p8XiFKTAS3fixwQz0bbOG33SivBZ3pvaP/DJ5pp5z+z93ZMTUsRmDw8r
	 S9LfeASlKMZ3JGjn7XlSSUDx7RiIxOIE4uxw/gbBknp/TWCwZ/UWsTco5RKON6gOIEL19gYKTUDV
	 0SV6l393VzsOwKpSeCzxnLU6/Oz03KtpAKkKhJ9UIh/JUE46+92e2wgaTL9MA=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Zhao Dongdong <winter91@foxmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>
Subject: [PATCH v2] Bluetooth: btintel_pcie: Fix DMA memory leak on probe failure
Date: Tue, 14 Jul 2026 16:42:28 +0800
X-OQ-MSGID: <20260714084228.400718-1-winter91@foxmail.com>
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
v2: Fix UAF in probe error path by resetting hardware before freeing DMA.
v1: https://lore.kernel.org/linux-bluetooth/tencent_44ED865C14DA3D3823CA85AE1DF2CEBC1805@qq.com/
---
 drivers/bluetooth/btintel_pcie.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 9e39327dc1fe..a005b2e390a2 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1920,6 +1920,9 @@ static int btintel_pcie_setup_rxq_bufs(struct btintel_pcie_data *data,
 
 static void btintel_pcie_free(struct btintel_pcie_data *data)
 {
+	if (!data->dma_pool)
+		return;
+
 	btintel_pcie_free_rxq_bufs(data, &data->rxq);
 	btintel_pcie_free_txq_bufs(data, &data->txq);
 
@@ -1980,6 +1983,7 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
 				 &p_addr);
 	if (!v_addr) {
 		dma_pool_destroy(data->dma_pool);
+		data->dma_pool = NULL;
 		err = -ENOMEM;
 		goto exit_error;
 	}
@@ -2072,6 +2076,7 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
 exit_error_pool:
 	dma_pool_free(data->dma_pool, data->dma_v_addr, data->dma_p_addr);
 	dma_pool_destroy(data->dma_pool);
+	data->dma_pool = NULL;
 exit_error:
 	return err;
 }
@@ -2918,6 +2923,7 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 exit_error:
 	/* reset device before exit */
 	btintel_pcie_reset_bt(data);
+	btintel_pcie_free(data);
 
 	destroy_workqueue(data->coredump_workqueue);
 
-- 
2.25.1

