Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFE6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Sep 2021 09:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D0CF61050
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Sep 2021 09:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245341AbhIXJpv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Sep 2021 05:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38132 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245326AbhIXJpj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Sep 2021 05:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632476646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nuPA8aTN1FauWq8dfAHiup4AH18RZTedYgNACLOuxkI=;
        b=Hq7egrKhlkR3T2B+YtJM0Ij5jkLiOqylf7PCOrSy0PeaJ1eVMq/fY8AbzbINx9Aw1FJbfF
        iW3AJnucXFrnKkhsIMQ91b74yNr0AZx1Ial+wTW9dEePugbUCd+IjGAXgTgPZpIV8N1B3f
        l5NhrGv4QpJKBaR6X5wsfG4t34EZ7cs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-QMwZg6SONL6zL5pUmnhYxA-1; Fri, 24 Sep 2021 05:42:34 -0400
X-MC-Unique: QMwZg6SONL6zL5pUmnhYxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AF22C7454;
        Fri, 24 Sep 2021 09:42:33 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E2605BAEB;
        Fri, 24 Sep 2021 09:42:31 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org, Archie Pusaka <apusaka@google.com>
Subject: [PATCH] Bluetooth: hci_h5: directly return hci_uart_register_device() ret-val
Date:   Fri, 24 Sep 2021 11:42:31 +0200
Message-Id: <20210924094231.32578-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Since the hci_uart_register_device() call is the last thing we do in
h5_serdev_probe() we can simply directly return its return-value.

Cc: Archie Pusaka <apusaka@google.com>
Suggested-by: Archie Pusaka <apusaka@google.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_h5.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 59b712742d33..3e067c7cabff 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -814,7 +814,6 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 	struct device *dev = &serdev->dev;
 	struct h5 *h5;
 	const struct h5_device_data *data;
-	int err;
 
 	h5 = devm_kzalloc(dev, sizeof(*h5), GFP_KERNEL);
 	if (!h5)
@@ -858,11 +857,7 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 	if (IS_ERR(h5->device_wake_gpio))
 		return PTR_ERR(h5->device_wake_gpio);
 
-	err = hci_uart_register_device(&h5->serdev_hu, &h5p);
-	if (err)
-		return err;
-
-	return 0;
+	return hci_uart_register_device(&h5->serdev_hu, &h5p);
 }
 
 static void h5_serdev_remove(struct serdev_device *serdev)
-- 
2.31.1

