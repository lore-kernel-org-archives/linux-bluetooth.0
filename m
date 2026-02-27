Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7648536C0CE;
	Fri, 27 Feb 2026 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772191453; cv=none; b=nPyHLk9rijlLnBnIhmjjI7fW6smHzr1v+V/9feBMteADc4F1esP3pm7ujN4zxMhe1qhafE6AvzXMLmLno6tlqY4xVg/7EscuW2J1Gp4/H4A+SrD5cL2rbA9LMeHd/7/PEHR3qvq7Kn6paI/l5xluKxZMy4er5iGRkEiA9DD+Chk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772191453; c=relaxed/simple;
	bh=5QjAjo5uDOX1TV4BvMSo0+rPv0iJk3LgL9i77oAwYQE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IlLctEeRkoBuYrp4jEn25m0HnP4o6lAKBpKqETillaFR/U49nTaV0djKMrkzNIbzfudS9QcRkX6kNNHm8AtIOyW6Shwk7MaX2WpM6dHvY6BGFDMar7ciIs4PqZuDEcfiTDVcbXRIlRq2bJk6ua5p/EMMaXJT2Dmmm+9/FukAh1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=zpQOeSZq; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="zpQOeSZq"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=88NWIMzdut4wFYMN/IOL9CvyxMsxNH1iWh6cKQMW8xo=;
	b=zpQOeSZq3Pgz7opP9P+ETO/ttfub9s8ZYPaBefUs15ClqGzFG3X15+YVhcqH7YRRlP9NTq5L4
	Hri7Yp6d8FEH1FWnjrg1XVHB1VwLzP5hz4KMpgySpkTSckx+m1l7o4G6W4iehC+GEVrkXSUqDlO
	RRHHXXBZIqmN7JdeIZBGDOw=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fMm7957xtzLlTr;
	Fri, 27 Feb 2026 19:19:17 +0800 (CST)
Received: from dggpemf100009.china.huawei.com (unknown [7.185.36.128])
	by mail.maildlp.com (Postfix) with ESMTPS id AFCDC40539;
	Fri, 27 Feb 2026 19:24:05 +0800 (CST)
Received: from huawei.com (10.67.175.29) by dggpemf100009.china.huawei.com
 (7.185.36.128) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 27 Feb
 2026 19:24:05 +0800
From: Wang Tao <wangtao554@huawei.com>
To: <marcel@holtmann.org>, <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhangqiao22@huawei.com>, <tanghui20@huawei.com>, <wangtao554@huawei.com>
Subject: [PATCH] Bluetooth: MGMT: Fix list corruption and UAF in command complete handlers
Date: Fri, 27 Feb 2026 11:03:39 +0000
Message-ID: <20260227110339.919014-1-wangtao554@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf100009.china.huawei.com (7.185.36.128)

Commit 302a1f674c00 ("Bluetooth: MGMT: Fix possible UAFs") introduced
mgmt_pending_valid(), which not only validates the pending command but
also unlinks it from the pending list if it is valid. This change in
semantics requires updates to several completion handlers to avoid list
corruption and memory safety issues.

This patch addresses two left-over issues from the aforementioned rework:

1. In mgmt_add_adv_patterns_monitor_complete(), mgmt_pending_remove()
is replaced with mgmt_pending_free() in the success path. Since
mgmt_pending_valid() already unlinks the command at the beginning of
the function, calling mgmt_pending_remove() leads to a double list_del()
and subsequent list corruption/kernel panic.

2. In set_mesh_complete(), the use of mgmt_pending_foreach() in the error
path is removed. Since the current command is already unlinked by
mgmt_pending_valid(), this foreach loop would incorrectly target other
pending mesh commands, potentially freeing them while they are still being
processed concurrently (leading to UAFs). The redundant mgmt_cmd_status()
is also simplified to use cmd->opcode directly.

Fixes: 302a1f674c00 ("Bluetooth: MGMT: Fix possible UAFs")
Signed-off-by: Wang Tao <wangtao554@huawei.com>
---
 net/bluetooth/mgmt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a7238fd3b03b..d52238ce6a9a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2195,10 +2195,7 @@ static void set_mesh_complete(struct hci_dev *hdev, void *data, int err)
 	sk = cmd->sk;
 
 	if (status) {
-		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER,
-				status);
-		mgmt_pending_foreach(MGMT_OP_SET_MESH_RECEIVER, hdev, true,
-				     cmd_status_rsp, &status);
+		mgmt_cmd_status(cmd->sk, hdev->id, cmd->opcode, status);
 		goto done;
 	}
 
@@ -5377,7 +5374,7 @@ static void mgmt_add_adv_patterns_monitor_complete(struct hci_dev *hdev,
 
 	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode,
 			  mgmt_status(status), &rp, sizeof(rp));
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 
 	hci_dev_unlock(hdev);
 	bt_dev_dbg(hdev, "add monitor %d complete, status %d",
-- 
2.34.1

