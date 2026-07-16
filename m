Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034F23DEFF1;
	Thu, 16 Jul 2026 08:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191691; cv=none; b=bAoyMFRkGeA8PyCCl2+zhc+x28mNBtaBkGvBt4ksd/B4GH+CeQJMthlWtDtnqWws26R8nbxm6S8Es4BDv6aaO2c7nLFzLymIoaqenF054HZr46DOQAYIaju2aqp92s0rsz81AFSl+TIGTZtkjhSmvM1+/QYQcpw93WQ+DIiQRjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191691; c=relaxed/simple;
	bh=5hU4yg3GdDdLx1LhoSoBWJA47GLb1DMB2e/Nj2XLUaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R8LJK2Wzj4p+glNP5c3kU4UXfH5Q9EzA6n4cCqlD94UO5rv9V0vnMpyOfw9qZYf0rO1VFkzIk16Tp0Z9BTg1N3IKJOcz9sWCPUI4kznzz3FhX9dZgTEy96IDn/rg4iRPsaZefTJTdlXHZU158c8PtiRAYVUh01zjljj8tE4Se0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0b49832080f311f1aa26b74ffac11d73-20260716
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
X-CID-O-INFO: VERSION:1.3.12,REQID:bf1d0df6-0808-4072-b45f-698fb7fc4fc1,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:40
X-CID-INFO: VERSION:1.3.12,REQID:bf1d0df6-0808-4072-b45f-698fb7fc4fc1,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:40
X-CID-META: VersionHash:e7bac3a,CLOUDID:d01f4b5bf46d39c55baa145fdf947810,BulkI
	D:260716164759XAYF71P7,BulkQuantity:0,Recheck:0,SF:10|66|78|102|127|865|89
	8,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0b49832080f311f1aa26b74ffac11d73-20260716
X-User: liqiang01@kylinos.cn
Received: from cvdaxia.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 378013744; Thu, 16 Jul 2026 16:47:57 +0800
From: Li Qiang <liqiang01@kylinos.cn>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Li Qiang <liqiang01@kylinos.cn>
Subject: [PATCH 0/5] Bluetooth: harden packet and transport parsing
Date: Thu, 16 Jul 2026 16:47:27 +0800
Message-ID: <cover.1784191283.git.liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series hardens Bluetooth packet receive paths and the HCI UART
transmit path against malformed lengths and invalid callback return
values.

The affected code accesses protocol fields before confirming that the
complete headers are present, or trusts a received length while
appending to an skb. The HCI UART write worker also assumes that a tty
driver always returns a valid written-byte count. These assumptions can
lead to out-of-bounds accesses or invalid skb manipulation when data is
truncated or a lower-level driver reports an invalid result.

Validate packet headers and declared data ranges before dereferencing
or copying them. Reject tty write return values outside the skb length,
and reset the QCA memdump state when a collection is discarded.

The affected Bluetooth objects were built with the required Bluetooth
configuration dependencies enabled. The series also passes
git diff --check and checkpatch on the generated patches.

Li Qiang (5):
  Bluetooth: bfusb: validate received block boundaries
  Bluetooth: btmrvl: validate event packet lengths
  Bluetooth: hci_bcsp: validate received packet lengths
  Bluetooth: hci_ldisc: reject invalid tty write lengths
  Bluetooth: hci_qca: validate controller memdump frames

 drivers/bluetooth/bfusb.c       | 37 +++++++++++++++++++--
 drivers/bluetooth/btmrvl_main.c | 10 ++++++
 drivers/bluetooth/hci_bcsp.c    |  5 ++-
 drivers/bluetooth/hci_ldisc.c   |  6 ++++
 drivers/bluetooth/hci_qca.c     | 58 +++++++++++++++++++++++----------
 5 files changed, 95 insertions(+), 21 deletions(-)


base-commit: 123b934b63a0bb3f7aa016f640b992406acd4047
-- 
2.43.0
