Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5402FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 21:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3273F61206
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 21:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242944AbhI1Vii (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Sep 2021 17:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbhI1Vih (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Sep 2021 17:38:37 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9096C06161C
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 14:36:57 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id n18so431915pgm.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 14:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hym3bLNj/USdMTU9o29QHXzP+w7cc1MS83jShdmHhOE=;
        b=DaXqPaYML1omf6gaM4nkXwYQWWVQZGbTnrGE575zwpeczVsuOZMW0n/mSjhuH7iT37
         5T5w6Gos2c5ZAreQ73+cCygcR4N+OXbwrxWF5ZOlfYFhzjkK8Mx48+v995CIC7kqLQey
         o8Mu+7oDnEF4YIWaHRK6NkbWB/kqxfKl61CFINctHuIzhTzjVXlwF9idrbH4NgfJxLNQ
         9ODA26wL3YSPOSKG2qCjHKwqmfcLoWGyu9BtHgGRzmjizdy6ydbvHuwORSEuaRDUlyE7
         hyMZOQA9nr/LCLj+tnOAzsNLzuA3fxovwfpYegpoWtojbgBSOh136tFU6brm2rXAvmk3
         2tLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hym3bLNj/USdMTU9o29QHXzP+w7cc1MS83jShdmHhOE=;
        b=SlbyoVZk5gYATuFWAdjyc7e3iRCcfuaGnqth2qPDhmYpV+xhwbhZJwn9/YrE/JSYca
         r59fhIutrVvQbabgnQw1j9tiQoviI5bROmHlbLbHuxVSMxGTs8vHFAVqs++zkqXnqoc3
         PHE7+cCJ2sLyPQWAa+5c6v1jAgh/eeyLO6LjzayGQLDM1JTavfQuAHAjSzIPmqgOVdmV
         UKs+pNLpOL56aDLSiCDaErOQ5Vox+45f6rVOdoLIQg/MUaiZjSLzR/IpPs5aZJecX9W+
         8b85GrVwDOdo4Bc+QTNEHcMI6iIb6TlGvIGG6M67GplLvlzTfcgtY191MOXEYUmFcnZx
         HkSA==
X-Gm-Message-State: AOAM5320xl3V6rxIxkxJ40oCv+WeuY2dY69eCHFBOjjAB/3ZIFf9eyts
        eHGrqfV9R1uNm0lIZh6aUfCa5niaoJY=
X-Google-Smtp-Source: ABdhPJx6kT7fA6eMJgYMX+qaxF6g0ir3y6rBaj7hiASUK/lCUobfXRghJS0B0vgLcIanCEzGGSfYdA==
X-Received: by 2002:aa7:9e90:0:b0:43f:2abb:a504 with SMTP id p16-20020aa79e90000000b0043f2abba504mr7668868pfq.35.1632865016955;
        Tue, 28 Sep 2021 14:36:56 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id ml21sm2053862pjb.55.2021.09.28.14.36.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 14:36:56 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] Bluetooth: Make use of hci_{suspend,resume}_dev on suspend notifier
Date:   Tue, 28 Sep 2021 14:36:51 -0700
Message-Id: <20210928213653.3028439-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves code from hci_suspend_notifier to hci_{suspend,resume}_dev
since some driver may handle pm directly using
HCI_QUIRK_NO_SUSPEND_NOTIFIER they would instead call
hci_{suspend,resume}_dev directly and we want that to have the same
behavior regardless of where pm is being handled.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Clarify why some code is being move into hci_{suspend,resume}_dev and
move debugfs entries to hci_vhci driver so it emulates more closely the
behavior of the driver implementing pm handling and calling the likes of
hci_suspend_dev.

 net/bluetooth/hci_core.c | 116 ++++++++++++++++++++++-----------------
 1 file changed, 67 insertions(+), 49 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index aeec5a3031a6..ea063ce4d7af 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3626,55 +3626,12 @@ static int hci_suspend_notifier(struct notifier_block *nb, unsigned long action,
 	struct hci_dev *hdev =
 		container_of(nb, struct hci_dev, suspend_notifier);
 	int ret = 0;
-	u8 state = BT_RUNNING;
-
-	/* If powering down, wait for completion. */
-	if (mgmt_powering_down(hdev)) {
-		set_bit(SUSPEND_POWERING_DOWN, hdev->suspend_tasks);
-		ret = hci_suspend_wait_event(hdev);
-		if (ret)
-			goto done;
-	}
 
-	/* Suspend notifier should only act on events when powered. */
-	if (!hdev_is_powered(hdev) ||
-	    hci_dev_test_flag(hdev, HCI_UNREGISTER))
-		goto done;
-
-	if (action == PM_SUSPEND_PREPARE) {
-		/* Suspend consists of two actions:
-		 *  - First, disconnect everything and make the controller not
-		 *    connectable (disabling scanning)
-		 *  - Second, program event filter/accept list and enable scan
-		 */
-		ret = hci_change_suspend_state(hdev, BT_SUSPEND_DISCONNECT);
-		if (!ret)
-			state = BT_SUSPEND_DISCONNECT;
-
-		/* Only configure accept list if disconnect succeeded and wake
-		 * isn't being prevented.
-		 */
-		if (!ret && !(hdev->prevent_wake && hdev->prevent_wake(hdev))) {
-			ret = hci_change_suspend_state(hdev,
-						BT_SUSPEND_CONFIGURE_WAKE);
-			if (!ret)
-				state = BT_SUSPEND_CONFIGURE_WAKE;
-		}
+	if (action == PM_SUSPEND_PREPARE)
+		ret = hci_suspend_dev(hdev);
+	else if (action == PM_POST_SUSPEND)
+		ret = hci_resume_dev(hdev);
 
-		hci_clear_wake_reason(hdev);
-		mgmt_suspending(hdev, state);
-
-	} else if (action == PM_POST_SUSPEND) {
-		ret = hci_change_suspend_state(hdev, BT_RUNNING);
-
-		mgmt_resuming(hdev, hdev->wake_reason, &hdev->wake_addr,
-			      hdev->wake_addr_type);
-	}
-
-done:
-	/* We always allow suspend even if suspend preparation failed and
-	 * attempt to recover in resume.
-	 */
 	if (ret)
 		bt_dev_err(hdev, "Suspend notifier action (%lu) failed: %d",
 			   action, ret);
@@ -4017,16 +3974,77 @@ EXPORT_SYMBOL(hci_release_dev);
 /* Suspend HCI device */
 int hci_suspend_dev(struct hci_dev *hdev)
 {
+	int ret;
+	u8 state = BT_RUNNING;
+
+	bt_dev_dbg(hdev, "");
+
+	/* Suspend should only act on when powered. */
+	if (!hdev_is_powered(hdev) ||
+	    hci_dev_test_flag(hdev, HCI_UNREGISTER))
+		return 0;
+
+	/* If powering down, wait for completion. */
+	if (mgmt_powering_down(hdev)) {
+		set_bit(SUSPEND_POWERING_DOWN, hdev->suspend_tasks);
+		ret = hci_suspend_wait_event(hdev);
+		if (ret)
+			goto done;
+	}
+
+	/* Suspend consists of two actions:
+	 *  - First, disconnect everything and make the controller not
+	 *    connectable (disabling scanning)
+	 *  - Second, program event filter/accept list and enable scan
+	 */
+	ret = hci_change_suspend_state(hdev, BT_SUSPEND_DISCONNECT);
+	if (!ret)
+		state = BT_SUSPEND_DISCONNECT;
+
+	/* Only configure accept list if disconnect succeeded and wake
+	 * isn't being prevented.
+	 */
+	if (!ret && !(hdev->prevent_wake && hdev->prevent_wake(hdev))) {
+		ret = hci_change_suspend_state(hdev, BT_SUSPEND_CONFIGURE_WAKE);
+		if (!ret)
+			state = BT_SUSPEND_CONFIGURE_WAKE;
+	}
+
+	hci_clear_wake_reason(hdev);
+	mgmt_suspending(hdev, state);
+
+done:
+	/* We always allow suspend even if suspend preparation failed and
+	 * attempt to recover in resume.
+	 */
 	hci_sock_dev_event(hdev, HCI_DEV_SUSPEND);
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(hci_suspend_dev);
 
 /* Resume HCI device */
 int hci_resume_dev(struct hci_dev *hdev)
 {
+	int ret;
+
+	bt_dev_dbg(hdev, "");
+
+	/* Resume should only act on when powered. */
+	if (!hdev_is_powered(hdev) ||
+	    hci_dev_test_flag(hdev, HCI_UNREGISTER))
+		return 0;
+
+	/* If powering down don't attempt to resume */
+	if (mgmt_powering_down(hdev))
+		return 0;
+
+	ret = hci_change_suspend_state(hdev, BT_RUNNING);
+
+	mgmt_resuming(hdev, hdev->wake_reason, &hdev->wake_addr,
+			      hdev->wake_addr_type);
+
 	hci_sock_dev_event(hdev, HCI_DEV_RESUME);
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(hci_resume_dev);
 
-- 
2.31.1

