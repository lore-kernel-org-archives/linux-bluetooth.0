Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1346FC04A95
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Sep 2022 04:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiI1Eyu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Sep 2022 00:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbiI1Eyp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Sep 2022 00:54:45 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEE413DE2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 21:54:40 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id e129so5147493pgc.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 21:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=AE1H7Y+htqTh2jhj/NgGwZWOi7FiWN2k2y5sky93uu8=;
        b=PTgZ/eExsr1+kRNxcbj0WeopofO6xk8zQODK2qtI72Oo7c3QzRmhdSMBSL11f7aILs
         8fxKA72nlaf4QJEn7RreZW4T2QsNEE1O/j03idmOOX/TQgrmYEuHCsH7WUQRPvht2G13
         bPJgZOvplPbQDo3Ur2OaDaU8k7Ke9mpBf3dCnpZLB6ZJPleKnkbecXu26AiuhhNufAlq
         q8P607smXfQ+E3X11tUXYD8pD87uCTsi+PJO52ZXH4W9XliQ+Vg0QvJB3DsX6U0ymZf+
         ilEuvSXaVmQ1QsFpjxD3qD4YLlwa8PnxYLlUhwc6w2qtAZpBAH5rIntmS/fO3AXZFFNN
         ib3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=AE1H7Y+htqTh2jhj/NgGwZWOi7FiWN2k2y5sky93uu8=;
        b=Mt66uRz7VurmiP87Fn+4Do21iUESJSF3ouvHqAn98uok0aU4+zswDftnoiZryg9+Rc
         k5kK8qMnq79UZArC4LFPirirvjmP5Ei5R1jQFENwIp0b4hTB7578v1GSpzSwTpbe8mHT
         JWWwkJ5nOZ09vczgabEE2P1ZU3Aa3cSn7lVyDZVyxThLWazj7hlVrG7CIfG86Bc/HioN
         ONIUZWvlT9V3xD16CYlvB8jwWdKm9do4AQaekdiyiQVkRT2bCSbA5csqhYYIPezoIARI
         evgzgYR6Dd7KyRaOuNlCwbALE9se3aOk/8ZqPtu8IaVm7CVKd29a6oK4THbX4UcsGe/C
         pYQg==
X-Gm-Message-State: ACrzQf3Sh8Dj3nVTg9cIVeMu/DlixAIf4VLVGCXIEFxayUEUElwoJe+c
        LiZExrZ22q5g3kbmsz2DkBTdG9w7M/M=
X-Google-Smtp-Source: AMsMyM6Eycsd7tLbV9DmPZ6jmhUH/VUf7mpdh7A7MaaMWWgKkLVOmLG+3khe0l3lSpJoQ7QUd4IQeA==
X-Received: by 2002:a63:187:0:b0:43b:cf3c:c64d with SMTP id 129-20020a630187000000b0043bcf3cc64dmr27497755pgb.359.1664340880189;
        Tue, 27 Sep 2022 21:54:40 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a80:cc40:b354:2fc2:b868:bbb7])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b001641b2d61d4sm2520073plg.30.2022.09.27.21.54.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 21:54:39 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2] doc: test patch - DO NOT MERGE
Date:   Tue, 27 Sep 2022 21:54:39 -0700
Message-Id: <20220928045439.210967-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This is the test patch and do not merge.
---
 README | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/README b/README
index 3dc226ff1..8773d97a6 100644
--- a/README
+++ b/README
@@ -5,6 +5,8 @@ Copyright (C) 2000-2001  Qualcomm Incorporated
 Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
 Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
 
+IGNORE THIS PATCH AND DO NOT MERGE
+
 
 Compilation and installation
 ============================
-- 
2.34.1

