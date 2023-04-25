Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAB8C6FD18
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Apr 2023 20:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbjDYUrp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Apr 2023 16:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236279AbjDYUrm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Apr 2023 16:47:42 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2D3146D3
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 13:47:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-24762b39b0dso4543560a91.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 13:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682455661; x=1685047661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PyJuAfdd0PCphtlEtD2kGWX3K6vfEm8PSzDy/C8YZhE=;
        b=Pyr8CkceIoWNPUdAVZMqDtETVbTta4q2PkQ1OtxQ1VSL+A8o74JA9dYWZYdighOvdZ
         MWgzPYabDmCbmmvOOFHpCApobz9MQgg0VENe1RcWMUTAd0ER8wY0rjPAZt9nykerN23v
         XFDiC95fzEJwTXlTygHkeA4n5qjkGUeyPVZSGoKe7MBb4aSuHTwKzjtGGh7R4K6AUBD9
         Ag0bFqPctgcxI28X9yaEDmkU1AcVSMDFw1p3RBWLeEq9Tv5p29kL5w8KG8oBiyGq2tlt
         cDyFmQNyZA8WHtnoj/37UmGurABw92WzN1LkWPIX/qzLO4w9+Ju26U0+kCnJrMO9cJTA
         D0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682455661; x=1685047661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyJuAfdd0PCphtlEtD2kGWX3K6vfEm8PSzDy/C8YZhE=;
        b=U3xr4OPZTXyv9OsfJaP2lchzkqCZGAie1G/yy4XKQnDfExtQvP98qYxN14nBK8EQRu
         spa+teEzQxEVyJtuprpINulftY8Gf8iIgawtu46+tnHpzfNWSThOn4pf33VtWiNZbx9T
         LtvX9ZpdKCQpNoBVPwoJmKSGXVRauU5wfZOBw3zd7d/h4ZdfwoEbAAzI4Iuxczkm7MdS
         A/lKTIkRbYinEK7u253z1kNZWBfpzbnyCrCr87WSJOtYMlkXqAUU7hnmT+8J8C2RFtd3
         JI4epJsGwE5istVSchnGlsiEU49nLAUwxOY3GgJXy6bN4nwCa/0LknMw3AxWY8Che/QN
         swSQ==
X-Gm-Message-State: AAQBX9f29dBrp9Jt5wFs+4ZXYeh9Bz3/0OjLL5Kd5gNWPJOU/YLzi38x
        pEcUR/xjCNieNJsZwleXU52Fvouim2g=
X-Google-Smtp-Source: AKy350ZFB/HFQyRXh3yBWHocvP/xgwLFh5Awl3eQw/Fnd/YV3Hcx2Kg8R/+2axUfFBUOvQ8r/j+6IQ==
X-Received: by 2002:a17:90a:a904:b0:246:896a:408d with SMTP id i4-20020a17090aa90400b00246896a408dmr18444780pjq.14.1682455660664;
        Tue, 25 Apr 2023 13:47:40 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id o5-20020a17090aac0500b0024677263e36sm8247454pjq.43.2023.04.25.13.47.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 13:47:39 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/7] shared/bap: Fix typo
Date:   Tue, 25 Apr 2023 13:47:27 -0700
Message-Id: <20230425204729.3943583-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230425204729.3943583-1-luiz.dentz@gmail.com>
References: <20230425204729.3943583-1-luiz.dentz@gmail.com>
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
index bd13abef9ce5..b080324f9525 100644
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

