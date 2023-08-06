Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFDFC04A6A
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Aug 2023 08:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjHFIBo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Aug 2023 04:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHFIBl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Aug 2023 04:01:41 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFA71FCC
        for <linux-bluetooth@vger.kernel.org>; Sun,  6 Aug 2023 01:01:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3177f520802so2725419f8f.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Aug 2023 01:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1691308896; x=1691913696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77Mvt05gb9c+2goFK08hoFzaMNPAPjt0DdNSyr1zw3g=;
        b=BuySFiMbcuTQEODH2U5PZLqTIOlX1pJN5cmxComb7Vlj0bjHkz1Y0O8bB7QuLXcnNw
         QRvkavuea2RQ+NtjSe6jOdmW6Ijqlm2SOfCqaueeNpTDxuC/qrUhG3kzbWHCYTwNvXLH
         zV/3Dlv48QOCKDhZI/eraniRrKCgwOP+Y9e2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691308896; x=1691913696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77Mvt05gb9c+2goFK08hoFzaMNPAPjt0DdNSyr1zw3g=;
        b=HgyjPapUsUEQhhg4L/AeWcDlfGcBmK+xKw85FNg9rCFC+o0k5J8g9Icgv8uS5x7UHQ
         AhjNAgODI7+96obJvNMEkQVTkhKMdVwRE07VpjznPlGBGVAiOQrkIcsNPk1ouwl/D0ta
         F3BpQm1VFQ03kszJ74zZz4OnfAg1YCu9mxj6aykc3vWm+VMlWuX8fBMGIHrSn9OE9KK8
         s4Ol2oCipFFPowlq3b350UgWqtK+X+zbMimnURs6C95YPAyiGegI4IQgXI6X1+5LXIU9
         s1w+fh9kfsgHzJWG21fMxoOgQaFJfbPwEzAomTTJuXlobcZ+61kYyPW1ezQD70kdBXrX
         CJNA==
X-Gm-Message-State: AOJu0YzyAxUCfNuGVqpVxythsTrqFNG5oPuKN5Wy3A5YSmLBdOnAVXeQ
        P+EjwCFYKFXTAZZ4OIWl2DpYGBv0oS4aWnOa3wU=
X-Google-Smtp-Source: AGHT+IGMGs5nsXZs4mQU0oloX3jEwiSlGuC1eOtM1aicGwpiEl3NSatcrvtpy2G5qMPDNvqdxuS+Mw==
X-Received: by 2002:adf:dfd2:0:b0:316:f9f1:bb0f with SMTP id q18-20020adfdfd2000000b00316f9f1bb0fmr3107906wrn.34.1691308896448;
        Sun, 06 Aug 2023 01:01:36 -0700 (PDT)
Received: from Legionbuntu.. ([2a01:c846:10c0:200:9bf4:d5f:8c8:5ad6])
        by smtp.gmail.com with ESMTPSA id u7-20020a5d5147000000b0031437ec7ec1sm6974156wrt.2.2023.08.06.01.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 01:01:35 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 2/2] a2dp: Expose "Key missing" error
Date:   Sun,  6 Aug 2023 10:01:09 +0200
Message-Id: <20230806080109.1639693-3-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230806080109.1639693-1-simon.mikuda@streamunlimited.com>
References: <20230806080109.1639693-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This error is not expected and retries will likely end up with same error.
---
 profiles/audio/a2dp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 47b5dd7c3..b43161a13 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -307,6 +307,7 @@ static int error_to_errno(struct avdtp_error *err)
 	switch (perr) {
 	case EHOSTDOWN:
 	case ECONNABORTED:
+	case EBADE:
 		return -perr;
 	default:
 		/*
-- 
2.34.1

