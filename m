Return-Path: <SRS0=jXj2=ZC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461DFC43331
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 Nov 2019 03:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102EC208C3
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 Nov 2019 03:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355372;
	bh=J7af8Qtw38Ew9P8n51YmBy+yIcLcxX26TQGIZ7m712s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DDWnmTUZG/Fb9sFHMvM0R1ssALYMZlHTyuhRbRAyppPYwAlBpZERboyVvctsxAbhn
	 p737/PdGQ6PaFQt4IRYOCSAwfDZhZTGHNCl1QTfKdtXZvoF6dY0fPJIhi1cDEu7tvM
	 QvDqkkU9GLyafPEDcoq+V/NwoMQEdZD4XKxmA6bg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfKJCog (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:44:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728592AbfKJCof (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 9 Nov 2019 21:44:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F9D421D82;
        Sun, 10 Nov 2019 02:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353874;
        bh=J7af8Qtw38Ew9P8n51YmBy+yIcLcxX26TQGIZ7m712s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VteY9gRcnJY2TuewLGeTHaOEOURGNqqjxMSNrn0zcRU03ZLPzWSMQMXZ1JIYbKzmj
         P7huH+GL+8Br/N6J/wtHNsvBff3L3bPSKbp/VbUzlH3N0vHJ4QTulK+zuFvros8Ngd
         5CZqkPJKkm/Tb/xxrBY4HioMNlKJzjkCiJT8HL0o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 153/191] Bluetooth: hci_serdev: clear HCI_UART_PROTO_READY to avoid closing proto races
Date:   Sat,  9 Nov 2019 21:39:35 -0500
Message-Id: <20191110024013.29782-153-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Balakrishna Godavarthi <bgodavar@codeaurora.org>

[ Upstream commit 7cf7846d27bfc9731e449857db3eec5e0e9701ba ]

Clearing HCI_UART_PROTO_READY will avoid usage of proto function pointers
before running the proto close function pointer. There is chance of kernel
crash, due to usage of non proto close function pointers after proto close.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_serdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index aa2543b3c2869..46e20444ba19b 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -368,6 +368,7 @@ void hci_uart_unregister_device(struct hci_uart *hu)
 {
 	struct hci_dev *hdev = hu->hdev;
 
+	clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
 
-- 
2.20.1

