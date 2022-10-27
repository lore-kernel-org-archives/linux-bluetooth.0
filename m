Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F49FECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Oct 2022 23:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbiJ0XZe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Oct 2022 19:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbiJ0XZc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Oct 2022 19:25:32 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E3F7CAA1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Oct 2022 16:25:31 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 3-20020a17090a0f8300b00212d5cd4e5eso8182241pjz.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Oct 2022 16:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5pQcjZ2AoGE1iTsgc2FGFzyNM0oaVKvF+dWfv0kyF6g=;
        b=qqx2j4I7jc8g566JCH7Aov1/FhXYmQEJafyWs1Vk507ZlJ2yGgsYuYDSUIz/d8Rdku
         Mz4Hy1E5yl35cXH99rYZuicRXVWJWk3gaEWUmPRMpTONvFYjsDBc3HmTXa1qo2IA79Qv
         VP/Nfa/KqrZwjqdLN3akpBWmOVX9HFhVVcj00XdAY30WIewWz1wdEXgDTERPCYft8nPy
         o2vaeEhtOOXd421zrT6yCeiGn3lF2hR2cXFLgaFaYsXtD3BwcDMLdpveIWmCOHBi/wdF
         m2a4Wt6xxXuU0DRyiUTyg7fbg5MEcQTizDGbKl9+0xDHJe9cDF2AoUfnZ8z8mnmgn478
         uJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5pQcjZ2AoGE1iTsgc2FGFzyNM0oaVKvF+dWfv0kyF6g=;
        b=5rEjhb7IEQbbdYgsUiZHNRjvxzM5JknL1H65+tOXIH5q3fDUZiNBsWBzacX5OVixQQ
         542bazkeFGDrTEEki6sqqHFRgTtb30gSNAbEA6UotW3vWm1uUepdkQIl1SWVa6pDjLmu
         ADjfkEy0jWJjfHkgKbD3hZ5MKbA+xJD3b4OrdEqaL4k9lGCDeUD0A36D9rZZvsnSOGL9
         2/8+ZNksibDowREKjyJsdrixrZewA/BLVEEbk/hWy5Nv/MsYgvDF2Mf5SFUrTbEZXD3S
         C+Tv+2Z2D+kx4rXwF5DsF7sS8j2X4S2mUDMazFKsZYMZZaLZkaP0qTfQ6JGLU0KH2Bwv
         ODLA==
X-Gm-Message-State: ACrzQf3kLUmk1piEiIrHfkOhf2cNmFOQ2319gNUCE4wv0DggAnK4LVYV
        98Zl3h4RPrXSMJa0cuefnEyndSNLNOM=
X-Google-Smtp-Source: AMsMyM4S9l6cimsjgqeqGLHwh3/twMUy7CXDzkqSg6rv6CIi53vZWasL3mh5hnAHxibk5TrHYL5hKw==
X-Received: by 2002:a17:903:4ca:b0:179:d21f:f04b with SMTP id jm10-20020a17090304ca00b00179d21ff04bmr52554172plb.7.1666913129978;
        Thu, 27 Oct 2022 16:25:29 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 11-20020a170902e9cb00b00186b9196cbesm1695858plk.249.2022.10.27.16.25.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 16:25:29 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add CONFIG_BT_LE_L2CAP_ECRED
Date:   Thu, 27 Oct 2022 16:25:28 -0700
Message-Id: <20221027232528.1996093-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds CONFIG_BT_LE_L2CAP_ECRED which can be used to enable L2CAP
Enhanced Credit Flow Control Mode by default, previously it was only
possible to set it via module parameter (e.g. bluetooth.enable_ecred=1).

Since L2CAP ECRED mode is required by the likes of EATT which is
recommended for LE Audio this enables it by default.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/Kconfig      | 11 +++++++++++
 net/bluetooth/l2cap_core.c |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index ae3bdc6dfc92..da7cac0a1b71 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -78,6 +78,17 @@ config BT_LE
 	  Bluetooth Low Energy includes support low-energy physical
 	  layer available with Bluetooth version 4.0 or later.
 
+config BT_LE_L2CAP_ECRED
+	bool "Bluetooth L2CAP Enhanced Credit Flow Control"
+	depends on BT_LE
+	default y
+	help
+	  Bluetooth Low Energy L2CAP Enhanced Credit Flow Control available with
+	  Bluetooth version 5.2 or later.
+
+	  This can be overridden by passing bluetooth.enable_ecred=[1|0]
+	  on the kernel commandline.
+
 config BT_6LOWPAN
 	tristate "Bluetooth 6LoWPAN support"
 	depends on BT_LE && 6LOWPAN
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1fbe087d6ae4..ef725ed41303 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -45,7 +45,7 @@
 #define LE_FLOWCTL_MAX_CREDITS 65535
 
 bool disable_ertm;
-bool enable_ecred;
+bool enable_ecred = IS_ENABLED(CONFIG_BT_LE_L2CAP_ECRED);
 
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN | L2CAP_FEAT_UCD;
 
-- 
2.37.3

