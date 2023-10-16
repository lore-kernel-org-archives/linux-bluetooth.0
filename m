Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152AFCDB465
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 23:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjJPX6I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 19:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjJPX6H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 19:58:07 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5732092
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 16:58:06 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5ac88d2cfaaso2578231a12.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 16:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697500686; x=1698105486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vl0A0wS4mipx03/z/XIztqTRHHUzp08WNJNVKjlc1zs=;
        b=AenvYRN/l73jU99J7HhAUCjTLAeBAvHKgKBnVAYpu05RfSAn3bz62hDMHD2IpnBoqd
         +GNtfpKTu4CuHCU80yIeH4bpY5BVbXmaA3bvEp3y0h8HVGJNhzieXIm4Moh3ioKz7BAq
         ntKleORXdStDO9F/xzrGS7SvJhXXSapyk1uiO7quFQMiYSYtQwhrpM15haWVKPNoVLjE
         Go47cKk/jWwR4sbCe/S4KGxLTW6SIdk+amWjv9sqIflW0oZASseHN+QmfdPVqAdfBlOQ
         Jq3gyKDyFvvW/fJAB03KVE6iUmoGlCzKQuztOASOj7/9BW7bo5dG4I0XkhrpaQHDBadX
         jWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697500686; x=1698105486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vl0A0wS4mipx03/z/XIztqTRHHUzp08WNJNVKjlc1zs=;
        b=v81cs7Ic0zTBEAmtIgxxi+V6pKLJ3udAoxjgYUUD1bLuw4MKmVBcdLHovNmVk9+y73
         4ZKcNyadza9I8wAw1ZdkgsP6Kmg5wSffgSaFPDcUZBCHkmd75R0tqWmGuu37vd4DYlh9
         6tjeMzofaGtfusNn0iAzOZ78D55PjYrfgCVyktL+BwTG3J1I2Jm62o1gGLWwXjkpdlTE
         9/f+uIXAaOfbp818ou67M1rbaKKT7WKYEo2KIt7Qe1E2bGQWs6k/FeaR653cOafV3iqO
         a/uiDbV5V9OvCIYPP75NYFnmyXhf2cUSGA8UujEcAg1BEW3zIdfcaGYbUuL+TRZlz+8B
         28ag==
X-Gm-Message-State: AOJu0Yz3v7tpoAI8ctnpCwV1andr5d5uGw0zhzmsDfNLaQWyAvJekBNg
        1y7EnGu14jB9YSEIk3HGIl2+5V1HLZOLOA==
X-Google-Smtp-Source: AGHT+IGmQeLWQX8wEO5IG4S041jvH4jmY1jXALTqkGSXNA4OkDBcBNnkzUGIdtF/9D6wYhCfHjLXtQ==
X-Received: by 2002:a05:6a21:a108:b0:136:e26b:6401 with SMTP id aq8-20020a056a21a10800b00136e26b6401mr576977pzc.16.1697500685506;
        Mon, 16 Oct 2023 16:58:05 -0700 (PDT)
Received: from fedora.. ([2601:601:a480:c78:c3f1:c438:9351:a6f1])
        by smtp.googlemail.com with ESMTPSA id l185-20020a6325c2000000b005898a3619c7sm190178pgl.48.2023.10.16.16.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 16:58:05 -0700 (PDT)
From:   Inga Stotland <inga.stotland@gmail.com>
To:     brian.gix@gmail.com, luiz.von.dentz@intel.com,
        linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@gmail.com>
Subject: [PATCH BlueZ] mesh: Fix check for active scan when using generic IO
Date:   Mon, 16 Oct 2023 16:56:37 -0700
Message-ID: <20231016235637.41364-1-inga.stotland@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This modifies the check for an active scan in generic IO:
the bug has been introduced during earlier code refactoring.

Fixes: https://github.com/bluez/bluez/issues/625
---
 mesh/mesh-io-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 00932ade7..2afe440e7 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -781,7 +781,7 @@ static bool recv_register(struct mesh_io *io, const uint8_t *filter,
 	bool already_scanning;
 	bool active = false;
 
-	already_scanning = !l_queue_isempty(io->rx_regs);
+	already_scanning = (l_queue_length(io->rx_regs) > 1);
 
 	/* Look for any AD types requiring Active Scanning */
 	if (l_queue_find(io->rx_regs, find_active, NULL))
-- 
2.41.0

