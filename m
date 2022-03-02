Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32587C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 13:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242328AbiCBNpk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 08:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbiCBNpj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 08:45:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B41BB5C642
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Mar 2022 05:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646228695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hvepoNzs1VRMmuURt4Qb/fWyBsChePGthX1yB7b/DFk=;
        b=DVW+c6RYTNYS5mqd7PQxWYrijSF6XlACBc7fCVXqczsAYDJIItkV1AhAvzJbJaKPYNd8ih
        gEc9GbFu/6bQ1YveGtg0P9FXkFDfEcZIStoNJNd5tUELjNs84KWrUgrsXk2seI7Bq7ZCTv
        NOKBLDzmztUYvIjD5t5VLVkk/CEmUZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-SIrw-65SPjmE23NapeAs8g-1; Wed, 02 Mar 2022 08:44:50 -0500
X-MC-Unique: SIrw-65SPjmE23NapeAs8g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C4C3801DDB;
        Wed,  2 Mar 2022 13:44:49 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.195.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 330F47B616;
        Wed,  2 Mar 2022 13:44:43 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH] Bluetooth: hci_core: Fix unbalanced unlock in set_device_flags()
Date:   Wed,  2 Mar 2022 14:44:39 +0100
Message-Id: <20220302134439.515377-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There is only one "goto done;" in set_device_flags() and this happens
*before* hci_dev_lock() is called, move the done label to after the
hci_dev_unlock() to fix the following unlock balance:

[   31.493567] =====================================
[   31.493571] WARNING: bad unlock balance detected!
[   31.493576] 5.17.0-rc2+ #13 Tainted: G         C  E
[   31.493581] -------------------------------------
[   31.493584] bluetoothd/685 is trying to release lock (&hdev->lock) at:
[   31.493594] [<ffffffffc07603f5>] set_device_flags+0x65/0x1f0 [bluetooth]
[   31.493684] but there are no more locks to release!

Note this bug has been around for a couple of years, but before
commit fe92ee6425a2 ("Bluetooth: hci_core: Rework hci_conn_params flags")
supported_flags was hardcoded to "((1U << HCI_CONN_FLAG_MAX) - 1)" so
the check for unsupported flags which does the "goto done;" never
triggered.

Fixes: fe92ee6425a2 ("Bluetooth: hci_core: Rework hci_conn_params flags")
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 37087cf7dc5a..f05b9b73e84b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4513,9 +4513,9 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 		}
 	}
 
-done:
 	hci_dev_unlock(hdev);
 
+done:
 	if (status == MGMT_STATUS_SUCCESS)
 		device_flags_changed(sk, hdev, &cp->addr.bdaddr, cp->addr.type,
 				     supported_flags, current_flags);
-- 
2.35.1

