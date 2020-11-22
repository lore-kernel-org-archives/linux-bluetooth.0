Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D3AC63798
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Nov 2020 10:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83BB120936
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Nov 2020 10:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAjN5TUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbgKVKdc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 22 Nov 2020 05:33:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39781 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727306AbgKVKdb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 22 Nov 2020 05:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606041210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fxcvHjURjgzH+4pBBaaisAcLqolTuB7e53inDOUpc5k=;
        b=hAjN5TUuH0FwKdYE9AY6ysU52DNbwOq22Jcx15B53jZiv0z7JF4qfvt3LY/VNqO/T7ono8
        vLG1rm6NCcQi4pCo3DnZNKHcz9LiMxOTtHw2MAbOvI9QAhBsxE8zAbhdY2Lz1rPhCz27XA
        i418OVmfUFQ1kDItNyNE3QglRfRc/JI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-vYtbeY8YOkuROV_2KEyhtQ-1; Sun, 22 Nov 2020 05:33:27 -0500
X-MC-Unique: vYtbeY8YOkuROV_2KEyhtQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9DE21005D70;
        Sun, 22 Nov 2020 10:33:26 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8F761F453;
        Sun, 22 Nov 2020 10:33:25 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_h5: Add OBDA0623 ACPI HID
Date:   Sun, 22 Nov 2020 11:33:23 +0100
Message-Id: <20201122103323.26116-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add OBDA0623 ACPI HID to the acpi_device_id table. This HID is used
for the RTL8723BS Bluetooth part on the Acer Switch 10E SW3-016.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1665610
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_h5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 981d96cc7695..179a757f9fdc 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -1001,6 +1001,7 @@ static struct h5_vnd rtl_vnd = {
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id h5_acpi_match[] = {
 #ifdef CONFIG_BT_HCIUART_RTL
+	{ "OBDA0623", (kernel_ulong_t)&rtl_vnd },
 	{ "OBDA8723", (kernel_ulong_t)&rtl_vnd },
 #endif
 	{ },
-- 
2.28.0

