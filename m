Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E631EE006
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530697; cv=none; b=Q/im+ijav4cKpDw7/OnHXtutnJ4t61vUrqA9O4wa/qLb/a6wD0Rcu2kg5y/lvs6DD1BAugg/h/EMzktDf1JfsxcHMJwsvlwfo4cdeP/NysC4Mz0rcwPdChDqNMHXzsgkAL2vLdaPT8AryFNXilTi7g7FVQXvr/oWdKbVrghiU9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530697; c=relaxed/simple;
	bh=nZ7kBkiLDeE9YXoDVxWXHo+ZYxJGHbGmWAID5bwm/Kc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Bq58nsEpjkcN/BDu+8yrhHG1vFUh3AUspzUIkMum4AvMUPX2ZkGlnHg+mRhuYEmxoerfY/mz6fiSHpFl1YrieLX7Eg97wPkTE2vbio9O4PxxCHGG7urJlBIleWVqNFzlVITjwJyxEay3d0+HCy1kb6ba5OjTO/DHPSYz89tNRn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iv9r2JrF; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iv9r2JrF"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-50d34db4edeso2104047e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 10:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729530693; x=1730135493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sn0V1drrCz5edQjd2l+q/PbcpfRbcz02j/sPXtOhLYA=;
        b=Iv9r2JrFVa6VQ9IZjsu9BhNpY5IfzG3rdLsZZ+aT08ezuMdJBhnjDy2587Jhf5GTzP
         BOUi2VM1ZmQ5sb/Jse+kMZukivEuqTe7+H71TU4KlVfxqZQA7ESewGdjIvljTqre5+aA
         yZc5+KC8KyQA2i20ETIM9KFXI6p+yJMyYswmUbGnzQTJXpw6D8/X4Qnp2/XFP9B3BPAZ
         roG8LYFB7ZvTWWc4PcV82r/7rs50XUMXfLUl0NYWKda+cJnz+fcBqDBg1N7VH4VNoLob
         4CHxyVLCe58uzkPksgxZNaycq4C/FbkraPaHO4N0D0klXXcwquQvu/yEjxv6jP6guAR4
         NqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729530693; x=1730135493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sn0V1drrCz5edQjd2l+q/PbcpfRbcz02j/sPXtOhLYA=;
        b=JEJq/8WSP7c/D5eYMGfaOUjnX5CanVQocxUwI+1/8I65MZgphGYD7Z1Sq/eog/AHGe
         wiNKpAxkF4XOq7UqGcguHt9J2mcinHgnCyVUCq338fH/zPLDpCXuWXSoMJYkOPGpMIJQ
         HXqxuK42/DvUx19oCXaR9O/x3SBawjXU7AgQ9ZScfIAFBttKS/Q7pnvfr8eUi3Id49PZ
         qWq06m0KL+w/kiWmjW1DV619S1P9uk+v3oFOZmIVlnARcDwLQBLZBO60lMF+Oqfcspze
         dqEyp9+8oaSP3IkOFeH7tpJQvNA4DKG6qGbuauSnq1+b19a04dbHXij7Usg6uFsUvY/l
         Darw==
X-Gm-Message-State: AOJu0Yx2NNxyqpCNHGVbT3jgSsn67g65uZh1zF2j2DyrowIXTC4xDdqU
	sp51aGnApvhxo9OOugpgXLRQOPhsru/lSCtg0A6FthG+lo5oqF7PO+2N9A==
X-Google-Smtp-Source: AGHT+IEwCIX43aKGxKbTjFQslUYVsYF6jplTlKdWd1yvtnQZnXrmloeiA5DPm3/IAbpkvRwhL/bv1g==
X-Received: by 2002:a05:6122:926:b0:50a:cbdb:b929 with SMTP id 71dfb90a1353d-50fb2f38efamr454147e0c.2.1729530693564;
        Mon, 21 Oct 2024 10:11:33 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50e19f8cf7csm500539e0c.44.2024.10.21.10.11.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 10:11:32 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_core: Disable works on hci_unregister_dev
Date: Mon, 21 Oct 2024 13:11:30 -0400
Message-ID: <20241021171130.1649110-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make use of disable_work_* on hci_unregister_dev since the hci_dev is
about to be freed new submissions are not disarable.

Fixes: 0d151a103775 ("Bluetooth: hci_core: cancel all works upon hci_unregister_dev()")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 20 +++++++++++++-------
 net/bluetooth/hci_sync.c | 12 +++++++++---
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7860750ecc45..395f9f8d5ac7 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2685,11 +2685,11 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	list_del(&hdev->list);
 	write_unlock(&hci_dev_list_lock);
 
-	cancel_work_sync(&hdev->rx_work);
-	cancel_work_sync(&hdev->cmd_work);
-	cancel_work_sync(&hdev->tx_work);
-	cancel_work_sync(&hdev->power_on);
-	cancel_work_sync(&hdev->error_reset);
+	disable_work_sync(&hdev->rx_work);
+	disable_work_sync(&hdev->cmd_work);
+	disable_work_sync(&hdev->tx_work);
+	disable_work_sync(&hdev->power_on);
+	disable_work_sync(&hdev->error_reset);
 
 	hci_cmd_sync_clear(hdev);
 
@@ -2796,8 +2796,14 @@ static void hci_cancel_cmd_sync(struct hci_dev *hdev, int err)
 {
 	bt_dev_dbg(hdev, "err 0x%2.2x", err);
 
-	cancel_delayed_work_sync(&hdev->cmd_timer);
-	cancel_delayed_work_sync(&hdev->ncmd_timer);
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
+		disable_delayed_work_sync(&hdev->cmd_timer);
+		disable_delayed_work_sync(&hdev->ncmd_timer);
+	} else  {
+		cancel_delayed_work_sync(&hdev->cmd_timer);
+		cancel_delayed_work_sync(&hdev->ncmd_timer);
+	}
+
 	atomic_set(&hdev->cmd_cnt, 1);
 
 	hci_cmd_sync_cancel_sync(hdev, err);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 40ccdef168d7..ae7a5817883a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5131,9 +5131,15 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 
 	bt_dev_dbg(hdev, "");
 
-	cancel_delayed_work(&hdev->power_off);
-	cancel_delayed_work(&hdev->ncmd_timer);
-	cancel_delayed_work(&hdev->le_scan_disable);
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
+		disable_delayed_work(&hdev->power_off);
+		disable_delayed_work(&hdev->ncmd_timer);
+		disable_delayed_work(&hdev->le_scan_disable);
+	} else {
+		cancel_delayed_work(&hdev->power_off);
+		cancel_delayed_work(&hdev->ncmd_timer);
+		cancel_delayed_work(&hdev->le_scan_disable);
+	}
 
 	hci_cmd_sync_cancel_sync(hdev, ENODEV);
 
-- 
2.47.0

