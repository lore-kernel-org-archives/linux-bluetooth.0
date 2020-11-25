Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33459C5519F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Nov 2020 07:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8E4520857
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Nov 2020 07:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MG24xoFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgKYH5h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Nov 2020 02:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgKYH5h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Nov 2020 02:57:37 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F028AC0613D4
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 23:57:36 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id t8so1548309pfg.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 23:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VqnAdtMLP+ZvXP78M6lImXQFstZ9U7MFO/JoeLuuTI8=;
        b=MG24xoFX9lkpzIMBNmzMcSajBGSV5/m5Z/3C/ojf8bkYRJONRMwOidmmtrkRnd/VnO
         J2Ao4WQDmk59+q9q7imtATrSu5YJyxLAOTnvDo4TnNqck+dl5BcRDK9iY9+pDIwI912u
         frr41TK4pi5FdorWR9vxtZCiQk6iVYLTc99Zf7XS1ClZhkEFMeC8T2yYWimK9EOiC1ll
         L6clgxv2R54fr+mnxkvXlmrynQTZOt4w6S1NUp4OCM04E576sYDOFX9Pcp98WvMXheAw
         IaxTkRcNjzZauxMe6q7/IIoZ+7bTV5HzAmBLL6nFys8rTkAzqgXZtLpuoQpyxTlvM/KQ
         0SIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VqnAdtMLP+ZvXP78M6lImXQFstZ9U7MFO/JoeLuuTI8=;
        b=rVYfZw+TqPk4qB3CUxmMVuAfSpGiXlwXPiSU6CbMd01mIJ8JY14eb3JrX/s7tJlAWj
         a+8ZIIwX5Koihfd3DE/lxq9nl63ji6usXB90mj9hZ4aBMCH4hZxb/D5m7DT56Ie3w5H2
         ZdMiQqRG/ny2kkQQqI4jSCTdChwqjFdqJ8rhFgO9Joc6K2yY43a3+9HpXmnhj+/JVQJ8
         0z8GxTeFGFDziTov30VayWwFOCVm/vweNw32sP6r4zF4K3dCV5hfKCcr1r0ohIunWcVq
         +gAkqDrkHDXD7xSkEkshY6SQNVCzTXVppKvlDM1T6XY9jQfZd/eQ8/I2PPs62NdroQ6n
         iEGA==
X-Gm-Message-State: AOAM530To09XfbGQj74P+KS+P6QJIdQk7Xypmx84L5Rats5uvmHCatPc
        xg3tDbu9EN064iUrZsoJFDmb/P0HQt0zPg==
X-Google-Smtp-Source: ABdhPJy4ipQu0syxwpfqjd1BkQVoVNXKzKTK7ETjPEiKE6bdou+bHUvEmD6xuPmdvV9J7nd2TARP2A==
X-Received: by 2002:a17:90b:1010:: with SMTP id gm16mr2631465pjb.152.1606291056389;
        Tue, 24 Nov 2020 23:57:36 -0800 (PST)
Received: from han1-mobl3.jf.net (c-73-164-224-32.hsd1.or.comcast.net. [73.164.224.32])
        by smtp.gmail.com with ESMTPSA id 199sm1323230pgg.18.2020.11.24.23.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 23:57:35 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Google-Original-From: Tedd Ho-Jeong An <tedd.an@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH] doc: Fix qemu unable to mount root fs for test-runner
Date:   Tue, 24 Nov 2020 23:57:07 -0800
Message-Id: <20201125075707.492685-1-tedd.an@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch fixes the kernel panic while loading the kernel image built
with the current config for test-runner.

 Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
 CPU: 0 PID: 1 Comm: swapper Not tainted 5.10.0-rc2-702835-ged93facee36e #6
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1 04/01/2014
 Call Trace:
  panic+0xee/0x27c
  mount_block_root+0x315/0x324
  ? rest_init+0x7a/0x7a
  prepare_namespace+0x128/0x157
  ? rest_init+0x7a/0x7a
  kernel_init+0x5/0xf6
  ret_from_fork+0x22/0x30
 Kernel Offset: 0x2a200000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbf)
---
 doc/tester.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/tester.config b/doc/tester.config
index e90899714..661d7a0b0 100644
--- a/doc/tester.config
+++ b/doc/tester.config
@@ -1,3 +1,4 @@
+CONFIG_PCI=y
 CONFIG_VIRTIO=y
 CONFIG_VIRTIO_PCI=y
 
-- 
2.25.4

