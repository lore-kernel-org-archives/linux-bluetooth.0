Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A505C47088
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 17:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA936101B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 17:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhEZRiD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 May 2021 13:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhEZRiB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 May 2021 13:38:01 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F84DC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 May 2021 10:36:30 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g24so1200113pji.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 May 2021 10:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W0xL/wAmB2zPBX9ms3ONNX4hzcZBWDkgv2/924oUi3c=;
        b=jAZlH3uT8PuIp/2oEVFg3EqLrlZNGEfE6INcfmp1PWE9GSZNvdJMcxyKaKMbfFwceC
         /vqD1J6C/b0c1FlKc+1KFVtdmg6HiF/1XEnq3wZgcK6XqXdF0ynY5E0KCdABAPDdQvua
         BuozTNakWslEdX1Of3LbPQwPy0LeaOzmiKF4SDJKZldELzphCXkl85+IHBNPDq0zvO/0
         udh09rdNMhBwsPULc5SAs/ejYwmV51Hyv4ksS2EnC9Qw5h6N88nOb1ZUoySqZ5tbROrO
         KgOFopmrzQDWrCdAy8L3abvA1Em6ACVhq0cZbKp3VERPqt3dpqNxmL1eolLyH2Nki97g
         NPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W0xL/wAmB2zPBX9ms3ONNX4hzcZBWDkgv2/924oUi3c=;
        b=YQek4xxRdfYO99x5UuvOK7eaoHieEv/848sSVdSp0k/5QcHhsrqOrDRpx3XxG8b4kK
         y0DusW4cLRa4XsUWlgmDL7MDopnKOWC+ZcgtouXyN51c88EC2WmibOGt6TY66tMrahE7
         r9QwdEyX2xGcRdkS37QuV2BnB2pJ9lBwaRUr1A7+E5o3LxcWcBdAevV+fkdXotUdTx97
         5w7/RLezYLsYG171mqgTwO6VQBoCfmDb20MChpTCaS39WvD1FLIB3m576Oc/BYfGo+Wq
         lQdQ+IGe3Yl+kMpc9bOr6ZyC6E3slmxWRCkT68hcDTM8V7vw6Mncl32BQBK0lsjxjbjk
         jr8A==
X-Gm-Message-State: AOAM532Ia4ciEBfQICsWVIa6brN6vInwzCUxF3uhWdKWywfGl3WoFOUL
        JfaoLAzhRvim9Lk2lrlAeYsO+9sNsnTO0A==
X-Google-Smtp-Source: ABdhPJzm2aH+alspi2S11MPhv4svtpgjzJ9sHLIFEJBQYN7cHKIKujR2QPw1570f+eTg9LisYd4TjQ==
X-Received: by 2002:a17:90a:5406:: with SMTP id z6mr35932161pjh.130.1622050587651;
        Wed, 26 May 2021 10:36:27 -0700 (PDT)
Received: from han1-mobl3.intel.com ([2601:1c0:6a01:d830::e853])
        by smtp.gmail.com with ESMTPSA id z5sm16187894pfa.172.2021.05.26.10.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 10:36:26 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH V2] Bluetooth: mgmt: Fix the command returns garbage parameter value
Date:   Wed, 26 May 2021 10:36:22 -0700
Message-Id: <20210526173622.444397-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

When the Get Device Flags command fails, it returns the error status
with the parameters filled with the garbage values. Although the
parameters are not used, it is better to fill with zero than the random
values.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 net/bluetooth/mgmt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b44e19c69c44..91d36c3bf23e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4061,6 +4061,8 @@ static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
+	memset(&rp, 0, sizeof(rp));
+
 	if (cp->addr.type == BDADDR_BREDR) {
 		br_params = hci_bdaddr_list_lookup_with_flags(&hdev->whitelist,
 							      &cp->addr.bdaddr,
-- 
2.26.3

