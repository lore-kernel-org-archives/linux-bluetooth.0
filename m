Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36064C19F2A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Aug 2022 12:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiHKMBa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Aug 2022 08:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbiHKMB1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Aug 2022 08:01:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E2579676D
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 05:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660219273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8OQGPoU9xp3+ZsTeJDXhMoZ6cJFPvXYwHVDNuQ1PzqY=;
        b=bcCI7JE42FpEvJ2fJR3Yadlr/bwD4kRs/BxtumV2QEbAX6eMUyRjGAEIdjFrXwwm2ihFoJ
        qhvUcmtnc0iKUkZB6goCxgDqWxfW2IeJsGKIaC3VfI6MBxBapRUpgYpMFP75JVdhDvPPVv
        kjaX3r2obT/LEOuhQzfB30tMs+YIu5Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-52AlhS72NSWE0VDk6yWDqA-1; Thu, 11 Aug 2022 08:01:10 -0400
X-MC-Unique: 52AlhS72NSWE0VDk6yWDqA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B6EA29ABA07;
        Thu, 11 Aug 2022 12:01:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A5652166B26;
        Thu, 11 Aug 2022 12:01:08 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH v2] Bluetooth: hci_event: Fix vendor (unknown) opcode status handling
Date:   Thu, 11 Aug 2022 14:01:03 +0200
Message-Id: <20220811120103.47669-1-hdegoede@redhat.com>
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
Changes in v2:
- Add a comment that byte 0 containing the status is not guaranteed
  by the Bluetooth specification
---
 net/bluetooth/hci_event.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index af17dfb20e01..eb43afd5549a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3996,6 +3996,26 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, void *data,
 			break;
 		}
 	}
+	if (i == ARRAY_SIZE(hci_cc_table)) {
+		/* Unknown opcode, assume byte 0 contains the status, so
+		 * that e.g. __hci_cmd_sync() properly returns errors
+		 * for vendor specific commands send by HCI drivers.
+		 *
+		 * Note that the specification does not specify that
+		 * byte 0 is the status:
+		 *
+		 * BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
+		 * page 2189:
+		 *
+		 * Return_Parameters:
+		 * Size: Depends on command
+		 *
+		 * For now using byte 0 seems to work fine, but in the future
+		 * this may need to be updated so that drivers using vendor
+		 * commands can specify their own completion handler.
+		 */
+		*status = skb->data[0];
+	}
 
 	handle_cmd_cnt_and_timer(hdev, ev->ncmd);
 
-- 
2.37.1

