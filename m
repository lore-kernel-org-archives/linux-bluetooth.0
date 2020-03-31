Return-Path: <SRS0=zBKN=5Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7DCC43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 09:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D8F208E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 09:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="QbfqucLX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbgCaJXH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:23:07 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:47098 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730559AbgCaJD4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Mar 2020 05:03:56 -0400
Received: by mail-lj1-f195.google.com with SMTP id r7so13471082ljg.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2020 02:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kN5+s+x9+6gdWCPe/jaSQAx6k7/V/+KKt5W9BglApCo=;
        b=QbfqucLXgVw4s0z1Ut8WN9zRY0xUTOGDADbjoql/cX8tapIV1nvyzoEqu/e0+CLev3
         AH7jaXdz21D9AhRDRxPZfdFO0ModNU5W029geLtwu/s6jZ9nxojTMg5d4UjfqML3p6wa
         18NWVEDGWG/k8cEOStRvXmTGWLptILxuwCHoJRst/FV011wHZ4bOzgJ28CYn7QyHYfn1
         /h2EpuoTpfnlPR+RWp+Gp8uRJKwhbdZIJCZV2gCUZOIdUAcImcNvv2uuNLiCk1lvACf4
         GlA9saORyF+GGUjzQQ66utghkb4oOZdiVBzYellpuvHm0z/mlcGpUoKJkr6ncN0aA4e2
         0NMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kN5+s+x9+6gdWCPe/jaSQAx6k7/V/+KKt5W9BglApCo=;
        b=bfNqhL0ERz7ov7MnPL5c5CTKZ1cLmyeJH1KVAmxuE93/GpNEVPLn0z3Cm+u3WhwPmE
         oA9zkyO4loYBzP/kwo8XwQQFBWVI+YPWY9Ie7fY3IpzCSbcasiGebSSxZZBc7X/08qda
         +oZlljt4EigUbEK4h1rBxLbMA4He9ndH5sOK4gCS98cyYsrnqpCjuqrdyCb7DfxMvBeU
         jI89B5DQg6b5AUPo5QsrYDj/S+tKZGlBMW4YCGqPj6hXzwliTbX6mknO2cPBOFLePVL9
         5407d3ZFpOIiU/HRh/GVXMhBq3Q5O9PYl7wpKiDaPxgSBK3+Z05jFY0YL9fPFDMl67dI
         EtiA==
X-Gm-Message-State: AGi0PuZeqAyXVaeN3oLXYH2Sp24N2Oa4FxVJDAy0wkrwAdJjS8LZ8mnx
        H72cb5d1HTd4DuBf/YtbvHCHg5jXe0HbuQ==
X-Google-Smtp-Source: APiQypJL+kLJBHZj52ma/o8mRCODKZViUMHyiLR1m2N0ahUVGpCuU2qmXsJlLsh1CTXp6+fqkaijXw==
X-Received: by 2002:a2e:b4e9:: with SMTP id s9mr9537587ljm.108.1585645434008;
        Tue, 31 Mar 2020 02:03:54 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id j13sm2603668lfb.6.2020.03.31.02.03.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 02:03:53 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] mesh: Fix FPE in overcommit logic.
Date:   Tue, 31 Mar 2020 11:04:00 +0200
Message-Id: <20200331090400.18379-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

During overcommit, mesh_config_save is called in asynchronous mode to
avoid blocking Send() calls. This means that update of cfg->write_time
is scheduled via l_idle_oneshot, so if the next Send() gets scheduled
first, the code may see elapsed time of zero.

If this happens, then the overcommit logic was already executed and the
overcommit is pending, so we can just return.
---
Fixed the commit log, sorry.

 mesh/mesh-config-json.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index ad2d4d0f8..21f2cfc37 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -2014,6 +2014,12 @@ bool mesh_config_write_seq_number(struct mesh_config *cfg, uint32_t seq,
 		timersub(&now, &cfg->write_time, &elapsed);
 		elapsed_ms = elapsed.tv_sec * 1000 + elapsed.tv_usec / 1000;
 
+		/* If time since last write is zero, this means that
+		 * idle_save_config is already pending, so we don't need to do
+		 * anything. */
+		if (!elapsed_ms)
+			return true;
+
 		cached = seq + (seq - cfg->write_seq) *
 					1000 * MIN_SEQ_CACHE_TIME / elapsed_ms;
 
-- 
2.20.1

