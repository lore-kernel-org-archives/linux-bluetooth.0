Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9532DC71156
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 11:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4218221D91
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 11:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387696AbgLCLLS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 06:11:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28308 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727764AbgLCLLS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 06:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606993791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yHXWWa5HMqI9NVHI0R7/9KApyIQI5M/8KT3VhGB2hZc=;
        b=iwvINTD1LhTFCegpBlCRyYeMv/GRA+/C6sj31XLodVYknjqO2pb/6uJSYqOlbeEnVbNx/9
        gvczpNE3CnKH2bNK4MBx1vGXrWUJn/e+te2NVWT+jQI7WS/iqqlj3iAkruk2B/D6ydU+Tf
        lrvVzOR8UIYkNRPi8Ip4hhIfk5rwxVs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-IoulR45zNUak4VtV8gi4XA-1; Thu, 03 Dec 2020 06:09:49 -0500
X-MC-Unique: IoulR45zNUak4VtV8gi4XA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E3C4107B45D;
        Thu,  3 Dec 2020 11:09:48 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-225.ams2.redhat.com [10.36.114.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 296DB10013C0;
        Thu,  3 Dec 2020 11:09:47 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: btusb: Add workaround for remote-wakeup issues with Barrot 8041a02 fake CSR controllers
Date:   Thu,  3 Dec 2020 12:09:44 +0100
Message-Id: <20201203110944.49307-2-hdegoede@redhat.com>
In-Reply-To: <20201203110944.49307-1-hdegoede@redhat.com>
References: <20201203110944.49307-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

With the recent btusb change to detect and deal with more fake CSR
controllers, I decided to see if fake CSR controllers with Barrot
8041a02 chips would now work.

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

This was with a fake CSR receiver with a Barrot 8041a02 chip with a
bcdDevice value of 0x8891, a lmp_subver of 0x1012, a hci_rev of 0x0810
and a hci_ver of BLUETOOTH_VER_4_0.

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
Changes in v3:
- Add info about which fake CSR chip this happens on to the commit message
  and source code comment
- Only apply the workaround on this specific chip
---
 drivers/bluetooth/btusb.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ac7fede4f951..236aefaf925c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1768,6 +1768,7 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 	struct hci_rp_read_local_version *rp;
 	struct sk_buff *skb;
 	bool is_fake = false;
+	int ret;
 
 	BT_DBG("%s", hdev->name);
 
@@ -1856,6 +1857,43 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 		 */
 		clear_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 		clear_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
+
+		/*
+		 * Special workaround for clones with a Barrot 8041a02 chip,
+		 * these clones are really messed-up:
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
+		if (bcdDevice == 0x8891 &&
+		    le16_to_cpu(rp->lmp_subver) == 0x1012 &&
+		    le16_to_cpu(rp->hci_rev) == 0x0810 &&
+		    le16_to_cpu(rp->hci_ver) == BLUETOOTH_VER_4_0) {
+			bt_dev_warn(hdev, "CSR: detected a fake CSR dongle using a Barrot 8041a02 chip, this chip is very buggy and may have issues\n");
+
+			pm_runtime_allow(&data->udev->dev);
+
+			ret = pm_runtime_suspend(&data->udev->dev);
+			if (ret >= 0)
+				msleep(200);
+			else
+				bt_dev_err(hdev, "Failed to suspend the device for Barrot 8041a02 receive-issue workaround\n");
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

