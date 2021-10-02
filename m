Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC911C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Oct 2021 18:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFEB761B3F
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Oct 2021 18:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbhJBSXA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 2 Oct 2021 14:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbhJBSW7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 2 Oct 2021 14:22:59 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EBBC0613EC
        for <linux-bluetooth@vger.kernel.org>; Sat,  2 Oct 2021 11:21:13 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s11so12544421pgr.11
        for <linux-bluetooth@vger.kernel.org>; Sat, 02 Oct 2021 11:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OwfU8G1eWOBNe2IU07+aDJQeaSkXzgUNEJDD2xJmHbc=;
        b=hou3IGwG1Br2brIjtRi8V3Auuq/KrXcI3F0UOSkqJ8rgWILuP+071XtS+aCY9jLrfc
         fuSMjVmNrKK+cTXwRvqSUpDlLjySoy323myo4/QT6lu4geKD4qMnCFI7rNz/cWuiFBhd
         6aAI+SUA1nMISonbYsdiATzva84qHiirfzFTdBZJGibIyg2uIEGyLHeezd1HAxd/1Tjq
         PVEy0Lmhz3JJHkPDMXmSH1rD9tY0250McqPqX2fAEQ4O8afxIAIn6kNb5gqwkQbEelPe
         sCzQvMuRPSVMC4eCin1++LXFDmawzyM6TGLfpE6uA3FHm6mlhoBHv5ma4LAMdtWNptsN
         gYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OwfU8G1eWOBNe2IU07+aDJQeaSkXzgUNEJDD2xJmHbc=;
        b=Vq9FIsCTkCK4LCw1BCnz+hLvFfKhV4+fiuaoUloL9MVulaxFia9vNgDN1D2dQUH/3B
         +xGazaOAIGcYgMyY1k0c6K1A/4W2+ZVNUDpUerjwBnYhN3HF9gbFFxZyBt9p4j6r2FwI
         TRZqFeoASu3FOjrcLeB8F6uuH0zPUQttu8Es+Neze2wRPHKG6Xp15EnYpC8uxUu89xqO
         m1ATX591pJ8T9nWfVJvW5aNJfU12RCWYqSwc+Xmsrc2dSpZsHcq0+SYv3dp+PyetN8Lj
         USJooHK8BkHrOZzl+ipE9LuhA83MpnLL6BQj7Uf4jhV3pF+IHtYwbdTzBy0ABhW8aJS7
         xygw==
X-Gm-Message-State: AOAM5307VDPGcORNjIdfzFfuJkLDhh5s2fSUJPRxQmVEhLrfXSj8Xsxt
        Hf5aUsjOEfRJjA16i8YGZNtHDLssTCw=
X-Google-Smtp-Source: ABdhPJxsYomXansHnjVNWDU4DgPcbiPsPpN/wwbKEjrRTjMijRPhUhGgT4c79ItL9hZ0khZfjnS6yg==
X-Received: by 2002:a62:51c6:0:b0:43d:e849:c69d with SMTP id f189-20020a6251c6000000b0043de849c69dmr16405983pfb.31.1633198872487;
        Sat, 02 Oct 2021 11:21:12 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:eb97:ba9a:7c99:dd3e])
        by smtp.gmail.com with ESMTPSA id u6sm9180174pgr.3.2021.10.02.11.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 11:21:11 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [RFC PATCH] Bluetooth: hci_vhci: Fix to set force_wakeup value
Date:   Sat,  2 Oct 2021 11:21:09 -0700
Message-Id: <20211002182109.165456-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch sets the wakeup value in the vhci driver data after reading
the value.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/hci_vhci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index b45db0db347c..5fd91106e853 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -176,6 +176,8 @@ static ssize_t force_wakeup_write(struct file *file,
 	if (data->wakeup == enable)
 		return -EALREADY;
 
+	data->wakeup = enable;
+
 	return count;
 }
 
-- 
2.25.1

