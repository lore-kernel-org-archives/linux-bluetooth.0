Return-Path: <SRS0=u2q6=RI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457C0C00319
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Mar 2019 13:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5D820848
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Mar 2019 13:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="hwYEDzCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfCENQv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:16:51 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:32642 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbfCENQv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Mar 2019 08:16:51 -0500
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Mar 2019 08:16:50 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1551791809;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=dH4kIXgnTkS8o4oIUiqCoA5Rl8wlM/9ovypb0u7z+Zw=;
        b=hwYEDzCU9I2TBosS2qlfLmuPPTHPxfEQoVr34fKgSunb7+8nSOjAQseRFSiDlCTiUo
        ZIDjgtxqlSB5iWle1aWejpLnJv/hJ01WNJD6XU8YvhoONvNJIODjSDyiQUn7zmZ3aKew
        U1lqNFF8TuSTzy9zKt5Tg8fA+G+txzJN62thCdoIoPSAl/idt6ak3Ls6f8m6TgAXZraN
        Heghn7TWcE2M/b3rpmrFnFOEmPO674UJDRcc0Ab9BiR4BKY7whQdSn8Pam721reWkp6R
        gs/e12wMFmdmHkNulmdtJzgg9kGzahRASGEsP2UmsfZ2Lw59+zi8ojriw64nRSJ5eRND
        Vc5g==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXtc7vtBpb4g=="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.13 AUTH)
        with ESMTPSA id i03afev25DATg0b
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 5 Mar 2019 14:10:29 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 1/2] Bluetooth: btbcm: Add entry for BCM2076B1 UART Bluetooth
Date:   Tue,  5 Mar 2019 14:09:00 +0100
Message-Id: <20190305130901.56660-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the device ID for the BT/FM/GPS combo chip BCM2076 (rev B1)
used in the AMPAK AP6476 WiFi/BT/FM/GPS module.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/bluetooth/btbcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index d5d6e6e5da3b..ea1a20a49f91 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -333,6 +333,7 @@ struct bcm_subver_table {
 static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x4103, "BCM4330B1"	},	/* 002.001.003 */
 	{ 0x410e, "BCM43341B0"	},	/* 002.001.014 */
+	{ 0x4204, "BCM2076B1"	},	/* 002.002.004 */
 	{ 0x4406, "BCM4324B3"	},	/* 002.004.006 */
 	{ 0x6109, "BCM4335C0"	},	/* 003.001.009 */
 	{ 0x610c, "BCM4354"	},	/* 003.001.012 */
-- 
2.21.0

