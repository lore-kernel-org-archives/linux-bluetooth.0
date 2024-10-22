Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F311A257A
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729609758; cv=none; b=AUA6oUO2sE/jQdrSCmjKFIvyUFfpslB3EQV7nEpcnnN6w1GOxuLDfySNpOBstULVbAiNV7fZkYwXWcTyecC1T7wsObYC/TEvKGfofrwwqUqvK+pFz+q0B+UAmjU5lbxGITE8tsX00fsqz4hkrUntb7Q9YFi4ZyqlgGdsxHD56eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729609758; c=relaxed/simple;
	bh=AXAd/L0s8nZN7Sa62MRpd0xPpvaTJkRvFhxcfjpK/VA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=enQRlCoqCD4yF0r9It796kiT2Me/9uz8GUJV33vTFw24AMQ0IoNVW2GGUjFonOhFlv6qlNCNbyZY6jOPliZcNFLtGFhsCg9uz6biJLyYNMnhzWz593UyjdltCPn4OMEardE53DGLeBiDP2rcHL6TSPGj3N/Y5kFiJNbVZ6AYbaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLN/74tU; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLN/74tU"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e5fef69f2eso2991046b6e.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 08:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729609755; x=1730214555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yBkaBEidz4jMCnGEJuR1qFw5Egg/UWqdyjRsxPaKMj8=;
        b=bLN/74tUgo88yk6/o/u9HnhKP16oYAot0027E95MfrisCAHOqZL5MaBiFAl+Pm4S7q
         VAfunF604hichIr2U0DkWPNEm7hJdbSFtLe9BDUreTtnYVbkFMkU6HHRkP9k4hHUPJmT
         9Ka3jVz/lxyRDUI2oUMskZUREysYD2T36rr8Pq+dU/uyPRUL99TxPVsLjZh7p9PSqSEd
         hsJ+MIFlYh2Uzq8kygVED3JG8x9POG8BnYHfRHpqGp0VQvjwku6MtNZWbP72ihf7Ej6y
         hMaEFqWz7G9ADfd1Eei9SFMBBzkgwkKNr01lPVS+f19jvrgrBPviaH4VsEFiSG7HZCgI
         4Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729609755; x=1730214555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBkaBEidz4jMCnGEJuR1qFw5Egg/UWqdyjRsxPaKMj8=;
        b=rNEdUBgRownNbhBhDVoAP8eJmBzG3o5W3jjF0tNzOfmgw2WcxMkwR5BolDyC3tMhWV
         1daKbMKyjUvPRynGxnW5y20mqJjSwxfYnKxxktBPeyTYxYrvMVF5ayFJ7z8h+BvU8e3U
         FfnFnMrO6hYsJz4vuKYaN25UEgYmgoDboUAcVvUVx4nzXaRGlpeKW5Z0mQWU/t+TlDJQ
         QCcyLQGdBBS4uZB/EWnQsg5LgOAD98Co/8EnZXjXU7AfqyFdsxzabNP//3P+aU/NURyZ
         7My+8epbKydhRIE83yE37SUn+68eiL98RS1ryv+IaegfPBjg1EdvG8Q7vduXJbrdc+uq
         OftA==
X-Gm-Message-State: AOJu0YyWMJN7biF+sU8V52WI8/NIV7+JEIbgR6xBovmS9jB+LHkSY83m
	JhDmcykEuEWx/xnVOuAnvUISVljejjLGW9Y23LEIGGzD9zsxXoEvg1lSpg==
X-Google-Smtp-Source: AGHT+IHJn5ncy/46QJ69w6p6uQkiZlr12Xb9uzmKiz+dzKB2BbO3Oi8vy1vK9L5Z1ET5V5Ja5250IA==
X-Received: by 2002:a05:6808:2112:b0:3e3:e67f:5d3a with SMTP id 5614622812f47-3e61d03a7dbmr3145825b6e.45.1729609755495;
        Tue, 22 Oct 2024 08:09:15 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-852144f35e1sm885650241.14.2024.10.22.08.09.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 08:09:14 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_core: Disable works on hci_unregister_dev
Date: Tue, 22 Oct 2024 11:09:13 -0400
Message-ID: <20241022150913.1855164-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_core.c | 24 +++++++++++++++---------
 net/bluetooth/hci_sync.c | 12 +++++++++---
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7860750ecc45..f6cff34a8542 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1644,12 +1644,12 @@ void hci_adv_instances_clear(struct hci_dev *hdev)
 	struct adv_info *adv_instance, *n;
 
 	if (hdev->adv_instance_timeout) {
-		cancel_delayed_work(&hdev->adv_instance_expire);
+		disable_delayed_work(&hdev->adv_instance_expire);
 		hdev->adv_instance_timeout = 0;
 	}
 
 	list_for_each_entry_safe(adv_instance, n, &hdev->adv_instances, list) {
-		cancel_delayed_work_sync(&adv_instance->rpa_expired_cb);
+		disable_delayed_work_sync(&adv_instance->rpa_expired_cb);
 		list_del(&adv_instance->list);
 		kfree(adv_instance);
 	}
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
index cde96debef3f..9482bd562f6b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5138,9 +5138,15 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 
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

