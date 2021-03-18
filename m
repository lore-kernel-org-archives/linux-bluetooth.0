Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E14C433E6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 08:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DDDE64EF9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 08:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhCRIng (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Mar 2021 04:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhCRInQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Mar 2021 04:43:16 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9466EC06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Mar 2021 01:43:15 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 16so6466763ljc.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Mar 2021 01:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=di/9uBz6WutdHLUXatgCC9P/S9U8Sn3j/0uRujoEw/4=;
        b=qj5SGbdpxdoS/QhGVUtclu8DpnTeBt6lVD0wsx/1fqf3nu0YlD25vPCyLfRXjJiC9b
         4aIPYrS8WF9pO8TSTPbWJTFHbvwZB0xrYw+CK259BciCgawIAsIYBBd2JU4E9hDZjIPM
         pJNgk75bdHt9b2aVdZB435L/mz8hPnMbKa93lyZImxTm/XrQL6bSinOZep4Ce+SnNC9x
         Xi9XdcMlSfdlXzT2DkPHXwXBTPtWROoSRUZ/evzBJr8C9WNYXehcYJDhH6QNG4kvwvSi
         brQpjjokg1/cRKwzCE1aCnV9L6kWN5cmt/1D14ef/w5tofIDuClQAWEnTCj5YahNM79x
         NF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=di/9uBz6WutdHLUXatgCC9P/S9U8Sn3j/0uRujoEw/4=;
        b=Rj+9OwzJ0RgHRzgn+Mkttpe4rxgAhSp4vZp+NyvrHCx2sJL9CVQSLsMpKh1RUP/odu
         rvelVrt7uJwRUucO+25AhFSu0chb35YwU3QYSQDhbLxmpc+++P+TCtkrr0LM7/NiZid3
         iYbv6lrezqnKzgdceMYU1gSUUtbToSZD0mvyKu0iomnSn6Nq3wIKt7AA66vWaCGKvcbQ
         x1xEckqozQDayHAk0tphNgUrMko/nk/osM4CbO0RsD1CMn6vmU2MEQ/ks6y593kXth2V
         WE0+wJR9T6MdAPDk914wawQ2FpS8ZX0rrH8GqJdxUPqJyI8NNl+dZhOKVGgNsgxk22O6
         nHkQ==
X-Gm-Message-State: AOAM532j5eS1QH0KjbA+tXem7l2cKeam77qilFjPAdv19G+FEG3RyHXT
        nf/q4U+wQOIuo7JsJ8t7VRVGdQ==
X-Google-Smtp-Source: ABdhPJx9kOTXcNXlezR4YjpjAD+a5IHKgfIIjKmxLmNN5lip7qfqrwcW9TlnGmosLVBDCC1PGQtAQA==
X-Received: by 2002:a2e:b4f6:: with SMTP id s22mr4600388ljm.328.1616056994099;
        Thu, 18 Mar 2021 01:43:14 -0700 (PDT)
Received: from localhost.localdomain (c-d7cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.215])
        by smtp.gmail.com with ESMTPSA id u11sm141982lfm.78.2021.03.18.01.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:43:13 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: btbcm: Add BCM4334 DT binding
Date:   Thu, 18 Mar 2021 09:43:08 +0100
Message-Id: <20210318084309.401951-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

BCM4334 was missing from the binding.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml b/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
index bdd6ca617e23..fbdc2083bec4 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
@@ -18,6 +18,7 @@ properties:
       - brcm,bcm20702a1
       - brcm,bcm4329-bt
       - brcm,bcm4330-bt
+      - brcm,bcm4334-bt
       - brcm,bcm43438-bt
       - brcm,bcm4345c5
       - brcm,bcm43540-bt
-- 
2.29.2

