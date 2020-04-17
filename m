Return-Path: <SRS0=bfEF=6B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E23C3815B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 17:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ED542078E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 17:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CuGLKFoM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgDQRQr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:16:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29304 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728088AbgDQRQr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Apr 2020 13:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587143806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qHwkqC/4pocBCW8rE1cuZp145riqd8MlnpYqgaiib/M=;
        b=CuGLKFoM+ix2OsfVexCWsqoWHAEGzbp/xEPOuj4v+Uy3A8fqDbaSXiodW4nJMnfOjtiI82
        6YF4s4+MDMXcCY/NCrs0e9ZdYR4NBJBQZSIE0rAtDnMWkZhSl9GNU2Ey9Ugd87RQ2S2oj4
        H/IedxrBmi/D2/3atWvvxwty9TgntOI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-NaZsJRmYOY2NTQU6y4SyuQ-1; Fri, 17 Apr 2020 13:15:40 -0400
X-MC-Unique: NaZsJRmYOY2NTQU6y4SyuQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11BD3104FB63;
        Fri, 17 Apr 2020 17:15:39 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-195.ams2.redhat.com [10.36.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 149D760BF7;
        Fri, 17 Apr 2020 17:15:37 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/8] Bluetooth: btbcm: Make btbcm_initialize() print local-name on re-init too
Date:   Fri, 17 Apr 2020 19:15:28 +0200
Message-Id: <20200417171532.448053-4-hdegoede@redhat.com>
In-Reply-To: <20200417171532.448053-1-hdegoede@redhat.com>
References: <20200417171532.448053-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Make btbcm_initialize() get and print the device's local-name on re-init
too, this will make us also print the local-name after loading the
Patch on UART attached devices making things more consistent.

This also removes some code duplication from btbcm_setup_patchram()
and allows more code duplication removal there in a follow-up patch.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btbcm.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index c22e90a5e288..3404021b10bd 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -360,6 +360,13 @@ static int btbcm_read_info(struct hci_dev *hdev)
 	bt_dev_info(hdev, "BCM: features 0x%2.2x", skb->data[1]);
 	kfree_skb(skb);
=20
+	return 0;
+}
+
+static int btbcm_print_local_name(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+
 	/* Read Local Name */
 	skb =3D btbcm_read_local_name(hdev);
 	if (IS_ERR(skb))
@@ -442,6 +449,9 @@ int btbcm_initialize(struct hci_dev *hdev, bool *fw_l=
oad_done)
 		if (err)
 			return err;
 	}
+	err =3D btbcm_print_local_name(hdev);
+	if (err)
+		return err;
=20
 	bcm_subver_table =3D (hdev->bus =3D=3D HCI_USB) ? bcm_usb_subver_table =
:
 						    bcm_uart_subver_table;
@@ -513,7 +523,6 @@ EXPORT_SYMBOL_GPL(btbcm_finalize);
 int btbcm_setup_patchram(struct hci_dev *hdev)
 {
 	bool fw_load_done =3D false;
-	struct sk_buff *skb;
 	int err;
=20
 	/* Initialize */
@@ -529,14 +538,6 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 	if (err)
 		return err;
=20
-	/* Read Local Name */
-	skb =3D btbcm_read_local_name(hdev);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	bt_dev_info(hdev, "%s", (char *)(skb->data + 1));
-	kfree_skb(skb);
-
 done:
 	btbcm_check_bdaddr(hdev);
=20
--=20
2.26.0

