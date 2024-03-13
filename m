Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id F25BD1FAA
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710315858; cv=none; b=R07kR51acNVcwNxu9sk5mvlDt7chOjdZfThxuLfWnFoTUVpdVWqk+X6siKl1DeodX+tvdKWMMTB2v4AXi9xM/pWJYmnx/qnGyxLxbeSX3xSSNaJ2XUJdMmV+3T0qGvfxnZkMf98UfHMyAkag8G/9FXKsvttVXy4ii17SW1aEyKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710315858; c=relaxed/simple;
	bh=VvfoF8rJk7T+G0p7C7pe7ujeL2gGxj8Wj89lKnIjHFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=adfyzf4RMD6UhlXegFpz2awF/ZBeUCr8EC8VP93AbXUiIwoM8R0V4c304FrX3wyuWBmSsIINl+WcsIJsHMk5CPak2O0yPZY6GWJeVnXB7l+adSJuOSSjpnXY/biM5huf9L1baVkXQBMcLcJVo0y3ojMzARvxnuX21NXUwU9Ygko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [103.163.180.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id A6F0A6032CDC7;
	Wed, 13 Mar 2024 15:44:05 +0800 (CST)
X-MD-Sfrom: youwan@nfschina.com
X-MD-SrcIP: 103.163.180.2
From: Youwan Wang <youwan@nfschina.com>
To: marcel@holtmann.org
Cc: johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	Youwan Wang <youwan@nfschina.com>
Subject: [v3] Bluetooth: btusb: Set error code in btusb_mtk_hci_wmt_sync()
Date: Wed, 13 Mar 2024 15:43:58 +0800
Message-Id: <20240313074358.427090-1-youwan@nfschina.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convenient to check if the function was executed successfully
and know the specific error location in the code.

Signed-off-by: Youwan Wang <youwan@nfschina.com>
---
 drivers/bluetooth/btusb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d793dcd06687..a7244a8a5b7c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2824,8 +2824,10 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
 		goto err_free_wc;
 	}
 
-	if (data->evt_skb == NULL)
+	if (data->evt_skb == NULL) {
+		err = -ENOBUFS;
 		goto err_free_wc;
+	}
 
 	/* Parse and handle the return WMT event */
 	wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
-- 
2.25.1

