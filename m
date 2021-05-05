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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C3BC433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 18:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8867D613C4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 18:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbhEESpE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 May 2021 14:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhEESpD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 May 2021 14:45:03 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4226CC061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 May 2021 11:44:07 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id k19so2670871pfu.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 May 2021 11:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IldoP9ZdzuRpoaqQQEjWc1taE7gjMYerrGgSFZuozmA=;
        b=q0kmTD1LVffNhwTF0+lQjLj8ZrZ16cg3b0LNECMuXs6Q0co7ChbTl+Y/A6V+RL2fn+
         y+nLBF3Dt52QvCO9Oix5Y9jVTbsDhuaisCNvJQbkaG5v4+MDpZE6eM3cIzvhn1UnOlBE
         qAlUQxfV+PGMjb9NoOyPwqcJB8cg2FSVW5gNe7UqN9Z4Xu8wY0/+mNy6PXnWySya1ZCe
         O9i5MrOTqNMuMOtUO0tVxoQyiWGjxCw53p5YvydcCIK48Pso03bz9FTNjr3vHMgRiL7H
         IIsLBv7kPCpCJXhVi2U7ZmARGmjOrvpxQrdQKbnwLBUVMsut8CIm44AXQF0EZHLYLVR9
         spBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IldoP9ZdzuRpoaqQQEjWc1taE7gjMYerrGgSFZuozmA=;
        b=QAuYgpwX8dDmA30Kv87ZIjmwbxAPX0IgFuFi3dUhU9KXqhWMY2TZkgr5VMh5vzp1jU
         DaCLAyi52iii87xxelziSx+yBW+njALRu8fG1XQzwlSqz2dofLBzSakn6gdwWHzuK9zz
         yVG5SgkE2ivi1RyEtjxtLXNhmgqktI+aOA6lrwCFbo3QMfgYOOMvMHijnONEd1f+GsV9
         TBggdFd0T5pWlyp8ULHsaTA0BZHb41n9d4JnrTY6iX3H+pZP6pPyGnH2h51HiFzcQaZ7
         Wby/iec9jfV3oBHvdb+B6XqHuskmHUuCJA8CFdq5U8+XEaaN4xuLgnsqz8MqIUXS2FFg
         sZAA==
X-Gm-Message-State: AOAM532YCi71IWH7tdhRQkCsulZtOTk8fMsuK5csgwZet3T9Yjg94gBu
        GcEvk77P9HN1xSWTiNVD8kyaeAprD6n1TA==
X-Google-Smtp-Source: ABdhPJxyTGRxo53AJOu4UgLPeWpcEVmS2/CEDAQ98Qnt0P8uGOVfYkk6dVgLD4SBFfOO8fbu5b8kHQ==
X-Received: by 2002:a63:150c:: with SMTP id v12mr328523pgl.344.1620240246682;
        Wed, 05 May 2021 11:44:06 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::f7ee])
        by smtp.gmail.com with ESMTPSA id z16sm7855584pjq.42.2021.05.05.11.44.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 11:44:06 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 1/2] gitignore: Add generated files to the ignore list
Date:   Wed,  5 May 2021 11:44:04 -0700
Message-Id: <20210505184405.1077111-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds generated files like manpages and binaries to the
ignore list so it won't show with 'git status'.
---
 .gitignore | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index f4fb5db28..9c8393a81 100644
--- a/.gitignore
+++ b/.gitignore
@@ -47,23 +47,33 @@ tools/avinfo
 tools/bccmd
 tools/hwdb
 tools/ciptool
+tools/ciptool.1
 tools/hciattach
+tools/hciattach.1
 tools/hciconfig
+tools/hciconfig.1
 tools/hcieventmask
 tools/hcisecfilter
 tools/hcitool
+tools/hcitool.1
 tools/hcidump
+tools/hcidump.1
 tools/hid2hci
+tools/hid2hci.1
 tools/rfcomm
+tools/rfcomm.1
 tools/l2ping
+tools/l2ping.1
 tools/l2test
 tools/cltest
 tools/rctest
+tools/rctest.1
 tools/scotest
 tools/amptest
 tools/oobtest
 tools/advtest
 tools/sdptool
+tools/sdptool.1
 tools/avtest
 tools/bdaddr
 tools/bluemoon
@@ -116,6 +126,7 @@ tools/rfcomm-tester
 tools/bnep-tester
 tools/userchan-tester
 tools/btattach
+tools/btattach.1
 tools/btconfig
 tools/btmgmt
 tools/btsnoop
@@ -125,15 +136,18 @@ tools/btmon-logger
 tools/bluetooth-logger.service
 peripheral/btsensor
 monitor/btmon
+monitor/btmon.1
 emulator/btvirt
 emulator/b1ee
 emulator/hfp
 client/bluetoothctl
 tools/meshctl
 tools/mesh-cfgclient
+tools/mesh-cfgtest
 mesh/bluetooth-meshd
 
 src/bluetoothd.8
+src/bluetoothd.rst
 src/bluetooth.service
 mesh/bluetooth-mesh.service
 
@@ -157,8 +171,6 @@ unit/test-mesh-crypto
 unit/test-*.log
 unit/test-*.trs
 
-doc/btmon.1
-
 android/system-emulator
 android/bluetoothd
 android/avdtptest
-- 
2.26.3

