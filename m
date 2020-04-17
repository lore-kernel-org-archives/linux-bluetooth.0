Return-Path: <SRS0=bfEF=6B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C28C38A2B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 17:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6778322209
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 17:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhauOamf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgDQRQr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:16:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34266 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbgDQRQr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Apr 2020 13:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587143806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vWBTUfX4h0qFQMftuBWZYnImAcC3+Kc3kLWX3ba0HJ4=;
        b=BhauOamf+6/7NF4XPbg7Y814puQ/aOxv5H/+KTyEJNy5rd4f5Th9syUPYAC9t13ceqXEg6
        WHz7I4JT4EKcfc7pSct+9bUuKdP2Dx+9Qidf0/+WiVxwJr1pH1soruhHZNqzzoxqBT7tXN
        dkHlnNZZBrDzg7Dy+/M8UtlmQpNhVUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-yA5XRcAzPsGHfwUnrUXu8Q-1; Fri, 17 Apr 2020 13:15:42 -0400
X-MC-Unique: yA5XRcAzPsGHfwUnrUXu8Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B944DB62;
        Fri, 17 Apr 2020 17:15:41 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-195.ams2.redhat.com [10.36.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A5CC60BE0;
        Fri, 17 Apr 2020 17:15:40 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/8] Bluetooth: btbcm: Bail sooner from btbcm_initialize() when not loading fw
Date:   Fri, 17 Apr 2020 19:15:30 +0200
Message-Id: <20200417171532.448053-6-hdegoede@redhat.com>
In-Reply-To: <20200417171532.448053-1-hdegoede@redhat.com>
References: <20200417171532.448053-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If we have already loaded the firmware/patchram and btbcm_initialize()
is called to re-init the HCI after this then there is no need to get
the USB device-ids and build a firmware-filename out of these.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btbcm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index cc3628cace35..9fa153b35825 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -463,6 +463,13 @@ int btbcm_initialize(struct hci_dev *hdev, bool *fw_=
load_done)
 		}
 	}
=20
+	bt_dev_info(hdev, "%s (%3.3u.%3.3u.%3.3u) build %4.4u",
+		    hw_name, (subver & 0xe000) >> 13,
+		    (subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
+
+	if (*fw_load_done)
+		return 0;
+
 	if (hdev->bus =3D=3D HCI_USB) {
 		/* Read USB Product Info */
 		skb =3D btbcm_read_usb_product(hdev);
@@ -479,13 +486,6 @@ int btbcm_initialize(struct hci_dev *hdev, bool *fw_=
load_done)
 		snprintf(fw_name, BCM_FW_NAME_LEN, "brcm/%s.hcd", hw_name);
 	}
=20
-	bt_dev_info(hdev, "%s (%3.3u.%3.3u.%3.3u) build %4.4u",
-		    hw_name, (subver & 0xe000) >> 13,
-		    (subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
-
-	if (*fw_load_done)
-		return 0;
-
 	err =3D request_firmware(&fw, fw_name, &hdev->dev);
 	if (err) {
 		bt_dev_info(hdev, "BCM: Patch %s not found", fw_name);
--=20
2.26.0

