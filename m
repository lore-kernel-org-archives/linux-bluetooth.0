Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7441C433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 18:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83BCB61285
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 18:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351610AbhERSlE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 14:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343747AbhERSlC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 14:41:02 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D00C06175F
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 11:39:42 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n8so379484plf.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 11:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sJMfQ7nQR3Pl+bsEnR4ULgp373XRVEfzHapTKV5IzLo=;
        b=HpJioW51Ka8qDHrvTOtCMASmG+HPmw6LXUeez4jkU+8YLNqTv7kexDfZS1CB3n1+gA
         XUeLuQ9ktpztecgbeBjJgKIu2mGAEi3fce3TTdBAEV8ubVbYJ0jUu+K9WGCb3arCvbwb
         RerBHfy7clsgZvRdeNlcCqyrNP66+4v9Nkg/UqnsSDwOszrMv/gzs4czx/FSsfrZ6wRC
         6wtK2ydOIZre4VYSlXLI8OFhmayTZWinMgi9gEJqxOaokEqBg1TYGdJmge736aiOaYdM
         ejuzU6j/M6vQtiruw2nSteYLO5QSW9EfA92YsOaW4cGNhg2+raepragLslBE/6LwIzRs
         k3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sJMfQ7nQR3Pl+bsEnR4ULgp373XRVEfzHapTKV5IzLo=;
        b=mK+jrDlXW2DCc5z7ZAtPyIISV4I0E2SqhUQhnze6pRI+jdGnsGgWSU5kMJ84+0tFlH
         hh1Fs+46JbFwDm3Nvwaz2CQysFBxchPKXgS77Pg/P+O3imzjkqH8r7qaQC+XzjaHlgao
         Hd6xTrgkHvPN5qRvMQxSzFO8hXV9ex0q8qtwprrFzyWuZ5quqntSQoNsoB6mklDx6r7x
         K8C/7w3ZURpBfbCiGRQVF2NTlfbQxNr23XlT8tvx4nhxFA5wd/KnrZt/c+X1QiE0PnZg
         l9IA/64Tqc2IYOXr8d/sW9Tw9Yoto6cRgussD4ZLuWfdbg2sYo4JLUO/sSBh5bSZ8tdt
         lheA==
X-Gm-Message-State: AOAM531ktDg9zanJgmTNQDDVaZqfjqVmqmYWD6JW1CutH0UAszHped8q
        pyDlxqQ8RAy6TfS2mQIatWvNuD1XqYU=
X-Google-Smtp-Source: ABdhPJybbPtHqLRnEAXOGf+kxkikUjQtp1HrdtJ/nQOdrW4LzyKpAR8+9qTVPyTdMkgCQuKKSuBhSw==
X-Received: by 2002:a17:902:8211:b029:ef:64c8:5bb2 with SMTP id x17-20020a1709028211b02900ef64c85bb2mr6184844pln.64.1621363181694;
        Tue, 18 May 2021 11:39:41 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r22sm13157121pgr.1.2021.05.18.11.39.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 11:39:41 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] shared/util: Decode BlueZ experimental UUIDs
Date:   Tue, 18 May 2021 11:39:36 -0700
Message-Id: <20210518183937.786605-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210518183937.786605-1-luiz.dentz@gmail.com>
References: <20210518183937.786605-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds BlueZ experimental UUIDs to uuid128_table so they are
decoded by the likes of btmon.
---
 src/shared/util.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 7fb1c01dc..8c216f936 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1019,6 +1019,12 @@ static const struct {
 	{ "6e400001-b5a3-f393-e0a9-e50e24dcca9e", "Nordic UART Service" },
 	{ "6e400002-b5a3-f393-e0a9-e50e24dcca9e", "Nordic UART TX"	},
 	{ "6e400003-b5a3-f393-e0a9-e50e24dcca9e", "Nordic UART RX"	},
+	/* BlueZ Experimental Features */
+	{ "d4992530-b9ec-469f-ab01-6c481c47da1c", "BlueZ Experimental Debug" },
+	{ "671b10b5-42c0-4696-9227-eb28d1b049d6",
+		"BlueZ Experimental Simultaneous Central and Peripheral" },
+	{ "15c0a148-c273-11ea-b3de-0242ac130004",
+		"BlueZ Experimental LL privacy" },
 	{ }
 };
 
-- 
2.30.2

