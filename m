Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D70C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Dec 2021 14:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381630AbhLCPCg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 10:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381627AbhLCPCf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 10:02:35 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37557C061359
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Dec 2021 06:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=vDsOiCXIJOBMs2DG8p+Cbmag+JNpQHQD0sNjbqaOyGU=;
        t=1638543551; x=1639753151; b=JqW8zOAqHbhmNfJYrWW7QjVV2eFt+mcllf6AHpEM8hcGof2
        ++yyYBzXk1sR46cJusWaVOWp+EHIFqGmmgckUd3f7XBnsy6ksVCeVIYlkb0iDESb7Kvq7v9IVI6E5
        zcIp6RngFN/6Y8TpIPp8EqZuS4bTzp4DqDX2/rlDl4rjP8dTkjy4F67ne9nrTmPZwTEbcm8oxNnfH
        IOYE9fMTb2EEdn/D+pVfgqR08yKkRf4RtfU5KyVxRKvUJLVjwM8iFTMQuvNXy4Qfv4WVZjz59mZLT
        5rOvLrRBqsx/0vZ3BkAvfakIJ5osA7tdcqJFKinEtfFocFHiJFRBuSwoIomjulOg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1mtA1l-006QDV-Ew;
        Fri, 03 Dec 2021 15:59:09 +0100
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Benjamin Berg <bberg@redhat.com>
Subject: [PATCH v2 3/4] Bluetooth: hci_core: Cancel sync command if sending a frame failed
Date:   Fri,  3 Dec 2021 15:59:01 +0100
Message-Id: <20211203145902.3223861-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211203145902.3223861-1-benjamin@sipsolutions.net>
References: <20211203145902.3223861-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Benjamin Berg <bberg@redhat.com>

If sending a frame failed any sync command associated with it will never
be completed. As such, cancel any such command immediately to avoid
timing out.

Signed-off-by: Benjamin Berg <bberg@redhat.com>

---

v2:
 * Pass error up and cancel sync command from hci_cmd_work
---
 net/bluetooth/hci_core.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fdc0dcf8ee36..5cadecd31f66 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2906,7 +2906,7 @@ int hci_unregister_cb(struct hci_cb *cb)
 }
 EXPORT_SYMBOL(hci_unregister_cb);
 
-static void hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
+static int hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	int err;
 
@@ -2929,14 +2929,17 @@ static void hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (!test_bit(HCI_RUNNING, &hdev->flags)) {
 		kfree_skb(skb);
-		return;
+		return -EINVAL;
 	}
 
 	err = hdev->send(hdev, skb);
 	if (err < 0) {
 		bt_dev_err(hdev, "sending frame failed (%d)", err);
 		kfree_skb(skb);
+		return err;
 	}
+
+	return 0;
 }
 
 /* Send HCI command */
@@ -3843,10 +3846,15 @@ static void hci_cmd_work(struct work_struct *work)
 
 		hdev->sent_cmd = skb_clone(skb, GFP_KERNEL);
 		if (hdev->sent_cmd) {
+			int res;
 			if (hci_req_status_pend(hdev))
 				hci_dev_set_flag(hdev, HCI_CMD_PENDING);
 			atomic_dec(&hdev->cmd_cnt);
-			hci_send_frame(hdev, skb);
+
+			res = hci_send_frame(hdev, skb);
+			if (res < 0)
+				hci_cmd_sync_cancel(hdev, -res);
+
 			if (test_bit(HCI_RESET, &hdev->flags))
 				cancel_delayed_work(&hdev->cmd_timer);
 			else
-- 
2.33.1

