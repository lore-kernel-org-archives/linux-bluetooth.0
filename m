Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671C2C636CA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Jul 2021 17:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C237613DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Jul 2021 17:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhGPSBR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Jul 2021 14:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhGPSBQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Jul 2021 14:01:16 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43285C06175F
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jul 2021 10:58:20 -0700 (PDT)
Received: from [192.168.1.195] (91-152-122-41.elisa-laajakaista.fi [91.152.122.41])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 6CDE41B0075B;
        Fri, 16 Jul 2021 20:58:17 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1626458297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UbcoVzo9J0hDBiwiFqraNEx6tbzJWEoryDRDUmfXOck=;
        b=AAD3VfwYFJSDZ8BJLGlGG+ScfTOUAhx2/78c8oCuhOjxZx8GNk3Ujmth7Bccr4MsBPiOK1
        SZSLaf8Su5dLbyPOCtm3UnSgsy9VtyJD4w0qqFhkxOQ31LsPeEr74Bp9ar4RjMbDJUP88c
        +ZRN7o/ALUyAf0MXgC2bbn2y7GiyqxudlvrS92GJYC5H1xvxKGzY3ul2WKFAqCVRomSv1h
        xzAk34EeJsBCo/R40gQULoSZpNaKPg8Ipk7C+yxFKb8CVinpateTB1oBuenTP8yr83JzQJ
        AHUwTEu4AZSKf7ph+GehTVZtLDrBD53RHIIazswlWDB9TuveXA58WD8njAvlQA==
Message-ID: <d43dffdc43a40782ec6d5d6c24b1638005992a8f.camel@iki.fi>
Subject: [PATCH] Bluetooth: btusb: check SCO MTU before enabling USB ALT 3
 for WBS
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Cc:     Hilda Wu <hildawu@realtek.com>
Date:   Fri, 16 Jul 2021 20:58:17 +0300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1626458297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UbcoVzo9J0hDBiwiFqraNEx6tbzJWEoryDRDUmfXOck=;
        b=FzdseXZquOw9LbCZ31m29ZQ/M2NVkw2FEkG+7RQcJZk0k3CxsljT2Yj/4QPN9Shch/Yiez
        fpWDbQ3+zerJQasW4AW9WTWuIa6VQbkz15psnIjc1OK/2BYe64Ea2TtuWZfMJy8MYobYsg
        9JJDYrjDxclf/cgo5WqrbVhbo/Yi/4gWrdH+BrlELH318HtUnb6bwVCYpj3ELyKKKm674G
        KO9rRc+N0uevBP+q7ttttl3xliudgCN3rRo2gqtCHql3MM/fOwlC9G2SgQ2Umvhu3/iFOH
        NK65CyEXhuiVCCPCl5Q83L5fuTQXeR1eFvJFhnF5yzmROzeV8SgtT3ifu+0PIQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1626458297; a=rsa-sha256;
        cv=none;
        b=MnIH+/bxBeE7V1CsftM7aZn+yJLXM4MPTn2c8UGhkMUknQ1XDQajeVBN4ul/lwnqq9BrOz
        1xUTO4NaBAfwyHo8ioG6zMxKdL53E7Aa39FQG6SAW0j49TXoO2a8rG/w8wy5s65Nmg6J7s
        mWTEv2Exayv4YjeDvsHyA0JSYRMqXjY/8dZaa8oI7N6ZJbIydDVDJnVvj1B3J4SuPHEL1q
        HHrkGmB6yEpV796f+9oWkqgI8fTD5dDC0551jCUwnXICGXlEHLZMbKP/o3IYK87SpGUYXD
        zj8w2S0mUr9toxmxCpgkhKo78G1hNaLQPli2rzlPTTnUX0WsSAFoDn5Q3d39cA==
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some USB BT adapters don't satisfy the MTU requirement mentioned in
commit e848dbd364ac ("Bluetooth: btusb: Add support USB ALT 3 for WBS")
and have ALT 3 setting that produces no/garbled audio. Check that the MTU
condition is satisfied, and fall back to ALT 1 if not.

Tested with USB adapters (mtu<72, produce sound only with ALT1)
BCM20702A1 0b05:17cb, CSR8510A10 0a12:0001, and (mtu>=72, ALT3)
RTL8761BU 0bda:8771, Intel AX200 8087:0029 (after disabling ALT6).

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 drivers/bluetooth/btusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a9855a2dd561..3ee66e415c4d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1763,9 +1763,11 @@ static void btusb_work(struct work_struct *work)
 			/* Because mSBC frames do not need to be aligned to the
 			 * SCO packet boundary. If support the Alt 3, use the
 			 * Alt 3 for HCI payload >= 60 Bytes let air packet
-			 * data satisfy 60 bytes.
+			 * data satisfy 60 bytes. USB Alt 3 support also needs
+			 * HFP transparent MTU >= 72 Bytes.
 			 */
-			if (new_alts == 1 && btusb_find_altsetting(data, 3))
+			if (new_alts == 1 && hdev->sco_mtu >= 72 &&
+			    btusb_find_altsetting(data, 3))
 				new_alts = 3;
 		}
 
-- 
2.31.1


