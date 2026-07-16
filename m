Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E043D648F;
	Thu, 16 Jul 2026 08:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191693; cv=none; b=HsUSLxWYw8fHap2q6IcyQHgqlKfSftduL3efbol5RGhX7izWmxXPgHhq3+anFtQKTltZITCCUimw4n9vSGfwbCUuAarJDIXj87ZQC6gIlDQMwR5cUcEpbAxsa6uvIYCveMU/WleFFI8g8XWMyvrRXTtDCoJ0G67ksk9xPeWdcBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191693; c=relaxed/simple;
	bh=Mmb11qGuNuQ9Ukkjol4ysz52hCWhPKx8Ft4uCnzggGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRhT7MyO3DUSvSfhrNTN5f0pAmzYzDRu7esc+yk/JUD/cegI+GdBb/lK5o+7ttYkriOILOYxudzy6+8xRfkFuf8y5km5x/B87O1o2gYQlddDxdIjlIP9MRItvInHY4NyaGqCWOm3hU9czpEV84s8x5SRzrZj2/I1flDmq37/96U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0c3e3b3680f311f1aa26b74ffac11d73-20260716
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c9c50dc8-5415-477a-83c7-be4a1cfcaa67,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:40
X-CID-INFO: VERSION:1.3.12,REQID:c9c50dc8-5415-477a-83c7-be4a1cfcaa67,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:40
X-CID-META: VersionHash:e7bac3a,CLOUDID:434d1b4dc89c9ee2f4d28a6a73807593,BulkI
	D:2607161648028MSLF5DN,BulkQuantity:0,Recheck:0,SF:10|66|78|81|82|102|127|
	865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,
	QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
	,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0c3e3b3680f311f1aa26b74ffac11d73-20260716
X-User: liqiang01@kylinos.cn
Received: from cvdaxia.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1545707886; Thu, 16 Jul 2026 16:47:59 +0800
From: Li Qiang <liqiang01@kylinos.cn>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Li Qiang <liqiang01@kylinos.cn>
Subject: [PATCH 4/5] Bluetooth: hci_ldisc: reject invalid tty write lengths
Date: Thu, 16 Jul 2026 16:47:31 +0800
Message-ID: <c273c52a3d68cc40948ac6beb1fe384299092a20.1784191283.git.liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784191283.git.liqiang01@kylinos.cn>
References: <cover.1784191283.git.liqiang01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HCI UART write worker assumes that a tty write callback returns a
value in the range from zero through the skb length. A negative value or
a value larger than the skb length is passed to accounting and skb_pull,
which can corrupt skb state.

Treat either return value as a transmit error and discard the skb.

Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
---
 drivers/bluetooth/hci_ldisc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 47f4902b40b4..668c4f84d7f2 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -163,6 +163,12 @@ static void hci_uart_write_work(struct work_struct *work)
 
 		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 		len = tty->ops->write(tty, skb->data, skb->len);
+		if (len < 0 || len > skb->len) {
+			hdev->stat.err_tx++;
+			kfree_skb(skb);
+			continue;
+		}
+
 		hdev->stat.byte_tx += len;
 
 		skb_pull(skb, len);
-- 
2.43.0

