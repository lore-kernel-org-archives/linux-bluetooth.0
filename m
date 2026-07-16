Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448643B961F;
	Thu, 16 Jul 2026 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191691; cv=none; b=S9Wo0Y9/ahyqOqJJ/T+Dign304SjczFjDgC/KZS6A4tVlx6NH1D66mbCDzM7PKZoq4IvtRN8lmz3iEJY+XGLjlv26Qrv2dA/bjSXmSF7r0dYCAtWAW4wmZiSA/IOdiuY77ANmctcB+S1pM0bTa45W8sdltbyinR89FeeJyw5SRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191691; c=relaxed/simple;
	bh=LmCayJ9+Wjm99zGyb7HqHOrgDuZXSyR/2h9nQ4uAWGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GI1YwPD5aKy/TLgOWYNHj+HDs42m8XajqAEHaACVvZfieP8iZQDTrWX8+sAJopn2ZDhKAgkKiWhxFj6PdNlin008SG6+CIHPaOf3hiBrtwmO3a/IZh0iN1hHL4IFdiC9XRkyVQcJlWI633uPAfhRaKd7zhNK8RlEXCLYRqL4ctY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0bd686c680f311f1aa26b74ffac11d73-20260716
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
X-CID-O-INFO: VERSION:1.3.12,REQID:58c440c3-e3e1-470b-a1f6-1382b5e3ca5d,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:58c440c3-e3e1-470b-a1f6-1382b5e3ca5d,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:f02665f253f8d726a52f493f920aa00c,BulkI
	D:260716164759C48U6KQP,BulkQuantity:0,Recheck:0,SF:10|66|78|81|82|102|127|
	865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0bd686c680f311f1aa26b74ffac11d73-20260716
X-User: liqiang01@kylinos.cn
Received: from cvdaxia.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1233171991; Thu, 16 Jul 2026 16:47:58 +0800
From: Li Qiang <liqiang01@kylinos.cn>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Li Qiang <liqiang01@kylinos.cn>
Subject: [PATCH 2/5] Bluetooth: btmrvl: validate event packet lengths
Date: Thu, 16 Jul 2026 16:47:29 +0800
Message-ID: <628bdb80b4ae352606d6cfb175180c980a8c362a.1784191283.git.liqiang01@kylinos.cn>
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

The Marvell event handlers access the HCI event header, command
complete payload, and driver-specific event header before validating
that the received skb contains them. A truncated event can consequently
cause an out-of-bounds read.

Validate each header and the command-complete payload length before
dereferencing the corresponding fields.

Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
---
 drivers/bluetooth/btmrvl_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index d6f0ad0b4b6e..aaf1614ccfd7 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -43,10 +43,17 @@ bool btmrvl_check_evtpkt(struct btmrvl_private *priv, struct sk_buff *skb)
 {
 	struct hci_event_hdr *hdr = (void *) skb->data;
 
+	if (skb->len < sizeof(*hdr))
+		return true;
+
 	if (hdr->evt == HCI_EV_CMD_COMPLETE) {
 		struct hci_ev_cmd_complete *ec;
 		u16 opcode;
 
+		if (hdr->plen < sizeof(*ec) ||
+		    skb->len < HCI_EVENT_HDR_SIZE + sizeof(*ec))
+			return true;
+
 		ec = (void *) (skb->data + HCI_EVENT_HDR_SIZE);
 		opcode = __le16_to_cpu(ec->opcode);
 
@@ -74,6 +81,9 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 	struct btmrvl_event *event;
 	int ret = 0;
 
+	if (skb->len < sizeof(*event))
+		return -EINVAL;
+
 	event = (struct btmrvl_event *) skb->data;
 	if (event->ec != 0xff) {
 		BT_DBG("Not Marvell Event=%x", event->ec);
-- 
2.43.0

