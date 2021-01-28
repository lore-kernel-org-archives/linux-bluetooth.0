Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAC1C433E6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 16:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA3764E0E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 16:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhA1QgR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jan 2021 11:36:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32893 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232578AbhA1Qfg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jan 2021 11:35:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611851649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2IPZyAYpapBF8BqK19nNG7kbsPa0a8ESJujLK+gQEZc=;
        b=YZfcj9Q03nw8AJEo+mm7OGV3zIsMCL8YiHJvNHnPG78Mae8z+pa7yKL0HsVxqiLHmWDmuv
        pyr5cHXx4ixswP4pL1o6ZOQnFMrxBniR0u3jAGq9I1uBgGn8aaj1fJazZ6sJfwiagJUCgS
        JVLRnutwQDp6OW1ygWkbDebti5BO25I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-hFO-Y1RqM9OvILHs-ugsPg-1; Thu, 28 Jan 2021 11:34:05 -0500
X-MC-Unique: hFO-Y1RqM9OvILHs-ugsPg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4CDD1081B2C;
        Thu, 28 Jan 2021 16:33:17 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-250.ams2.redhat.com [10.36.114.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63E1E5C233;
        Thu, 28 Jan 2021 16:33:16 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [PATCH v2 2/2] Bluetooth: hci_h5: Disable the hci_suspend_notifier for btrtl devices
Date:   Thu, 28 Jan 2021 17:33:13 +0100
Message-Id: <20210128163313.426404-2-hdegoede@redhat.com>
In-Reply-To: <20210128163313.426404-1-hdegoede@redhat.com>
References: <20210128163313.426404-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

This commit avoids these problems by disabling the hci_suspend_notifier.

Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Use the new HCI_QUIRK_NO_SUSPEND_NOTIFIER quirk, instead of directly
  unregistering the notifier from hci_h5.c
---
 drivers/bluetooth/hci_h5.c     |  7 +++++++
 drivers/bluetooth/hci_serdev.c |  3 +++
 drivers/bluetooth/hci_uart.h   | 13 +++++++------
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 7be16a7f653b..e8f3afab6587 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -914,6 +914,13 @@ static int h5_btrtl_setup(struct h5 *h5)
 
 static void h5_btrtl_open(struct h5 *h5)
 {
+	/*
+	 * Since h5_btrtl_resume() does a device_reprobe() the suspend handling
+	 * done by the hci_suspend_notifier is not necessary; it actually causes
+	 * delays and a bunch of errors to get logged, so disable it.
+	 */
+	set_bit(HCI_UART_NO_SUSPEND_NOTIFIER, &h5->hu->hdev_flags);
+
 	/* Devices always start with these fixed parameters */
 	serdev_device_set_flow_control(h5->hu->serdev, false);
 	serdev_device_set_parity(h5->hu->serdev, SERDEV_PARITY_EVEN);
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index ef96ad06fa54..dbc14b8ac477 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -349,6 +349,9 @@ int hci_uart_register_device(struct hci_uart *hu,
 	if (test_bit(HCI_UART_EXT_CONFIG, &hu->hdev_flags))
 		set_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks);
 
+	if (test_bit(HCI_UART_NO_SUSPEND_NOTIFIER, &hu->hdev_flags))
+		set_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks);
+
 	if (test_bit(HCI_UART_CREATE_AMP, &hu->hdev_flags))
 		hdev->dev_type = HCI_AMP;
 	else
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 4e039d7a16f8..4df2330ac103 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -35,12 +35,13 @@
 #define HCI_UART_NOKIA	10
 #define HCI_UART_MRVL	11
 
-#define HCI_UART_RAW_DEVICE	0
-#define HCI_UART_RESET_ON_INIT	1
-#define HCI_UART_CREATE_AMP	2
-#define HCI_UART_INIT_PENDING	3
-#define HCI_UART_EXT_CONFIG	4
-#define HCI_UART_VND_DETECT	5
+#define HCI_UART_RAW_DEVICE		0
+#define HCI_UART_RESET_ON_INIT		1
+#define HCI_UART_CREATE_AMP		2
+#define HCI_UART_INIT_PENDING		3
+#define HCI_UART_EXT_CONFIG		4
+#define HCI_UART_VND_DETECT		5
+#define HCI_UART_NO_SUSPEND_NOTIFIER	6
 
 struct hci_uart;
 struct serdev_device;
-- 
2.29.2

