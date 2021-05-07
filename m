Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FDAC433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 00:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEBC36101D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 00:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbhEGA5f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 May 2021 20:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbhEGA5e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 May 2021 20:57:34 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865C2C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 May 2021 17:56:33 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id m12so5956350pgr.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 May 2021 17:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jw1qRXyeIMOZFjf3Rqh0MQrUITmwJBIMdkk5++Lv+nA=;
        b=TUuGgyjDG4uWMyqffUaSMJNgdREWV4/5/ORikZcxo2Bv9NQJMLkcCmYbMtC+s9ed50
         sFH8xy1C8iCNN/UgldG/9lcKM84flxOrthg+PqSFWwVIgfZo0yeKOf1wQaYkW7FwgVXC
         IafX4YHGacMKTfaInTyMKR5UkmZ8WmhmXrnknUvYxdon4JSJQDpdZ/pjr/f44hYdDZHS
         cunFHYwknQeW3qQsM5p8NTQpQjB3m+vXOF1zX4s0lA5/5C3bAFKO9+2yc14LdSq8RLJH
         cgd5f81U31hrjvMMt1sHFS5LiYv+7vxmvfdWmm5cDH+tVqkGupf1XBxmBp+ebIYGN5DR
         epgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jw1qRXyeIMOZFjf3Rqh0MQrUITmwJBIMdkk5++Lv+nA=;
        b=gjPozqipsmGDg81T9ACVIJ62gegn2W73vI7pvU3SKcrXFRyuT4TsoSGRQx+1tndKMU
         sYeWi8pirddrwt05+QO5oJTe5sy548yjFy6QuA2zytsQEUcYkMSGT/WwU4n8kRyacmqY
         AADPcykMTio7Uf8UHjtoGArgqy0xTYNq4HYuNnqKa9L+bG0mGdJLcdicUc1sk5BvCcxO
         xfwdzeWKN1zoaDoTln/Dt/kUYuTj/wwu+I4oFazu2qHERrxWE8yQNBcZZOrcnwv6Ib39
         BUxxQd9aDcsrRyuLN3FRNaIjHG8YpGDnAML7XXibB9mo8FHNA1nIEV65/x5iCgQF3/sY
         L67A==
X-Gm-Message-State: AOAM533hSMgaPNPiAToKe1W4nAESQ4ue8hBuXh46gnOLZaYrp73n17om
        zzENvcPljkVPDk696xTjj++NwT+rdExIAg==
X-Google-Smtp-Source: ABdhPJxMxEbvpPZQIqzrI27oTRDGlFQFDaagYLAciNuPIrkdJAuEDNwxM4d5utsDdw1+lRa+0Kk4qA==
X-Received: by 2002:a63:1e1e:: with SMTP id e30mr7034790pge.77.1620348992117;
        Thu, 06 May 2021 17:56:32 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::f7ee])
        by smtp.gmail.com with ESMTPSA id x6sm3067123pfu.120.2021.05.06.17.56.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 17:56:31 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] monitor: Remove Pygments dependency from manpage
Date:   Thu,  6 May 2021 17:56:30 -0700
Message-Id: <20210507005630.1231205-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch removes the Pygments dependency from btmon .rst file.
When the code-block type is specified, the rst2man throws a warning
asking for Pygments package.
---
 monitor/btmon.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor/btmon.rst b/monitor/btmon.rst
index c59fdde62..0ab13eb2e 100644
--- a/monitor/btmon.rst
+++ b/monitor/btmon.rst
@@ -148,14 +148,14 @@ EXAMPLES
 Capture the traces from hci0 to hcidump.log file
 ------------------------------------------------
 
-.. code-block:: bash
+.. code-block::
 
    $ btmon -i hci0 -w hcidump.log
 
 Open the trace file
 -------------------
 
-.. code-block:: bash
+.. code-block::
 
    $ btmon -r hcidump.log
 
-- 
2.26.3

