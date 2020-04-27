Return-Path: <SRS0=BBV2=6L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580DEC54FCB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 14:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30B4520661
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 14:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="In/OKeUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgD0OyX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:54:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60423 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727010AbgD0OyX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Apr 2020 10:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587999262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YNFlswHXlYnAm35o1GlkqsA8tU4GT8bP6tfFTiYXoSg=;
        b=In/OKeUB/EZiCTQk+w9vMvxqmu5qifUR2z07xQ8HIdDrqDLILm9ZLlt7lDXzWl12rtC5jR
        zBf+wiFoowtaKdh/Ju7oaKuxqmt3FD0ebZP3lxHZShfGN2JGQN0r6lC7qUCRdOcFUvvw05
        JuzOzaZv+rVR//K1I7XgjGp18Odle5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-IiGZN3o9PIaySdOeFFZ30A-1; Mon, 27 Apr 2020 10:54:20 -0400
X-MC-Unique: IiGZN3o9PIaySdOeFFZ30A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B1C1107ACF8;
        Mon, 27 Apr 2020 14:54:19 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-38.ams2.redhat.com [10.36.114.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1528397;
        Mon, 27 Apr 2020 14:54:16 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btbcm: Do not free IRQ on close if we did not request it
Date:   Mon, 27 Apr 2020 16:54:14 +0200
Message-Id: <20200427145414.121700-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When the patch-ram is missing the hci_bcm code does not request the
IRQ, in this case we should not try to free it from bcm_close()

This fixes the following WARN statements + backtraces:
[  332.670662] WARNING: CPU: 3 PID: 4743 at kernel/irq/devres.c:143 devm_=
free_irq+0x45/0x50
[  332.670882] Trying to free already-free IRQ 44
[  332.670891] WARNING: CPU: 3 PID: 4743 at kernel/irq/manage.c:1718 free=
_irq+0x1f4/0x390

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_bcm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 0c34b6c57f7d..0fb4b9c1dfc1 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -118,6 +118,7 @@ struct bcm_device {
 	u32			oper_speed;
 	int			irq;
 	bool			irq_active_low;
+	bool			irq_requested;
=20
 #ifdef CONFIG_PM
 	struct hci_uart		*hu;
@@ -333,6 +334,8 @@ static int bcm_request_irq(struct bcm_data *bcm)
 		goto unlock;
 	}
=20
+	bdev->irq_requested =3D true;
+
 	device_init_wakeup(bdev->dev, true);
=20
 	pm_runtime_set_autosuspend_delay(bdev->dev,
@@ -514,10 +517,11 @@ static int bcm_close(struct hci_uart *hu)
 	}
=20
 	if (bdev) {
-		if (IS_ENABLED(CONFIG_PM) && bdev->irq > 0) {
+		if (bdev->irq_requested) {
 			devm_free_irq(bdev->dev, bdev->irq, bdev);
 			device_init_wakeup(bdev->dev, false);
 			pm_runtime_disable(bdev->dev);
+			bdev->irq_requested =3D false;
 		}
=20
 		err =3D bcm_gpio_set_power(bdev, false);
--=20
2.26.0

