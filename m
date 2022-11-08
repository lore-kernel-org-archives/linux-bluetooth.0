Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1224C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Nov 2022 11:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbiKHLY4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Nov 2022 06:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbiKHLYZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Nov 2022 06:24:25 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E112F38E;
        Tue,  8 Nov 2022 03:24:24 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N65Mt5JbtzmVgY;
        Tue,  8 Nov 2022 19:24:10 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 19:24:22 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500015.china.huawei.com
 (7.185.36.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 19:24:22 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <luiz.von.dentz@intel.com>, <luiz.dentz@gmail.com>,
        <pabeni@redhat.com>, <liwei391@huawei.com>,
        <linux-bluetooth@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] Bluetooth: hci_conn: Fix potential memleak in iso_listen_bis()
Date:   Tue, 8 Nov 2022 19:23:08 +0800
Message-ID: <20221108112308.3910185-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When hci_pa_create_sync() failed, hdev should be freed as there
was no place to handle its recycling after.

Fixes: f764a6c2c1e4 ("Bluetooth: ISO: Add broadcast support")
Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 net/bluetooth/iso.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index f825857db6d0..4e3867110dc1 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -880,6 +880,9 @@ static int iso_listen_bis(struct sock *sk)
 
 	hci_dev_unlock(hdev);
 
+	if (err)
+		hci_dev_put(hdev);
+
 	return err;
 }
 
-- 
2.25.1

