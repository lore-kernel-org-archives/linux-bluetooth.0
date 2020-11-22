Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E46C63777
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Nov 2020 22:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CEEA20776
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Nov 2020 22:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvjzIjGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKVWRl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 22 Nov 2020 17:17:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26311 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725964AbgKVWRk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 22 Nov 2020 17:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606083459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3wYLw231f65HOsLC6e/TSsqN0cdk0lYC+gfTXW9AR64=;
        b=VvjzIjGj8eUHxzDbCKEMXg0acxqsfXDxQ1K3C+B1CYIXD51RmA9FZLJ3Jdb1BnWNJmpo2e
        0+j5zBwOb4Lm8lyJp1fZDeivC3f3e0lmeuJ5ywBPdca90iEiW81CKPM8kh7j9rt5wXHRQp
        ezJMtEYtmt/UsuBEdDDAQWtqjd2HQOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-yMtfj-L5Ok6EE5_YSpT3zg-1; Sun, 22 Nov 2020 17:17:35 -0500
X-MC-Unique: yMtfj-L5Ok6EE5_YSpT3zg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CF76879500;
        Sun, 22 Nov 2020 22:17:34 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60DFF620D7;
        Sun, 22 Nov 2020 22:17:33 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: btusb: Fix detection of some fake CSR controllers with a bcdDevice val of 0x0134
Date:   Sun, 22 Nov 2020 23:17:30 +0100
Message-Id: <20201122221731.441864-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Fixes: cde1a8a99287 ("Bluetooth: btusb: Fix and detect most of the Chinese Bluetooth controllers")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
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

