Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEF5C282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 15:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937B620692
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 15:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="HDQRhdSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgAHPTu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:19:50 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:33441 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgAHPTu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 10:19:50 -0500
Received: by mail-wr1-f44.google.com with SMTP id b6so3850577wrq.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2020 07:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7NCoEDbz6IvPHVyuW0HcYC5Lash7bMjum2cStzmfUq8=;
        b=HDQRhdSQq1MPGm1M1aEjQAIUe7w7xUO/lYe8Uq43wPDfUXKU8O3czgMtGkMfs1PKHl
         NGaPG8BHr60g4ySi33fwbARzUvgISRb5gMhrL2HJBhbDDztmTd7zDD68lD6en2mMAsGH
         ilbVlMAivG9A68nJ6PONvgNKerQbpV2Rhht0/790TzHOQpIDKuK4y7dSVUOTFmKK+VPQ
         TRu8rNm7ZIBs4JecmAiMWfg66nS5NTqO3RoG2mz5uunyV2//IHmWGmarfVtQLN7XblzW
         5aciUHNXoK3AminC6RTYJdjmuVbqM6qWAJM7nYqOJ/4sqm4wD+ScJYsGXfalb8qL418n
         BE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7NCoEDbz6IvPHVyuW0HcYC5Lash7bMjum2cStzmfUq8=;
        b=ihEojdgKums7m9xcNyjHiSxNVvZqjVncI3QsHEPSyD08M0vwEY18NLImdhIrBY/JmX
         7+BbIm9FuLFPaJnGIcvk3CyYSP+REQQNQzjBXslKMUTLBy3ydJ3l/gReJN95btOhchV7
         qn43rjVticzzWWfLfKkMEq0wgU3emhxbuykejjdI4xY5IRx/kxIGak6dQ/tEtT09CA/B
         yLr5xrPQK6PxXgPSSBAMMo/feFONOsWU6uesviyf4OwQWO66oo4OfW8pjoB8L8pvDq7s
         i+nz0+7OiDfTwzZVlF0cF0S9nCRNCpwOdJobLkgHxrcfKlTOAAz212O2OjtGAgwvrJe9
         v5xg==
X-Gm-Message-State: APjAAAWqSlw9X12PUd1KFgTM1/PmAKG3RWjayd8IxyHpu4O/uQ1SIYJl
        8t6E1C1L43cyUPfkZL3tu7ci6YjmbtA=
X-Google-Smtp-Source: APXvYqwA3qT1zffMR9wh6+D2fbJ9sYBct7JmDgfX48gSNzA72ADOcGG0Y4MvaYCRmwmnN4a0ad//1A==
X-Received: by 2002:a5d:4045:: with SMTP id w5mr4802386wrp.59.1578496786808;
        Wed, 08 Jan 2020 07:19:46 -0800 (PST)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id w22sm3935552wmk.34.2020.01.08.07.19.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 07:19:46 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Remove misleading DEFAULT_CRPL from node.c
Date:   Wed,  8 Jan 2020 16:19:41 +0100
Message-Id: <20200108151941.14609-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/node.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index 31a986d06..0ad935105 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -56,8 +56,6 @@
 /* Default element location: unknown */
 #define DEFAULT_LOCATION 0x0000
 
-#define DEFAULT_CRPL 10
-
 enum request_type {
 	REQUEST_TYPE_JOIN,
 	REQUEST_TYPE_ATTACH,
-- 
2.19.1

