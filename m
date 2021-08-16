Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6F4C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 14:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6226A60FC3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 14:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhHPOal (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Aug 2021 10:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhHPOak (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Aug 2021 10:30:40 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB96C061764
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 07:30:09 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id c12so14478114ljr.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 07:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0XPd3kE3S+5kYRIU9mJV1XHj/UDJkpccxP0oA/GqjDo=;
        b=HpEytukT5MCNJaCisOD6tYgT/tBkz1yvEn6sWHXehDVrT3YmjwuOBQkG4nFu+SVNIl
         fDKenlYPJRBk5435wFKpw3fGXDdsiX9kBAzDPjCUurFRhKaXUUhcfpxBux0ejenGi6i/
         wDRQfdVDHSOxtXC16pU5RFrNHjtmcvcbJiTYEZVCQdYyQ5EG6EmmAKMok7OT11JVRj4e
         dAU2+7/NPuaOXTgnBWpZBqTW8P3x6HFZWb9Gsh3tmiaHu/fp5Z+OPYMYkC9CzvXCj6Fy
         qSymjFPPU4ZWdj9WUclqVNgpH323GfjLAoihLKmzu8qmhBGqzJVdFh3utf4p717Z5mUv
         3/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0XPd3kE3S+5kYRIU9mJV1XHj/UDJkpccxP0oA/GqjDo=;
        b=kUJvoLqG1dTiA6slVu6YyMOULHF860VfK2jpvYAXOrI1zo+wcy7r9m3jMNKYRypZcG
         nDWgeeTFVcEAfq9Vrdc0XbF+8ZDpIJCbo4TMbZ/yAXa1esvE+qubkDfAskQ0MKWpQykf
         2NXZjDBqVpcJKQnrY6Q+VFHtMnhi3KqdCbIpO9BR2IiDF07YfhA7biuabhxUoe2rpBa7
         pGPKPmKRgWmYZcr/2AiVs6yqn9vR2D+joX3R2QLUXHoueZg4eeMgtoc1mB+iNQZBB1Ma
         c7I5WV5c3DV3KkZKR9JZlnewFa+J4X62viL/8iPUXDEmJ5BFhm4NocpIwjAJ+hVLP7tQ
         91tw==
X-Gm-Message-State: AOAM530wAOmAZzDUFLZNwI1u7i5Tb6qzYBa/KUMr+ey8Pf0VAuUth74m
        56KWD4JnUSAWCedokITT4OLfgFPUW1586Q==
X-Google-Smtp-Source: ABdhPJy+WiyoHoNMhuS0NyQ0zmYCdBK6DYHsqPhm0IJoHTMl2+WXqczsbmOs6MpqktkRAp6t8m6ICg==
X-Received: by 2002:a2e:95c1:: with SMTP id y1mr12809596ljh.71.1629124207405;
        Mon, 16 Aug 2021 07:30:07 -0700 (PDT)
Received: from localhost.localdomain ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id t142sm959619lff.269.2021.08.16.07.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 07:30:07 -0700 (PDT)
From:   mariusz.skamra@codecoup.pl
To:     linux-bluetooth@vger.kernel.org
Cc:     Mariusz Skamra <mariusz.skamra@codecoup.pl>
Subject: [PATCH 2/2] monitor: Fix logging of CIG Test SDU Interval param
Date:   Mon, 16 Aug 2021 16:29:56 +0200
Message-Id: <20210816142956.1690272-2-mariusz.skamra@codecoup.pl>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816142956.1690272-1-mariusz.skamra@codecoup.pl>
References: <20210816142956.1690272-1-mariusz.skamra@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Mariusz Skamra <mariusz.skamra@codecoup.pl>

This fixes log of SDU interval in StoM direction.
---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 210c03259..74d9a87a3 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -8083,7 +8083,7 @@ static void le_set_cig_params_test_cmd(const void *data, uint8_t size)
 
 	print_field("CIG ID: 0x%2.2x", cmd->cig_id);
 	print_usec_interval("Master to Slave SDU Interval", cmd->m_interval);
-	print_usec_interval("Master to Slave SDU Interval", cmd->s_interval);
+	print_usec_interval("Slave to Master SDU Interval", cmd->s_interval);
 	print_field("Master to Slave Flush Timeout: 0x%2.2x", cmd->m_ft);
 	print_field("Slave to Master Flush Timeout: 0x%2.2x", cmd->s_ft);
 	print_field("ISO Interval: %.2f ms (0x%4.4x)",
-- 
2.31.1

