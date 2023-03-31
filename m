Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754DFC761A6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Mar 2023 21:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbjCaVMV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Mar 2023 17:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCaVMU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Mar 2023 17:12:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DD01D850
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 14:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680297095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sRc0UYyAZYIYagX39KJKvjX1mPVa+8i42bJ/FcCBWjE=;
        b=Rfp3QIWoT4wTQQ4h9G19sOJ/qduyO88Gyli8TRoF0iHF4ovqtINeWPYLPPwgM0zjcaSJ9x
        PJACWvRQj8HTitX0nSrn3ViTeoeHwPHeUSihDinXMHYJxOK0tYovgvG5P35n+LzCs3SPE/
        PvkU2zZiV2DHJ0ROfiZyn7dAjg286Vc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-L7IUwBBvM_m3MtZwzU2KJg-1; Fri, 31 Mar 2023 17:11:34 -0400
X-MC-Unique: L7IUwBBvM_m3MtZwzU2KJg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8D961C0512B;
        Fri, 31 Mar 2023 21:11:33 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 238D2492B00;
        Fri, 31 Mar 2023 21:11:32 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/4] Bluetooth: hci_bcm: 4 fixes / tweaks
Date:   Fri, 31 Mar 2023 23:11:20 +0200
Message-Id: <20230331211124.463003-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi All,

Here is a series with 4 fixes for UART attached Broadcom BT adapters.

Note patch 3/4 is an unchanged resend of an earlier patch,
the other 3 or new.

Regards,

Hans


Hans de Goede (4):
  Bluetooth: hci_bcm: Fall back to getting bdaddr from EFI if not set
  Bluetooth: hci_bcm: Limit bcm43430a0 / bcm43430a1 baudrate to 2000000
  Bluetooth: hci_bcm: Add Lenovo Yoga Tablet 2 830 / 1050 to the
    bcm_broken_irq_dmi_table
  Bluetooth: hci_bcm: Add Acer Iconia One 7 B1-750 to the
    bcm_broken_irq_dmi_table

 drivers/bluetooth/btbcm.c   | 47 +++++++++++++++++++++++++++--
 drivers/bluetooth/hci_bcm.c | 60 +++++++++++++++++++++++++++----------
 2 files changed, 89 insertions(+), 18 deletions(-)

-- 
2.39.1

