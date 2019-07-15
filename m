Return-Path: <SRS0=pDNe=VM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90615C7618F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jul 2019 14:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D4D21530
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jul 2019 14:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563201285;
	bh=GfIJ5mf34KYLU643Ccq17W951qP5uEeWYv14+vhzvxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P9h4zhrng93jWIA0nDSSgfdyRXuQPXx9qe/ON9WoZeg1Q1xgSXBD4WG+QvnLKIgY/
	 VS8ESSw/TDnVNRqef4ex358WoLHUfOPh3nT3ajHaGs/j3BTgC+1fF6K65sAI6B7KcG
	 xtbDyD5/uM65sy+5T2SslD0iWOrt5+HFEHQ1XSHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391850AbfGOOeo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:34:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404136AbfGOOen (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jul 2019 10:34:43 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97E42204FD;
        Mon, 15 Jul 2019 14:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563201282;
        bh=GfIJ5mf34KYLU643Ccq17W951qP5uEeWYv14+vhzvxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k9TE08MFi5I0oGVcGdM4F9SiEGgE4AOZ98sDyrhBjQYkvdXNIhgk3xfHCnvSHZT0C
         Y6Y2ovEK60VJdIape5uHj8sKOhtF0XQQolCWqexC+hO0g7aY5sSKcX3zPtQNRhXGjy
         4ovJAIaCZU9xQ3wsNwus+ngOxNZRFfLWEggNaAtw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomas Bortoli <tomasbortoli@gmail.com>,
        syzbot+98162c885993b72f19c4@syzkaller.appspotmail.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 096/105] Bluetooth: hci_bcsp: Fix memory leak in rx_skb
Date:   Mon, 15 Jul 2019 10:28:30 -0400
Message-Id: <20190715142839.9896-96-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715142839.9896-1-sashal@kernel.org>
References: <20190715142839.9896-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tomas Bortoli <tomasbortoli@gmail.com>

[ Upstream commit 4ce9146e0370fcd573f0372d9b4e5a211112567c ]

Syzkaller found that it is possible to provoke a memory leak by
never freeing rx_skb in struct bcsp_struct.

Fix by freeing in bcsp_close()

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+98162c885993b72f19c4@syzkaller.appspotmail.com
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_bcsp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index d880f4e33c75..57a7f4255ac0 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -757,6 +757,11 @@ static int bcsp_close(struct hci_uart *hu)
 	skb_queue_purge(&bcsp->rel);
 	skb_queue_purge(&bcsp->unrel);
 
+	if (bcsp->rx_skb) {
+		kfree_skb(bcsp->rx_skb);
+		bcsp->rx_skb = NULL;
+	}
+
 	kfree(bcsp);
 	return 0;
 }
-- 
2.20.1

