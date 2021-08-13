Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45F9C4320E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B600460F46
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240467AbhHMMWB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240473AbhHMMWA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:22:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E498C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f3-20020a25cf030000b029055a2303fc2dso9025479ybg.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=m6PNpVn9SnFo5vrFodpmglO6Nfvo+NAI8KogPbsCQck=;
        b=qZn/SwIbhFwSPnZ3O04tW8EGeuN5wJHazJ1NdOMSS0zrI1rj0YYAb2XUeA3qqDianU
         /V06/06K1/FRwfU843sOXQGGhWKh6l4qlDC4sqP1kxK210w8zdcylNciNRvGHWWHTRpK
         Ggo1g5jXoK05tmwnfbv+fP/czOVRqVS53BV38n7Y3Cs8UhSqiDLdcb/zCnMNV2MHbxne
         gc6iGUFxuCkaby0XL9X++Blyfp2F4WWqZpmkZasKzbx17ZaS5FLdaAiP/tPcWWj0XoB9
         rXNRwgcfiiEuib5VFJP+9MjQ9K4Y3ZEEC7Y8COaT5Nrl3t350l7cOZssKvYZhHlmmRSA
         6txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m6PNpVn9SnFo5vrFodpmglO6Nfvo+NAI8KogPbsCQck=;
        b=IoNSrzwvSVxryXQfT7bodfi8CTpjLrNSS+vFnuGpTnY9ito/FobpvxL6DuPS5ZeYFo
         EpDO2xOWDMMUsoT5F4Dra+JUGrsZXIHGkpFKBDTuRX650KZla55QBxQMW7MJEbeMKPeh
         qkYaOaETL2/mNr6I/DVdgwetDvzpcfOjy7nVRZYvjb+KDfvUauW3zn/pZnzAoeyJVw6R
         p3PRUQnos8TzREYZTAEyeE8h327bmSN2L+k0x7ps14YmDYVG5hQHzMUFHgUGb4tRxaP/
         na2cpl/xvck2H6etx8KJkNzCSxAeyirgSK1EAEaSYRE62DfYGPFn+hPhX7wCkzZi2FIr
         Zc7w==
X-Gm-Message-State: AOAM532QBZJT8yY/+DMaFYOM2ERLIAchXl8S1fnV/60CRa37Ph003nbW
        ibh5wgc8ggLluZk5WdosnkQamrQ5DKnKZWL1i/aiVpY6Oml6DmZWLLx0DWCbhrau8wlYM2IeQZY
        BTQ7lA3jrP+VzZtnMAwrnoA1vnAszF6scU6qoYCl7oG3dRqRWCVrVskByi4TN5ALvTuvQyxviS7
        rG
X-Google-Smtp-Source: ABdhPJzhG3nh8m3vVBR/hCsC0dw6fJoGhcEGhcj8LfKzxKRiSjk1l1+w1wr627Ib2FnfMYUsL0f/O5EXPsS4
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a25:ef04:: with SMTP id
 g4mr2482227ybd.287.1628857293298; Fri, 13 Aug 2021 05:21:33 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:17 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.32.I8ac883404f7e143bba977d10f1657eaf8096af31@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 32/62] tools/mgmt-tester: Inclusive language changes
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"central" and "peripheral" are the preferred terms, as reflected in
the BT core spec 5.3.
---

 tools/oobtest.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/oobtest.c b/tools/oobtest.c
index 0368bc3865..eed765af02 100644
--- a/tools/oobtest.c
+++ b/tools/oobtest.c
@@ -134,15 +134,15 @@ static void new_long_term_key_event(uint16_t index, uint16_t len,
 	switch (ev->key.type) {
 	case 0x00:
 		if (ev->key.central)
-			type = "Unauthenticated, Master";
+			type = "Unauthenticated, Central";
 		else
-			type = "Unauthenticated, Slave";
+			type = "Unauthenticated, Peripheral";
 		break;
 	case 0x01:
 		if (ev->key.central)
-			type = "Authenticated, Master";
+			type = "Authenticated, Central";
 		else
-			type = "Authenticated, Slave";
+			type = "Authenticated, Peripheral";
 		break;
 	case 0x02:
 		type = "Unauthenticated, P-256";
-- 
2.33.0.rc1.237.g0d66db33f3-goog

