Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E31DC11F69
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jun 2021 19:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F63561D9A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jun 2021 19:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbhF2UBo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jun 2021 16:01:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38592 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235320AbhF2UBl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jun 2021 16:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624996753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ouVxo/zxae5gXThrRHBXzTZ4nIgnfA0w9RjelCry6lU=;
        b=H/Ig2l337J6Wm3EU/jYghHgAUTyWNgsSpfRvIJmH6U8QsUcSRAftP11VZ0KUg/xTUFQGl/
        hqATuPUsSWoUiO7llzE7EcN0dZu4HQT5GKOqOZy1HsY6bEqrtajElTNmZDs66SaKV10YUB
        R4+MlrpzyAAUMh9B1toJehtWgUh2N8E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-ON8sJmYcM92gPSeStXuqCg-1; Tue, 29 Jun 2021 15:59:12 -0400
X-MC-Unique: ON8sJmYcM92gPSeStXuqCg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE3FE362FA;
        Tue, 29 Jun 2021 19:59:10 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-29.ams2.redhat.com [10.36.112.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF9E05DA2D;
        Tue, 29 Jun 2021 19:59:08 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [PATCH v3] Bluetooth: hci_h5: Disable the hci_suspend_notifier for btrtl devices
Date:   Tue, 29 Jun 2021 21:59:07 +0200
Message-Id: <20210629195907.64769-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Changes in v3:
- Use hu->flags instead of hu->hdev_flags to store the
  HCI_UART_NO_SUSPEND_NOTIFIER flag

Changes in v2:
- Use the new HCI_QUIRK_NO_SUSPEND_NOTIFIER quirk, instead of directly
  unregistering the notifier from hci_h5.c
---
 drivers/bluetooth/hci_h5.c     | 7 +++++++
 drivers/bluetooth/hci_serdev.c | 3 +++
 drivers/bluetooth/hci_uart.h   | 7 ++++---
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 27e96681d583..c283504ec3b3 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -919,6 +919,13 @@ static int h5_btrtl_setup(struct h5 *h5)
 
 static void h5_btrtl_open(struct h5 *h5)
 {
+	/*
+	 * Since h5_btrtl_resume() does a device_reprobe() the suspend handling
+	 * done by the hci_suspend_notifier is not necessary; it actually causes
+	 * delays and a bunch of errors to get logged, so disable it.
+	 */
+	set_bit(HCI_UART_NO_SUSPEND_NOTIFIER, &h5->hu->flags);
+
 	/* Devices always start with these fixed parameters */
 	serdev_device_set_flow_control(h5->hu->serdev, false);
 	serdev_device_set_parity(h5->hu->serdev, SERDEV_PARITY_EVEN);
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 9e03402ef1b3..3b00d82d36cf 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -343,6 +343,9 @@ int hci_uart_register_device(struct hci_uart *hu,
 	hdev->setup = hci_uart_setup;
 	SET_HCIDEV_DEV(hdev, &hu->serdev->dev);
 
+	if (test_bit(HCI_UART_NO_SUSPEND_NOTIFIER, &hu->flags))
+		set_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks);
+
 	if (test_bit(HCI_UART_RAW_DEVICE, &hu->hdev_flags))
 		set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
 
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 4e039d7a16f8..fb4a2d0d8cc8 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -86,9 +86,10 @@ struct hci_uart {
 };
 
 /* HCI_UART proto flag bits */
-#define HCI_UART_PROTO_SET	0
-#define HCI_UART_REGISTERED	1
-#define HCI_UART_PROTO_READY	2
+#define HCI_UART_PROTO_SET		0
+#define HCI_UART_REGISTERED		1
+#define HCI_UART_PROTO_READY		2
+#define HCI_UART_NO_SUSPEND_NOTIFIER	3
 
 /* TX states  */
 #define HCI_UART_SENDING	1
-- 
2.31.1

