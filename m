Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A914C63697
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Nov 2020 22:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2778020758
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Nov 2020 22:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXq7SB4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgKVWRk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 22 Nov 2020 17:17:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56141 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725952AbgKVWRk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 22 Nov 2020 17:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606083458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PjefuY0KlyU8PcQEa1Z+I3eC/OJuTl4GWD0T/J2yCBM=;
        b=eXq7SB4g5G4UCTTcc3T+KVycLHMIwjCga+pFtdk9dyZ6a9dbiBhW09WKouqB0E7KnrAL6L
        +XJnuWYlBsy2S0RjvooH6X0T6aa/eeLZ+6nZDG3oVFW8E8y63xHt5rvUI5FYxgbY+4x4kY
        GgMFPdqtxkx+3TOa32juh4BWJAfE+8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-_P-Z7ClpPBGMPqx38mmQqQ-1; Sun, 22 Nov 2020 17:17:36 -0500
X-MC-Unique: _P-Z7ClpPBGMPqx38mmQqQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86204879510;
        Sun, 22 Nov 2020 22:17:35 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93BF363B8C;
        Sun, 22 Nov 2020 22:17:34 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: btusb: Add workaround for remote-wakeup issues with some fake CSR controllers
Date:   Sun, 22 Nov 2020 23:17:31 +0100
Message-Id: <20201122221731.441864-2-hdegoede@redhat.com>
In-Reply-To: <20201122221731.441864-1-hdegoede@redhat.com>
References: <20201122221731.441864-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

With the recent btusb change to detect and deal with more fake CSR
controllers, I decided to see if one of the fakes which I have
lying around would now work.

After much experimentation I came to the conclusion that it works, if I
have autosuspend enabled initially and then disable it after the device
has suspended at least once. Yes this is very weird, but I've tried many
things, like manually clearing the remote-wakeup feature. Doing a
runtime-resume + runtime suspend is the only way to get the receiver
to actually report received data (and/or pairing info) through its
bulk rx endpoint.

But the funkyness of the bulk-endpoint does not stop there, I mainly
found out about this problem, because with autosuspend enabled
(which usually ensures the suspend at least once condition is met),
the receiver stops reporting received data through its bulk rx endpoint
as soon as autosuspend kicks in. So I initially just disabled
autosuspend, but then the receiver does not work at all.

This was with a fake CSR receiver with a bcdDevice value of 0x8891,
a lmp_subver of 0x0x1012, a hci_rev of 0x0810 and a hci_ver of
BLUETOOTH_VER_4_0.

Summarizing this specific fake CSR receiver has the following 2 issues:

1. The bulk rx endpoint will never report any data unless
the device was suspended at least once.

2. They will not wakeup when autosuspended and receiving data on their
bulk rx endpoint from e.g. a keyboard or mouse (IOW remote-wakeup support
is broken for the bulk endpoint).

Add a workaround for 1. which enables runtime-suspend, force-suspends
the hci and then wakes-it up by disabling runtime-suspend again.

Add a workaround for 2. which clears the hci's can_wake flag, this way
the hci will still be autosuspended when it is not open.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btusb.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ac7fede4f951..48e404dfa246 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1768,6 +1768,7 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 	struct hci_rp_read_local_version *rp;
 	struct sk_buff *skb;
 	bool is_fake = false;
+	int ret;
 
 	BT_DBG("%s", hdev->name);
 
@@ -1856,6 +1857,37 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 		 */
 		clear_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 		clear_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
+
+		/*
+		 * Some of these clones are really messed-up:
+		 * 1. Their bulk rx endpoint will never report any data unless
+		 * the device was suspended at least once (yes really).
+		 * 2. They will not wakeup when autosuspended and receiving data
+		 * on their bulk rx endpoint from e.g. a keyboard or mouse
+		 * (IOW remote-wakeup support is broken for the bulk endpoint).
+		 *
+		 * To fix 1. enable runtime-suspend, force-suspend the
+		 * hci and then wake-it up by disabling runtime-suspend.
+		 *
+		 * To fix 2. clear the hci's can_wake flag, this way the hci
+		 * will still be autosuspended when it is not open.
+		 */
+		if (device_can_wakeup(&data->udev->dev)) {
+			pm_runtime_allow(&data->udev->dev);
+
+			ret = pm_runtime_suspend(&data->udev->dev);
+			if (ret >= 0)
+				msleep(200);
+			else
+				bt_dev_warn(hdev, "Failed to suspend the device for CSR clone receive-issue workaround\n");
+
+			pm_runtime_forbid(&data->udev->dev);
+
+			device_set_wakeup_capable(&data->udev->dev, false);
+			/* Re-enable autosuspend if this was requested */
+			if (enable_autosuspend)
+				usb_enable_autosuspend(data->udev);
+		}
 	}
 
 	kfree_skb(skb);
-- 
2.28.0

