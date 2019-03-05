Return-Path: <SRS0=u2q6=RI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169F3C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Mar 2019 13:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE6720842
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Mar 2019 13:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="MZSxpKno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfCENQu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:16:50 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:36025 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfCENQu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Mar 2019 08:16:50 -0500
X-Greylist: delayed 375 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Mar 2019 08:16:49 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1551791808;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=527GXGoO1BeQ7cCjIV/JsCF7udm6w1ZF0BvOrr9Y4lM=;
        b=MZSxpKnoTEN4qK5DKJAdVIxnAYWEaejgKW+6FlCe/csp2c7IICmBVTwRqhLK+ikZf9
        wS6XqdCsAueQzTnFkWUTux+73Lts14kRAXcCsvPHC0wtO7MtPJRVh839MdkrtbrMKn5/
        0cdnFxVbbj5bjERHja9FpYDkg0fIUBj+3H/ppEiPmwF/6X1J6MSxuIC06aC28CXHK+qP
        r1Y3cdhG3DOuGJKS8W/PJOM7sDqyXpJP332jW92qEibjQVPxXdsmzf5h08t9EgtCVBEH
        Sw63QMBIBpaZ9ThsCaFL94IyVeQxLZjsRkgI55trENVwHmUhQCT/G+tdunjroZD8CG61
        DPCw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXtc7vtBpb4g=="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.13 AUTH)
        with ESMTPSA id i03afev25DAXg0d
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 5 Mar 2019 14:10:33 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 2/2] Bluetooth: btbcm: Add default address for BCM2076B1
Date:   Tue,  5 Mar 2019 14:09:01 +0100
Message-Id: <20190305130901.56660-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190305130901.56660-1-stephan@gerhold.net>
References: <20190305130901.56660-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

BCM2076B1 appears to use 20:76:A0:00:56:79 as default address.
This address is used by at least 5 devices with the AMPAK AP6476
module and is also suspicious because it starts with the chip name
2076 (followed by a different revision A0 for some reason).

Add it to the list of default addresses and leave it up to the
user to configure a valid one.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/bluetooth/btbcm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index ea1a20a49f91..35394076267b 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -34,6 +34,7 @@
 
 #define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00}})
 #define BDADDR_BCM20702A1 (&(bdaddr_t) {{0x00, 0x00, 0xa0, 0x02, 0x70, 0x20}})
+#define BDADDR_BCM2076B1 (&(bdaddr_t) {{0x79, 0x56, 0x00, 0xa0, 0x76, 0x20}})
 #define BDADDR_BCM43430A0 (&(bdaddr_t) {{0xac, 0x1f, 0x12, 0xa0, 0x43, 0x43}})
 #define BDADDR_BCM4324B3 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb3, 0x24, 0x43}})
 #define BDADDR_BCM4330B1 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb1, 0x30, 0x43}})
@@ -69,6 +70,9 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 	 * The address 20:70:02:A0:00:00 indicates a BCM20702A1 controller
 	 * with no configured address.
 	 *
+	 * The address 20:76:A0:00:56:79 indicates a BCM2076B1 controller
+	 * with no configured address.
+	 *
 	 * The address 43:24:B3:00:00:00 indicates a BCM4324B3 controller
 	 * with waiting for configuration state.
 	 *
@@ -80,6 +84,7 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 	 */
 	if (!bacmp(&bda->bdaddr, BDADDR_BCM20702A0) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM20702A1) ||
+	    !bacmp(&bda->bdaddr, BDADDR_BCM2076B1) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM4324B3) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM4330B1) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM43430A0)) {
-- 
2.21.0

