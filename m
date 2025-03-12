Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340A92F43
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 06:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741759594; cv=none; b=parEVwyLrhnUoIPtoTFXY5+KclEnZMa2GgcA1vJ9wKgWidcnBFOb6/HOV1w2wGIyb3JD5e7qCKIPpFIau8BvD7xSQcopeQd9C9qoBogOEnfunm1vJlu//0budOROaIn0H0Ue+cqm4ti3kvENcrt6H2cMZSJCuT+ScQzsjqJ++Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741759594; c=relaxed/simple;
	bh=3gUYVXUImx1evT7tSBl3zlk/8cB+RVqW6Vd0zD56Ewg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mj5gcUrPPO7p6YrSSI0yr/e/2bqoyx7gzKDUpuQWDUFFWo6G1gUPhR+gp0GrVb0eyKFNrsytvWhlf5sUyz5pVZWfGdxX+3+RvkYpUTsgjHT4LZA79tqddJuhANFfnlj0tw8SWBKugRCiwhZbkeFNpbgr22WML+FfQl1tXW6Oj2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CRtsObbs; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CRtsObbs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=24AMA
	qZj9+CBjN+19Li4jBovtaXcNsGtNcCbAHy+xs8=; b=CRtsObbsqCsdc+auhl8DE
	ZUbgbpcnwDZ9VKmozxEQLg59l2Se5u1oaCb4NBKzE/Pt3cr/8kLrpMBE5Z2u0QnD
	FTUw3IBMhCjTqRseTNsey5VFwffCSu9b/bz24DKmSN5DL3HAai1BBlUzkLd0tRVd
	uRLV6IgvE09YOMj3nxGbhI=
Received: from A207080518.realsil.com.cn (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3H81aJNFn1xzBRQ--.175S2;
	Wed, 12 Mar 2025 14:06:20 +0800 (CST)
From: michael_kong <kx960506@163.com>
To: linux-bluetooth@vger.kernel.org
Cc: michael_kong <kx960506@163.com>
Subject: [PATCH] share/hci: Fix data type in bt_hci_send_data
Date: Wed, 12 Mar 2025 14:06:05 +0800
Message-Id: <20250312060605.305-1-kx960506@163.com>
X-Mailer: git-send-email 2.29.1.windows.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H81aJNFn1xzBRQ--.175S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRC1vsDUUUU
X-CM-SenderInfo: dn0zliqvqwqiywtou0bp/1tbiuhgOumfRHizNRgAAsZ

The data type in bt_hci_send_data shall be ACL, SCO or ISO.
---
 src/shared/hci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/hci.c b/src/shared/hci.c
index 07fdffc82..575254c09 100644
--- a/src/shared/hci.c
+++ b/src/shared/hci.c
@@ -620,7 +620,7 @@ bool bt_hci_send_data(struct bt_hci *hci, uint8_t type, uint16_t handle,
 	switch (type) {
 	case BT_H4_ACL_PKT:
 	case BT_H4_SCO_PKT:
-	case BT_H4_EVT_PKT:
+	case BT_H4_ISO_PKT:
 		break;
 	default:
 		return false;
-- 
2.29.1.windows.1

