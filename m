Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC775C433E6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Mar 2021 22:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B305E64FB9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Mar 2021 22:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbhCJWNV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Mar 2021 17:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbhCJWNN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Mar 2021 17:13:13 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272BDC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Mar 2021 14:13:13 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so8292995pjb.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Mar 2021 14:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=evtDg3M5EU3d72r7Ou75psLgErjX79HLHfdQlJbHcVw=;
        b=pszqurzo9NXSGYZWiegpZ71h4dx+N8odDu21f++ti1rNP8br4I3HezSr0FQZpWHiKS
         CUQHqAe6mOtLCJlvmhH3htLkaqkM8GzGO05s12FSmt+Ot3vNmroqyS5qwyiSzGL8Ktma
         aoBkQg4QKBFuETg7T42POVq8/w792tvm9ZZsrV6Cg++LZHgq2kDUcEca+Tox1DG6qkdc
         20eFdJLIgvY2fiVX+hqZ+Et5Foy//a1xs47js5Gayyh1sOCuMTrZV+CfAwSGscQbZMio
         FhAo5MR9Oyc/5eyxWbr6obvoV1Stg8ZWm/xOAji7xBNXxpYoJnt07iPr885safVO7Lhs
         BmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=evtDg3M5EU3d72r7Ou75psLgErjX79HLHfdQlJbHcVw=;
        b=mcuiHWs/Em/jOopSQmuZs7aDZHqBPt0GnBN7s8TVF0cTWqgE3DAzsSyr6TeSZECm02
         KmRH6crApAEH6nQS2bafxxvdQdYK4Cax/6Pn6XU4F/p03phgbRDdQKJG2qzaHkHlG8Nz
         N2oPQZzAfA8AOG0ZTd/lzVyq3J0oHTSa6xDREYpYr7LbR0XyQw58LwQ47riB3tbtmEG4
         NnJ7E2KE43wHolHfU9415tgSB55oVsfnc0ZLcsbezixnrqNq3fcLIIcxkV3EfValqUh+
         am7Wqi3ppqKQtAcquQT9Uvny7UBMgeTmxA+F3DyqwmsdypzccP7nBy0JDJJ8xN6pMaBu
         sYXA==
X-Gm-Message-State: AOAM532MLMKZpoCM0bLKTfFpOifoh6NdPqMfLEZYyPMjGQp3Z8BILKWa
        FXenf3zs8MorgCRhDEtsWr4YMZp+aOEiag==
X-Google-Smtp-Source: ABdhPJxuUlFRdt1NDFfSe6KevRfxZ/6E8El90vp1cN8zAbH5Npq4O0zCaB5NgDqQwlKbRD4gDpmlRA==
X-Received: by 2002:a17:902:9304:b029:e4:12f4:bdb0 with SMTP id bc4-20020a1709029304b02900e412f4bdb0mr5118216plb.55.1615414392492;
        Wed, 10 Mar 2021 14:13:12 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id c24sm324781pjv.18.2021.03.10.14.13.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:13:12 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: SMP: Fail if remote and local public keys are identical
Date:   Wed, 10 Mar 2021 14:13:08 -0800
Message-Id: <20210310221309.894602-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fails the pairing procedure when both remote and local non-debug
public keys are identical.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Use crypto_memneq instead of memcmp and add a patch converting the use of
BT_ERR/BT_DBG to bt_dev_err/bt_dev_dbg.

 net/bluetooth/smp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b0c1ee110eff..e03cc284161c 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2732,6 +2732,15 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*key))
 		return SMP_INVALID_PARAMS;
 
+	/* Check if remote and local public keys are the same and debug key is
+	 * not in use.
+	 */
+	if (!test_bit(SMP_FLAG_DEBUG_KEY, &smp->flags) &&
+	    !crypto_memneq(key, smp->local_pk, 64)) {
+		bt_dev_err(hdev, "Remote and local public keys are identical");
+		return SMP_UNSPECIFIED;
+	}
+
 	memcpy(smp->remote_pk, key, 64);
 
 	if (test_bit(SMP_FLAG_REMOTE_OOB, &smp->flags)) {
-- 
2.29.2

