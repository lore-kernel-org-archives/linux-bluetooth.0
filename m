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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A86C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 18:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 324F360F92
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 18:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhIOSev (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhIOSev (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 14:34:51 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01649C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 11:33:32 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 5so2185056plo.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 11:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Evc8LcD4TtrYEx4kHuvGKjEcl3Q5NYJf75iDzkjNm9w=;
        b=aU7m5WifhdSxi/F994pmtBZYPO+uHedkDtQTlC9Db3N4VHlAXCI++rdw8iWYfZU7JS
         OojlR2Kz8dZsznky2A1mDDIsZY0S8vh70r59WVnoqMCDLfGgasOho9b9qB1wlLcsitJz
         ZQiFcN7/KCjdn4eylCv77yRgwELrzeww3jEYBLSV7A0mmKeH+Zl6t97t8Q5hggGcC4Bl
         BM6FyiBDjMW97g+GgoqHaBa93fvtWynTTaUcsQHDlHqmYQxxQUrLw5GS1lk0A+w7xCkF
         tX7HSKwp8sfBTlkMs6L9MMZNXFPXiQxdpmMAUCyOVtBJET8rO2deudJyQHwce2sX6w9g
         pyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Evc8LcD4TtrYEx4kHuvGKjEcl3Q5NYJf75iDzkjNm9w=;
        b=3pIjLXCpQLL9zX/Q2z9SBX9DDaXm8AhKQdLpyzSdVAAODKmkg7nVndfENnUFOJ87cY
         KewejxOt7u+NpX+3qNih3v/QMRUDID7EByUoex9Hxg/Y+itV/jMD4WHS9vLA0VuaKYCX
         OwVfljhn9QBOUNPJtXFm++UwJ04aAeqiyQJJ+OXySdRO0UZteRK0tQ1wDeKfRenffxpH
         4odB2VtKuNBOjLrSR1y0epzAujXwBuKb8BfDLU6gBp9wBunrg0tuqyNq4zkZeAcAaGZ+
         R0ihMdjBIhbUB49NKOm8shJduN3InENaHXIclKhC4qnY4XyYPsvweywOuEFRS5EGdNSZ
         4XJw==
X-Gm-Message-State: AOAM532iplrbUbG6jhZ2vesA6zuTxc6bGCZmnkhBRa1Q+jYsRlhD/mUU
        o01foyo1bna+881jIM4lPh4XcBKjCfg=
X-Google-Smtp-Source: ABdhPJx5MqSJj6nz16wVM3ofTWZI+a5NJON/mQsnueOt9KY5ImDp1EVA2RWFnudYOOb17pOkPB9W3g==
X-Received: by 2002:a17:90a:aa14:: with SMTP id k20mr9895677pjq.88.1631730811224;
        Wed, 15 Sep 2021 11:33:31 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:daed:9e32:fa47:fad2])
        by smtp.gmail.com with ESMTPSA id n14sm650618pgd.48.2021.09.15.11.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 11:33:30 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [DNM PATCH v2] Bluetooth: Build: Test patch - Do Not Merge
Date:   Wed, 15 Sep 2021 11:33:23 -0700
Message-Id: <20210915183323.384752-1-hj.tedd.an@gmail.com>
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

