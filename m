Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82778C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Dec 2021 19:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350171AbhLWTuI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Dec 2021 14:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350174AbhLWTuH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Dec 2021 14:50:07 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CC1C061401
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Dec 2021 11:50:07 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id w7so4584103plp.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Dec 2021 11:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9ihzvmfL1JKR63zuErQK+qR+qt0qyup6+/MlQjMaiNo=;
        b=OTkXxK2yRnb1cD636Xr0YoBRLHOtcwQJa9+RSicFMC7EGY39ZwXS1Nqqxs18P/1ybP
         EDtaP4okx25FPYoeXixSUaS9g+sGFQ1pCohrNjRs3o4XKbcS8zsUrG5CTBWPZsSjcuiz
         dQY1Ym6z+Nxjq6IbwTDNlD1QwSxor+xSANxjpH+RH1V726s8iCBlb67ifx010Ol+xHs0
         2gNi5fiQnlcGU7kjjFuE8IFzutKX+T7sFUfaBn/mmsm8tvDgeiNXOuS89JcDedQlQ+Lg
         xLel99zKW3fQx+VYo+nl+WfgnwvYpGT6WSTnhkd6RI9fI+y0RSQ46thR7hexIz//n5wC
         /GOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ihzvmfL1JKR63zuErQK+qR+qt0qyup6+/MlQjMaiNo=;
        b=jzkTHzo/Wq2yULtRls/yGIqL7X+EMEsPl7vdeQO+JYEKxDjU/vOaIOiX4Us793mizk
         woEJjcvUFJc24JTaR+NZKwv8AteRiTRuib/Ij3n3mjBPzdOtRiXgUWcQ/R6j1V64YcrB
         PUv7BVcGa+rVAyni7qpDfW6uEvx8qVSt93xzJnIdpEv+C/BplqJAup/kohHwsqNVxvYW
         Qn6/5gVG7N3+K4vDorhwdgrkWQWyAguiOOolnprFtZxm7RAM+66O0dpW64oNQDu/FwdT
         snT2fESiF434k4HinGbzLWwX/tVnqNUOW5oU2n2gZDfU/Xw5kVlnDC1OOsW1GzimlDUx
         pgKg==
X-Gm-Message-State: AOAM530GoVbG7W5yJqabj4NhNlNDdAWccjQMHHutwmxyCYD5NtVvXlTY
        CX/EcF2csScQFSM8El8HB8T8nvgXs0s=
X-Google-Smtp-Source: ABdhPJxYarq5ZTuDZXV1fTBsMOiFKCOpQXQ9rwEAMrd0i9nitC8InIUOmgXgH4pTlePCfuTpcIphWw==
X-Received: by 2002:a17:90b:4390:: with SMTP id in16mr4228620pjb.14.1640289006584;
        Thu, 23 Dec 2021 11:50:06 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id mu2sm6631894pjb.43.2021.12.23.11.50.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 11:50:06 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 4/4] gattrib: Fix passing NULL to memcpy
Date:   Thu, 23 Dec 2021 11:50:03 -0800
Message-Id: <20211223195003.1647434-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211223195003.1647434-1-luiz.dentz@gmail.com>
References: <20211223195003.1647434-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following runtime error:

  attrib/gattrib.c:198:2: runtime error: null pointer passed as
  argument 2, which is declared to never be null
---
 attrib/gattrib.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 270a37ebe..041b9d289 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -195,7 +195,9 @@ static uint8_t *construct_full_pdu(uint8_t opcode, const void *pdu,
 		return NULL;
 
 	buf[0] = opcode;
-	memcpy(buf + 1, pdu, length);
+
+	if (pdu && length)
+		memcpy(buf + 1, pdu, length);
 
 	return buf;
 }
-- 
2.33.1

