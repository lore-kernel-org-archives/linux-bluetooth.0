Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC2BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 17:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D307C61361
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 17:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344708AbhI2RuF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Sep 2021 13:50:05 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:33131 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245131AbhI2RuE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Sep 2021 13:50:04 -0400
Received: from fedora.. (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 64603CECFC
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 19:48:22 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btrtl: Add support for MSFT extension to rtl8821c devices
Date:   Wed, 29 Sep 2021 19:48:19 +0200
Message-Id: <20210929174819.66551-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The rtl8821c class of Realtek devices does support the Microsoft
extensions and thus enable them.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btrtl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 22b84405c257..08582effb25e 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -122,6 +122,7 @@ static const struct id_table ic_id_table[] = {
 	{ IC_INFO(RTL_ROM_LMP_8821A, 0xc, 0x8, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
+	  .has_msft_ext = true,
 	  .fw_name  = "rtl_bt/rtl8821c_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8821c_config" },
 
-- 
2.31.1

