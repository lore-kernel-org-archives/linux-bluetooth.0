Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4764FA3741
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Oct 2022 23:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJ1XrS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Oct 2022 19:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJ1XrQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Oct 2022 19:47:16 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7A71D6A42
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Oct 2022 16:47:15 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f23so6134833plr.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Oct 2022 16:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zmVtj6367OdE/cBtmC/6aSPVpj/jJRKxBa497UFOCEo=;
        b=jip4If778PxfuvH8jVv5WYsAAWorHgZGV5zptdF1BJUWEMLz7BsF0eVnXo//EeTKF2
         e4dCuD2D0eOLifWLss9r+P83vqAT2A+cfJJx2mB9Vp1iVQQOoVfzGn+4dBFcO9R2kBx5
         dyOkn+262shJuTJShV/yOTtJ6i00aDQQYwKu59oKXS4FIwIZG3fDwmOIHycxR1Sxpa7u
         KcC6gjB5OjdAUUM+ES53uMHD5xJ/o0tI8GvMN/Mmffs1Ia8qwYnoFnVjTJdzTcc+4Z7q
         50p+Dfg01VPNO0saGotdKBkS8ww8JQDAHPa5l0hVF+k1YN9nn6kQLTz+wn+klXeYvMId
         BS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmVtj6367OdE/cBtmC/6aSPVpj/jJRKxBa497UFOCEo=;
        b=mphglT/44W/+3+dYCbuDrbVtb0yaulwIo7PID0UNJPeYyrQLV0V9/l1STLZUTYgMVr
         fQ/jS0n4jdtOlgoxbUteBkx5A3qBKkVun2gbvRbhffW4Wp7dixqGNWktFvVtkOESFmwb
         HdvwZKkbzKWH+P51X3vrXIut79oFmWETNf1RY+idxVOkc71d62WYUk42+usOTFq+gwXj
         0jWSwsZkxSse2MYTAq0j9pk1w45lQRVSuqpo+0IINpCHttLXixdbJK66PWrHkWv/2c1P
         DjEGYx7aGlOdcXpLJBke3BedFp1YLIo8/V4u3yP3e4j0yOh08dIbHIdGHx18bUtphi0p
         E8WA==
X-Gm-Message-State: ACrzQf1vHSMqRLA3UOFyJ3mEFV2gqRzfdMKO8PSpi0n5zlNEeiCZrOjb
        eKL7BcVN5bFmuKw+5Dre3XU5WasUMww=
X-Google-Smtp-Source: AMsMyM4L3gWhvr8ay954XUF6LiP07pM7sgsjANvjluqzoE/iInhn4l1b9Auzp7r7+PJCrP/SFTks3Q==
X-Received: by 2002:a17:902:e804:b0:185:5276:7063 with SMTP id u4-20020a170902e80400b0018552767063mr1563122plg.171.1667000834714;
        Fri, 28 Oct 2022 16:47:14 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h14-20020a17090a9c0e00b00212e9196f6asm15117pjp.21.2022.10.28.16.47.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 16:47:13 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] tools/test-runner: Remove bluetooth.enable_ecred
Date:   Fri, 28 Oct 2022 16:47:12 -0700
Message-Id: <20221028234712.2213561-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

L2CAP ECRED is now enabled by default by the following kernel change:

98f18bb78b7d ("Bluetooth: Add CONFIG_BT_LE_L2CAP_ECRED")
---
 tools/test-runner.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 560d638e4db2..6660ea8de9bf 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -250,7 +250,6 @@ static void start_qemu(void)
 				"rootfstype=9p "
 				"rootflags=trans=virtio,version=9p2000.u "
 				"acpi=off pci=noacpi noapic quiet ro init=%s "
-				"bluetooth.enable_ecred=1 "
 				"TESTHOME=%s TESTDBUS=%u TESTDAEMON=%u "
 				"TESTDBUSSESSION=%u XDG_RUNTIME_DIR=/run/user/0 "
 				"TESTAUDIO=%u "
-- 
2.37.3

