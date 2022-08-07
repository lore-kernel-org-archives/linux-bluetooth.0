Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78FCC19F2A
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Aug 2022 20:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbiHGU54 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 7 Aug 2022 16:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiHGU5z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 7 Aug 2022 16:57:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48E8A6561
        for <linux-bluetooth@vger.kernel.org>; Sun,  7 Aug 2022 13:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659905872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=x3LfyWSP4k5UhUXtPDVxn5YG6kmcpVYppmGX/byuoJs=;
        b=G9m4DjPywvF7h9jQsPsmVk+kNqCNWnWjT42RfY9H8rdGWNo2fpCkdClPB584y8il/x+jYB
        bu4rWqdqWPjngqwY5w4ocVTsHwmJ1hY1ofyoe2L48Pv/xknhBMyurrtWLfY7IdGEwY9Kd5
        P1o3OlLs/AnQbeD6kb+8i0w98G++S+A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-AsTxPYrUPCWwm4YOY1M_1Q-1; Sun, 07 Aug 2022 16:57:47 -0400
X-MC-Unique: AsTxPYrUPCWwm4YOY1M_1Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2664F8037B5;
        Sun,  7 Aug 2022 20:57:47 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24F192166B26;
        Sun,  7 Aug 2022 20:57:45 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH] Bluetooth: hci_event: Fix vendor (unknown) opcode status handling
Date:   Sun,  7 Aug 2022 22:57:40 +0200
Message-Id: <20220807205740.777363-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Commit c8992cffbe74 ("Bluetooth: hci_event: Use of a function table to
handle Command Complete") was (presumably) meant to only refactor things
without any functional changes.

But it does have one undesirable side-effect, before *status would always
be set to skb->data[0] and it might be overridden by some of the opcode
specific handling. While now it always set by the opcode specific handlers.
This means that if the opcode is not known *status does not get set any
more at all!

This behavior change has broken bluetooth support for BCM4343A0 HCIs,
the hci_bcm.c code tries to configure UART attached HCIs at a higher
baudraute using vendor specific opcodes. The BCM4343A0 does not
support this and this used to simply fail:

[   25.646442] Bluetooth: hci0: BCM: failed to write clock (-56)
[   25.646481] Bluetooth: hci0: Failed to set baudrate

After which things would continue with the initial baudraute. But now
that hci_cmd_complete_evt() no longer sets status for unknown opcodes
*status is left at 0. This causes the hci_bcm.c code to think the baudraute
has been changed on the HCI side and to also adjust the UART baudrate,
after which communication with the HCI is broken, leading to:

[   28.579042] Bluetooth: hci0: command 0x0c03 tx timeout
[   36.961601] Bluetooth: hci0: BCM: Reset failed (-110)

And non working bluetooth. Fix this by restoring the previous
default "*status = skb->data[0]" handling for unknown opcodes.

Fixes: c8992cffbe74 ("Bluetooth: hci_event: Use of a function table to handle Command Complete")
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 net/bluetooth/hci_event.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index af17dfb20e01..fda31d558ded 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3996,6 +3996,13 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, void *data,
 			break;
 		}
 	}
+	if (i == ARRAY_SIZE(hci_cc_table)) {
+		/* Unknown opcode, assume byte 0 contains the status, so
+		 * that e.g. __hci_cmd_sync() properly returns errors
+		 * for vendor specific commands send by HCI drivers.
+		 */
+		*status = skb->data[0];
+	}
 
 	handle_cmd_cnt_and_timer(hdev, ev->ncmd);
 
-- 
2.37.1

