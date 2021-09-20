Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639ECC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Sep 2021 12:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40BC8610A1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Sep 2021 12:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbhITM7P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Sep 2021 08:59:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60054 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229719AbhITM7N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Sep 2021 08:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632142666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rVUOOaCgoBsCCyZfatRP3uiZYtMxgn7N6vs6RYEfHX0=;
        b=eH8clCrh6KgKe8jn6Hl7ZYBT5Mkodop+8b8qSUU15k1jtpzesU7C4HDOb0ThIEgUNwU3TC
        7z6XIYh+WQYsUo3a+aET+34UB8CkDBuC+EXKXX0Me763Nn0nvqN4avGJrOgv0hI9hI/UhC
        3ubT9LYG6oD+kQ/WsAgXQJIAqKKkarQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-4eHCm5D0PYmIqvRAOlWE0w-1; Mon, 20 Sep 2021 08:57:43 -0400
X-MC-Unique: 4eHCm5D0PYmIqvRAOlWE0w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A99F10168C8;
        Mon, 20 Sep 2021 12:57:42 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A38A377BF5;
        Mon, 20 Sep 2021 12:57:40 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org,
        Archie Pusaka <apusaka@chromium.org>
Subject: [PATCH 5.15 regression fix] Bluetooth: hci_h5: Fix (runtime)suspend issues on RTL8723BS HCIs
Date:   Mon, 20 Sep 2021 14:57:39 +0200
Message-Id: <20210920125739.111846-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The recently added H5_WAKEUP_DISABLE h5->flags flag gets checked in
h5_btrtl_open(), but it gets set in h5_serdev_probe() *after*
calling  hci_uart_register_device() and thus after h5_btrtl_open()
is called, set this flag earlier.

Also on devices where suspend/resume involves fully re-probing the HCI,
runtime-pm suspend should not be used, make the runtime-pm setup
conditional on the H5_WAKEUP_DISABLE flag too.

This fixes the HCI being removed and then re-added every 10 seconds
because it was being reprobed as soon as it was runtime-suspended.

Cc: Archie Pusaka <apusaka@chromium.org>
Fixes: 66f077dde749 ("Bluetooth: hci_h5: add WAKEUP_DISABLE flag")
Fixes: d9dd833cf6d2 ("Bluetooth: hci_h5: Add runtime suspend")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_h5.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 0c0dedece59c..59b712742d33 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -846,6 +846,8 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 		h5->vnd = data->vnd;
 	}
 
+	if (data->driver_info & H5_INFO_WAKEUP_DISABLE)
+		set_bit(H5_WAKEUP_DISABLE, &h5->flags);
 
 	h5->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
 	if (IS_ERR(h5->enable_gpio))
@@ -860,9 +862,6 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 	if (err)
 		return err;
 
-	if (data->driver_info & H5_INFO_WAKEUP_DISABLE)
-		set_bit(H5_WAKEUP_DISABLE, &h5->flags);
-
 	return 0;
 }
 
@@ -962,11 +961,13 @@ static void h5_btrtl_open(struct h5 *h5)
 	serdev_device_set_parity(h5->hu->serdev, SERDEV_PARITY_EVEN);
 	serdev_device_set_baudrate(h5->hu->serdev, 115200);
 
-	pm_runtime_set_active(&h5->hu->serdev->dev);
-	pm_runtime_use_autosuspend(&h5->hu->serdev->dev);
-	pm_runtime_set_autosuspend_delay(&h5->hu->serdev->dev,
-					 SUSPEND_TIMEOUT_MS);
-	pm_runtime_enable(&h5->hu->serdev->dev);
+	if (!test_bit(H5_WAKEUP_DISABLE, &h5->flags)) {
+		pm_runtime_set_active(&h5->hu->serdev->dev);
+		pm_runtime_use_autosuspend(&h5->hu->serdev->dev);
+		pm_runtime_set_autosuspend_delay(&h5->hu->serdev->dev,
+						 SUSPEND_TIMEOUT_MS);
+		pm_runtime_enable(&h5->hu->serdev->dev);
+	}
 
 	/* The controller needs up to 500ms to wakeup */
 	gpiod_set_value_cansleep(h5->enable_gpio, 1);
@@ -976,7 +977,8 @@ static void h5_btrtl_open(struct h5 *h5)
 
 static void h5_btrtl_close(struct h5 *h5)
 {
-	pm_runtime_disable(&h5->hu->serdev->dev);
+	if (!test_bit(H5_WAKEUP_DISABLE, &h5->flags))
+		pm_runtime_disable(&h5->hu->serdev->dev);
 
 	gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
 	gpiod_set_value_cansleep(h5->enable_gpio, 0);
-- 
2.31.1

