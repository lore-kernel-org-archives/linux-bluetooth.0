Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3942AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Jan 2022 01:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiAOBDd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Jan 2022 20:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiAOBDd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Jan 2022 20:03:33 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE99C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jan 2022 17:03:33 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id n16-20020a17090a091000b001b46196d572so1740060pjn.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jan 2022 17:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i+1IbN4UyRH0UIy0LvgR8qcSwdT/SZf1HdxrW+k1aHA=;
        b=YX6rxkFbFY3pBv2X2j4Y94gOqFZQgGmVYAoeyZPWwZv/nES4y/kqwEwJvfn36/TnOK
         BGa+qc3eZ/Rw4Lub0DhYyWdJTZrpbzL+fKQ4UhoWoK+/97sBWOW2DzADEf5hajLOhD86
         hjgVqtWR3TdTu8KaJfy+wiAML517FCkFbe5ntmuNxKr30MfEzEmpGUY/URqaRpXkNAX4
         VaUWNPhwm45+7B2/LT62d39wI+cY1gwC8R3QyrolByDsBHVvjL8Nt4Trw6XrsK48Gdil
         Jk2uRFJxggflgKdLe//BL0WCRWErYWwqtf0H2BjBRyTZJ98dl/iDFzCsXIaoG2CPLqlk
         Z2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i+1IbN4UyRH0UIy0LvgR8qcSwdT/SZf1HdxrW+k1aHA=;
        b=JW/4vsMeKZigY6bAk1XxY/SSyex6JFEKXID0WPSsdLC4HTrRtnue45FSryVUr2206m
         iL3gRtxZ6YYeUANG8oIfd8y+QErdvWI/F6c1eEe8fxc6pHw8wKGAvVgnsq6CTGfFyLa1
         z/viinuwYJnFrOvY25KDtRHLrjKE5G1kUp0t5KehKqmXGhop4KDccpdHbndWGP+19+aF
         FuygMn5h+EaDBMnbcVitr/VIkXgkedgn1iSeFgnvTKomlbN9WIJHbptx1cw7vHgkEdgf
         PpgTJJlsJVYfhfAf8WkD48otsd84sSWDDGGyxKi4ex0SWfPI8GTzOjX9QjK4HwIwNMe6
         tcow==
X-Gm-Message-State: AOAM531qAKkNZc3tEO6NIrwb03aXT0f3dwjF8/THolhkSqnimx5D6MRA
        f27IsDAPDx4qsxl372/K/7mov+vbsGI=
X-Google-Smtp-Source: ABdhPJwTMl5WHs5dtPxkZswVntomYHYGTek9Ll+NPuhMe8v5LRieK5HginjHXMrtQfCkJkh774AgiA==
X-Received: by 2002:a17:902:c206:b0:14a:410e:2ac9 with SMTP id 6-20020a170902c20600b0014a410e2ac9mr12351783pll.42.1642208612348;
        Fri, 14 Jan 2022 17:03:32 -0800 (PST)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:34a:96e0:8881:913d])
        by smtp.gmail.com with ESMTPSA id om16sm2402679pjb.49.2022.01.14.17.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 17:03:31 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH] Bluetooth: Remove kernel-doc style comment block
Date:   Fri, 14 Jan 2022 17:03:29 -0800
Message-Id: <20220115010329.241808-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch changes the kernel-doc style comment block to common comment
block. These files don't support kernel-doc style so no need to use the
kernel-doc style. Also, they cause the warning when W=1 option is used
as below.

drivers/bluetooth/hci_ll.c:518: warning: Function parameter or member 'lldev' not described in 'download_firmware'
drivers/bluetooth/btmrvl_debugfs.c:29: warning: cannot understand function prototype: 'struct btmrvl_debugfs_data '
drivers/bluetooth/btmrvl_sdio.c:36: warning: expecting prototype for Marvell BT-over-SDIO driver(). Prototype was for VERSION() instead

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btmrvl_debugfs.c | 2 +-
 drivers/bluetooth/btmrvl_sdio.c    | 2 +-
 drivers/bluetooth/hci_ll.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_debugfs.c b/drivers/bluetooth/btmrvl_debugfs.c
index c4867576be00..db35b917aecf 100644
--- a/drivers/bluetooth/btmrvl_debugfs.c
+++ b/drivers/bluetooth/btmrvl_debugfs.c
@@ -1,4 +1,4 @@
-/**
+/*
  * Marvell Bluetooth driver: debugfs related functions
  *
  * Copyright (C) 2009, Marvell International Ltd.
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 68378b42ea7f..b8ef66f89fc1 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1,4 +1,4 @@
-/**
+/*
  * Marvell BT-over-SDIO driver: SDIO interface related functions.
  *
  * Copyright (C) 2009, Marvell International Ltd.
diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index eb1e736efeeb..4eb420a9ed04 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -509,7 +509,7 @@ static int send_command_from_firmware(struct ll_device *lldev,
 	return 0;
 }
 
-/**
+/*
  * download_firmware -
  *	internal function which parses through the .bts firmware
  *	script file intreprets SEND, DELAY actions only as of now
-- 
2.25.1

