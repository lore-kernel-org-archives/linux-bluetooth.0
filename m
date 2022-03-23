Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC44EC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 00:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240864AbiCWAI2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Mar 2022 20:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbiCWAI1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Mar 2022 20:08:27 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C59D5DE5A
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 17:06:59 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id jx9so123718pjb.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 17:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/j7e/CWw6oRrnkQVp/KphTi81K+8ZW6pXdZNgewlKz0=;
        b=qPbTf1MCnBva0zGGEK9LeauLScXkFY63tlXFzaD+bNymnigqq3Yl2Bl7OySCUdJ2uw
         KS2TioG4dSjb+LQwztfyBx4erLxiu5GlC0ptrATW/oXLjON6r6VTGxawHYWMpHzxnpH2
         NTChqFHriu5j7+9y6Hb/OYMQBff/ban9KDRHKh7j2wUV2O8S83/iSKt/Ue3T8lfNDuFa
         pSg7LIoBAoLXmexXAv9eCd1+vy6YXL89b28OmQ5l+QsixefI+2s2Z1zNKxnyq5XwncaV
         1mID25wifZIJxI8zsBMHZrig3M6mhCpMZ2mi375NVZSqqA2KONi3wNa5HFEZizwz6w5b
         vi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/j7e/CWw6oRrnkQVp/KphTi81K+8ZW6pXdZNgewlKz0=;
        b=Ve0tBPVv8q3QpLX5+c4JU90XH4kmsptIUl/+NY3pCu0/HuXnG6z0qffmks0I0qdSqo
         EO6E22gy5gdpVqoy3DKW1qfT2jLinVEtpa2xV8AGlHcWQBIjyfQPoFxQ+mLhYLRR2U/B
         LY+YdzJSG1yrVAJ+qs0pNDApn6LYRHLxYjt6RKPOxHZj2b3RMonlypnJ+RRIUJR5SsI2
         QV5hhPc81PA7ENe23BMbYLGTmFHqvbbdemVgJmVVOnl7Q8H+uVgnwCGM4oCokKTgaHFU
         La3MsdzUZ2+DxJsHI8so8/sv5Nwpw15pZeGM0e7kb2d0Q4y4Fm4lf5GQw1ybqNHlBVZZ
         lHVg==
X-Gm-Message-State: AOAM530ULLuOpI7t4IR6d/owH5F5kR3MLgV971ngRR33d3yH0GlgL303
        4lgoAadcdlCVxhx9u4MldQPx+OJ08bk=
X-Google-Smtp-Source: ABdhPJwG2FkwMToS8je/jzbRjig145RgGdinAuooHVloxI855HK7BmeoCmi5tN3E6mi+WGD8i8lssw==
X-Received: by 2002:a17:902:b490:b0:151:6ee1:8034 with SMTP id y16-20020a170902b49000b001516ee18034mr20895015plr.28.1647994018515;
        Tue, 22 Mar 2022 17:06:58 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id bx22-20020a056a00429600b004fa936a64b0sm10098423pfb.196.2022.03.22.17.06.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 17:06:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/9] att: Log file and function names
Date:   Tue, 22 Mar 2022 17:06:50 -0700
Message-Id: <20220323000654.3157833-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323000654.3157833-1-luiz.dentz@gmail.com>
References: <20220323000654.3157833-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds logging of file and function names.
---
 src/shared/att.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 169f726e4..7344b0c46 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -308,10 +308,12 @@ static void att_log(struct bt_att *att, uint8_t level, const char *format,
 }
 
 #define att_debug(_att, _format, _arg...) \
-	att_log(_att, BT_ATT_DEBUG, _format, ## _arg)
+	att_log(_att, BT_ATT_DEBUG, "%s:%s() " _format, __FILE__, __func__,\
+		## _arg)
 
 #define att_verbose(_att, _format, _arg...) \
-	att_log(_att, BT_ATT_DEBUG_VERBOSE, _format, ## _arg)
+	att_log(_att, BT_ATT_DEBUG_VERBOSE, "%s:%s() " _format, __FILE__, \
+		__func__, ## _arg)
 
 static void att_hexdump(struct bt_att *att, char dir, const void *data,
 							size_t len)
-- 
2.35.1

