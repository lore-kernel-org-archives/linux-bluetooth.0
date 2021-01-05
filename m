Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91C8C433E9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jan 2021 16:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7747E22CA1
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jan 2021 16:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbhAEQLj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Jan 2021 11:11:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:38466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbhAEQLj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Jan 2021 11:11:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41FE322C9E;
        Tue,  5 Jan 2021 16:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609863059;
        bh=sd/ij6Y2ELBRm6tt18pXSxggzb03Ef8UOfolC0SvHLc=;
        h=From:To:Cc:Subject:Date:From;
        b=ThW61h1hBI7ZOucXXqlA/IpA3DwfyO2kKyHXRJDtlqGXaq5kAxo4jsnUqCl7omUJe
         FNt1fr5wmzoqe0xXxI0drIpWtJdSGtdv/2ab1wSJS7fpkFdCU/4+K7RUDDURviyBNT
         SZZ0JlbpGdwWdD73zAqkIIdQ3dUJiKHpdlDflfr6Kerf/7KCE6PsCemkp8cqQOCH+8
         QQp95qwxgNRLOrQwjLhGCjZyq7jDMyEf5zAMx0IRBdErbDPssaSvYeJyTKZD/a7wQ7
         fVRjKEpNiobFGGJ/SDSR14MAcAEAbPWwHLGXSgF8nG7YRO51wXIIHxWlrYwsPdjCU/
         fdtF70erMkdsQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] Bluetooth: avoid u128_xor() on potentially misaligned inputs
Date:   Tue,  5 Jan 2021 17:10:53 +0100
Message-Id: <20210105161053.6642-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

u128_xor() takes pointers to quantities that are assumed to be at least
64-bit aligned, which is not guaranteed to be the case in the smp_c1()
routine. So switch to crypto_xor() instead.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 net/bluetooth/smp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index c659c464f7ca..b0c1ee110eff 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -25,7 +25,6 @@
 #include <linux/crypto.h>
 #include <crypto/aes.h>
 #include <crypto/algapi.h>
-#include <crypto/b128ops.h>
 #include <crypto/hash.h>
 #include <crypto/kpp.h>
 
@@ -425,7 +424,7 @@ static int smp_c1(const u8 k[16],
 	SMP_DBG("p1 %16phN", p1);
 
 	/* res = r XOR p1 */
-	u128_xor((u128 *) res, (u128 *) r, (u128 *) p1);
+	crypto_xor_cpy(res, r, p1, sizeof(p1));
 
 	/* res = e(k, res) */
 	err = smp_e(k, res);
@@ -442,7 +441,7 @@ static int smp_c1(const u8 k[16],
 	SMP_DBG("p2 %16phN", p2);
 
 	/* res = res XOR p2 */
-	u128_xor((u128 *) res, (u128 *) res, (u128 *) p2);
+	crypto_xor(res, p2, sizeof(p2));
 
 	/* res = e(k, res) */
 	err = smp_e(k, res);
-- 
2.17.1

