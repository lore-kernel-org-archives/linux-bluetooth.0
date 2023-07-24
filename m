Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D449C001E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jul 2023 01:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjGXBon (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Jul 2023 21:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjGXBnb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Jul 2023 21:43:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C32530EC;
        Sun, 23 Jul 2023 18:38:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E92DC61014;
        Mon, 24 Jul 2023 01:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C3AC4339A;
        Mon, 24 Jul 2023 01:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162429;
        bh=OdeuT2FSQb/6tpNx0/w9gwoaPb8pfCCs2oSPVLvIZqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HojDZWROwmA4OJltSA0F/T1khp/y3THsIukuWTZffBoB4qZAHVj38w6y0SWLwaYqt
         o9SQ7OJMqIeFwmBOQB4JL5iNsFT6wncnansbOjpp3BPuyst1Qv0AJGS7PCYIzfnXi6
         Hm5ieWoL+82B/W64IFeC6Wvm1mBIrFsLtWNO4T45ApxUrmSyXCPYAV8fT29XYgJeYG
         h9WeAVua/GBgeavzxUq4BlRUj0wik2IQEqTc6lRvN0vvL/ceRKogvl7KjsQsmsR8ry
         WYl6UKXDxORlr+/j2nklHr5Sl5AsmJGB4/Ai6tHG8RBYzyavuceeweWE8SPhqiPiJp
         //DAN9mxo2+Fw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matthew Anderson <ruinairas1992@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, marcel@holtmann.org,
        gustavo@padovan.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 16/24] Bluetooth: btusb: Add MT7922 bluetooth ID for the Asus Ally
Date:   Sun, 23 Jul 2023 21:33:17 -0400
Message-Id: <20230724013325.2332084-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013325.2332084-1-sashal@kernel.org>
References: <20230724013325.2332084-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.121
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Matthew Anderson <ruinairas1992@gmail.com>

[ Upstream commit fa01eba11f0e57c767a5eab5291c7a01407a00be ]

Adding the device ID from the Asus Ally gets the bluetooth working
on the device.

Signed-off-by: Matthew Anderson <ruinairas1992@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9eb2267bd3a02..15d253325fd8a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -475,6 +475,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe0d9), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0f5), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 	{ USB_DEVICE(0x13d3, 0x3568), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
-- 
2.39.2

