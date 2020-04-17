Return-Path: <SRS0=bfEF=6B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0084C38A2D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 17:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82D012078E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 17:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OE08oA6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbgDQRRI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:17:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24953 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729089AbgDQRRD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Apr 2020 13:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587143822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z6l/zWDZCEaXbXc/ePUQ9stSahTa93C4eKw2IG5XIZw=;
        b=OE08oA6oG4D+GMWtVbgEj5qSX7fsnebApflgwAmuozxpZ5zzBzNQBwBRMRgw70chJM04s4
        YfAEftlm9v0k/ORryUhgjb0w5KXdz0h8JTTzqioTE76SwqquRJEG7PuH0CMxk+VOaNypy4
        iYLQhjGg357qN+tFvb3R8dukR+4U9gw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-gJl3UALLMs2u7MqkWeqrdw-1; Fri, 17 Apr 2020 13:15:41 -0400
X-MC-Unique: gJl3UALLMs2u7MqkWeqrdw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 527A21088382;
        Fri, 17 Apr 2020 17:15:40 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-195.ams2.redhat.com [10.36.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5667760BE0;
        Fri, 17 Apr 2020 17:15:39 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/8] Bluetooth: btbcm: Make btbcm_setup_patchram use btbcm_finalize
Date:   Fri, 17 Apr 2020 19:15:29 +0200
Message-Id: <20200417171532.448053-5-hdegoede@redhat.com>
In-Reply-To: <20200417171532.448053-1-hdegoede@redhat.com>
References: <20200417171532.448053-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On UART attached devices we do:

1. btbcm_initialize()
2. Setup UART baudrate, etc.
3. btbcm_finalize()

After our previous changes we can now also use btbcm_finalize() from
the btbcm_setup_patchram() function used on USB devices without any
functional changes. This completes unifying the USB and UART paths
as much as possible.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btbcm.c   | 27 ++++++++-------------------
 drivers/bluetooth/btbcm.h   |  4 ++--
 drivers/bluetooth/hci_bcm.c |  2 +-
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 3404021b10bd..cc3628cace35 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -502,15 +502,16 @@ int btbcm_initialize(struct hci_dev *hdev, bool *fw=
_load_done)
 }
 EXPORT_SYMBOL_GPL(btbcm_initialize);
=20
-int btbcm_finalize(struct hci_dev *hdev)
+int btbcm_finalize(struct hci_dev *hdev, bool *fw_load_done)
 {
-	bool fw_load_done =3D true;
 	int err;
=20
-	/* Re-initialize */
-	err =3D btbcm_initialize(hdev, &fw_load_done);
-	if (err)
-		return err;
+	/* Re-initialize if necessary */
+	if (*fw_load_done) {
+		err =3D btbcm_initialize(hdev, fw_load_done);
+		if (err)
+			return err;
+	}
=20
 	btbcm_check_bdaddr(hdev);
=20
@@ -530,20 +531,8 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 	if (err)
 		return err;
=20
-	if (!fw_load_done)
-		goto done;
-
 	/* Re-initialize after loading Patch */
-	err =3D btbcm_initialize(hdev, &fw_load_done);
-	if (err)
-		return err;
-
-done:
-	btbcm_check_bdaddr(hdev);
-
-	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
-
-	return 0;
+	return btbcm_finalize(hdev, &fw_load_done);
 }
 EXPORT_SYMBOL_GPL(btbcm_setup_patchram);
=20
diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
index 8437caba421d..8bf01565fdfc 100644
--- a/drivers/bluetooth/btbcm.h
+++ b/drivers/bluetooth/btbcm.h
@@ -63,7 +63,7 @@ int btbcm_setup_patchram(struct hci_dev *hdev);
 int btbcm_setup_apple(struct hci_dev *hdev);
=20
 int btbcm_initialize(struct hci_dev *hdev, bool *fw_load_done);
-int btbcm_finalize(struct hci_dev *hdev);
+int btbcm_finalize(struct hci_dev *hdev, bool *fw_load_done);
=20
 #else
=20
@@ -109,7 +109,7 @@ static inline int btbcm_initialize(struct hci_dev *hd=
ev, bool *fw_load_done)
 	return 0;
 }
=20
-static inline int btbcm_finalize(struct hci_dev *hdev)
+static inline int btbcm_finalize(struct hci_dev *hdev, bool *fw_load_don=
e)
 {
 	return 0;
 }
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 6f0c3f2599c0..0c34b6c57f7d 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -603,7 +603,7 @@ static int bcm_setup(struct hci_uart *hu)
 		btbcm_write_pcm_int_params(hu->hdev, &params);
 	}
=20
-	err =3D btbcm_finalize(hu->hdev);
+	err =3D btbcm_finalize(hu->hdev, &fw_load_done);
 	if (err)
 		return err;
=20
--=20
2.26.0

