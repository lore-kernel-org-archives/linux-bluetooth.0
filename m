Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AE5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 May 2022 22:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444768AbiEFWf2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 May 2022 18:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444764AbiEFWf0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 May 2022 18:35:26 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E6C562C2
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 May 2022 15:31:42 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id b5so5672441ile.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 May 2022 15:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DWzlXByRiJK1GiKVTGwA5BAMQgPbPfK30A7wefmRXjI=;
        b=h1RNeAyOrtIm6ICcREmfCrZBw9tXreIEuFtBamSbBP6YEY2Pcih3hTKj2EHcgiiXIw
         Msl6mSvfPnv6EK7QyLVc7H3D4+bckyTvzWcJiWdNcE9N4nscuYjmEnbmJCa8K1BW3NgG
         T/WWOlomJ39/GzqSdBKxuyzmuIPdVZV2nQx6pnrPTmeSTJEeyMIONcvfTkDOO8L9L3px
         WMzZ5YPGGuVjOXFLgvowpLlMe4Y5qpvRqtHIqAWEogtg+JIwCjlzyEXeRl2H6W9TFZjJ
         921MzcZSdIlyG4udIFcWHETBYvMUtARBhrWMi82hjEgDkM+36qo+OgxYknOjQP3K7ghq
         pOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DWzlXByRiJK1GiKVTGwA5BAMQgPbPfK30A7wefmRXjI=;
        b=sPXLYNKuwCs1HZcmIqEkuHdzBKAENI+X1eylMe6F3I2ax8hk8ajRtqh711zOtJj8wq
         Q2gEEO8zgtjZ84gCu7/pqCA3DCfUtcArc/M62DxhtAAcTuCLhh2vLGXIOx7Y+jpffsNO
         8gPgMQTNLsnheAl9Es7pxleAgcwJI5o8xlQNiAhdYdYrLq7hGq/b4+ApQWS5gjdY6To4
         L/E7PqekmuBKl9YuGUtG5fCrLlnkHiiJ+6mkArDkk+bRZeINKplkesD0FxZfYcvFf8eQ
         o1pOasAl7y1Q8sgncVwp+DDI2ZCJQ7JZwYb2Ub9xg/0krg/KIGeJNAH0sr+auToRsq3x
         u6jw==
X-Gm-Message-State: AOAM531wlJi39evs1odMXphqWXJpc+R2B3tt1uDrIAmnRcRd/QPeH2CD
        +4zm6wuM7acKoNB1CvET2lKFd0YioqA=
X-Google-Smtp-Source: ABdhPJzwWuamAPpZK9B+ucLvFEc9MKYpgBThlBpISA5rY2+6us+lBI4HEGHnTtM4PAcdaC67KYePFw==
X-Received: by 2002:a05:6e02:f52:b0:2ca:95e4:f4b5 with SMTP id y18-20020a056e020f5200b002ca95e4f4b5mr2066262ilj.240.1651876301604;
        Fri, 06 May 2022 15:31:41 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p16-20020a92c110000000b002cbed258dcfsm1488375ile.0.2022.05.06.15.31.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 15:31:41 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 BlueZ 2/8] shared/util: Decode BlueZ Experimental ISO Socket UUID
Date:   Fri,  6 May 2022 15:31:28 -0700
Message-Id: <20220506223139.3950573-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506223139.3950573-1-luiz.dentz@gmail.com>
References: <20220506223139.3950573-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds BlueZ experimental ISO Socket UUID to uuid128_table so it is
decoded by the likes of btmon.
---
 src/shared/util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 33196bf8b..b74a005ce 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1149,6 +1149,8 @@ static const struct {
 	{ "330859bc-7506-492d-9370-9a6f0614037f",
 		"BlueZ Experimental Bluetooth Quality Report" },
 	{ "a6695ace-ee7f-4fb9-881a-5fac66c629af", "BlueZ Offload Codecs"},
+	{ "6fbaf188-05e0-496a-9885-d6ddfdb4e03e",
+		"BlueZ Experimental ISO Socket"},
 	{ }
 };
 
-- 
2.35.1

