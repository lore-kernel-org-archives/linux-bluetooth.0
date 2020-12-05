Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE22C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Dec 2020 18:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48EFD230FD
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Dec 2020 18:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgLESap (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 5 Dec 2020 13:30:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35423 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387399AbgLES36 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 5 Dec 2020 13:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607192911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7iXeg+d369Z9iAeCZ8VXKpQ+G+cpYya/oh3Qpx6294E=;
        b=MTEuna+wuyISeA4KLPOW+w1aq8yPYsZWqR5GFntygUHYQ4J7XdB98RvjfLsltAnvXnuoHV
        EdJ/UmbSE5EGC2Ilw1GdcPuP9625s/S9OzL7xc5dMVkMOx9L9TQt6DyXnQEIQCDU1siVKT
        UEK8BeAQEnu64Vv8L86m9Xd+R9ySiXw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-WkwkAE2GNOyjS9bbDj4OjQ-1; Sat, 05 Dec 2020 10:02:08 -0500
X-MC-Unique: WkwkAE2GNOyjS9bbDj4OjQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B256F10054FF;
        Sat,  5 Dec 2020 15:02:06 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-32.ams2.redhat.com [10.36.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD4165D6D5;
        Sat,  5 Dec 2020 15:02:03 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: btusb: Fix detection of some fake CSR controllers with a bcdDevice val of 0x0134
Date:   Sat,  5 Dec 2020 16:02:00 +0100
Message-Id: <20201205150201.5631-2-hdegoede@redhat.com>
In-Reply-To: <20201205150201.5631-1-hdegoede@redhat.com>
References: <20201205150201.5631-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Commit cde1a8a99287 ("Bluetooth: btusb: Fix and detect most of the
Chinese Bluetooth controllers") made the detection of fake controllers
more generic fixing it for much of the newer fakes / clones.

But this does not work for a fake CSR controller with a bcdDevice
value of 0x0134, which was correctly identified as fake before
this change.

Add an extra check for this special case, checking for a combination
of a bcdDevice value of 0x0134, together with a lmp_subver of 0x0c5c
and a hci_ver of BLUETOOTH_VER_2_0.

The chip inside this fake dongle is marked as with "clockwise cw6629d".

Fixes: cde1a8a99287 ("Bluetooth: btusb: Fix and detect most of the Chinese Bluetooth controllers")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Add description of chip inside the fake dongle to the commit message
---
 drivers/bluetooth/btusb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1005b6e8ff74..ac7fede4f951 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1763,6 +1763,8 @@ static int btusb_setup_bcm92035(struct hci_dev *hdev)
 
 static int btusb_setup_csr(struct hci_dev *hdev)
 {
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	u16 bcdDevice = le16_to_cpu(data->udev->descriptor.bcdDevice);
 	struct hci_rp_read_local_version *rp;
 	struct sk_buff *skb;
 	bool is_fake = false;
@@ -1832,6 +1834,12 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 		 le16_to_cpu(rp->hci_ver) > BLUETOOTH_VER_4_0)
 		is_fake = true;
 
+	/* Other clones which beat all the above checks */
+	else if (bcdDevice == 0x0134 &&
+		 le16_to_cpu(rp->lmp_subver) == 0x0c5c &&
+		 le16_to_cpu(rp->hci_ver) == BLUETOOTH_VER_2_0)
+		is_fake = true;
+
 	if (is_fake) {
 		bt_dev_warn(hdev, "CSR: Unbranded CSR clone detected; adding workarounds...");
 
-- 
2.28.0

