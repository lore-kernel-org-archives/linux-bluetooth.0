Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D12EEB568
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Sep 2023 19:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344272AbjIHTHf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Sep 2023 15:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbjIHTHU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Sep 2023 15:07:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B87180;
        Fri,  8 Sep 2023 12:07:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1264C43395;
        Fri,  8 Sep 2023 18:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197268;
        bh=N6TW+wJFKqGrMBbBiTie2FyrWAxCgOLtZEo9uIPYPF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W7IcCq8M0PEbLebjQ/iGgpL/SEDV+oRFoGIwVPmNCbFDtCaxx/V8mLzjGHmDkvLQs
         dnxGm3/934i+hLj4UQ95yUxd0TuHohbG+mEr4dZcCIJClQH3wZC2pjvodmGIJaoGRb
         jKTP4dukpTuuSp+hDyOHRkblh0QaevhEVuRjQxUOpj8FgK7u8Mg7BMUJBdChBi/nym
         yIcete/tTGx28R1IWPmhQHC3JgKSELKEwHIw8/HnQfB4oLD1lntkn/XdUesoVNJ5x1
         eUy8nxHWf5rHyMKtnMkjAXbwqPXiTYtAp1A7YIXB9th1YvtIVb9rQg/XXR25RhcejI
         +j67qoobljKmw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bastien Nocera <hadess@hadess.net>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 10/10] Bluetooth: btusb: Fix quirks table naming
Date:   Fri,  8 Sep 2023 14:20:44 -0400
Message-Id: <20230908182046.3460968-10-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908182046.3460968-1-sashal@kernel.org>
References: <20230908182046.3460968-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.256
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Bastien Nocera <hadess@hadess.net>

[ Upstream commit d831e3612111d385e8629104af5429808ef26e25 ]

The quirks table was named "blacklist_table" which isn't a good
description for that table as devices detected using it weren't ignored
by the driver.

Rename the table to match what it actually does.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 79f77315854f4..c766861b65573 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -170,7 +170,7 @@ static const struct usb_device_id btusb_table[] = {
 
 MODULE_DEVICE_TABLE(usb, btusb_table);
 
-static const struct usb_device_id blacklist_table[] = {
+static const struct usb_device_id quirks_table[] = {
 	/* CSR BlueCore devices */
 	{ USB_DEVICE(0x0a12, 0x0001), .driver_info = BTUSB_CSR },
 
@@ -3620,7 +3620,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (!id->driver_info) {
 		const struct usb_device_id *match;
 
-		match = usb_match_id(intf, blacklist_table);
+		match = usb_match_id(intf, quirks_table);
 		if (match)
 			id = match;
 	}
-- 
2.40.1

