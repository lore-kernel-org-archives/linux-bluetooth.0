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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4CCC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 22:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA69820872
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 22:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aN+lcK8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgKXWrg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Nov 2020 17:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgKXWrg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Nov 2020 17:47:36 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC85C0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 14:47:36 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t3so512493pgi.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 14:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3p1Q4QTbj/4FveS3d2xoRo+g7HRnI+KeEkfIyald8ZU=;
        b=aN+lcK8bGurRUzkX9T1iCx6M98mtCxN3pGUwtH0EM1aSn+qksCB66PcP3yIip/jbd4
         QwaM2lhUxrf3gvQSbH38b+lhIqGr7+1xbyCevD8h3Sn8C3w6tB1CGQz38Dh/FiCZzM8j
         4dtbMZV1jzgHnbwsL3h/wMAxuchyZ6W89XyrqKSXV8nXhGElv94paWB/xLWu+YgHE+dU
         k4heY+o+/VSq+uAV6PjKOsNeKpg6YLjddvm6cpQfMXx5uw/jKl8t7WZCcJE0WGKfZtGs
         /GukJ1mwhuhzy8A4DvPH+Ss/FZdywjuVwMUosb87zvD4IP8JIdmFieoiqgAZY3S5gLTx
         5vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3p1Q4QTbj/4FveS3d2xoRo+g7HRnI+KeEkfIyald8ZU=;
        b=dLZ0102yoc9w/DdkXvWvQkfSS6PJWm8pSrv3Hw+zLmiFtuYb4tpQ1W0+9w/RX/+QIv
         fkW5nZsc1iKhzwuUG4sUhEm6LLylr9CsGtVun2fQ9Pa8i93INnTBBCByIK/U9hjtmY13
         dD05caD0KFL0bTNFL0CFxjvjWGLlCzilc+BLSF4dxdoefS8fjGtaKHoJGQQB/bANAfwc
         Q5i9ymP9G+egVR2apiw6h39CrO7K0tjpcnUL2xElCIW+4RLpIgehyeWPQjUma8nOh1Os
         i0yu/Ijq9ZZ/oRekOZ4zpWshLe7AaW7QHxFMazvqw2/7qsL5wrKLoESVbSwcae4bw61o
         Nl9g==
X-Gm-Message-State: AOAM530g76l1GI/YMEghK/4kTB6RzYLTi5RVsqVGLafnUOZDVxPWfbgK
        AD905RV/MH5ANSdD7oUQKVq9B9T9jA==
X-Google-Smtp-Source: ABdhPJxkRwhtbFioxuVW5c3WhKhIoC8yVf8EB4hcv1pcjK+bZNFc4v68ET66VcW3AS58SejXs73irA==
X-Received: by 2002:a17:90a:cc01:: with SMTP id b1mr493106pju.121.1606258055791;
        Tue, 24 Nov 2020 14:47:35 -0800 (PST)
Received: from rxps.home ([2600:8800:1680:2610:887a:d98e:bda0:669f])
        by smtp.gmail.com with ESMTPSA id a3sm82311pfo.46.2020.11.24.14.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 14:47:35 -0800 (PST)
From:   Ronan Pigott <rpigott314@gmail.com>
X-Google-Original-From: Ronan Pigott
To:     linux-bluetooth@vger.kernel.org
Cc:     Ronan Pigott <rpigott@berkeley.edu>
Subject: [PATCH BlueZ] main.conf: use correct key for BREDR configuration
Date:   Tue, 24 Nov 2020 15:46:58 -0700
Message-Id: <20201124224658.32605-1-rpigott@berkeley.edu>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Ronan Pigott <rpigott@berkeley.edu>

Signed-off-by: Ronan Pigott <rpigott@berkeley.edu>
---

There is a mismtach between the "BREDR" group name in the config
and the valid group name "BR" accepted in main.c. This changes
main.conf, but I'm not certain if it's main.c that should be changed
instead.

 src/main.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/main.conf b/src/main.conf
index d3bc61441..ad36638b7 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -86,7 +86,7 @@
 # profile is connected. Defaults to true.
 #RefreshDiscovery = true
 
-[BREDR]
+[BR]
 # The following values are used to load default adapter parameters for BR/EDR.
 # BlueZ loads the values into the kernel before the adapter is powered if the
 # kernel supports the MGMT_LOAD_DEFAULT_PARAMETERS command. If a value isn't
-- 
2.29.2

