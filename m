Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F9821CA16;
	Sat, 28 Jun 2025 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751105643; cv=none; b=Sl50r95N+9wiulNbVUKhQ1UmCjVHFX7P/31htmxnYHHMqaFYkU7J69Y0SVIYT/WFj7TV+wTBj1N3adwnyCVj0XXjDkR6iTrJgfPx3i+YTZDcbAQReahhqvW+YYlPdsvvtYjvzP5srz27QoWMK+G3/QIXeRV7Hy5pfZIAceHN45w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751105643; c=relaxed/simple;
	bh=evHe/Q4Z7c3/bPp/IGnTWoWNO5VUuiNQ3xAGZ+TcF3k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fFuxYb2EKMsZMz0PNBqgQYvxO6xZAi9G2rkgoDnx0ikUP/akF8lFmoUjhTK9PWAcVWQnjnuaFRiudlJdAeW0xcrCzcBfJEKh/ddOV7sMOoC+V2FVCVXIFfCzbr/YnEEaNy3Bf5ZeWx+R7O5kreLC8q/KfVh4r7dNTMwKzgPDI9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bTp711fTfz10XJN;
	Sat, 28 Jun 2025 18:09:17 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id E60D618007F;
	Sat, 28 Jun 2025 18:13:55 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 28 Jun
 2025 18:13:55 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <marcel@holtmann.org>, <luiz.dentz@gmail.com>,
	<kai.heng.feng@canonical.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] Bluetooth: btrtl: Fix passing zero to 'ERR_PTR'
Date: Sat, 28 Jun 2025 18:31:05 +0800
Message-ID: <20250628103105.211049-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500002.china.huawei.com (7.185.36.57)

If bt_skb_alloc() fails, ret should be -ENOMEM then pass to ERR_PTR().

Fixes: 1996d9cad6ad ("Bluetooth: btrtl: Ask 8821C to drop old firmware")
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/bluetooth/btrtl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 7838c89e529e..6d5b37990be6 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1137,8 +1137,10 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 
 	if (btrtl_dev->drop_fw) {
 		skb = bt_skb_alloc(sizeof(*cmd), GFP_KERNEL);
-		if (!skb)
+		if (!skb) {
+			ret = -ENOMEM;
 			goto err_free;
+		}
 
 		cmd = skb_put(skb, HCI_COMMAND_HDR_SIZE);
 		cmd->opcode = cpu_to_le16(0xfc66);
-- 
2.34.1

