Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AA91DE8AD;
	Fri,  9 Jan 2026 02:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767924367; cv=none; b=qGW0nUT9Y+HwqrQsVa5r1NR5cz2/ABSoX+Yx2oZhtKqOjJqq5Dgje6sjgddPVS9hJBJGn5eG+9aWkWO1NIT5zT36VxdjITYBjKz8jrcL7sQGyMFxNZ9FUB0WxHpGVDZju7F8vS9HuKzXpFN5IqW451/utsTwtibYTmNAl+JRk0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767924367; c=relaxed/simple;
	bh=9G8oM73fknRerD9fp4+g6TZrtv0KFWl17iqA4POZBxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JrI5aPD75aRpI2jA2suzzPH6LZKz7LOYmsMd324/3h7fzW+YdPiD/YLSMeIUKLVrR74qaCt9TCUYhi0wgUqId8Z2fqN34ssFr6VDFruXLR2FmEOawU16Eo84MX996RnGuehihoHTrs/SNo0HWbmYbqFfUcO4DaUyoS0BNQPq3yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b7b05e82ecff11f0a38c85956e01ac42-20260109
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:d7ea81fd-db6d-41d4-92d9-d7f3f82eddfb,IP:0,UR
	L:0,TC:0,Content:23,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:23
X-CID-META: VersionHash:a9d874c,CLOUDID:cffaad0ea6d5df24553c103348dba1b3,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:3|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b7b05e82ecff11f0a38c85956e01ac42-20260109
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1592845196; Fri, 09 Jan 2026 10:05:49 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH v3 2/2] Bluetooth: btusb: Reject autosuspend if discovery is active
Date: Fri,  9 Jan 2026 10:05:38 +0800
Message-Id: <20260109020538.2803094-3-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260109020538.2803094-1-lilinmao@kylinos.cn>
References: <CABBYNZJR9SB4EAMi5C0bf-ezMSa0rt02W8zVM0ypBwrqqxcPuQ@mail.gmail.com>
 <20260109020538.2803094-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If USB autosuspend occurs while discovery is active, the ongoing
HCI operation may not complete successfully. On some devices, this
can leave discovery.state stuck in DISCOVERY_FINDING.

Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/bluetooth/btusb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ded09e94d296..565e276be3b2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4469,10 +4469,11 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 
 	BT_DBG("intf %p", intf);
 
-	/* Don't auto-suspend if there are connections; external suspend calls
-	 * shall never fail.
+	/* Don't auto-suspend if there are connections or discovery in
+	 * progress; external suspend calls shall never fail.
 	 */
-	if (PMSG_IS_AUTO(message) && hci_conn_count(data->hdev))
+	if (PMSG_IS_AUTO(message) &&
+	    (hci_conn_count(data->hdev) || hci_discovery_active(data->hdev)))
 		return -EBUSY;
 
 	if (data->suspend_count++)
-- 
2.25.1

