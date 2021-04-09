Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C7DC433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 13:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07BB761178
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 13:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhDIN7O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Apr 2021 09:59:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40841 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233577AbhDIN7M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Apr 2021 09:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617976738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NDcS8GoQ3L3C1hzomfAqrhX5CNIDi8TF3tk5rXeoaG4=;
        b=YGJLtrRQQuPF/IjFVlGFPesQL8uwyAPP1ZsW6Y1U8TYSgW5JQ/Lg4Zm+wE35dOGfxKmMbE
        4Bt++gn/euyJIF+hlIeN9waXoVUACJp8UqgZTPvCk9AZSC1w1CgPxmlMok+rsoo9dFJ7Qi
        KdlJ5iANR2pL1MM300G0yRcb/Zz9Y7k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-HZxhJxPAMOCh0A5d5gz7jQ-1; Fri, 09 Apr 2021 09:58:55 -0400
X-MC-Unique: HZxhJxPAMOCh0A5d5gz7jQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED06C18B9EC3;
        Fri,  9 Apr 2021 13:58:53 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-113-60.ams2.redhat.com [10.36.113.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6BE85D9E3;
        Fri,  9 Apr 2021 13:58:52 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Hui Wang <hui.wang@canonical.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 5.12 regression fix 1/1] Bluetooth: btusb: Revert Fix the autosuspend enable and disable
Date:   Fri,  9 Apr 2021 15:58:50 +0200
Message-Id: <20210409135850.106730-2-hdegoede@redhat.com>
In-Reply-To: <20210409135850.106730-1-hdegoede@redhat.com>
References: <20210409135850.106730-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

drivers/usb/core/hub.c: usb_new_device() contains the following:

        /* By default, forbid autosuspend for all devices.  It will be
         * allowed for hubs during binding.
         */
        usb_disable_autosuspend(udev);

So for anything which is not a hub, such as btusb devices, autosuspend is
disabled by default and we must call usb_enable_autosuspend(udev) to
enable it.

This means that the "Fix the autosuspend enable and disable" commit,
which drops the usb_enable_autosuspend() call when the enable_autosuspend
module option is true, is completely wrong, revert it.

This reverts commit 7bd9fb058d77213130e4b3e594115c028b708e7e.

Cc: Hui Wang <hui.wang@canonical.com>
Fixes: 7bd9fb058d77 ("Bluetooth: btusb: Fix the autosuspend enable and disable")
Acked-by: Hui Wang <hui.wang@canonical.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btusb.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 52683fd22e05..5cbfbd948f67 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4849,8 +4849,8 @@ static int btusb_probe(struct usb_interface *intf,
 			data->diag = NULL;
 	}
 
-	if (!enable_autosuspend)
-		usb_disable_autosuspend(data->udev);
+	if (enable_autosuspend)
+		usb_enable_autosuspend(data->udev);
 
 	err = hci_register_dev(hdev);
 	if (err < 0)
@@ -4910,9 +4910,6 @@ static void btusb_disconnect(struct usb_interface *intf)
 		gpiod_put(data->reset_gpio);
 
 	hci_free_dev(hdev);
-
-	if (!enable_autosuspend)
-		usb_enable_autosuspend(data->udev);
 }
 
 #ifdef CONFIG_PM
-- 
2.30.2

