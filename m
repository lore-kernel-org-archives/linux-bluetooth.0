Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D906C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 May 2023 22:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjEAWoU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 May 2023 18:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjEAWoT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 May 2023 18:44:19 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D371FDD
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 May 2023 15:44:17 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a66e7a52d3so22700855ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 May 2023 15:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682981056; x=1685573056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OBlP1yWmSe/KeQ1+ZXJpMbLGfwR1ADwCzc1rSW6r9g=;
        b=m6LP4j7gqpPpI4ITZMrAd4tOA+Gcigj194u6n0OPftKVXZd+gN3Zl3ztTlrBPO1wft
         Gp9wAjRuAg0DdNYo82XwvZ7xdGdKRcV0Y2e2c6OJ1ZREwWwSFBd9DE8QtbdyVKZSZp5g
         Jj9irV2WCslwZNUIrMD1udR09b4sE5CieDaJX54ItbbEy7i426GU/XrJkwax7V6FAL9q
         q+RvTSIjvLvuIpQhqlNkmpqBBCq+lSRB0LVAYt0sz9zmly3XPSQz9QLBj5yzFRkGetDn
         IL+eE0e4f5e98xium4nNjFb2JsuDJgzW02y0UlEkdyEP8BmQExcyr4kHBOv5AuQvZT/M
         FoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682981056; x=1685573056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OBlP1yWmSe/KeQ1+ZXJpMbLGfwR1ADwCzc1rSW6r9g=;
        b=Wh9nhoCjNVVaE7fSdXpuFcooombQ1aYTedUsEaK5DXN9TGCjgeEaKgKXSBytoVx1yw
         ALhR2GZSLQRuicluY4CPlgBfFGrSJ9zFQlANmTCfX9nVt6WHJkOrnx2Wr+tkjNG4xRTT
         M/o51OxDQZhBt1odLamuSiCqXg03WOJRgFtUyjkPoGSeSCjuhn8oFYrTWheu5xxkalZM
         41SFeXI5kVMBPcmrlHehO2JOXtVCkTze3XUJKMkT4D8b1lQJZOHdzmro5498spDvsY8x
         XhUdaXWKy/SibtCpYzIeILLvmqhnzTpgdpIK9CPZuENqK8xHIjydIbPACxZ1KSs1Qn48
         PK/A==
X-Gm-Message-State: AC+VfDyy49DOu/x4GYsrjRU+/i6H5GBXlEMs5NQUK5f5Q1CPjUClhdaw
        fE/FbvJ3USkX8Fa0VY29lJk3cjD9B58=
X-Google-Smtp-Source: ACHHUZ4oysU9Hfyx8pgfkNZ2CN2lKJxWZjC+kmaNFTyEUgDzuIOSuInVKqxcE0/YQ/FpABoZeUa/Yw==
X-Received: by 2002:a17:903:246:b0:19f:2328:beee with SMTP id j6-20020a170903024600b0019f2328beeemr17613227plh.11.1682981056583;
        Mon, 01 May 2023 15:44:16 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902a70800b001a6756a36f6sm18279806plq.101.2023.05.01.15.44.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 15:44:15 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3 3/4] shared/shell: Fix not releasing prompt
Date:   Mon,  1 May 2023 15:44:09 -0700
Message-Id: <20230501224410.1119023-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230501224410.1119023-1-luiz.dentz@gmail.com>
References: <20230501224410.1119023-1-luiz.dentz@gmail.com>
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

