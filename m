Return-Path: <SRS0=9IM7=WP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE68C3A5A0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Aug 2019 09:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795142184D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Aug 2019 09:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="bzhdYVJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfHSJdf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Aug 2019 05:33:35 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:37009 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfHSJde (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Aug 2019 05:33:34 -0400
Received: by mail-wm1-f49.google.com with SMTP id d16so876105wme.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2019 02:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=V+zx/MM9fEvktxddrGMjZaLEVWWNfSqBv04bsfJ5SKM=;
        b=bzhdYVJe0tJAEavGvv0KvdE59b48uCa812M90IZSDnn1wiWohHh9JqrZf2kMhw3INb
         R5spq4WO6XApHrBlnIqmhdjTsw6W3FFd8Rg7P4dqPqaEA2whYG7RsPfDO8h4/aneMAXT
         2pLBoac6sDQsDAFdjSNOHNwxibFzIO8f8wejQfRk4p620IvZB7+GLGmxrr/UahmXacPP
         oIiOSkkSuXsUsmTPR3YhDOAOer4kNP/4dK6vjtPCNwPliUMtPl6Yic5cCy37BSMPhWlz
         Bklf7kByr545dQLWJCNs4yN5koMxc4mC7h958JnVqAMOXUpoRKDNVjfMj5+LEo9ntW8X
         4CBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V+zx/MM9fEvktxddrGMjZaLEVWWNfSqBv04bsfJ5SKM=;
        b=QajkpwQhXc6MXD2d9imq1uGU1vCwJGWbgMPSBcnw2iiDOv/cijqXH/sTntoNKpiM04
         xfF5+Zysw4pJLrn6+eiSech/LWErlxWRKZxNhLzM+6lI9ugPjYk129nSp/LLSiBKWDlZ
         GC6+mshlJQ11M8rO43Yu12Dr9pOn7O+pPrUICC1DjudFESCxRAksXsq78DqvgN5ceMza
         IN/0cLqDI9g00SGqLKxdv0pYf73MmqUk9KEC2dMGAwAFA5yw1j+/Yj5fvGmrEIQv7lRO
         YFURolhYJOueThvzDPGkOwNA+dlMDgbwBbWVvwdfHVXheSnrH1aS+4Ko7Df9Fa6+PVXp
         +U3A==
X-Gm-Message-State: APjAAAV2S51Xi3iF8LRhUuC7wsCwlD288wE4+9ahAgERYI3J+6lIm15q
        j8V+BeUruhvdLFnf8UDqsY8MtPrQRFw=
X-Google-Smtp-Source: APXvYqwjJNiolxXpB2Ov0WrI8Db26zEnTxFXh19HLUGizRKC/YsksZaaFx0OE8CuAgs9F16b9CCA/Q==
X-Received: by 2002:a7b:c8cb:: with SMTP id f11mr19529226wml.138.1566207212566;
        Mon, 19 Aug 2019 02:33:32 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id o9sm21675360wrm.88.2019.08.19.02.33.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 02:33:32 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] mesh: Remove unused defines
Date:   Mon, 19 Aug 2019 11:33:21 +0200
Message-Id: <20190819093324.10566-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190819093324.10566-1-michal.lowas-rzechonek@silvair.com>
References: <20190819093324.10566-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/crypto.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/mesh/crypto.c b/mesh/crypto.c
index a6dc7ffe2..9862e5856 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -26,20 +26,10 @@
 #include <sys/socket.h>
 #include <ell/ell.h>
 
-#include <linux/if_alg.h>
-
 #include "mesh/mesh-defs.h"
 #include "mesh/net.h"
 #include "mesh/crypto.h"
 
-#ifndef SOL_ALG
-#define SOL_ALG		279
-#endif
-
-#ifndef ALG_SET_AEAD_AUTHSIZE
-#define ALG_SET_AEAD_AUTHSIZE	5
-#endif
-
 /* Multiply used Zero array */
 static const uint8_t zero[16] = { 0, };
 
-- 
2.19.1

