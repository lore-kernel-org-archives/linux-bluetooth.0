Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0BAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 20:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5BAB60FC0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 20:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbhI0UHw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236657AbhI0UHv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Sep 2021 16:07:51 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C777EC061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 13:06:13 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x8so9729695plv.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 13:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GCWNNxwm0ZwDH2eXf0Cai1T6ld0NKMDb+enYV+Xv9GI=;
        b=lhY5Tf2s3zfPLIYMfh3tmn5iK3W83F2qPL90o+6em2zsEOw/rj9417oFEvPsIAPU1M
         853h32e1wNwFDvgMsnoGVycifxRHF+mmu/QJBaquooWl+bRBMcwrxp+LjbiFH9hMJk2Y
         O2QyxEN+WpZqRzR/BrOVC6cLzJr158XY/QgD0bfP6e5VDhraWEGb4S6qi29pa3FIU/FW
         /ceBwq5j79EdM7o1M31lzszDjeOwXCGHoNynrE2axX/kZEIV5aHslxbDV7vUA9ei+fM+
         UgHf5GAbUnvuuCpMcMRBxuV5X1thqIrJjroeERPfP8Ga64rMSeo4JvIcsJ9Ww9uC5s+P
         uBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GCWNNxwm0ZwDH2eXf0Cai1T6ld0NKMDb+enYV+Xv9GI=;
        b=2NxByyWGjMyiDLOmxLFudeY/Ca7xt3/cVZbXSU8ekBDK4bjdNPo6z5GeFO1SwFWW7O
         vtrchcvm6M6qAwiHRtZpFExOVGCIEs2LRqpURscMdJ/KPSHMgIZwh3NJvKgjMtEnSF8g
         YZFZ6mUwj8sNS/zWpWHjzhe/hk5+MxSczjyrAQaczTjcCOwyJ8jrjB3ys/yAOWlB06Zo
         x4NfAvDm08mdTvjTMLHX9HtxgJisqMCCa6BjvArJ/+3eZwcKKJyAXTTdAq4auLPWzycT
         apekMCTiVKOzyPjhnFbGw7gEl6/U/O8eGuOAtuXRRjJinzl7kPUwtnniqvnKpucsn2Nc
         9pEQ==
X-Gm-Message-State: AOAM531/bG+/IfDAUJjTUWArXHeYn+RwI5dxuOAl5Gy1R0tpJbbP9dQi
        JYTfL8Ufh9AnkxJJKUylXh7wPOxu94k=
X-Google-Smtp-Source: ABdhPJz6MhGtbznWFOaVsl4oQ4o314Fk3ofIKBK2ezU7VQCYuDuw5jSX9liwOJVWRkZTYRHRUQe8iw==
X-Received: by 2002:a17:90a:b288:: with SMTP id c8mr984270pjr.67.1632773172773;
        Mon, 27 Sep 2021 13:06:12 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y5sm17742830pfb.207.2021.09.27.13.06.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 13:06:12 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Make use of hci_{suspend,resume}_dev on suspend notifier
Date:   Mon, 27 Sep 2021 13:06:09 -0700
Message-Id: <20210927200611.2722757-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves code from hci_suspend_notifier to hci_{suspend,resume}_dev
since some driver may handle pm directly using
HCI_QUIRK_NO_SUSPEND_NOTIFIER.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
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

