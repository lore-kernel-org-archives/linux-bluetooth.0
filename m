Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9252C77B7E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Apr 2023 18:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346520AbjD1Sq6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Apr 2023 14:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346513AbjD1Sq4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Apr 2023 14:46:56 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF2A5BA9
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 11:46:55 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b5465fb99so316619b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 11:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682707614; x=1685299614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Zf1jMK3UJ9SfKs4kbWstHqgU/7a87nWIjklSePkN28=;
        b=Ls+uvENs64o+8/zeyjC81G/7ipfo99ps8dN+90HzYYrUkDv1BkwLxaYUHgaHjXTadY
         gF2NpEnFdXQIzX9YCJdfhdqN3CnAzIwQfaEcuvBszTEd2S/v1HTViBjutJd5pLC2S07P
         aEQrKoIBNsQjaEP2GWjrWnp+YpaTia5EzYs3+g57tgLvHp8U3As4ZNUWHpqf6QSOd4Ss
         FIY9RifBqw8aOiBw31fJMZqTbO76TGDWl01wkSuesVV2D9H0L3jtdWisbSDis96DHkdq
         wUw9ozs4oiRatlHbfDRX1OMoxG4PiOCDgugq14BmaCxGwUsC+fwgJeguD2MX3yTkY7d9
         VeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682707614; x=1685299614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Zf1jMK3UJ9SfKs4kbWstHqgU/7a87nWIjklSePkN28=;
        b=Du9v+Lu6aPCLtoQT7hb5JL8GCl+IupHlHNS5DENkdJq6SSe3w1I4LCKKad9D+cvWGm
         7P5O8qobixG7CbcJ+fbXkOpI+60GxpjFHcwaNdIum6GRdaqqbhS8xVK02Q2I81djF4q4
         6H+aqG/p5VQOLcXDTxot2k4kI7qOikC1/295id7zi5Hy2sk9xcENeiJG4RU/0XkldMty
         oWXtMl2lQ8XIXLGNkS4eDAKCCSIzdrygjs3R5AZZUPXOZ1MYDbARywPVsQ9dpeqAfdFG
         jLQ/RA86P2oFTfRhntPv3GVkVCBeaN/TsSYhuOFmxIbYCY6VtYFNPw0Qx/YqROS0SSWE
         F/cw==
X-Gm-Message-State: AC+VfDw9e0V2BUDhotlZjhIjWWcxyIROk2N3ohzIvEE5zuyHfEoT2nT3
        CXDDMcaSruj81Ifxdu67ow4YqglF9gU=
X-Google-Smtp-Source: ACHHUZ5wiiYnCHY0Rn2SC/EEMrhZtJhT/vpWIFG5p1k+RD0kwG0cbPoPwQzA1Bk2PuR7yt4jkngODg==
X-Received: by 2002:a17:903:40c6:b0:1a5:2592:89c6 with SMTP id t6-20020a17090340c600b001a5259289c6mr6018797pld.29.1682707613892;
        Fri, 28 Apr 2023 11:46:53 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id bf9-20020a170902b90900b0019f9fd10f62sm13626366plb.70.2023.04.28.11.46.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 11:46:53 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v4 8/9] shared/util: Fix runtime error
Date:   Fri, 28 Apr 2023 11:46:39 -0700
Message-Id: <20230428184640.849066-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428184640.849066-1-luiz.dentz@gmail.com>
References: <20230428184640.849066-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following errors:

src/shared/util.c:271:2: runtime error: null pointer passed as argument
2, which is declared to never be null
---
 src/shared/util.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/util.c b/src/shared/util.c
index d31daacc4b93..9a4a8d77abce 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -268,7 +268,8 @@ void *util_iov_push_mem(struct iovec *iov, size_t len, const void *data)
 	if (!p)
 		return NULL;
 
-	memcpy(p, data, len);
+	if (data)
+		memcpy(p, data, len);
 
 	return p;
 }
-- 
2.40.0

