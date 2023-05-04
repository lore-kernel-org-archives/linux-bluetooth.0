Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E791C7EE29
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 May 2023 19:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjEDTqT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 May 2023 15:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjEDTpb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 May 2023 15:45:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6AC619C;
        Thu,  4 May 2023 12:44:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0B7F62EB8;
        Thu,  4 May 2023 19:44:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8782DC4339E;
        Thu,  4 May 2023 19:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229444;
        bh=roCqDH/rrFtOfxVCQCfNrQQhMMOYcsjmHbrYglM5Mhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nb4J7Py6XGFh1Z4GgCZNxoixCvkSoCU3PCpY3gCGhb6ziJXTxWFLhI1JDkEXxZoGP
         GIXKBE2TP+Noej0tqAeSaNIRwWC41uUOE/m1eYCMcPbx02SR4kGeMUhI+Je9vbKP5H
         XRSbgW9PVY8L3kvK5TCOTolkF1+4X120Dgi0741MN0aUJRYOFe4X46ymCphpA3egX6
         OB8V5JXs69VEZCnXpdqqQiHTb7JEfl7jhgo4lDGUt6rYIbcSDkSjKUyxMmda47Lf7j
         za2koSkr3+//Zvr/9uA9at1/PqsnorpAv5XVjlCDQ7CrJf9jbINDZJxK4zwyoPRkHa
         t1rdHg12HRoYQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Chou <max.chou@realtek.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 54/59] Bluetooth: btrtl: check for NULL in btrtl_set_quirks()
Date:   Thu,  4 May 2023 15:41:37 -0400
Message-Id: <20230504194142.3805425-54-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194142.3805425-1-sashal@kernel.org>
References: <20230504194142.3805425-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Max Chou <max.chou@realtek.com>

[ Upstream commit 253cf30e8d3d001850a95c4729d668f916b037ab ]

The btrtl_set_quirks() has accessed btrtl_dev->ic_info->lmp_subver since
b8e482d02513. However, if installing a Realtek Bluetooth controller
without the driver supported, it will hit the NULL point accessed.

Add a check for NULL to avoid the Kernel Oops.

Signed-off-by: Max Chou <max.chou@realtek.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btrtl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 44b672cca69ee..7061621faeb0c 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -889,6 +889,9 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 		break;
 	}
 
+	if (!btrtl_dev->ic_info)
+		return;
+
 	switch (btrtl_dev->ic_info->lmp_subver) {
 	case RTL_ROM_LMP_8703B:
 		/* 8723CS reports two pages for local ext features,
-- 
2.39.2

