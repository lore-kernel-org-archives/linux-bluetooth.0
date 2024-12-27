Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3DD3597A;
	Fri, 27 Dec 2024 09:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735291329; cv=none; b=P0XigEWpIsbxEj7dpSf/QRvSTIG2RoEVtzWm4PIzl0emNNCQMfYABbJvN/IpmtqCiPlpgy45LsbODrSldrRP/GemAKFK+wBjP/nUqHN9CVkXhxPUN5Bed25VGe2Ml4uveEYL/H8uNXOueIOjZuP9VpzlLO70xrcLz6k1Q2mgSZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735291329; c=relaxed/simple;
	bh=cryk5UA2Vl1+p9K//OPXEYJzSkHbZX4L1qTC9FBosu0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f2e4yH0UsxzFKdCXX5MnPOCOM9UhpzS28AUQdAo2hjR+y4ENmEASmo0fiMvNfxdor1pL3fkVshJVrLyA+wIUi9gPH2Y6LBHJ+eDhvvPijPOJ/zd1MHKf11XHQheu57DHyQ1xM1zENc6ZdsyadSDld1jYAsyXFmmhgx68hPXxQ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id YNW00149;
        Fri, 27 Dec 2024 17:20:49 +0800
Received: from localhost.localdomain (10.94.19.32) by
 jtjnmail201604.home.langchao.com (10.100.2.4) with Microsoft SMTP Server id
 15.1.2507.39; Fri, 27 Dec 2024 17:20:48 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <marcel@holtmann.org>, <luiz.dentz@gmail.com>,
	<christophe.jaillet@wanadoo.fr>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles
 Han <hanchunchao@inspur.com>
Subject: [PATCH] Bluetooth: btbcm: Fix NULL deref in btbcm_get_board_name()
Date: Fri, 27 Dec 2024 17:20:46 +0800
Message-ID: <20241227092046.23304-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2024122717204928ceb4c31bfa28519735dc23e60699b8
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

devm_kstrdup() can return a NULL pointer on failure,but this
returned value in btbcm_get_board_name() is not checked.
Add NULL check in btbcm_get_board_name(), to handle kernel NULL
pointer dereference error.

Fixes: f9183eaad915 ("Bluetooth: btbcm: Use devm_kstrdup()")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/bluetooth/btbcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index a1153ada74d2..d7f3ccf5f594 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -553,6 +553,9 @@ static const char *btbcm_get_board_name(struct device *dev)
 
 	/* get rid of any '/' in the compatible string */
 	board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
+	if (!board_type)
+		return -ENOMEM;
+
 	strreplace(board_type, '/', '-');
 
 	return board_type;
-- 
2.31.1

