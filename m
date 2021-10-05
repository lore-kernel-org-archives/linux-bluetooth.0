Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CC7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Oct 2021 01:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F854613AC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Oct 2021 01:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbhJEBMG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Oct 2021 21:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhJEBMF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Oct 2021 21:12:05 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE41C061745
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Oct 2021 18:10:16 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 75so18253614pga.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Oct 2021 18:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Evc8LcD4TtrYEx4kHuvGKjEcl3Q5NYJf75iDzkjNm9w=;
        b=ljXhc6WRpf0CzDZXpkop60ppcx/r/W2oqyhd+HpZuQqkt8cxUBc/oCrDvvz1WoVZvj
         2oOjja5cgYr6IbHPdYBMWF9hc75HM1x3BbWJFfFyUz0IXCIfiCwaJORTXIhWXCD1T8Mj
         Gh3ZOHKhMOQctkbk+jt5EBiycZuKj/U/cAsxpLVdcP+XDLPDU3vbz1Lk9oCS0hMJ6Hqc
         8K8BGTf9FgT9DHO70In8eMwN1EIza8aKX9aPKy86MCn+7vKZpvsDkoEqp7XNvtv56Xoi
         Zaj39SOjDFWXz5f1ZIjF9hTBxK0Lg9hsA1YJuZnWPDLGSYhO8qA2/p8tf0QZcWQtlgJu
         Og8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Evc8LcD4TtrYEx4kHuvGKjEcl3Q5NYJf75iDzkjNm9w=;
        b=FqN7wPALVqyeng6NmCW6nBSQdDI1OBu6rqPcSTvAcsTdG7WgZAGCZ/bck+F7DF2Cgb
         tCKstvVCHjdt1xjKE3nmZN3gyFaCAlnCn5S7H/2twAB7PyZK/HYqAe2PK4rDlUsY52cC
         hB12493M8KLbeXwvAye61IGQdoQO/tdzUbrqsb/s+Nl64rwObB9IhnKu37FGham3azRO
         c23kHT4dCKglACeLoyCO7gsb/iaq+JfQjV2C2B6fetJLhogMg6AsUXC8llJDzlf91lu4
         7Wc4UxS/72eZzadALhzHmTlbSCcfPooAy+3BfESpM4O8U5KdT7XBfOd0VOcnBlyzjfpP
         6egw==
X-Gm-Message-State: AOAM530S/QeC0TkZ+9g9M59Amp482tD0Rl9RkkgUT7r7c8rhndZ9k6Mu
        iITs1i6KV9ERWIOWdxePPaZ9hV1xgTQ=
X-Google-Smtp-Source: ABdhPJw26xwFJviRcV0mJKJhw3zlNGzEJGkSU2o3KPrVMTEIyxd0IYoaH4VWIPkYSRHSCBbbvNJWQw==
X-Received: by 2002:aa7:9614:0:b0:43d:ea99:2a2a with SMTP id q20-20020aa79614000000b0043dea992a2amr27694451pfg.48.1633396215260;
        Mon, 04 Oct 2021 18:10:15 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830::d9e])
        by smtp.gmail.com with ESMTPSA id q11sm74217pjf.14.2021.10.04.18.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 18:10:14 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [DNM PATCH v2] Bluetooth: Build: Test patch - Do Not Merge
Date:   Mon,  4 Oct 2021 18:10:11 -0700
Message-Id: <20211005011011.402465-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

Do Not Merge this path.
This is a test patch to trigger the CI test.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 README | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/README b/README
index 669ac7c32292..514f2d6a9de9 100644
--- a/README
+++ b/README
@@ -1,3 +1,5 @@
+
+
 Linux kernel
 ============
 
-- 
2.25.1

