Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CC7C00528
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jul 2023 01:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjGXBm2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Jul 2023 21:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjGXBlp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Jul 2023 21:41:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335D71990;
        Sun, 23 Jul 2023 18:36:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E989860FF5;
        Mon, 24 Jul 2023 01:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC49C43397;
        Mon, 24 Jul 2023 01:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162387;
        bh=nWyYbUWyHEX+PrbQdtho8hjG1GA4fLjt+ufHwU2aBys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hWClxGmB7g7CGdaDwkY2vPpeUiatNMl9KhTWefZtrq1Q974bMzKTeVPZJ/87IxBTm
         LV0jNJuYy9+V4vp/x58YZ068SfuDM3JLz/+5fhbCbACJ2GCj9a4TPFFiUotXB0ctoV
         nopIwJnaY6Zxt4uREwXYUEikd7lFDs05/GlECpOuJzdbRAqw05IrlHpKqVplAc/v8/
         F4d5fkYjjIABcHy1SyQOC/2Ivb4vrTTxDq5y1rQTHI+d2EQZHarKGiNpOAx4VEO2qg
         n0DNjtdob2yp/jDspUjIuvy/YCrZhMjB8JBXF1x1eez2uWMKW/AVztnEHTo/U0xcbg
         64VrCEeItgzMg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matthew Anderson <ruinairas1992@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, marcel@holtmann.org,
        gustavo@padovan.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 21/34] Bluetooth: btusb: Add MT7922 bluetooth ID for the Asus Ally
Date:   Sun, 23 Jul 2023 21:32:24 -0400
Message-Id: <20230724013238.2329166-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013238.2329166-1-sashal@kernel.org>
References: <20230724013238.2329166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
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
index faad19b396d50..d6f405763c56f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -600,6 +600,9 @@ static const struct usb_device_id blacklist_table[] = {
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

