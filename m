Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08DD2C21D5;
	Sun, 28 Sep 2025 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759057680; cv=none; b=UUhcASxwoPdgtU0aUc07sDzMG9R3yhfamd3btXtuUdR25/THVeaLL4oejdVIrUSkOGljKPHSP/KhoAhYZf6X7+BodfWFMj+IBfac3f1cMCGOewUDf3bdZQf40O3INezdcPfW0msgAiT3HcMdFE1m8gNZIBiGoKQRMaiONbB9Ek4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759057680; c=relaxed/simple;
	bh=0aO9erk5QqK6WpcXoMryELoQBa/6Vfo2mzJiRTMSxBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ixR1TOhG0m75gIXer1A5Ek+bkqxFFB+NnhMqxQha/ZEeuK03wi5YiI4cQx8MJY+VF3LAOCmXf6vnoKrbnWhmsdmk7fTiiBNyUdhWkge+ik9P3lceJG11g1bpssJ7b8UqPxSl+W7BrS+VmiMq593Ec21NS3PIG33ri8t04MdpJ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=j93zRoDR; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="j93zRoDR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=xZ
	5qO6uMsGJcIcgO/VDq94SOb+oBcEOxKQbcI8nndCs=; b=j93zRoDR/84ULPeDdv
	vR+4Ll2r4WGt3K+DlF7MSvaQM18eQwShkzu3yN9GmtEBit4S1ww5pkrat2Cvm20W
	UDL/P/DD+I5cIQuf0MuJ0wRWrgA6VYMGH6kqnoaGXcgGMcaA6FBXIVhD+laY8u19
	PB5TBiCJwUZGwa8qGwyyIheSY=
Received: from localhost (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAnYuP_Ftlom3d5AQ--.64678S2;
	Sun, 28 Sep 2025 19:07:44 +0800 (CST)
From: Cen Zhang <zzzccc427@163.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	johan.hedberg@gmail.com,
	marcel@holtmann.org
Cc: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Cen Zhang <zzzccc427@gmail.com>
Subject: [PATCH] Bluetooth: hci_sync: fix race in hci_cmd_sync_dequeue_once
Date: Sun, 28 Sep 2025 11:07:40 +0000
Message-ID: <20250928110740.137220-1-zzzccc427@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAnYuP_Ftlom3d5AQ--.64678S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF45WryrKryDCFWUGF4DJwb_yoW8Gr1Upa
	43uFy5Zr4rXr43Xryvya1rZFW8uF4xWr9rCan8WryfJw4xtr4xtw12yrySqF909rWDuF15
	ZF4qqFy3C3W5Gr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jlCJPUUUUU=
X-CM-SenderInfo: 5222uujfuslqqrwthudrp/1tbiXRvWhGjZEv1FeAAAs3

From: Cen Zhang <zzzccc427@gmail.com>

hci_cmd_sync_dequeue_once() does lookup and then cancel
the entry under two separate lock sections. Meanwhile,
hci_cmd_sync_work() can also delete the same entry,
leading to double list_del() and "UAF".

Fix this by holding cmd_sync_work_lock across both
lookup and cancel, so that the entry cannot be removed
concurrently.

Reported-by: Cen Zhang <zzzccc427@gmail.com>
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 net/bluetooth/hci_sync.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b6f888d83..f059b19fe 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -862,12 +862,13 @@ bool hci_cmd_sync_dequeue_once(struct hci_dev *hdev,
 			       void *data, hci_cmd_sync_work_destroy_t destroy)
 {
 	struct hci_cmd_sync_work_entry *entry;
-
-	entry = hci_cmd_sync_lookup_entry(hdev, func, data, destroy);
+	mutex_lock(&hdev->cmd_sync_work_lock);
+	entry = _hci_cmd_sync_lookup_entry(hdev, func, data, destroy);
 	if (!entry)
 		return false;
 
-	hci_cmd_sync_cancel_entry(hdev, entry);
+	_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
+	mutex_unlock(&hdev->cmd_sync_work_lock);
 
 	return true;
 }
-- 
2.43.0

