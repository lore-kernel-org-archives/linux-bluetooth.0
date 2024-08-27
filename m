Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EE51991D0
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752027; cv=none; b=W/dEF9hNzt51HtvIbgb/1gw3PnuMXujAIrbazTGT+utMbubMlzd0mVdHumafU98/VUgAb8ztsOHgjJUYTv33xTX0D7i+di6QlxlEFuRSPqRUn5eTCx8qzLjVVW2NrSVNAU+AY41cpLkreZjMFJTSBrxpbIGAngtpJHOedcAU5ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752027; c=relaxed/simple;
	bh=e2R8NZUsSGDkEP2ps/K05pYbJKamSciq0avqmPpxl8s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NaRpFM9wuwGIyYiUNwVebd9fb+v/IT07qMMXGEK9StjP6B6CPjdajPgKBi8Wc3H7fIOxJtMMlpNA5EgYR8A+N+KrL26vDfeYlq1ezgIcGBRj4NveF7goMLPoJ5ADhzAhPbhPk3tVlV2RLxYAtV8hgtagTccFjJNDzwqBCNPLfIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WtMyY4Wrtz20mkc;
	Tue, 27 Aug 2024 17:42:13 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id D0FC31401F4;
	Tue, 27 Aug 2024 17:47:01 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 17:47:01 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <marcel@holtmann.org>, <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH -next] net/bluetooth: make use of the helper macro LIST_HEAD()
Date: Tue, 27 Aug 2024 17:55:00 +0800
Message-ID: <20240827095500.3913638-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)

list_head can be initialized automatically with LIST_HEAD()
instead of calling INIT_LIST_HEAD(). Here we can simplify
the code.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 net/bluetooth/6lowpan.c | 8 ++------
 net/bluetooth/msft.c    | 4 +---
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 50cfec8ccac4..e4b2fb771da3 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -988,9 +988,7 @@ static void disconnect_all_peers(void)
 {
 	struct lowpan_btle_dev *entry;
 	struct lowpan_peer *peer, *tmp_peer, *new_peer;
-	struct list_head peers;
-
-	INIT_LIST_HEAD(&peers);
+	LIST_HEAD(peers);
 
 	/* We make a separate list of peers as the close_cb() will
 	 * modify the device peers list so it is better not to mess
@@ -1182,9 +1180,7 @@ static const struct file_operations lowpan_control_fops = {
 static void disconnect_devices(void)
 {
 	struct lowpan_btle_dev *entry, *tmp, *new_dev;
-	struct list_head devices;
-
-	INIT_LIST_HEAD(&devices);
+	LIST_HEAD(devices);
 
 	/* We make a separate list of devices because the unregister_netdev()
 	 * will call device_event() which will also want to modify the same
diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index 5a8ccc491b14..917de240df25 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -305,10 +305,8 @@ static void msft_remove_addr_filters_sync(struct hci_dev *hdev, u8 handle)
 	struct msft_monitor_addr_filter_data *address_filter, *n;
 	struct msft_cp_le_cancel_monitor_advertisement cp;
 	struct msft_data *msft = hdev->msft_data;
-	struct list_head head;
 	struct sk_buff *skb;
-
-	INIT_LIST_HEAD(&head);
+	LIST_HEAD(head);
 
 	/* Cancel all corresponding address monitors */
 	mutex_lock(&msft->filter_lock);
-- 
2.34.1

