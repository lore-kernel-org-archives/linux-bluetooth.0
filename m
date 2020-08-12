Return-Path: <SRS0=iWKJ=BW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5470C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Aug 2020 20:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8064F20774
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Aug 2020 20:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8b3pBE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgHLUfw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Aug 2020 16:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgHLUfv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Aug 2020 16:35:51 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9452C061383
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2020 13:35:51 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e4so1707316pjd.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2020 13:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=mpEnNZQnLlJNcY8p8W8RFZ+S/9A7eLY+2ognL6bHrAo=;
        b=h8b3pBE28mDWlzQovnRmjvjZlISShKsRlGH507tdVMyCuWuV0MFP+7zmrU+iB7mchn
         qM6qfwETnK+fcUWERrECOY0RiMnpPuxIlmEzEjWfdZc6kbWUU9iDf5Aibuh9pdcaHS5n
         MX7vFp+QF+T8u2xiruDnANHvvp/EdJ3woIgg1Q4uonNax5lp2AZXFNJJ0utRu1vRV99K
         Y0UsncTLQTDeKvAeq4NqONXbbeB2N4k0xcL6scEThP/seo/vxDp48cjpAG6l3d97AE+t
         ncinophGdlnlEgqL1bLcrLiHzRLze+3p/eQIBPAuO8h6+K+GCnqP0Qsm6fqbYd/Rpg/E
         OqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=mpEnNZQnLlJNcY8p8W8RFZ+S/9A7eLY+2ognL6bHrAo=;
        b=mlGfkx2hMbOZutud6ls4fz+o/NNTS9vUrBGaq32bzfEXoIg1OCqqhGZem8q7dVUD+h
         DQ1ilBnMCNk8Fo/3PsuoYiBvZFwmozuZP21lIrGV3cu3P2XQGrVQ+sxfuK8oQu19Sh8F
         s7/asKxS+was+Qhnx9P8Yn+DX4CRXn3ldF91F1FDOv+C6VxPGMDxEkGReDKuNLKfpdES
         0fF3tp1Ed5DSYBD3pOpih5GLaTWklTjQ8g9AYZqbljBoFqTAiL5fV1O+tmYWP82zxLLu
         RSSFDARowgV85MwwrxTk7d/6tsf/cRkLRbfIEcfpjSFVIRFZRvky0qDIOU9rH9Zev2uF
         QIEw==
X-Gm-Message-State: AOAM532cVFx9YYaJDmpKQAPR0aF0ZgjVSDl3BXaz8AliZ7uRLkt4p+Jt
        L7eovsECrLexN6vRljWjXfrptSep
X-Google-Smtp-Source: ABdhPJwx55sbLWEN4uMoeI3KCTj8L0RKL+t+FueemJV5DUkk0GfbGu+mLdcU5I/R0S987a3Xm1jT1w==
X-Received: by 2002:a17:902:8685:: with SMTP id g5mr1015181plo.201.1597264549854;
        Wed, 12 Aug 2020 13:35:49 -0700 (PDT)
Received: from LAPTOPV63503GP (c-76-103-226-229.hsd1.ca.comcast.net. [76.103.226.229])
        by smtp.gmail.com with ESMTPSA id f27sm3316142pfk.217.2020.08.12.13.35.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2020 13:35:49 -0700 (PDT)
From:   "Viktor Filiba" <termic.technology@gmail.com>
To:     <linux-bluetooth@vger.kernel.org>
Subject: Bluez 5.5 stack
Date:   Wed, 12 Aug 2020 13:35:49 -0700
Message-ID: <022b01d670e8$2ad9aac0$808d0040$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdZw6Ci/x+H4NcVWT+CFZzpnXA8OFg==
Content-Language: en-us
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Does the stack handle automatic acknowledgment of indicate messages? I only
see StartNotify()

Thank you,
Viktor Filiba

