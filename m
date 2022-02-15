Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E4CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 22:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244637AbiBOWuP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 17:50:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244257AbiBOWuP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 17:50:15 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555F7D5F4D
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 14:50:04 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v12so486038wrv.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 14:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jP3aOQGvYKZFwHgBVUjtWfL4c8tq1Gfdx3ppGs7rn9w=;
        b=PfIM6MkvlIRSgA+c9sGRXblKFpl+meN73jRC7LY++Wr6cy27/ebqlDgvKlr5Evq0O9
         q/eAB5Yiu2btvLypfPhDnUvnRklc5CvaFJBnEyT0xnwR9SDhLgBpTRXLnS8MI9DU380j
         /PTFqyFem+WCzXlTt8W1/wYuHBB7sasGvV0RSaOhm7Nx4tPJvBiVc3dv34/XicngkqN+
         twiPP3OFCpBeKZ+cbDjIlkCPLCNZSwvDD3jC8sS1HD7i2NI7xBUX+TuUhl/Bs5nxMUVP
         1QsIYBAJduUQBqfc1roxaaYrKwIDBu3dSz+LZR+SsP2y2onuYFSDomXPouhR3Gfs8Ikz
         4JKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jP3aOQGvYKZFwHgBVUjtWfL4c8tq1Gfdx3ppGs7rn9w=;
        b=hV1/w5xE+Hqfoa2NrbPJI8iPKCwH0pwERToCXL3mf1XLusBfITteDy2zA4Z8BNfNi7
         lgEU++73dGV5nh7DCgfjuXc2GUgSTDxVxJphOvxpsaMNXaMgqk0tiukoZj3KZeqIKmCN
         Tj+8fV21p9qEqPwq0z25sixG+hy+e54+HcKMQPBFjWXzlKvd9r6LjUNRbJ2h2E5207wG
         B7LJk1ZXQkqq/LK4tLjM3TMr1Tgtfy+391xBwsiK6r4CH4v8fFTSJGZlRXlqzVkGVPK8
         qPuAojFGKoWxZZbN84W+w9A4lyFOsGfnudHwub6NNuofyXoyGvHc4SNNLIes32QNW+WE
         +3hg==
X-Gm-Message-State: AOAM532SXOETm3MypsouO9Ri5e4o4iBS1sH/afPFPs+x6tMMml4t0Q5o
        2BK2dAR8f0tn4gyoGK4ofUq4CR5V8uA=
X-Google-Smtp-Source: ABdhPJwJBqfscYjHDP1mBv8aUPYCFFP7k4ldqBNvY48/w76vCQvKO3d5WiV6tZKBcW7ig2n6p3/RyA==
X-Received: by 2002:a05:6000:178f:b0:1e6:f1ca:3f96 with SMTP id e15-20020a056000178f00b001e6f1ca3f96mr102574wrg.145.1644965402570;
        Tue, 15 Feb 2022 14:50:02 -0800 (PST)
Received: from kali.home (2a01cb088e0b5b002be75de2a1caa253.ipv6.abo.wanadoo.fr. [2a01:cb08:8e0b:5b00:2be7:5de2:a1ca:a253])
        by smtp.gmail.com with ESMTPSA id b4sm26482522wrw.100.2022.02.15.14.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 14:50:02 -0800 (PST)
From:   Fabrice Fontaine <fontaine.fabrice@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Michael Nosthoff <bluez@heine.tech>,
        Michael Nosthoff <buildroot@heine.tech>
Subject: [PATCH BlueZ] tools/mesh-cfgtest: include limits.h
Date:   Tue, 15 Feb 2022 23:50:15 +0100
Message-Id: <20220215225015.3568246-1-fontaine.fabrice@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Michael Nosthoff <bluez@heine.tech>

mesh-cfgtest.c uses PATH_MAX so it should include limits.h.

fixes compilation error when enabling mesh support with musl-based
toolchains observed in buildroot autobuilders.

http://autobuild.buildroot.net/results/20cc47f54de0b0d4bdf108c3715c590ae8ab476f/
http://autobuild.buildroot.net/results/003968b25906579dbcf5a95d1e43fec0ab504ef5/

Signed-off-by: Michael Nosthoff <buildroot@heine.tech>
---
I'm sending back this patch as for an unknown reason, the patch sent by
Michael in July 2021 is set as superseded in patchwork:
https://patchwork.kernel.org/project/bluetooth/patch/20210722204923.29735-1-bluez@heine.tech

 tools/mesh-cfgtest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/mesh-cfgtest.c b/tools/mesh-cfgtest.c
index fa0474faa..116ab7f16 100644
--- a/tools/mesh-cfgtest.c
+++ b/tools/mesh-cfgtest.c
@@ -21,6 +21,7 @@
 #include <ftw.h>
 #include <getopt.h>
 #include <libgen.h>
+#include <limits.h>
 #include <signal.h>
 #include <stdio.h>
 #include <time.h>
-- 
2.32.0

