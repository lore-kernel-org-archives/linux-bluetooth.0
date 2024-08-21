Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D18581E
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 01:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724202998; cv=none; b=rQCc5RiJojMIldoPEe4j1mIGEilxGbsYvDauc/PWq4uGl2WVyStyD6kLzUEJn37bU+8a+PKGeg2OA8MGC0bjFyg9+MG4ayNfkOQVTheeEY/SNcIjOMHnUInDysqJSwKXjN8fSChmiudxqRG4USsCO+jPjY9wrh4QpfiFppcsDJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724202998; c=relaxed/simple;
	bh=oREfIt+sCrpt9MTlv9yWAfZlx5/VpKDbbWFU4+gJWJ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J5g6RI/mt4CCwBR4eogf9f0lmOMOddKV+fLatRVI3KVxQJB/Icx53/NFUQZxLYNOP0TvK9Votlbzbpn4DJEuDu19+9sUsQWl8epcpROuJZkZHr3bRnk9De2YW7pHZzMDwZLJbgUvQYolo8kLXxJ804GgIDugHT0bWi2znrToRac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WpSzf0ygXz1xty9;
	Wed, 21 Aug 2024 09:14:38 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 789271A016C;
	Wed, 21 Aug 2024 09:16:32 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Wed, 21 Aug
 2024 09:16:31 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <marcel@holtmann.org>, <luiz.dentz@gmail.com>
CC: <lizetao1@huawei.com>, <linux-bluetooth@vger.kernel.org>
Subject: [PATCH -next] Bluetooth: btrtl: Use kvmemdup to simplify the code
Date: Wed, 21 Aug 2024 09:24:03 +0800
Message-ID: <20240821012403.1947764-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Use kvmemdup instead of kvmalloc() + memcpy() to simplify the code.

No functional change intended.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/bluetooth/btrtl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index f2f37143c454..96754c8a4461 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -878,10 +878,8 @@ static int rtl_load_file(struct hci_dev *hdev, const char *name, u8 **buff)
 	if (ret < 0)
 		return ret;
 	ret = fw->size;
-	*buff = kvmalloc(fw->size, GFP_KERNEL);
-	if (*buff)
-		memcpy(*buff, fw->data, ret);
-	else
+	*buff = kvmemdup(fw->data, fw->size, GFP_KERNEL);
+	if (!*buff)
 		ret = -ENOMEM;
 
 	release_firmware(fw);
-- 
2.34.1

