Return-Path: <SRS0=bfEF=6B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AEAC2D0EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 17:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CB3C2078E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 17:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYLpWUXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgDQRQo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:16:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36585 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729658AbgDQRQo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Apr 2020 13:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587143803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WjAevoRtNnA5eQLgcRAeqiJLeblt9WTjZ1CS+lxMnjI=;
        b=fYLpWUXlq66k1CtpYD9h8mvlqMNFE/fSSpMb7YlQvyMqPX1Dxw7XwxmPD6FLg+Nbdn958S
        PmGt3rLm4HlJ5BpMLEsfzG3qK3WuK55ToCIrZT13nyaMXDUJSA8KFvnx0yOyBS3dUJHzBH
        nsyU7e3HdoIMiGNY0NU5hAZkrvykLic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-nKmmyVq8MCK42vuE7DHaTQ-1; Fri, 17 Apr 2020 13:15:36 -0400
X-MC-Unique: nKmmyVq8MCK42vuE7DHaTQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D0B9801E70;
        Fri, 17 Apr 2020 17:15:35 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-195.ams2.redhat.com [10.36.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E21560BF7;
        Fri, 17 Apr 2020 17:15:33 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/8] Bluetooth: btbcm: Drop upper nibble version check from btbcm_initialize()
Date:   Fri, 17 Apr 2020 19:15:25 +0200
Message-Id: <20200417171532.448053-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

btbcm_initialize() must either return an error; or fill the passed in
fw_name, otherwise we end up passing uninitialized stack memory to
request_firmware().

Since we have a fallback hw_name of "BCM" not having a known version
in the subver field does not matter, drop the check so that we always
fill the passed in fw_name.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btbcm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 1f498f358f60..b9e1fe052148 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -440,10 +440,6 @@ int btbcm_initialize(struct hci_dev *hdev, char *fw_=
name, size_t len,
 			return err;
 	}
=20
-	/* Upper nibble of rev should be between 0 and 3? */
-	if (((rev & 0xf000) >> 12) > 3)
-		return 0;
-
 	bcm_subver_table =3D (hdev->bus =3D=3D HCI_USB) ? bcm_usb_subver_table =
:
 						    bcm_uart_subver_table;
=20
--=20
2.26.0

