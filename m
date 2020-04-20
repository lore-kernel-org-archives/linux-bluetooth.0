Return-Path: <SRS0=YdAw=6E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3220FC54FCB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 12:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1161020857
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 12:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="1CVdTiOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgDTMHO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725944AbgDTMHO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Apr 2020 08:07:14 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEABC061A0F
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 05:07:13 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 198so7699552lfo.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 05:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CjToos8DVyJOPKLRIFmS8/X/EuQPOnHvG9kj6h8qFhc=;
        b=1CVdTiORuJpxx0QXtNyM8VGakYuF71ETGaAz0xhBXieC0VxVQ4hDMSVU3OkGZA08mU
         2qJAXBZ/qY9Kc19VqC2hWagPdxSYCiTW68DUpywnVneYbp9ptr4zxM0LM+S7/niM1JsE
         1jX22mmoE2tmNTuvlHIqCwwjDMxBFZ0EhPB0E2xWOwnOyFMozy6kB6asWdAnITf3aOpx
         A+3xUdlm/o0LHeFELeQwCsPRaIGyePatB6h8N7WWG2AOrzM/nG9JodKuhkYFO+/R82ub
         tjHrGREezgkR0AVo/YNrqyZFKjfHhd+JaQtJwTc6qPxPgYeXfxp5m5uesBEs0g3UQ+kp
         1OEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CjToos8DVyJOPKLRIFmS8/X/EuQPOnHvG9kj6h8qFhc=;
        b=XNSPoYpSpKY2BoADACyN3b3aCbIh5NZ0a5F5JgYeezDKxZg293QDV7STY0kOEaCew9
         G9mgfYrQqFSsYWy/+dyVsCKAgm4d/rS6ihuL+NlwPTTJAcx9DjvwrgPrhSc4F+O3h2PJ
         PVI+0hQhROmAoQkn3szzfl6tmyygugeq5FCOIs4+Njg/3CeIUQ788icV8vqmk9+KQBS6
         +YvplaXlEhx04ns2bLj161Vtg/3lPrNnhxru4vf9as3rkekzv8jDWCnzRuoLBnHk+ndh
         c9LJmwpv1cHtOIIO9Y6FTRBf0bY43CcSXGki2qKd7uWjRltUYotsaHB/SLNfXajReRdV
         X2Lw==
X-Gm-Message-State: AGi0Pub0oBMflM58lH7tosWZ8aiDyj6Gzc3yQp3kfi3N0ut9KKl6aUFi
        2QbZLHzRfeBEjZo0Ayw+06fs1VLSgQQ=
X-Google-Smtp-Source: APiQypIg6UWwdYtTu28oZTK4/hb+v5lE1O+3jHVtsY9+3GTtMAoMbq8GrB17ndOHI6x2M4GNw1to3A==
X-Received: by 2002:a05:6512:10c9:: with SMTP id k9mr10281900lfg.183.1587384431729;
        Mon, 20 Apr 2020 05:07:11 -0700 (PDT)
Received: from localhost.localdomain (45-11-60-42.ip4.greenlan.pl. [45.11.60.42])
        by smtp.gmail.com with ESMTPSA id i18sm666814lfo.57.2020.04.20.05.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 05:07:11 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 2/4] sap: Fix compilation with GCC 10
Date:   Mon, 20 Apr 2020 14:07:03 +0200
Message-Id: <20200420120705.89691-2-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420120705.89691-1-szymon.janc@codecoup.pl>
References: <20200420120705.89691-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 profiles/sap/sap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/sap/sap.h b/profiles/sap/sap.h
index 16c333a9b..6e78d6c2d 100644
--- a/profiles/sap/sap.h
+++ b/profiles/sap/sap.h
@@ -76,7 +76,7 @@ struct sap_parameter {
 	uint8_t id;
 	uint8_t reserved;
 	uint16_t len;
-	uint8_t val[0];
+	uint8_t val[];
 	/*
 	 * Padding bytes 0-3 bytes
 	 */
@@ -86,7 +86,7 @@ struct sap_message {
 	uint8_t id;
 	uint8_t nparam;
 	uint16_t reserved;
-	struct sap_parameter param[0];
+	struct sap_parameter param[];
 } __attribute__((packed));
 
 #define SAP_BUF_SIZE		512
-- 
2.26.0

