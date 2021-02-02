Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CABC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Feb 2021 09:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E40964DA8
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Feb 2021 09:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhBBJpR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:45:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56699 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229525AbhBBJoN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Feb 2021 04:44:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612258966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Vzm/mrc1ZFOkXdj+KdSvny4GrPp0T66LcDMochKWx2U=;
        b=GV9RG0cXGZ+rAhuxzlDqFdPpIwAvLhjLKHufBg+46UdMh789w0nf0hQa/YdfBN9/PANuKW
        yQ+hHDP6tBVjFW20duBgrt8mz/MHAGIpnzPxI3RkLqQ7L892RzTpBDEdMM7FCAz4khNZ9p
        Ne96wlXYOfixUE2SJaFUECKHMJ0xNPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-i3zj0tY-Mf6c7OQ7kzMxFg-1; Tue, 02 Feb 2021 04:42:44 -0500
X-MC-Unique: i3zj0tY-Mf6c7OQ7kzMxFg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA6AE10054FF;
        Tue,  2 Feb 2021 09:42:43 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.64.242.181])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D34EF57995;
        Tue,  2 Feb 2021 09:42:40 +0000 (UTC)
From:   Gopal Tiwari <gtiwari@redhat.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org
Cc:     gtiwari@redhat.com
Subject: [PATCH] Bluetooth: Fix null pointer dereference in amp_read_loc_assoc_final_data
Date:   Tue,  2 Feb 2021 15:12:30 +0530
Message-Id: <20210202094230.13659-1-gtiwari@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

kernel panic trace looks like: 

 #5 [ffffb9e08698fc80] do_page_fault at ffffffffb666e0d7
 #6 [ffffb9e08698fcb0] page_fault at ffffffffb70010fe
    [exception RIP: amp_read_loc_assoc_final_data+63]
    RIP: ffffffffc06ab54f  RSP: ffffb9e08698fd68  RFLAGS: 00010246
    RAX: 0000000000000000  RBX: ffff8c8845a5a000  RCX: 0000000000000004
    RDX: 0000000000000000  RSI: ffff8c8b9153d000  RDI: ffff8c8845a5a000
    RBP: ffffb9e08698fe40   R8: 00000000000330e0   R9: ffffffffc0675c94
    R10: ffffb9e08698fe58  R11: 0000000000000001  R12: ffff8c8b9cbf6200
    R13: 0000000000000000  R14: 0000000000000000  R15: ffff8c8b2026da0b
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #7 [ffffb9e08698fda8] hci_event_packet at ffffffffc0676904 [bluetooth]
 #8 [ffffb9e08698fe50] hci_rx_work at ffffffffc06629ac [bluetooth]
 #9 [ffffb9e08698fe98] process_one_work at ffffffffb66f95e7

hcon->amp_mgr seems NULL triggered kernel panic in following line inside
function amp_read_loc_assoc_final_data

        set_bit(READ_LOC_AMP_ASSOC_FINAL, &mgr->state);

Fixed by checking NULL for mgr.

Signed-off-by: Gopal Tiwari <gtiwari@redhat.com>
---
 net/bluetooth/amp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 9c711f0dfae3..be2d469d6369 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -297,6 +297,9 @@ void amp_read_loc_assoc_final_data(struct hci_dev *hdev,
 	struct hci_request req;
 	int err;
 
+	if (!mgr)
+		return;
+
 	cp.phy_handle = hcon->handle;
 	cp.len_so_far = cpu_to_le16(0);
 	cp.max_len = cpu_to_le16(hdev->amp_assoc_size);
-- 
2.21.1

