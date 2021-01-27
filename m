Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97B1C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 22:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AF4C64DA3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 22:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbhA0WAO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 17:00:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236320AbhA0WAL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jan 2021 17:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611784722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Dy8NRlqgfGocW4Rd3mRlL6ZQ3w8EHEZmxzVj/jv/Hyc=;
        b=fpr9uPrB8zzVCs4UwCMr+58L8pekJHfMFpUmeJ/RWAlnGtM56Zw1SrrUdgdfAKUMHbZ/IY
        EhW/mGXp3dV723lAELMv6yp1gQY0uk/oY+2rzPcmC7T86HMEhEFVKJDoesXhQSC2k+UxHp
        6QIQZMAJ8xKd5OhTjZ6fuBCPdHKtQxc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-F1b65OVhOkikq0siCZHnoQ-1; Wed, 27 Jan 2021 16:58:38 -0500
X-MC-Unique: F1b65OVhOkikq0siCZHnoQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA1FD1005504;
        Wed, 27 Jan 2021 21:58:36 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-28.ams2.redhat.com [10.36.112.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FF40722E5;
        Wed, 27 Jan 2021 21:58:34 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [PATCH] Bluetooth: hci_h5: Disable the hci_suspend_notifier for btrtl devices
Date:   Wed, 27 Jan 2021 22:58:34 +0100
Message-Id: <20210127215834.9367-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The hci_suspend_notifier which was introduced last year, is causing
problems for uart attached btrtl devices. These devices may loose their
firmware and their baudrate setting over a suspend/resume.

Since we don't even know the baudrate after a suspend/resume recovering
from this is tricky. The driver solves this by treating these devices
the same as USB BT HCIs which drop of the bus during suspend.

Specifically the driver:
1. Simply unconditionally turns the device fully off during
   system-suspend to save maximum power.
2. Calls device_reprobe() from a workqueue to fully re-init the device
   from scratch on system-resume (unregistering the old HCI and
   registering a new HCI).

This means that these devices do not benefit from the suspend / resume
handling work done by the hci_suspend_notifier. At best this unnecessarily
adds some time to the suspend/resume time.

But in practice this is actually causing problems:

1. These btrtl devices seem to not like the HCI_OP_WRITE_SCAN_ENABLE(
SCAN_DISABLED) request being send to them when entering the
BT_SUSPEND_CONFIGURE_WAKE state. The same request send on
BT_SUSPEND_DISCONNECT works fine, but the second one send (unnecessarily?)
from the BT_SUSPEND_CONFIGURE_WAKE transition causes the device to hang:

[  573.497754] PM: suspend entry (s2idle)
[  573.554615] Filesystems sync: 0.056 seconds
[  575.837753] Bluetooth: hci0: Timed out waiting for suspend events
[  575.837801] Bluetooth: hci0: Suspend timeout bit: 4
[  575.837925] Bluetooth: hci0: Suspend notifier action (3) failed: -110

2. The PM_POST_SUSPEND / BT_RUNNING transition races with the
driver-unbinding done by the device_reprobe() work.
If the hci_suspend_notifier wins the race it is talking to a dead
device leading to the following errors being logged:

[  598.686060] Bluetooth: hci0: Timed out waiting for suspend events
[  598.686124] Bluetooth: hci0: Suspend timeout bit: 5
[  598.686237] Bluetooth: hci0: Suspend notifier action (4) failed: -110

In both cases things still work, but the suspend-notifier is causing
these ugly errors getting logged and ut increase both the suspend- and
the resume-time by 2 seconds.

This commit works around these problems by disabling (unregistering)
the hci_suspend_notifier.

Note that any eventual hci_unregister_dev() will call
unregister_pm_notifier() a second time, this is fine it will
simply fail with -ENOENT and hci_unregister_dev() ignores the
return value.

Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_h5.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 7be16a7f653b..acbcc676d6c2 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -14,6 +14,7 @@
 #include <linux/of_device.h>
 #include <linux/serdev.h>
 #include <linux/skbuff.h>
+#include <linux/suspend.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -876,6 +877,13 @@ static int h5_btrtl_setup(struct h5 *h5)
 	bool flow_control;
 	int err;
 
+	/*
+	 * Since h5_btrtl_resume() does a device_reprobe() the suspend handling
+	 * done by the hci_suspend_notifier is not necessary; it actually causes
+	 * delays and a bunch of errors to get logged, so disable it.
+	 */
+	unregister_pm_notifier(&h5->hu->hdev->suspend_notifier);
+
 	btrtl_dev = btrtl_initialize(h5->hu->hdev, h5->id);
 	if (IS_ERR(btrtl_dev))
 		return PTR_ERR(btrtl_dev);
-- 
2.29.2

