Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B467C5519F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Nov 2020 12:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C17212072C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Nov 2020 12:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ge3AqIzN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbgKVMRf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 22 Nov 2020 07:17:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45224 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727318AbgKVMRe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 22 Nov 2020 07:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606047453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wx1TioL2Kr9OnCSpgdXiyjcV7iAtkvbWH8xFyP8x8Zk=;
        b=ge3AqIzNPSkRBe2TrwGP/Vv8TiU92ace9QscEKwgyGQbmyKEgDRoCkXAdTvbJnFg8WLXmD
        A89Ts/kUfNGkI46HkTlNz+bMwCl2+4Y+RtS0XBuwWsKdo6pB1hVjHonbXEbSRkDrEJqYTj
        VEJ+adcGMtjgCkx8PMBjp2Q9daR3GLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-rlpPR-8lO-62kx2FthAJXQ-1; Sun, 22 Nov 2020 07:17:29 -0500
X-MC-Unique: rlpPR-8lO-62kx2FthAJXQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2649187950E;
        Sun, 22 Nov 2020 12:17:28 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1333C5D9DC;
        Sun, 22 Nov 2020 12:17:26 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Subject: [PATCH] Bluetooth: revert: hci_h5: close serdev device and free hu in h5_close
Date:   Sun, 22 Nov 2020 13:17:25 +0100
Message-Id: <20201122121725.54351-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There have been multiple revisions of the patch fix the h5->rx_skb
leak. Accidentally the first revision (which is buggy) and v5 have
both been merged:

v1 commit 70f259a3f427 ("Bluetooth: hci_h5: close serdev device and free
hu in h5_close");
v5 commit 855af2d74c87 ("Bluetooth: hci_h5: fix memory leak in h5_close")

The correct v5 makes changes slightly higher up in the h5_close()
function, which allowed both versions to get merged without conflict.

The changes from v1 unconditionally frees the h5 data struct, this
is wrong because in the serdev enumeration case the memory is
allocated in h5_serdev_probe() like this:

        h5 = devm_kzalloc(dev, sizeof(*h5), GFP_KERNEL);

So its lifetime is tied to the lifetime of the driver being bound
to the serdev and it is automatically freed when the driver gets
unbound. In the serdev case the same h5 struct is re-used over
h5_close() and h5_open() calls and thus MUST not be free-ed in
h5_close().

The serdev_device_close() added to h5_close() is incorrect in the
same way, serdev_device_close() is called on driver unbound too and
also MUST no be called from h5_close().

This reverts the changes made by merging v1 of the patch, so that
just the changes of the correct v5 remain.

Cc: Anant Thazhemadam <anant.thazhemadam@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_h5.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 2cb5a48121f1..7be16a7f653b 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -251,12 +251,8 @@ static int h5_close(struct hci_uart *hu)
 	if (h5->vnd && h5->vnd->close)
 		h5->vnd->close(h5);
 
-	if (hu->serdev)
-		serdev_device_close(hu->serdev);
-
-	kfree_skb(h5->rx_skb);
-	kfree(h5);
-	h5 = NULL;
+	if (!hu->serdev)
+		kfree(h5);
 
 	return 0;
 }
-- 
2.28.0

