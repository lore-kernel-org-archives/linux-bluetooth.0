Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AD3C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 03:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbiKVDnS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Nov 2022 22:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbiKVDnH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Nov 2022 22:43:07 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3192A269;
        Mon, 21 Nov 2022 19:43:00 -0800 (PST)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NGVSb1kRPzHvyr;
        Tue, 22 Nov 2022 11:42:23 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 22 Nov
 2022 11:42:58 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <yuehaibing@huawei.com>, <jkosina@suse.cz>,
        <gregkh@linuxfoundation.org>, <benjamin.tissoires@redhat.com>
CC:     <linux-bluetooth@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] Bluetooth: Fix Kconfig warning for BT_HIDP
Date:   Tue, 22 Nov 2022 11:42:46 +0800
Message-ID: <20221122034246.24408-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

commit 25621bcc8976 add HID_SUPPORT, and HID depends on it now.
Add HID_SUPPORT dependency for BT_HIDP to fix the warning:

WARNING: unmet direct dependencies detected for HID
  Depends on [n]: HID_SUPPORT [=n]
  Selected by [m]:
  - BT_HIDP [=m] && NET [=y] && BT_BREDR [=y] && INPUT [=m]

Fixes: 25621bcc8976 ("HID: Kconfig: split HID support and hid-core compilation")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/bluetooth/hidp/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hidp/Kconfig b/net/bluetooth/hidp/Kconfig
index 14100f341f33..6746be07e222 100644
--- a/net/bluetooth/hidp/Kconfig
+++ b/net/bluetooth/hidp/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config BT_HIDP
 	tristate "HIDP protocol support"
-	depends on BT_BREDR && INPUT
+	depends on BT_BREDR && INPUT && HID_SUPPORT
 	select HID
 	help
 	  HIDP (Human Interface Device Protocol) is a transport layer
-- 
2.17.1

