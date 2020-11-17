Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99ABC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 19:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D06E22202
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 19:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNDFgyPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgKQTGK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Nov 2020 14:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgKQTGK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Nov 2020 14:06:10 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F47C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 11:06:10 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id x15so10775827pll.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 11:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VX1oJAPUAQ25o7Nmy4FLHfajPo/rCOOY1sNzllb2oL4=;
        b=LNDFgyPLtXP0QGZbqMgkJEftOecYE0Am3p9NSz6h4L4yg3bf7u8Gv2ElWseouUN71O
         uhPfAvforgZnhkHcduUvoTflrFQagL0Sz4lZXtV4xJlFR/jeVtigYMEkh18W4+ZcxXXi
         aVLr1y7EJQt5BJN5utrwvCVOvv4pLQEKKdlP7qP9/Acoi2lgWfwbwgnmtP7FTNBHQUEN
         fdtHStLeWE55gDmmcQuk38gNjSJujT50OWeJpD51+9vNNLlEBrCgrdCzlaYlFANFQ5jt
         cMarGZvKgUBCuibq9ZwRVoRnR1stGlagbyviBPCVoYWpFhfHpyzFLTqGpIQyNR8WonKK
         e3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VX1oJAPUAQ25o7Nmy4FLHfajPo/rCOOY1sNzllb2oL4=;
        b=ZR2YU3JfO40wY4h3STQBtNzr2yeUI1LGzoES5mBO80Z1dOc4j00cR5LfvZoNn9t1oF
         B4f1k/JFasx9mSHIvRJP2RMrRoqocerdGj5eJtcMQkl34axEKFCzKe+P2uqJ4NCMCFUX
         dTHB7GS1Ank/T7YzB7zsVlyGpawmEK9rGL0W2p72pI/Hoi0Jy8PcmvExzuazkhqp8NpL
         OLfEwJfdt5Py64BuqpgDkOLET5lBEzpo7p6zVt+KTutaksjtRto1BSOofuyjVTeFhlQW
         bh76zavnDh3yZMgZaCUAgFxbOxyPVZgF7E2wWVl2Uxwvc+P1RRB0sdUq7DmReZt6ipmq
         nvvw==
X-Gm-Message-State: AOAM532IWR42Jbo7V+9UGEDePDK4d8PriTs+4H+Df5bpvJUU2SXbtGkm
        nrehcmRqH13o8HM5Y3CIxFT3UR8sU5Q=
X-Google-Smtp-Source: ABdhPJxtEsHoj2lhOOXMkmlZB/ICBqSabQuqXlj5P0XJeNlHSKPW5NUdUqE86T5KkP/8kiwPtuS6DA==
X-Received: by 2002:a17:902:b209:b029:d8:e821:d61a with SMTP id t9-20020a170902b209b02900d8e821d61amr571936plr.58.1605639969530;
        Tue, 17 Nov 2020 11:06:09 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 194sm22122041pfz.142.2020.11.17.11.06.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 11:06:09 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] test-runner: Change qemu output
Date:   Tue, 17 Nov 2020 11:06:06 -0800
Message-Id: <20201117190607.50483-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This changes the serial device to include mux=on which enables the
output of early kernel logs.
---
 tools/test-runner.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index a53b468f4..0c5daf2d9 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -195,8 +195,8 @@ static char *const qemu_argv[] = {
 	"-no-reboot",
 	"-fsdev", "local,id=fsdev-root,path=/,readonly,security_model=none",
 	"-device", "virtio-9p-pci,fsdev=fsdev-root,mount_tag=/dev/root",
-	"-chardev", "stdio,id=chardev-serial0,signal=off",
-	"-device", "pci-serial,chardev=chardev-serial0",
+	"-chardev", "stdio,id=con,mux=on",
+	"-serial", "chardev:con",
 	NULL
 };
 
-- 
2.26.2

