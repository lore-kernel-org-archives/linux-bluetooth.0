Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E75C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Dec 2021 14:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381641AbhLCPCj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 10:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245020AbhLCPCf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 10:02:35 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300DAC061353
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Dec 2021 06:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=hvWDrkt26pgfpjnKS6vgCC4J9GIM4uWh5a5u+N3cj/c=;
        t=1638543551; x=1639753151; b=wyw8Utitge3J+7Oe5GcOc0Y4wmjsTAmkZkvucIRF3Rgfpl4
        4n++LlelyTJFM5PCGHwUJiXOuAM7339JVvE24DZ0dlyXr6dgB3TYOiBLX62MQNv64mrCOAz3ts85e
        M+I5V+6cEVAKOicTJ/sSJIGOPE8BMi8SlJFQc/fthw5tF4wGEyjkuYqzUvyyB2miUqSM+xcAM8QjR
        qfngOWQVhcgSDvLKdMPRXvQ8oA8w5dkFbLbLm9E+3BDsWGvedkXDf4/jPe2EXTxgIYNE6md21ZnTd
        A4EJ1tULXnHRmtwMhLum06wla6OzdwbJnHZAuiIx9tM2GfsanVCpqsrC1bSklSkw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1mtA1k-006QDV-Kd;
        Fri, 03 Dec 2021 15:59:08 +0100
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Benjamin Berg <bberg@redhat.com>
Subject: [PATCH v2 1/4] Bluetooth: Reset more state when cancelling a sync command
Date:   Fri,  3 Dec 2021 15:58:59 +0100
Message-Id: <20211203145902.3223861-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211203145902.3223861-1-benjamin@sipsolutions.net>
References: <20211203145902.3223861-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Benjamin Berg <bberg@redhat.com>

Resetting the timers and cmd_cnt means that we assume the device will be
in a good state after the sync command finishes. Without this a chain of
synchronous commands might get stuck if one of them is cancelled.

Signed-off-by: Benjamin Berg <bberg@redhat.com>
---
 net/bluetooth/hci_request.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 8b3205e4b23e..58d640a31bde 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -118,6 +118,11 @@ void hci_req_sync_cancel(struct hci_dev *hdev, int err)
 	if (hdev->req_status == HCI_REQ_PEND) {
 		hdev->req_result = err;
 		hdev->req_status = HCI_REQ_CANCELED;
+
+		cancel_delayed_work_sync(&hdev->cmd_timer);
+		cancel_delayed_work_sync(&hdev->ncmd_timer);
+		atomic_set(&hdev->cmd_cnt, 1);
+
 		wake_up_interruptible(&hdev->req_wait_q);
 	}
 }
-- 
2.33.1

