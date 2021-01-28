Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA83C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 16:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4A2D64E0C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 16:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbhA1Qgj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jan 2021 11:36:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232591AbhA1Qfa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jan 2021 11:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611851643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wgqGSQYCYG8H3B0wjSS50/8sCVB6kJcp1awJG1izGGw=;
        b=RkYS/LGmRL6thdcmJl4N7LB/M+gUxV9lsYvhS0t4LYDsG5D9ob9rWCmIhAyRnEiGAL4jdA
        92I5AKSU9lg2Dn8TmYAeONIVQuS+tjNSiaYofkZVC819uBgpvtKbjTge5ZSz+UhuIW2YAi
        BztZDJQKAqSd+/4jh27Yr+ygnPZilYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-7VObSRMXPJWvXeaPy8XEdQ-1; Thu, 28 Jan 2021 11:34:01 -0500
X-MC-Unique: 7VObSRMXPJWvXeaPy8XEdQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BD901005419;
        Thu, 28 Jan 2021 16:33:16 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-250.ams2.redhat.com [10.36.114.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D42595C1BB;
        Thu, 28 Jan 2021 16:33:14 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [PATCH v2 1/2] Bluetooth: Add new HCI_QUIRK_NO_SUSPEND_NOTIFIER quirk
Date:   Thu, 28 Jan 2021 17:33:12 +0100
Message-Id: <20210128163313.426404-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some devices, e.g. the RTL8723BS bluetooth part, some USB attached devices,
completely drop from the bus on a system-suspend. These devices will
have their driver unbound and rebound on resume (when the dropping of
the bus gets detected) and will show up as a new HCI after resume.

These devices do not benefit from the suspend / resume handling work done
by the hci_suspend_notifier. At best this unnecessarily adds some time to
the suspend/resume time. But this may also actually cause problems, if the
code doing the driver unbinding runs after the pm-notifier then the
hci_suspend_notifier code will try to talk to a device which is now in
an uninitialized state.

This commit adds a new HCI_QUIRK_NO_SUSPEND_NOTIFIER quirk which allows
drivers to opt-out of the hci_suspend_notifier when they know beforehand
that their device will be fully re-initialized / reprobed on resume.

Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- This is a new patch in v2 of this patch-set
---
 include/net/bluetooth/hci.h |  8 ++++++++
 net/bluetooth/hci_core.c    | 18 +++++++++++-------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c1504aa3d9cf..ba2f439bc04d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -238,6 +238,14 @@ enum {
 	 * during the hdev->setup vendor callback.
 	 */
 	HCI_QUIRK_BROKEN_ERR_DATA_REPORTING,
+
+	/*
+	 * When this quirk is set, then the hci_suspend_notifier is not
+	 * registered. This is intended for devices which drop completely
+	 * from the bus on system-suspend and which will show up as a new
+	 * HCI after resume.
+	 */
+	HCI_QUIRK_NO_SUSPEND_NOTIFIER,
 };
 
 /* HCI device flags */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9d2c9a1c552f..9d8dbb38585c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3827,10 +3827,12 @@ int hci_register_dev(struct hci_dev *hdev)
 	hci_sock_dev_event(hdev, HCI_DEV_REG);
 	hci_dev_hold(hdev);
 
-	hdev->suspend_notifier.notifier_call = hci_suspend_notifier;
-	error = register_pm_notifier(&hdev->suspend_notifier);
-	if (error)
-		goto err_wqueue;
+	if (!test_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks)) {
+		hdev->suspend_notifier.notifier_call = hci_suspend_notifier;
+		error = register_pm_notifier(&hdev->suspend_notifier);
+		if (error)
+			goto err_wqueue;
+	}
 
 	queue_work(hdev->req_workqueue, &hdev->power_on);
 
@@ -3865,9 +3867,11 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	cancel_work_sync(&hdev->power_on);
 
-	hci_suspend_clear_tasks(hdev);
-	unregister_pm_notifier(&hdev->suspend_notifier);
-	cancel_work_sync(&hdev->suspend_prepare);
+	if (!test_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks)) {
+		hci_suspend_clear_tasks(hdev);
+		unregister_pm_notifier(&hdev->suspend_notifier);
+		cancel_work_sync(&hdev->suspend_prepare);
+	}
 
 	hci_dev_do_close(hdev);
 
-- 
2.29.2

