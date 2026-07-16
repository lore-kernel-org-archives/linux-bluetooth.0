Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9103F39CE;
	Thu, 16 Jul 2026 08:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191694; cv=none; b=eQBeuoj5mM0b8+aZD9Lvh3lJb/2TJB3NWIcLKXclVGH2FNmztGp+1Tj4IlFshjA5fdp8k59bVW6KkPdO0EIEECjYeJcvLuSoSf6mFdJFix7xqjLvb+aOSKpm5A9c+oyOYjvGp0jaM5c1NPwRCUG9/3JrOwMrsUOAf6DI5x96rxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191694; c=relaxed/simple;
	bh=MVdmPcaWyVy3JP2kCitS0f6oP3GTIXBvQwQL/DaAA8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VeqTSKOWMfZarsIILBxUhz75q5cpYh7WB6wG0Il7i4DV19/pwDOJ219T0I8LmCqTxxe8knNR+Fpma5M2y0ff/w3KIT1AWny8jXvI6mS6Q+rRi1McDq6AEqT2+YZPI92NmTjQN7/21WTZw8C+dJu9lH40LTsM8/ufHIRRzL+cvek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0ba10b5480f311f1aa26b74ffac11d73-20260716
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
X-CID-O-INFO: VERSION:1.3.12,REQID:1420eca0-e2f5-45c0-9419-085d5f24bbe9,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:40
X-CID-INFO: VERSION:1.3.12,REQID:1420eca0-e2f5-45c0-9419-085d5f24bbe9,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:40
X-CID-META: VersionHash:e7bac3a,CLOUDID:e828882c9c8458322efd681cfb785677,BulkI
	D:260716164759OD3OA5D0,BulkQuantity:0,Recheck:0,SF:10|66|78|81|82|102|127|
	865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,
	QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
	,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0ba10b5480f311f1aa26b74ffac11d73-20260716
X-User: liqiang01@kylinos.cn
Received: from cvdaxia.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1958976310; Thu, 16 Jul 2026 16:47:58 +0800
From: Li Qiang <liqiang01@kylinos.cn>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Li Qiang <liqiang01@kylinos.cn>
Subject: [PATCH 1/5] Bluetooth: bfusb: validate received block boundaries
Date: Thu, 16 Jul 2026 16:47:28 +0800
Message-ID: <1f79f2f12306c15d6f686348bb79d8e6839968d2.1784191283.git.liqiang01@kylinos.cn>
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

The USB receive path trusts the block header to contain the required
number of bytes and passes it to the reassembly routine. The routine
also trusts a malformed HCI packet type and can append more data than
the skb allocated from the advertised packet length. A malformed USB
transfer can therefore cause out-of-bounds reads or an skb tail
overwrite.

Validate block header availability, declared block size, packet type,
and reassembly tailroom. Drop the partial frame on an invalid block.

Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
---
 drivers/bluetooth/bfusb.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 8df310983bf6..d31d797639b5 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -301,6 +301,11 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
 				return -EILSEQ;
 			}
 			break;
+
+		default:
+			bt_dev_err(data->hdev, "unknown packet type 0x%02x",
+				   pkt_type);
+			return -EILSEQ;
 		}
 
 		skb = bt_skb_alloc(pkt_len, GFP_ATOMIC);
@@ -319,6 +324,13 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
 		}
 	}
 
+	if (len > skb_tailroom(data->reassembly)) {
+		bt_dev_err(data->hdev, "block exceeds packet length");
+		kfree_skb(data->reassembly);
+		data->reassembly = NULL;
+		return -EILSEQ;
+	}
+
 	if (len > 0)
 		skb_put_data(data->reassembly, buf, len);
 
@@ -353,6 +365,13 @@ static void bfusb_rx_complete(struct urb *urb)
 	skb_put(skb, count);
 
 	while (count) {
+		if (count < 2) {
+			bt_dev_err(data->hdev, "short block header");
+			kfree_skb(data->reassembly);
+			data->reassembly = NULL;
+			break;
+		}
+
 		hdr = buf[0] | (buf[1] << 8);
 
 		if (hdr & 0x4000) {
@@ -360,16 +379,28 @@ static void bfusb_rx_complete(struct urb *urb)
 			count -= 2;
 			buf   += 2;
 		} else {
+			if (count < 3) {
+				bt_dev_err(data->hdev, "short block header");
+				kfree_skb(data->reassembly);
+				data->reassembly = NULL;
+				break;
+			}
+
 			len = (buf[2] == 0) ? 256 : buf[2];
 			count -= 3;
 			buf   += 3;
 		}
 
-		if (count < len)
+		if (count < len) {
 			bt_dev_err(data->hdev, "block extends over URB buffer ranges");
+			kfree_skb(data->reassembly);
+			data->reassembly = NULL;
+			break;
+		}
 
-		if ((hdr & 0xe1) == 0xc1)
-			bfusb_recv_block(data, hdr, buf, len);
+		if ((hdr & 0xe1) == 0xc1 &&
+		    bfusb_recv_block(data, hdr, buf, len) < 0)
+			data->hdev->stat.err_rx++;
 
 		count -= len;
 		buf   += len;
-- 
2.43.0

