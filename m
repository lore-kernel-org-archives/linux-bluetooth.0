Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id AEC3E10953
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 01:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710295187; cv=none; b=Y7h5rejkUDOuC85nIKFIqxiodLq8HOEghNq/OJjkDlbuE2eoTt4h0jOuvegDG2jWg5lVcYWgiVVMElQTiWsT7ZtQx5deeZwBQS7Vit/74ndaSV20fFVUM36ZXhbyd+Zw0NlR/sN5AHJjclB7/0oD/KvY9kiwn5rmvqivACGJAGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710295187; c=relaxed/simple;
	bh=20ls82YLtZTjVQoQFdVO2vHSOfswcwvM4SUaEClj+nM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YkDpEGn92dGNWDqMVdoAOKCWrrA9RYEytwso2O45EFZ6fqYMGjZE0BgopIY3KN0E7I+EYp/mrc1R+WC6cvKZqlPpze2cgA0XZJ9ab/2wTFslYG+bh09I0piyQzSV1GovAy7j5ZxiD37mWW7NT456mzR8F/8hzgkUggSen0ycrok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [103.163.180.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 85927601A2DFF;
	Wed, 13 Mar 2024 09:59:32 +0800 (CST)
X-MD-Sfrom: youwan@nfschina.com
X-MD-SrcIP: 103.163.180.2
From: Youwan Wang <youwan@nfschina.com>
To: marcel@holtmann.org
Cc: johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	Youwan Wang <youwan@nfschina.com>
Subject: [PATCHI] Bluetooth: btusb: Add return error code
Date: Wed, 13 Mar 2024 09:59:14 +0800
Message-Id: <20240313015914.422751-1-youwan@nfschina.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add return error code

Signed-off-by: Youwan Wang <youwan@nfschina.com>
---
 drivers/bluetooth/btusb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b8e9de887b5d..ec6bdc9687b1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2826,8 +2826,10 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
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

