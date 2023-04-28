Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02900C7EE21
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Apr 2023 18:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346101AbjD1Sqz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Apr 2023 14:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346404AbjD1Sqv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Apr 2023 14:46:51 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6872268D
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 11:46:50 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so129877a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 11:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682707609; x=1685299609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6pK5TjJ5FkDFV3GQCfWI9bCv3wKiC+Ep60HITp76X6o=;
        b=d4e4kmcFyhtYDZMNIXfC3Y9b8Lak/AU0NcmpqY3hqQuQ1n2eSFxV0CtJIvJlQ9AAje
         JpyaBoH/kTBv+UAE8AYMXQJJbDqEe53/gejXXowwdSvb55+r36NTr+OTutaUqffpGeaI
         fztc95YW1ldEVNtVElAFYuRohxNqazXuGBe/hIAdAr+tt6TklIG/uIHl5KY98+bdJ26M
         oZvjQ2cSgLhWRx0S/N2gCZfIx4eLmPGja+UFkgHxXMmNUQzAq9qTRdnyH7gec+iPEbxi
         2NG0M5vQ4Uu/YrVvB4wUQWCiJxnIpner9RDXONiaVyAEP7yHSV627d+WxOURAYY1nS5A
         bPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682707609; x=1685299609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pK5TjJ5FkDFV3GQCfWI9bCv3wKiC+Ep60HITp76X6o=;
        b=Ux4eUdzgm0I7YTs0KA0BHsHd0iM1pJ9sUG9SmUsp68sXH2BU6NVsdHZN1Gv6V02qW9
         qpMJZa1smnljFMeoO3kLBN9UJq2eZuG+S8iqU4DcPTEzd4qSKx+fkjlUUXR3YDyL1i3i
         1+bE7qFXtUrelQaKIWqkHuQrQKbWL1nBu+AEtICcKnm2V9vtbF22DoJdT/y/sR5e3TJF
         DD12pCSluLTh2yZEQBwDylQVb4CwfKP2dCF62kUzwk3YfqMd7l86uwvSkb9UWP7TTO8V
         R2ldx6oUHaVlqw13K2SJcff9g0txS+pK2Lot+XFsbu+nKU6u4WG1jpyGytpt+4u2jqhY
         dNBA==
X-Gm-Message-State: AC+VfDy6iqeqVN0l+4KOJv4+LLPpkS3T8E4l76MD7hupoLxORe2yqh+3
        vzndyx12N5HXhhoNvuNYAsoEV3ei5vU=
X-Google-Smtp-Source: ACHHUZ4EFGRzCoy9HIdmF3SMeMQD0MPt+BAMEdUNatvkalFektmlh9Jl6bFgGrs/FhShwRnRDuMLWA==
X-Received: by 2002:a17:903:230e:b0:1a9:7424:7758 with SMTP id d14-20020a170903230e00b001a974247758mr7210494plh.0.1682707609361;
        Fri, 28 Apr 2023 11:46:49 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id bf9-20020a170902b90900b0019f9fd10f62sm13626366plb.70.2023.04.28.11.46.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 11:46:48 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v4 5/9] shared/bap: Fix typo
Date:   Fri, 28 Apr 2023 11:46:36 -0700
Message-Id: <20230428184640.849066-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428184640.849066-1-luiz.dentz@gmail.com>
References: <20230428184640.849066-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Fix typo s/BT_BAP_CONFIG_LATENCY_BALACED/BT_BAP_CONFIG_LATENCY_BALANCED
---
 src/shared/bap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/bap.h b/src/shared/bap.h
index 0d419aa74982..e9f769d0ef3a 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -26,7 +26,7 @@
 #define BT_BAP_STREAM_STATE_RELEASING	0x06
 
 #define BT_BAP_CONFIG_LATENCY_LOW	0x01
-#define BT_BAP_CONFIG_LATENCY_BALACED	0x02
+#define BT_BAP_CONFIG_LATENCY_BALANCED	0x02
 #define BT_BAP_CONFIG_LATENCY_HIGH	0x03
 
 #define BT_BAP_CONFIG_PHY_1M		0x01
-- 
2.40.0

