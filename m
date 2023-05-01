Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10582C7EE21
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 May 2023 20:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjEAUDk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 May 2023 16:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjEAUDi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 May 2023 16:03:38 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E962D7B
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 May 2023 13:03:33 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ab05018381so5384665ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 May 2023 13:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682971412; x=1685563412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OBlP1yWmSe/KeQ1+ZXJpMbLGfwR1ADwCzc1rSW6r9g=;
        b=diOSf6Lz2W0fRWJRadGgzG8TGPJVBjvlM6bE876sxJyaKzmE424jhy3vWp+A+spjWH
         0QW+w/vGddy+t9NkjMdh6TM6jCXlpTujulk+S9PHShWe1Ni1DQflOtx7q9VQMe50fxhs
         YZTNuVNg4Gll+1v4Ny3V3qZKj0Fh/eKUejkZBlvdcLenB15J22S8vfBj/FVaykbbIPO4
         QenXYCEF0ey7cm+xOHqky9uqq75HKV02+V/9B/zoPUQKS0yO/mqPucHCrEbp1IpqdwH9
         4dE1b1uGWIgusD3yzeFWMiwW+dUCbkQT4vQJ4HPc6oR7563AVgzxPKHND/V6diak8Thc
         RjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682971412; x=1685563412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OBlP1yWmSe/KeQ1+ZXJpMbLGfwR1ADwCzc1rSW6r9g=;
        b=WcmtkS+F4HMS0DDqOFXygUy/grTBepTdXJeqD+1ZMIdem1PmeUf3BMxK8HzWv1E2zb
         S0Gl5Y4VQSKvRvYeCu8w+K5rsT5zstlSFFC23VUbD/dFd3lwWn9hj4tMA29ZkLKf7jt9
         xbxgjMPOirj0OaT+6A4lxruliSnW6MtX6WrWC10gTQUbw3e+NNowr+iPPxaFEbxDIpJD
         01/Akn4l4bAYB+euGYIZwImjHjRi05pyJNW4SpK3fLV+W4kG6M5R6onmR2bnDoJ0aVYG
         bDAD+sWP+4ephZbW55f6isMNQ1AntLpcVYeYM/xXHs73zt8IBuEDypyxtrbmTv8jdfya
         m8Wg==
X-Gm-Message-State: AC+VfDxs5IDe435ZK+lbHSsVdhDp4uBUSlucK+hcDBQXGeg6/NCgcsOV
        7tYW3rpJ5JOy8BHJo2MbUuQZFqm3y6Q=
X-Google-Smtp-Source: ACHHUZ5iXcRu8P9bunGlZG/uPDrMlj2BduYnTcac3kDKdlLgf5oZ4gZEIp8uDw2BSSpxIzlkPdTUVg==
X-Received: by 2002:a17:902:db11:b0:1aa:e653:1c0d with SMTP id m17-20020a170902db1100b001aae6531c0dmr8100719plx.19.1682971412018;
        Mon, 01 May 2023 13:03:32 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id ix7-20020a170902f80700b001aaecc15d66sm3037514plb.289.2023.05.01.13.03.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 13:03:31 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 3/3] shared/shell: Fix not releasing prompt
Date:   Mon,  1 May 2023 13:03:26 -0700
Message-Id: <20230501200326.1056736-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230501200326.1056736-1-luiz.dentz@gmail.com>
References: <20230501200326.1056736-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes not releasing prompt when queueing a line to be executed
since it can be considered as user input if the init script is
attempting to enter it as response to prompt input.
---
 src/shared/shell.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 8b8b253d0bcf..757e16199ddf 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1295,6 +1295,9 @@ static int bt_shell_queue_exec(char *line)
 
 	/* Queue if already executing */
 	if (data.line) {
+		/* Check if prompt is being held then release using the line */
+		if (!bt_shell_release_prompt(line))
+			return 0;
 		queue_push_tail(data.queue, strdup(line));
 		return 0;
 	}
-- 
2.40.0

