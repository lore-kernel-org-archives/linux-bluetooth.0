Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7636D1459F6;
	Mon,  9 Jun 2025 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749460259; cv=none; b=WGJ1rJXYCjRRqUgtSZ59XGFbgwkQQGYEPDwQh7N/gOKtcMCFMtYc7Iyv4vJSc8149KFSIDbGdrT04T4ZyPGJRYJJA5L4uUU57RGzzd6BjdsTixEaqkvIgrEhPDHJaJ8DRjVPpOYj/nidXmJgiG6fCLMV87Exz+51k+ZGNQCtAxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749460259; c=relaxed/simple;
	bh=1Laqy9K3Sa//1xXgXcrvpPDa39oYnbbl/vRj7g8hL34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F3RadO6YOSnHz0q0YKaIj/CAjfie8Y9r3T7pU76uCBujxfJk7luZA9YiKs0O/eshWNM9Ynm6W83Qp9MH5Vdd1L0hMYKmWlf84gy/tGZGp31cuJsz15t+q2W4ihETF5lgH4bjeZ8TVM/iLuHYn0eYrXFUc2hPty+oG0rx+Y9tNzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qN02OxuJ; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qN02OxuJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=5O
	bFtmI+x5i+eSJ5A3vtQDWvwb2QRwUN61ZtJLr9x0k=; b=qN02OxuJQ/Cwg/lTgr
	NJFoR+di3C6bGbkKSo7cwZIa1iV2j7lGUAds7FcMEejHtK1mf1X0ZNbVGcQhTqKR
	Dt+37eGpvHGT/1TpzEYTrJGBhC6NQBCg3pfasUmFzn7GPDsxEHYmLJ86eQ2y4Zjj
	gNFikmmEKn7pIXEY2E+MnJ+PM=
Received: from gmail.com (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDnTygSpUZozhUGBQ--.9165S2;
	Mon, 09 Jun 2025 17:10:43 +0800 (CST)
From: Yongbo Zhang <giraffesnn123@163.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
	kiran.k@intel.com,
	luiz.von.dentz@intel.com,
	linux-kernel@vger.kernel.org,
	Yongbo Zhang <giraffesnn123@163.com>
Subject: [PATCH] Bluetooth: btintel_pcie: Use devm_free_irq() instead of free_irq()
Date: Mon,  9 Jun 2025 17:10:40 +0800
Message-ID: <20250609091040.7535-1-giraffesnn123@163.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDnTygSpUZozhUGBQ--.9165S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFy3tr1rKF15Cr1xAw4fZrb_yoW3uwc_ua
	45Zry3ZFWUJr1fKw4akFy3ury3ur1FqFs7X3ZaqFy5Xa4UWw4DC347ZrnrX3WfWrWUCry7
	AryDXw18Jw1UXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRVbk5UUUUU==
X-CM-SenderInfo: pjlutwhihv00qrstqiywtou0bp/1tbiTw9n32hGo280ggAAss

devm_free_irq() instead of free_irq() should be used to manually
free IRQs allocated with devm_request_irq().

Signed-off-by: Yongbo Zhang <giraffesnn123@163.com>
---
 drivers/bluetooth/btintel_pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 563165c5efae..b4b3b014547f 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2296,7 +2296,7 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 		struct msix_entry *msix_entry;

 		msix_entry = &data->msix_entries[i];
-		free_irq(msix_entry->vector, msix_entry);
+		devm_free_irq(&data->pdev->dev, msix_entry->vector, msix_entry);
 	}

 	pci_free_irq_vectors(pdev);
--
2.49.0

