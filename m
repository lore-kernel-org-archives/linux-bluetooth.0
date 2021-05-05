Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A61C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 16:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0944061429
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 16:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbhEEQvk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 May 2021 12:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235917AbhEEQsj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 May 2021 12:48:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8C3C61960;
        Wed,  5 May 2021 16:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620232626;
        bh=B61VQ74IWJ1ywVD/Lw6XXpCVtaIHuTCSX9xELC4BiSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W+vHuw7Efsa2R6Wrd+hu1Lw3FHj/XMf43vGJUK1WA2npHjtPOyZUSQm69t/XHDREw
         p1OWGCE3hKkXtlhqT9hmXt52/Sg9iHal2hwhjy1x8KdgunwqzejuJsZALk/C8ZvwCY
         AEYxPp7esabl+awNRyiJe7At0cY/Pcn97erSr7jdy9ZOmzt7ZGfDGa90JSL7oQRJhA
         pCXMToCSdVYf8BZtOokQW2KpSvNr4C89mvIzhtPFPOteRXrUa17bZL4X4p6DucnkUj
         O7xxyChimKRO8wjuxSyZLOLrGp/jc16uX3mNjSMu/wf9NBTDgCFLWX667U+NBv0+jD
         lUo6tJ+goG9Vw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ayush Garg <ayush.garg@samsung.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 12/85] Bluetooth: Fix incorrect status handling in LE PHY UPDATE event
Date:   Wed,  5 May 2021 12:35:35 -0400
Message-Id: <20210505163648.3462507-12-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505163648.3462507-1-sashal@kernel.org>
References: <20210505163648.3462507-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Ayush Garg <ayush.garg@samsung.com>

[ Upstream commit 87df8bcccd2cede62dfb97dc3d4ca1fe66cb4f83 ]

Skip updation of tx and rx PHYs values, when PHY Update
event's status is not successful.

Signed-off-by: Ayush Garg <ayush.garg@samsung.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 17a72695865b..8b5ee3fcc18c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5896,7 +5896,7 @@ static void hci_le_phy_update_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
-	if (!ev->status)
+	if (ev->status)
 		return;
 
 	hci_dev_lock(hdev);
-- 
2.30.2

