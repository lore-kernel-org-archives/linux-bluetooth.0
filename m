Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A381B142D;
	Fri,  9 Jan 2026 02:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767924367; cv=none; b=HX/Tnuo83W5NHzwuT4ABcHNffAHb2FeGtQmajHKfeXwPu6rf3tUzeN9/6bM5Ra3vtHYL/WgcMyuORlZSKg5ZFhZjEywMvnDIrE7peRazTPeM9mXfEwQiyZKr+j6P5VcPgyeWl4IR77px0Dl75iNewI5KxdlSdzEATK+ox/cXmOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767924367; c=relaxed/simple;
	bh=xYSrlbZ/6VZZEyLjvT5dTLZq5VnrRJkDg8tArwwwgtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=im50903pmp6KSheg8bbyGRx5o5K2qpxGIxPF7PhDLc1bUwSxSShiny8IcyoXq8D5UF5vBLey6qdidwp80Nh/AcZQocPUKsE3vxPQOluem0a5UQjAHR9TyS2IBMGTHMJ2Xi8K4e0eRdM/h9IaSWQifL88ErIgu44MojK2k0KeEvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b3e5c03aecff11f0a38c85956e01ac42-20260109
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:4ced77a7-4ec5-4e20-a2f8-51a2dc0d8e5a,IP:0,UR
	L:0,TC:0,Content:21,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:21
X-CID-META: VersionHash:a9d874c,CLOUDID:9900116799a954d5421890004f04278c,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:4|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b3e5c03aecff11f0a38c85956e01ac42-20260109
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 323485101; Fri, 09 Jan 2026 10:05:42 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH v3 0/2] Bluetooth: btusb: Reject autosuspend if discovery is active
Date: Fri,  9 Jan 2026 10:05:36 +0800
Message-Id: <20260109020538.2803094-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CABBYNZJR9SB4EAMi5C0bf-ezMSa0rt02W8zVM0ypBwrqqxcPuQ@mail.gmail.com>
References: <CABBYNZJR9SB4EAMi5C0bf-ezMSa0rt02W8zVM0ypBwrqqxcPuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes an issue where USB autosuspend during discovery
can leave the HCI state machine in an inconsistent state.

v3:
  - Export hci_discovery_active() in patch 1
  - Use hci_discovery_active() in btusb in patch 2

v2:
  - Use hci_discovery_active() instead of testing individual bits
    (Luiz Augusto von Dentz)

Linmao Li (2):
  Bluetooth: hci_core: Export hci_discovery_active
  Bluetooth: btusb: Reject autosuspend if discovery is active

 drivers/bluetooth/btusb.c | 7 ++++---
 net/bluetooth/hci_core.c  | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.25.1

