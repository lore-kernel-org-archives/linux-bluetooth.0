Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEACC433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 22:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E9BD64FF9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 22:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhCDWYx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Mar 2021 17:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhCDWYw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Mar 2021 17:24:52 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC3FC061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Mar 2021 14:24:52 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l18so118469pji.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Mar 2021 14:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zd0CUtnUGTUkgYWBpU6n0FzYrvZVG1GH7hWd1gmIK5k=;
        b=cZUwITLvH+u1cKULdaiikyYDPFecNFFz3g6ZJBLrQHzeT7qR3cM8QL6YrmDqdJtL0f
         sGv55mBKRfQ/Sd/piGURzmUxQZEPyy6FPYvAuTgmWlFEPMXnHJSil5uqmnmzM6+8+jfZ
         ncpHHMTTKiGaC1toQ/ro5Vn9Rj8wnaowFuMJYfpj5Pn6YXgct7BrdkpHM3Rw/PNF14kt
         hMSwXnT32qsGrZbvNqwzTVUGhaSZnigM9SMFLW1tFB4U+91pJg0dmnLHjtYQkdP3T14o
         UH66wo/i6w95nf4CZMO1ij85XU1GPIDDCXPES6fQvub8TgTFl1vpw/76INgHEO0r+BsE
         Jjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zd0CUtnUGTUkgYWBpU6n0FzYrvZVG1GH7hWd1gmIK5k=;
        b=GpTzSxufPKhvXXbqprVO/QERpyfL+WCfyfH3oeMgGphTsfik2lXq8N8voCey+L+66K
         S4rMHxKbXr44qtuAkd2gROG2bpn3oQu4dVQm3KA2/pkyYcK9VzOKygk8J1LO+m/d0hhu
         Hq4qBrFFJqZfeOCfAcvI4fSsz43gwZd2v5vNNoPNJviZtzAx2EuzESo2a7ZUPvQSRRRP
         C+zkH2poYLqoLUdzs/5vB7umPIV3LLSrxxDhUiNziz0cDftGjs/YUBJGmivPAP6Abqx4
         AxzCNxAegjEq6dXrrWE0aXcLw+88qgv48VAs1LLMVpuMgxTJ+5z7aIFVHA8lCRQ6Op+V
         7WHQ==
X-Gm-Message-State: AOAM532CdVDbT8HeTL+Mf/IUePAFR0y46mTycYruDmkDEiMtGMCFFlEL
        LTxGoq1lqMJ3WqZkWnO2cS8M9Ole4eOFKg==
X-Google-Smtp-Source: ABdhPJxFj9+iINWynPuPVOl4l2MeJrAsr5SMgJxBxUrB94YbLPyw2pkqVG9l97SAIvLBTVba32vkHw==
X-Received: by 2002:a17:90a:8b02:: with SMTP id y2mr6625947pjn.111.1614896691687;
        Thu, 04 Mar 2021 14:24:51 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 71sm196691pfu.82.2021.03.04.14.24.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 14:24:51 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] adapter: Fix not using the correct setting
Date:   Thu,  4 Mar 2021 14:24:47 -0800
Message-Id: <20210304222448.3769100-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

set_mode shall use opcode to identify what setting are being changed
rather then the mode.
---
 src/adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 051c32753..f483cc827 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -631,7 +631,7 @@ static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
 	memset(&cp, 0, sizeof(cp));
 	cp.val = mode;
 
-	switch (mode) {
+	switch (opcode) {
 	case MGMT_OP_SET_POWERED:
 		setting = MGMT_SETTING_POWERED;
 		break;
-- 
2.29.2

