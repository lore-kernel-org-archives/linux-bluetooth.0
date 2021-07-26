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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FDBC4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jul 2021 20:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43FFB60F9B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jul 2021 20:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhGZTmO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Jul 2021 15:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhGZTmN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Jul 2021 15:42:13 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08055C061757
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jul 2021 13:22:41 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c11so13020870plg.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jul 2021 13:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YmhQ3VIwX/2HSA13XFQJ4Scf5Hrs2vzXcuk2eRLwD1Y=;
        b=D09cpCdVzt0TahvmeOuIiNfp0IaMGJWP8XF/OYr/b4GoTi9P+qIYzP3h34dZsfow46
         GYJX/eqNdsEzOZ3Ouj/u5EfvioPsnf3rAEpwg0xL4c2qC5seMYkqY8UBdY76K/uyJGDJ
         JtXqOV8aXy0jcGC4RKwUSYYlI0lKddcEw/MNPtI+isMT+qi3cljm264SwjL6b78kES0G
         d1h/ghWmb3PfxeFzS95Xk1Rh3jI4l2PDqUKa2/MXVJMYxJQViQilChaBu18YvKa2UsFd
         ojFd3XDSyUo/GUBsCEOTxb2WFBzki2xoddDFHSlkhihcMahcCVuLckp6Qel9/MVz8CMP
         CvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YmhQ3VIwX/2HSA13XFQJ4Scf5Hrs2vzXcuk2eRLwD1Y=;
        b=Rn2MgHkc7w3AWhWx3M0p+GH1FRoTvmn2bleQ2dJ9KJvc6KwHCoS17g+A1I+uFnOxTx
         n52Ms1Yf2g2P90CFWYG0SSK9d5mreIHNeuY0gaS8PCXeigVFshb6Em0KEntxfI7PHeJ+
         DzDizPdcafKkUdtjd0rrauZ/fsCszdgE4bh7N3v1X4LwpUgqE9+KqxNbQfHyGamS2Jil
         VXygl58lmnOtDi3vb8v79VAu69ekQCDvDsLEPhlO2beKtQOaE8hTBTwShjPezjRBB5gv
         liO1C4OsFn3JJXSzv0M9cYkSK+DyuZggKraasuQNwZdeZgEaRSrGy1Bk3UKcg42I+EeC
         tGeA==
X-Gm-Message-State: AOAM530NAnbqSrsg6kbIqEkqe0cdMn5qVXBeBfYXsBlB85/8aRd2OWs2
        /OWef4MKobSkL9Pi8EQqCOw/ZOyka5A=
X-Google-Smtp-Source: ABdhPJxkNtRN4FG3XEV3jV1GyqCf/Y09aoWR6BrY36CFlmWLcYCxbMCppRsLI9BoGrrGkGaGmFXhqg==
X-Received: by 2002:a62:1982:0:b029:356:3484:b7ec with SMTP id 124-20020a6219820000b02903563484b7ecmr19798174pfz.48.1627330960347;
        Mon, 26 Jul 2021 13:22:40 -0700 (PDT)
Received: from han1-mobl3.intel.com ([2601:1c0:6a01:d830::7cb2])
        by smtp.gmail.com with ESMTPSA id j3sm924526pfe.98.2021.07.26.13.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 13:22:39 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH] Bluetooth: mgmt: Fix wrong opcode in the response for add_adv cmd
Date:   Mon, 26 Jul 2021 13:22:36 -0700
Message-Id: <20210726202236.136598-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the MGMT add_advertising command repsones with the
wrong opcode when it is trying to return the not supported error.

Fixes: cbbdfa6f33198 ("Bluetooth: Enable controller RPA resolution using Experimental feature")
Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3663f880df11..1e21e014efd2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7725,7 +7725,7 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	 * advertising.
 	 */
 	if (hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
-		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 				       MGMT_STATUS_NOT_SUPPORTED);
 
 	if (cp->instance < 1 || cp->instance > hdev->le_num_of_adv_sets)
-- 
2.26.3

