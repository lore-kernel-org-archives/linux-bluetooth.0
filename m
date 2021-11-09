Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9718EC43219
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 16:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81C06611AF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 16:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238174AbhKIQo0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Nov 2021 11:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238230AbhKIQoX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Nov 2021 11:44:23 -0500
Received: from sipsolutions.net (unknown [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EDFC061766
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Nov 2021 08:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=TOO8C8tEp0g4+AMQpN3GsxmGX9+CLXdDYGzNnlDnX+I=;
        t=1636476097; x=1637685697; b=Zj/Qaz+DRv0pnPADDx/fU0uJof5qJmlF+knjGHolTpqnrZS
        trQFXt2JUknlae/alg1FW6O97idShvRrCOd3ZtthKvoL95hJ6RO1OEt6/+FQ3fgMUJm/zFhH7qxgp
        ifXDT3pkAqPA9Tmf0bAW9qSJXQrmWEDEKHJYoG1CQbAfBi5MOWnExTf/MattUDwPImZBIDKsqg758
        CVCOpBFS+UxEe3PVByzCa/mKMl+bdY2U0k98li0UH+yLRt2cPEA2BWwCaojGlEQ3ElG9ckDLOuqKR
        koD15nncbDvU/bGsYiWKx1QLc6FXms6WFLQ+NO5szBGS6ofRMnw2PjFcK2BWQVBw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1mkUBh-00D1dY-Ae;
        Tue, 09 Nov 2021 17:41:33 +0100
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Benjamin Berg <bberg@redhat.com>
Subject: [PATCH 1/4] Bluetooth: Reset more state when cancelling a sync command
Date:   Tue,  9 Nov 2021 17:41:10 +0100
Message-Id: <20211109164113.65981-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211109164113.65981-1-benjamin@sipsolutions.net>
References: <20211109164113.65981-1-benjamin@sipsolutions.net>
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
index 92611bfc0b9e..c948ee28bede 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -122,6 +122,11 @@ void hci_req_sync_cancel(struct hci_dev *hdev, int err)
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
2.31.1

