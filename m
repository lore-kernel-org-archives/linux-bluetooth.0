Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA0CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 06:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F9D661B73
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 06:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhKPGws (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Nov 2021 01:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhKPGwr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Nov 2021 01:52:47 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4FFC061570
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 22:49:51 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso1996449pjo.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 22:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ksu+SMB1e0U3bHfGlITIUZZYT7PE8i9Hx74UO1qfrsU=;
        b=Kl8iIozhV6y4kRHVOGdO3zPDG8/mCM9KckOyVTmOUe3NwYffYPMON9949xMBL9Jydj
         Ps0HQIGhwi6DorzkY9KwVoi5Gj61gTuc3seDydkx9deUS5ldmqEV/izWibB4orV94gMH
         g08YWRS4Yf9XfxF4rrQ+iToAdqE1JTpNUCQc08zIUB8ui+vSWVuosId1c92vE3P1Z8pP
         XKCOO+Jr9NrvAV3cd095DKFgvOB7PgFtQQE65cCRFhZgFxOKdZZGaHEfgh9W9Z/XeCZC
         RHRoeP/VLzCPOBGLgpAqCvKyEn8gCBWmtuB5MU/A+yJF/yvd6tLYG7Y4HFIj6Fz/WNCE
         zRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ksu+SMB1e0U3bHfGlITIUZZYT7PE8i9Hx74UO1qfrsU=;
        b=k3VpH4JnUoWkZnKN1ajdMKLhlOKYTztPBoWMC42F/fnMsScIhWTWZZUOdFC6D56e3b
         vyu0bPNEiqsxuKSiVp0aiUv/ZMQDrWStMZnIseuIa7oIXO+Pe/pQE8CF231gb6kS+9fP
         T9SzttZp4+i7q04cizc8QgJbUCfAZCSQKUS4qUE5B2NyCYXVQCBVtqPyKP/INFoRacem
         oOdHtj+kguBy7zk63rpSxugD/W9nT48Koml29G45nTkcr7r+q+rDqYs8CKJN4QfhI8CJ
         2HN1nyMT+npt04dfHPhlEIy4Joq9/MiLiqoYOjDKJKxNqQmAwnUK2HYCSQi7otR5vGGD
         l7ew==
X-Gm-Message-State: AOAM532BwkVQZuJiK2RrO2bEwjetrtzF5S3MQgoEa6pJtRYQ8wvILngZ
        JKmWfN+/fg4gtPBw8tW9YD5SDD/OdYg=
X-Google-Smtp-Source: ABdhPJy7wH3d1nV97KBxBwZdZZ0wHrLBFoHMZubvcMuvTICWeZh7M8WlVsBKEI5cL41I8nzuDuHOog==
X-Received: by 2002:a17:902:a510:b0:143:7fd1:b18a with SMTP id s16-20020a170902a51000b001437fd1b18amr42805610plq.2.1637045390859;
        Mon, 15 Nov 2021 22:49:50 -0800 (PST)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:d5e1:ab79:edf3:1718])
        by smtp.gmail.com with ESMTPSA id y18sm19357701pfa.142.2021.11.15.22.49.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 22:49:50 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] emulator: fix potential resource leak
Date:   Mon, 15 Nov 2021 22:49:49 -0800
Message-Id: <20211116064949.463398-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch releases the allocated fd to prevent the potential resource
leak. This was reported by the Coverity scan.
---
 emulator/vhci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/emulator/vhci.c b/emulator/vhci.c
index 59ad1ecb8..014df87d2 100644
--- a/emulator/vhci.c
+++ b/emulator/vhci.c
@@ -140,8 +140,10 @@ struct vhci *vhci_open(uint8_t type)
 	}
 
 	vhci = malloc(sizeof(*vhci));
-	if (!vhci)
+	if (!vhci) {
+		close(fd);
 		return NULL;
+	}
 
 	memset(vhci, 0, sizeof(*vhci));
 	vhci->type = type;
-- 
2.25.1

