Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FA4C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 22:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3FB720B80
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 22:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d+NB92zi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgFPW45 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jun 2020 18:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgFPW44 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jun 2020 18:56:56 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C714C061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 15:56:56 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id d4so285551pgk.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 15:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CdHyWq/MfAuzSAG7Mf8tf08IXfZGy0e5RAYSXPj9atg=;
        b=d+NB92zi75DKJkiL/hlcU/PZNamGnRf3orr+CawWEnmjKp3tntfwmq8Dq1QIkmzMbn
         xPjsCWIDbMmiCBZA5kTPp+nx92Agoi/8WkCjrMpZafb+JEr7ZnnYH4gLcLsCBN+ZnplO
         93IIuqsWP+1ps6z4AJFCkZzHArwgzCyXCC2fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CdHyWq/MfAuzSAG7Mf8tf08IXfZGy0e5RAYSXPj9atg=;
        b=n4tlGXpZIB64qf/4U9yCAl8NaakGnuBefdAzKuRXGvH1fYH2/KvNicpMfiv5dyd5/F
         u9CKsUgZGN1xLhcItwxFCDL1XgfaWeGobIG7svK2+FE4AUjXsvZ2LGBC5RLATydE56iv
         IfLW5IbuqFtSbqdWRKd2QcftDj8PT6dPMXKFMd9l9bV+CF2jsxLCLQH3SmFNw5DT4HM2
         T9Ze9JxE7CKKRP8FK5e+m49sNzJYMP/nkXWPwYnCVy1e+on1tmNjZ6PdWkrzx/ivyFe2
         yO4YoKdxUwAH6LivIl9POSGLz+5Z3VOwgD3/1xGoeH1OIbZbJMhqVk9SWCzvNMu1ZtbP
         LtTg==
X-Gm-Message-State: AOAM531bEVxGM8otEM93WJ4nOvrRy5CteHK+BfSrO+wnHWpI3/ZjTHhK
        oMQmGd9psEAg5YHb/5YHDrpZMGy3jMs=
X-Google-Smtp-Source: ABdhPJz4vktZsxj2YLU2Fci/GZMQso11G/G45P4jx1/QRvyJtubW6M8zwvjPA7vppr1lFGo95DuZqg==
X-Received: by 2002:a65:458e:: with SMTP id o14mr3598356pgq.87.1592348215420;
        Tue, 16 Jun 2020 15:56:55 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id k11sm3460269pjs.9.2020.06.16.15.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 15:56:54 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v1] lib: Correct the string for a mgmt op
Date:   Tue, 16 Jun 2020 15:56:50 -0700
Message-Id: <20200616155641.BlueZ.v1.1.I5d071a56cb3a8d3640abf7c41d96e8233f14f8e6@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This corrects the string of MGMT_OP_ADD_ADV_PATTERNS_MONITOR to match
mgmt-api.txt.
---

 lib/mgmt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index bb31156ab..fad1f3dfe 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -1008,7 +1008,7 @@ static const char *mgmt_op[] = {
 	"Read Default System Configuration",
 	"Set Default System Configuration",
 	"Read Advertisement Monitor Features",
-	"Add Advertisement Monitor",
+	"Add Advertisement Patterns Monitor",
 	"Remove Advertisement Monitor",
 };
 
-- 
2.26.2

