Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B3EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 16:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38348610C8
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 16:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbhKIQoZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Nov 2021 11:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238174AbhKIQoX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Nov 2021 11:44:23 -0500
Received: from sipsolutions.net (unknown [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E16C061764
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Nov 2021 08:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=K20FTmKeMcaSMklUhK0ny/B+G4bWOYmXCUJt5X0Pkww=;
        t=1636476097; x=1637685697; b=P7/xjy07XICHD8P6t9oM4dHMpnkEiUjnQI+52o5g5VAC+Rq
        dw5U4PktbhKVnAeEnyfP2rUblFo+mzQyN28C5qjCpu8oDpvCRDpLiP7GiFtcdowzNpYX4BGwj/7Nt
        baWLy7i7X1vN8WiLIEAxbgMJyDiXGh/i0aa7fsvs8YfoMCd3cXrVIkeEB59CmpV1TaFYBOK3K0Ano
        th2XpiN8xSKh5Wk2mVpG9R+TuCU22pHHg1tL6v3SiTnKCEIx6ZDVc04oZlV+TOWSToHLVIfHBB9jK
        EOqu0p8UtIAbeiwWP5dVxXCE4p/F+nsGFEV9gEhkanAYFvYTOXtdx2OJdobvUQLQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1mkUBh-00D1dY-IK;
        Tue, 09 Nov 2021 17:41:33 +0100
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Benjamin Berg <bberg@redhat.com>
Subject: [PATCH 2/4] Bluetooth: Add new hci_tx_error function
Date:   Tue,  9 Nov 2021 17:41:11 +0100
Message-Id: <20211109164113.65981-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211109164113.65981-1-benjamin@sipsolutions.net>
References: <20211109164113.65981-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Benjamin Berg <bberg@redhat.com>

Currently this function only cancels any synchronous operation that
might be ongoing. Adding this function allows aborting synchronous
commands in case of low level TX/RX issues. A common example for this is
that the device has been removed.

Signed-off-by: Benjamin Berg <bberg@redhat.com>
---
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_core.c         | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index dd8840e70e25..542f5a37b9d0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1267,6 +1267,7 @@ void hci_release_dev(struct hci_dev *hdev);
 int hci_suspend_dev(struct hci_dev *hdev);
 int hci_resume_dev(struct hci_dev *hdev);
 int hci_reset_dev(struct hci_dev *hdev);
+void hci_tx_error(struct hci_dev *hdev, int err);
 int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb);
 int hci_recv_diag(struct hci_dev *hdev, struct sk_buff *skb);
 __printf(2, 3) void hci_set_hw_info(struct hci_dev *hdev, const char *fmt, ...);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8d33aa64846b..bbb35188e41f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4069,6 +4069,13 @@ int hci_reset_dev(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL(hci_reset_dev);
 
+/* Reset HCI device */
+void hci_tx_error(struct hci_dev *hdev, int err)
+{
+	hci_req_sync_cancel(hdev, err);
+}
+EXPORT_SYMBOL(hci_tx_error);
+
 /* Receive frame from HCI drivers */
 int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
-- 
2.31.1

