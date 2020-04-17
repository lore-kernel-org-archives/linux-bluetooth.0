Return-Path: <SRS0=bfEF=6B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58EAC38A2B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 17:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89B54208E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 17:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1bPjIW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbgDQRQp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:16:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36900 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728088AbgDQRQo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Apr 2020 13:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587143803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g9L+Xx6ldbz31YrRmH5WHkiQ+j02vucVgaDmAo2y/sE=;
        b=i1bPjIW9gdN/wcPAfb1TL1Zny5IdQraoia3GUBLU5fMTCZaXWCVsNevUGuJz5FivVKgSsj
        rc2ge00pueAooRsPceE4OWL/tc7GPXNJkCHf/N4DEJ6aCaElBqLOvmvb117OnHRzMO2hUt
        uuIn6fBqTvzUGkLI/wPnMXRZpMHcFoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399--s47qxWNOuOKtZIbgdPZxg-1; Fri, 17 Apr 2020 13:15:37 -0400
X-MC-Unique: -s47qxWNOuOKtZIbgdPZxg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E03310444C1;
        Fri, 17 Apr 2020 17:15:36 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-195.ams2.redhat.com [10.36.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 555BD60C05;
        Fri, 17 Apr 2020 17:15:35 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/8] Bluetooth: btbcm: Move setting of USE_BDADDR_PROPERTY quirk to hci_bcm.c
Date:   Fri, 17 Apr 2020 19:15:26 +0200
Message-Id: <20200417171532.448053-2-hdegoede@redhat.com>
In-Reply-To: <20200417171532.448053-1-hdegoede@redhat.com>
References: <20200417171532.448053-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

btbcm_finalize() is currently only used by UART attached BCM devices.

Move the setting of the USE_BDADDR_PROPERTY quirk, which we only want
for UART attached devices to hci_bcm in preparation for using
btbcm_finalize() for USB attached devices too.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btbcm.c   | 6 ------
 drivers/bluetooth/hci_bcm.c | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index b9e1fe052148..8052a0e8dbfb 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -488,12 +488,6 @@ int btbcm_finalize(struct hci_dev *hdev)
=20
 	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
=20
-	/* Some devices ship with the controller default address.
-	 * Allow the bootloader to set a valid address through the
-	 * device tree.
-	 */
-	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btbcm_finalize);
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index b236cb11c0dc..dcd2bdf2b4b9 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -620,6 +620,12 @@ static int bcm_setup(struct hci_uart *hu)
 	if (err)
 		return err;
=20
+	/* Some devices ship with the controller default address.
+	 * Allow the bootloader to set a valid address through the
+	 * device tree.
+	 */
+	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hu->hdev->quirks);
+
 	if (!bcm_request_irq(bcm))
 		err =3D bcm_setup_sleep(hu);
=20
--=20
2.26.0

