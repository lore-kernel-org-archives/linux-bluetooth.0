Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06063EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jul 2023 12:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjGUMF1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jul 2023 08:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjGUMFH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jul 2023 08:05:07 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8BD30F5
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jul 2023 05:04:56 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b74209fb60so27488691fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jul 2023 05:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20221208.gappssmtp.com; s=20221208; t=1689941095; x=1690545895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBmrOOAi8DD4Y+ChseAJhqkrvV1M8DrwtBBmtQH5UuU=;
        b=GaMoZMOntpMJ8DBNiNb5SMGZYsK+e1IrP3Rx+d++/W33TOIqUIPnVlFH09iTIJnq5c
         xC+QNRvy1jiV9MPD31OmSfcKrFSgiOfl76RknJwb7aQot20s+W5Tk0gSU492KcyZDtTk
         p1QVE+4wEYPgT7XjZZrw7Klqk8jULg/OkGaRO+j8gs/IB7eZbGOJCKC8vjiY7PwjIP6Z
         FzRL4h0uviZ5C7xAHZgWowFVjzp96JCazDcwhW4F6pXpJc3FPxb8ELbJWpajRRqnJPmP
         AeS4T6sVsjWre9zW4Iygh8C9WKOOgK5ASP2xnO7FyZVzULkYrdgbzorsiT5dEusfzfUP
         aWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689941095; x=1690545895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBmrOOAi8DD4Y+ChseAJhqkrvV1M8DrwtBBmtQH5UuU=;
        b=E8ivSnN2DLb8XCdzjjowJ6nXWcYzX72gNkYQq1Nl7gFEOHAravPbZXL0bMVAYZJmUp
         r9FvMdiMiuo3Yj2QCE8RJK/htjZ1zhgwLPpqmZPS9MHGm8UpAE9JORDm7Eble2OFPQau
         tERXF2XutG//d4xaTH0CVMIu/BSN/VN51dGLScl8ImqfMHwIOS9Cs+Beyv/18XRoQvBe
         GWlkMgjv8H6yLMSymohP4Y8eBq7GT9HPOaHwxJasKuBsC6rmGxcOiJ1KfqAO5903qKRR
         jwnouNvnEBaaxz9/eHxWv0XkcYOPyDphGne39cxHScUbBNy/q5Sz2N241aZzPd9xW/9s
         W9Qw==
X-Gm-Message-State: ABy/qLbwtqW/wjOkMEyHP61vMZx88I9nUMwZ9boQdNDTIhY98NSnsiYM
        ms3GtvrqPA0I/Ump1TPJZpkfQN4Lmv4gB5Dp85s=
X-Google-Smtp-Source: APBJJlGYpH5F2kru277WwSFDNiaeF8YRAZK+sJaJ6624NOZdFRhuhiiTrSv/JUn+vMceZBGARLnNPA==
X-Received: by 2002:a05:651c:d0:b0:2b6:ee6d:b647 with SMTP id 16-20020a05651c00d000b002b6ee6db647mr1297550ljr.28.1689941094948;
        Fri, 21 Jul 2023 05:04:54 -0700 (PDT)
Received: from rymek.localdomain (217.96.247.89.ipv4.supernova.orange.pl. [217.96.247.89])
        by smtp.gmail.com with ESMTPSA id z26-20020a2e885a000000b002b6de6deb5asm907977ljj.2.2023.07.21.05.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 05:04:54 -0700 (PDT)
From:   =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jakub Tyszkowski <jakub.tyszkowski@codecoup.pl>
Subject: [PATCH BlueZ 1/4] monitor: Fix adv_handle size in the set info transfer packet
Date:   Fri, 21 Jul 2023 14:03:17 +0200
Message-Id: <20230721120320.147496-2-lukasz.rymanowski@codecoup.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721120320.147496-1-lukasz.rymanowski@codecoup.pl>
References: <20230721120320.147496-1-lukasz.rymanowski@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Jakub Tyszkowski <jakub.tyszkowski@codecoup.pl>

As per Bluetooth Core 5.4 Vol 4. Part E, 7.8.90,
adv_handle is 1 octet size and not 2.
---
 monitor/bt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 37fcdaeaa..131024e46 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2608,7 +2608,7 @@ struct bt_hci_cmd_periodic_sync_trans {
 struct bt_hci_cmd_pa_set_info_trans {
 	uint16_t handle;
 	uint16_t service_data;
-	uint16_t adv_handle;
+	uint8_t adv_handle;
 } __attribute__ ((packed));
 
 #define BT_HCI_CMD_PA_SYNC_TRANS_PARAMS		0x205c
-- 
2.34.1

