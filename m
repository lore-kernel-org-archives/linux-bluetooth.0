Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E5AC433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 20:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87B23613CB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 20:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239858AbhDEUft (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Apr 2021 16:35:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235275AbhDEUfs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Apr 2021 16:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617654940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v++je7X7UZ6KTTWUIYkq0B1XsnNaBOenCbYwRjCUGPA=;
        b=M37O5FzBy+ICktXqEVpH+zSp/f/wBtLtjnJMGVM6kD1LzS/IoX9pRxSqN26ufqOw3ESTqj
        n3/yEG1F6SrSApTsa0VJi4dP/3PYwLyviCi4vdeJbKvwNjmqIECQuAkAwxv5Jk8o7OYGe2
        lPbLwvwsP3OeoASuW4I7AVcGbh8Rb48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-7psx3p9jN_KG4ZiYa_uSfg-1; Mon, 05 Apr 2021 16:35:39 -0400
X-MC-Unique: 7psx3p9jN_KG4ZiYa_uSfg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CACDE881D66;
        Mon,  5 Apr 2021 20:35:37 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-31.ams2.redhat.com [10.36.112.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92AFD610A8;
        Mon,  5 Apr 2021 20:35:36 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Hui Wang <hui.wang@canonical.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 5.12 regression fix resend 1/1] Bluetooth: btusb: Revert Fix the autosuspend enable and disable
Date:   Mon,  5 Apr 2021 22:35:33 +0200
Message-Id: <20210405203533.17091-2-hdegoede@redhat.com>
In-Reply-To: <20210405203533.17091-1-hdegoede@redhat.com>
References: <20210405203533.17091-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

