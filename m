Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48737C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 18:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 228406113E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 18:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhDGS33 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Apr 2021 14:29:29 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:57464 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355379AbhDGS3R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Apr 2021 14:29:17 -0400
Received: from localhost.localdomain (p4ff9f418.dip0.t-ipconnect.de [79.249.244.24])
        by mail.holtmann.org (Postfix) with ESMTPSA id 03851CECE1
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Apr 2021 20:36:48 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: virtio_bt: Use virtio_cread16 instead of virtio_cread
Date:   Wed,  7 Apr 2021 20:28:22 +0200
Message-Id: <20210407182822.343157-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Using virtio_cread leads to a warning on PowerPC architecture:

drivers/bluetooth/virtio_bt.c:303:17: sparse:    bad type *
drivers/bluetooth/virtio_bt.c:303:17: sparse:    unsigned short *
drivers/bluetooth/virtio_bt.c:303:17: sparse: sparse: incompatible types in comparison expression (different base types):
drivers/bluetooth/virtio_bt.c:303:17: sparse: sparse: no generic selection for 'unsigned short [addressable] virtio_cread_v'
drivers/bluetooth/virtio_bt.c:303:17: sparse: sparse: no generic selection for 'unsigned short virtio_cread_v'

Since the values are defined as 16-bit, just use virtio_cread16 instead.

Fixes: 148a48f61393 ("Bluetooth: Add support for virtio transport driver")
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/virtio_bt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index c804db7e90f8..a90294d3c438 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -300,7 +300,8 @@ static int virtbt_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_BT_F_VND_HCI)) {
 		__u16 vendor;
 
-		virtio_cread(vdev, struct virtio_bt_config, vendor, &vendor);
+		vendor = virtio_cread16(vdev, offsetof(struct virtio_bt_config,
+						       vendor));
 
 		switch (vendor) {
 		case VIRTIO_BT_CONFIG_VENDOR_ZEPHYR:
@@ -331,12 +332,11 @@ static int virtbt_probe(struct virtio_device *vdev)
 	}
 
 	if (virtio_has_feature(vdev, VIRTIO_BT_F_MSFT_EXT)) {
-		__u16 msft_opcode;
+		__u16 opcode;
 
-		virtio_cread(vdev, struct virtio_bt_config,
-			     msft_opcode, &msft_opcode);
-
-		hci_set_msft_opcode(hdev, msft_opcode);
+		opcode = virtio_cread16(vdev, offsetof(struct virtio_bt_config,
+						       msft_opcode));
+		hci_set_msft_opcode(hdev, opcode);
 	}
 
 	if (virtio_has_feature(vdev, VIRTIO_BT_F_AOSP_EXT))
-- 
2.30.2

