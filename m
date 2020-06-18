Return-Path: <SRS0=NPxI=77=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62822C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jun 2020 01:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3515B221F7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jun 2020 01:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aeIEbei0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732111AbgFRBsU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbgFRBsS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 21:48:18 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940C6C06174E
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 18:48:17 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id k13so2577341vsm.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 18:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pjwvclQcKmJ7gxyF++2dnR8rUBpdMbIHY+4uf6zSMCQ=;
        b=aeIEbei0WzfmuzEDjxfrt8DQyL7O1eAY3PUXTe24LDKr/wlIUm/LfQgUkH//ufkufc
         wU6uZ5ILDfJPS1Q5+FE8/tjpDXMap3jR2FdnJkO24LmZbcooz5ypFH3q9QnXcj4zjGqV
         lA2rMtiTqcnq9QxK79jD+T79rZT/3p/IfuV64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pjwvclQcKmJ7gxyF++2dnR8rUBpdMbIHY+4uf6zSMCQ=;
        b=UvYllCjSjVHboNE6mEu1XF+wBkf3Y9D5daerJiDT3Jl5FH3jg+/w2E3epDcdxEJPwz
         YBLaQQoQoRkbNnGH3ar0WWD3sQziwoMSpOesicCkmtsR0UQp8VZqhax2Uo7wy/AgCava
         CzZ/jz+B0Ep+9Ab+ZPDLigKOWaS9eliW6gCT2lnhqo5Dz7GLjHxXGg5ZWb5e+gb2AxJZ
         hdi+tqQydm4msL4+ciTOZ9tNl+dYRdkhrWAci9ZWaOBVcdDm6QVA014MKulZmphh6M2M
         fqSzqypduduXMBYz5FjKrrjEz6fNZwfcnhrqFvPhKgU+N3A06fTjOxj3kQDZmY/hd3PT
         RLSw==
X-Gm-Message-State: AOAM53366CFtblv98aNQCvtd2h8RtQL3zhPRC0Kij6gqfcokIYtHsLdq
        bXruvEZuhk3+KwrDiYKWCFO4HiOTHA8=
X-Google-Smtp-Source: ABdhPJxvHev0iMl3wg9TWh+Z25SnRmkMwqQ8xMLtPq7SU/mVRgooG8m0wuPnTanSeEJ98nXvDEG6Ig==
X-Received: by 2002:a67:22c7:: with SMTP id i190mr1658920vsi.179.1592444896532;
        Wed, 17 Jun 2020 18:48:16 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id i2sm183822vkp.22.2020.06.17.18.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 18:48:16 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH] main: fixing logical error when loading controller params
Date:   Thu, 18 Jun 2020 01:48:12 +0000
Message-Id: <20200618014812.234606-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fixing logical error when loading configuration parameters from the
config file.  Without this patch, the maximum allowable value is always
used.

---

 src/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/main.c b/src/main.c
index e51f614b3..75ea27f40 100644
--- a/src/main.c
+++ b/src/main.c
@@ -421,12 +421,13 @@ static void parse_controller_config(GKeyFile *config)
 		int val = g_key_file_get_integer(config, "Controller",
 						params[i].val_name, &err);
 		if (err) {
+			warn("%s", err->message);
 			g_clear_error(&err);
 		} else {
-			DBG("%s=%d", params[i].val_name, val);
+			info("%s=%d", params[i].val_name, val);
 
-			val = MIN(val, params[i].min);
-			val = MAX(val, params[i].max);
+			val = MAX(val, params[i].min);
+			val = MIN(val, params[i].max);
 			*params[i].val = val;
 			++main_opts.default_params.num_entries;
 		}
-- 
2.27.0.111.gc72c7da667-goog

