Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2701DF736;
	Thu,  8 Jan 2026 02:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767838024; cv=none; b=e06LxNoR/yerDzEk0i1ybpAknd5+Yuev+T5F5ddjYTKPcuazVDg/vq/d68HSHOmGJCr0wRCHWXOuxdITMxsZuPEI0ub5cZHxwNR76dTls9tqPzxDLwcNjPtLKp+cX6GM5G5tqJtyF8TzEa0QQJLAHfdOCArF5tY8yyh5xiK0AN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767838024; c=relaxed/simple;
	bh=9G8oM73fknRerD9fp4+g6TZrtv0KFWl17iqA4POZBxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MMsn2lm56eddR7fxqqy6BQMDmhzak4RwPR8FESpQYPCr/pvFoFZYIP/kqNvYOy2mYLQtvqV2LmCsUGedlQE+c6gy+nbTPey+0OnAiG8MK64PKBC8dz7Z4exHiD0qCLVe15uEPPJudQaNXXTuoeS1IanF2p+LtJV29znprnwVbLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: aa9dfc00ec3611f0a38c85956e01ac42-20260108
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:3e383b23-38b7-4f1d-881c-88bec2721a0a,IP:0,UR
	L:0,TC:0,Content:23,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-2
X-CID-META: VersionHash:a9d874c,CLOUDID:3b086cd76aa093ed63dded2386e430d2,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:3|15|50
	,EDM:2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: aa9dfc00ec3611f0a38c85956e01ac42-20260108
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 387355865; Thu, 08 Jan 2026 10:06:38 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH v2] Bluetooth: btusb: Reject autosuspend if discovery is active
Date: Thu,  8 Jan 2026 10:06:33 +0800
Message-Id: <20260108020633.1729637-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CABBYNZ+Zq2HYsfGbOi7V=pnV1GczSv6--rMEbi+=yCXE4p+-6g@mail.gmail.com>
References: <CABBYNZ+Zq2HYsfGbOi7V=pnV1GczSv6--rMEbi+=yCXE4p+-6g@mail.gmail.com>
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

