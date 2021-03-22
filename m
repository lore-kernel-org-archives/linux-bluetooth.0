Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E848C433C1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 01:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27CA261944
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 01:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCVBBL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 Mar 2021 21:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhCVBBF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 Mar 2021 21:01:05 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB229C061574;
        Sun, 21 Mar 2021 18:01:04 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id cx5so7911586qvb.10;
        Sun, 21 Mar 2021 18:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n5P9MnMgzEhc4X4YhEwr2zl9SZ+jCJFUsF5LT3vR+xg=;
        b=hZVirO+FhaKGwKadBY3nNV43GUaG5aRFFtCGpJQYo/vA+di3WN0uK3ot9zPVHpmj9Y
         doO1oczoogt5uhBHlRfujr4oeVYIA8+uyNoW9crt+5RrXP9tHBzALnuup2uQ1LdupJLI
         ZotFvu5TCTHVJ/IORuR31VjetJDN3+lYfqam1st0jSgVOweP1CUKW6VXMBm0n0joH9pl
         G1p6HT8FOG0VW1lpOjZZP8uSGzM9TXAZkmZddDVF5SY0c67dqu1ExCwcV2/pa1zwnHZT
         +cpkIMghed77ljUhyzu9wfJzyjHOSVBVel4L+7qypsx8xGbe67y9JmdDqk3/ppMMpi0M
         5jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n5P9MnMgzEhc4X4YhEwr2zl9SZ+jCJFUsF5LT3vR+xg=;
        b=MU7BO4oblXCC+kvoxzAYK0OSSlM5wT6IDKyRUxbCIOf7rwVMMuwZv5scAwQ8VagKmA
         byUw+ohzQaaI5Kdvn0mOLVHCKU1FFXpTWSCWo3+F7PByw0AzR+ZdIefWW1ylBOWZgfXd
         HRE5b1f632HLX44WlSaxMKFnN2fOVnnlQPzh5jXaMuqcfZg0klYR63oheto0A1T6kdtd
         Zhd947oPN3qUDuaYtbHMgB4mmlGNBzQmHpaOGuRfJYmpeacB7Zh42LoDse0nHEhb8fhV
         5m6afIDGDhZZg3LV+ibQsqzk8s+kCODsDVmRVWfyhzI/LWBv80Q8AOPhOrV8RdAmFfxo
         0Lew==
X-Gm-Message-State: AOAM533DcXA25tgieCVA2Qdufr4FRTP7pYfHi36fWBf+B4/GAsImyyWK
        z118jmm2G2KoW5utqTA+QPN/bSscAjczbPYB
X-Google-Smtp-Source: ABdhPJwfogQzOjutwBTv9Czk26SXAL3887ylV/e9n/riDJr4EKsXGVVAz5IvSSDkf0KYjp4biIB7Kg==
X-Received: by 2002:ad4:560f:: with SMTP id ca15mr19265767qvb.42.1616374864178;
        Sun, 21 Mar 2021 18:01:04 -0700 (PDT)
Received: from localhost.localdomain ([156.146.54.190])
        by smtp.gmail.com with ESMTPSA id x1sm7919076qtr.97.2021.03.21.18.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 18:01:03 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] Bluetooth: hci_qca: Mundane typo fix
Date:   Mon, 22 Mar 2021 06:30:51 +0530
Message-Id: <20210322010051.483622-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


s/packat/packet/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/bluetooth/hci_qca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index de36af63e182..f2eee9112e41 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1066,7 +1066,7 @@ static void qca_controller_memdump(struct work_struct *work)
 		 * packets in the buffer.
 		 */
 		/* For QCA6390, controller does not lost packets but
-		 * sequence number field of packat sometimes has error
+		 * sequence number field of packet sometimes has error
 		 * bits, so skip this checking for missing packet.
 		 */
 		while ((seq_no > qca_memdump->current_seq_no + 1) &&
--
2.31.0

