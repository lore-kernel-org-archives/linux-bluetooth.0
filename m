Return-Path: <SRS0=tHDW=ZJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D0CC432C0
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Nov 2019 20:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F034420730
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Nov 2019 20:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="k96wiDVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfKQUxD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 17 Nov 2019 15:53:03 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21]:23484 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfKQUxD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 17 Nov 2019 15:53:03 -0500
X-Greylist: delayed 360 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Nov 2019 15:53:02 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574023981;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=q1SlCqcYNA8v4afPgFyelT/M3Fbh/mLrgWCv7EiA/Sg=;
        b=k96wiDVqKZ9ZhRpHe1em6K7oNnH7Godwl23YxTzD0DKlzMs7HIzIYr6k04UDODDryt
        zm+33BzoOWGDyg8rdYUamuByNmXp54ro/o1PjRvtWpqnUxE7CZnK3vQdm0rSRxDTr98c
        l6G+NQs0TDv/Yv67auDBKN/fT9xXAiJ5gE28lFnsMxwWk1IqCivS+mPRdE8lXEldo3AQ
        bc0txoJvjdP5djzsd1mTIzAzevjYoKMyEsl8WKbOjLeHDUxp49ry+d+pixWXzXbTPnlU
        MOD9nB3o8a9lG8a93YEYnDW5QjRP3HM8wNM6MJrrj+QuBEVsiOLYxoxra4YrxCQBdi5s
        NzVg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXsMvvtBRRPA=="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vAHKexb1p
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 17 Nov 2019 21:40:59 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH] Bluetooth: btbcm: Add entry for BCM4334B0 UART Bluetooth
Date:   Sun, 17 Nov 2019 21:39:46 +0100
Message-Id: <20191117203946.233900-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the device ID for the WiFi/BT/FM combo chip BCM4334 (rev B0).

The chip seems to use 43:34:b0:00:00:00 as default address,
so add it to the list of default addresses and leave it up
to the user to configure a valid one.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/bluetooth/btbcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 2d2e6d862068..0bb9023ec214 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -23,6 +23,7 @@
 #define BDADDR_BCM43430A0 (&(bdaddr_t) {{0xac, 0x1f, 0x12, 0xa0, 0x43, 0x43}})
 #define BDADDR_BCM4324B3 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb3, 0x24, 0x43}})
 #define BDADDR_BCM4330B1 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb1, 0x30, 0x43}})
+#define BDADDR_BCM4334B0 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb0, 0x34, 0x43}})
 #define BDADDR_BCM4345C5 (&(bdaddr_t) {{0xac, 0x1f, 0x00, 0xc5, 0x45, 0x43}})
 #define BDADDR_BCM43341B (&(bdaddr_t) {{0xac, 0x1f, 0x00, 0x1b, 0x34, 0x43}})
 
@@ -74,6 +75,7 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 	    !bacmp(&bda->bdaddr, BDADDR_BCM2076B1) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM4324B3) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM4330B1) ||
+	    !bacmp(&bda->bdaddr, BDADDR_BCM4334B0) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM4345C5) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM43430A0) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM43341B)) {
@@ -326,6 +328,7 @@ struct bcm_subver_table {
 
 static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x4103, "BCM4330B1"	},	/* 002.001.003 */
+	{ 0x410d, "BCM4334B0"	},	/* 002.001.013 */
 	{ 0x410e, "BCM43341B0"	},	/* 002.001.014 */
 	{ 0x4204, "BCM2076B1"	},	/* 002.002.004 */
 	{ 0x4406, "BCM4324B3"	},	/* 002.004.006 */
-- 
2.23.0

