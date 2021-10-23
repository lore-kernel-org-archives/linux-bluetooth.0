Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659C2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 23 Oct 2021 10:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0BF60F02
	for <linux-bluetooth@archiver.kernel.org>; Sat, 23 Oct 2021 10:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhJWKM5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 23 Oct 2021 06:12:57 -0400
Received: from aposti.net ([89.234.176.197]:47142 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230140AbhJWKM4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 23 Oct 2021 06:12:56 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     list@opendingux.net, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] Bluetooth: hci_bcm: Remove duplicated entry in OF table
Date:   Sat, 23 Oct 2021 11:10:27 +0100
Message-Id: <20211023101027.44123-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The entry "brcm,bcm4330-bt" was listed twice in the table.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/bluetooth/hci_bcm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ef54afa29357..7852abf15ddf 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1508,7 +1508,6 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
 	{ .compatible = "brcm,bcm4330-bt" },
 	{ .compatible = "brcm,bcm4334-bt" },
 	{ .compatible = "brcm,bcm4345c5" },
-	{ .compatible = "brcm,bcm4330-bt" },
 	{ .compatible = "brcm,bcm43438-bt", .data = &bcm43438_device_data },
 	{ .compatible = "brcm,bcm43540-bt", .data = &bcm4354_device_data },
 	{ .compatible = "brcm,bcm4335a0" },
-- 
2.33.0

