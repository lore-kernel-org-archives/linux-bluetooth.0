Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C3EEEB569
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Sep 2023 18:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244347AbjIHSXm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Sep 2023 14:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243659AbjIHSWA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Sep 2023 14:22:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683C030FA;
        Fri,  8 Sep 2023 11:19:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB80C433B6;
        Fri,  8 Sep 2023 18:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197157;
        bh=Ik9/QVGVg+jXasKtm7EkVsxi7Ehspun5iSq48dMCjaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d4+27uZhPKFuFdbm6dDXrhyc2XQS/QssFF+43cN5uotznNUXqn9oMEEVoqP6WK3PK
         E+/ISkEAuMUxPi3OSVqpetVmkO8ma82Ex3jbGc3CGz9kzOAn0HcqdS7e4UbgyPJ5ui
         IifenxZe3jSe/ADyXaIhmhaO1hBIAZEsryhsTkA8HqkmC/fk/f1TH3ZFHrz8WAipWf
         GjPfqtm+G1i+9U52cuZ/93DochsND2A3fOzI/vduqva5M6507kCjxmQP9XnGLnTS0L
         OoaktXs8nSYf+FROCbGp0b6vkd1lz/tMV7UVCq6y1BGIDwPzUws50p6gFDRFhlfZXq
         8hjZumQh6JDbw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bastien Nocera <hadess@hadess.net>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 26/26] Bluetooth: btusb: Fix quirks table naming
Date:   Fri,  8 Sep 2023 14:18:04 -0400
Message-Id: <20230908181806.3460164-26-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181806.3460164-1-sashal@kernel.org>
References: <20230908181806.3460164-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
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
index d6f405763c56f..7bb774457e129 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -174,7 +174,7 @@ static const struct usb_device_id btusb_table[] = {
 
 MODULE_DEVICE_TABLE(usb, btusb_table);
 
-static const struct usb_device_id blacklist_table[] = {
+static const struct usb_device_id quirks_table[] = {
 	/* CSR BlueCore devices */
 	{ USB_DEVICE(0x0a12, 0x0001), .driver_info = BTUSB_CSR },
 
@@ -3767,7 +3767,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (!id->driver_info) {
 		const struct usb_device_id *match;
 
-		match = usb_match_id(intf, blacklist_table);
+		match = usb_match_id(intf, quirks_table);
 		if (match)
 			id = match;
 	}
-- 
2.40.1

