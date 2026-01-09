Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B16E219303;
	Fri,  9 Jan 2026 02:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767924367; cv=none; b=HcxHIChd7rBnN8rEEFJrhwGvT3Qh3FF8FI9DaExOAjIofn7y0eobw5CpN6WFAx340yCLCu1gqKGdqHxgmztxpTFxiRUjR7JQ2ypLFEjBso4J0iWLWSb8+QsWws4y9l/JmMfxKUDizjEpp1yJZiMjQMnC2Y/XqktLK917QOgWp94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767924367; c=relaxed/simple;
	bh=IRNNjx5LDAwWFQFUjXQ+jlp1ykYt5v2DW0cCleUgUP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MSDQiwJ/oWIOQYOsKuX6QqpTY+rsJwtg8Atc3nllw095tr8SDGf0UVj0d2pOPb2Iu9nKPZld8oKYPUCC4wPJFPDZ8LM20h7LRtxKVWYR09CJcARJVI/+PAtmkqkrHRgdOm8fiDM8lAdNDwWS29al/rsO62rR5nxSoJqdBcU8u3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b69d43d4ecff11f0a38c85956e01ac42-20260109
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:9744efb6-dd5a-43c2-8b2d-a3b9d6efc835,IP:0,UR
	L:0,TC:0,Content:21,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:21
X-CID-META: VersionHash:a9d874c,CLOUDID:b04c158dcb31ce16d5367db61ef22020,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:4|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b69d43d4ecff11f0a38c85956e01ac42-20260109
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 656985874; Fri, 09 Jan 2026 10:05:47 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH v3 1/2] Bluetooth: hci_core: Export hci_discovery_active
Date: Fri,  9 Jan 2026 10:05:37 +0800
Message-Id: <20260109020538.2803094-2-lilinmao@kylinos.cn>
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

Export hci_discovery_active() so it can be used by bluetooth
drivers built as modules.

Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 net/bluetooth/hci_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8ccec73dce45..b069607b145b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -117,6 +117,7 @@ bool hci_discovery_active(struct hci_dev *hdev)
 		return false;
 	}
 }
+EXPORT_SYMBOL(hci_discovery_active);
 
 void hci_discovery_set_state(struct hci_dev *hdev, int state)
 {
-- 
2.25.1

