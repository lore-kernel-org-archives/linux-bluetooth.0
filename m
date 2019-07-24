Return-Path: <SRS0=wkNI=VV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2A4C7618B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jul 2019 11:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5461022387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jul 2019 11:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYkdFMb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfGXLB5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:01:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39213 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfGXLB4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Jul 2019 07:01:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so46453139wrt.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2019 04:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S3kQCcTDDr4NZtcCTxkifwzlDwJdOjEwfbMDck/XkgU=;
        b=lYkdFMb4Q9emWVk7GZI5ZDDTZk40i0veorB/BDJHBGUn/kGN+KSrBgJustZV2v9Wha
         p1bQECPrQAPOmkDNJb2xcULr4U0K6NmdgzdiTUilYy+4QQAENPrW1EKeElekf0xaiYTf
         ISGCD0vJl0EUVQE0BnQnoK078bjhdiJxu4+riBqy/gDrFyePq7hCj0tGybvkAH3XYIN6
         e4RqK6/4AHMeONegEhNJn+mbOJQHFmgHPvE2NKNDG0FYMyfc/mQvWQ0Fb5Mv714FSs+8
         tJWcq3KaVrGmctqY0MYSPIcxbo6d9Y4KxDoM1Jz2GOmTW6qgXOYm16j6yiqCIGOcFqV5
         BjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S3kQCcTDDr4NZtcCTxkifwzlDwJdOjEwfbMDck/XkgU=;
        b=SnCVpkLEo002vUuWvTb6TP1vd17PP4Wn1GZnZlVbWTuDaPDpYJa+mc6ZQBqjeN/OKX
         MKk/5CJaBKuru3Jqai7Kb6PSLx6MmPxekmTn1ht1vYp93n0rEWtM5Db2FGWhZ0TVAVqa
         /W1tKKsbp1QPZEhnhCL8vgnwCPYoaHDN0Rzi+WpwDrMvuQnv1mesjmF2sUuNy9e4dw2U
         Vwp4nL3cJE2uc+FmnD7uxD7rLseD5UPl+LwMFsLZ1cVt84uNlhMU4LJY55ZpYQnEtfBe
         8difwZgHaHGiiGo96aDHBChktiIUDg/7uWn7FsCA1L0z3pfflVL9BW/BwXxVI2tR+MOC
         4aOA==
X-Gm-Message-State: APjAAAVRtg8hpG5y4ran+skqKoBZ7h8GjEagS435qkYyM/qmYV4g682z
        BGNJaQqR2yIMeCR6KKxF8qDaY2mqcZk=
X-Google-Smtp-Source: APXvYqyRDclE3dieOr0lDsaAP8iBLB4A1aaNs7XRVHYPzNAarD6LUK6nL3vtwpYjEED60iMIeRHNRg==
X-Received: by 2002:a5d:46d1:: with SMTP id g17mr36405515wrs.160.1563966114283;
        Wed, 24 Jul 2019 04:01:54 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id l17sm28691805wrr.94.2019.07.24.04.01.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 04:01:53 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] input: Fix not removing security watch when disconnecting
Date:   Wed, 24 Jul 2019 14:01:51 +0300
Message-Id: <20190724110151.4258-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If interrupt channels disconnects the security watch would be left
dangling as the channel is being shutdown which can cause some bugs:

https://bugzilla.kernel.org/show_bug.cgi?id=204275
---
 profiles/input/device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index a711ef527..32c682b79 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -327,6 +327,11 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
 		idev->intr_io = NULL;
 	}
 
+	if (idev->sec_watch > 0) {
+		g_source_remove(idev->sec_watch);
+		idev->sec_watch = 0;
+	}
+
 	/* Close control channel */
 	if (idev->ctrl_io && !(cond & G_IO_NVAL))
 		g_io_channel_shutdown(idev->ctrl_io, TRUE, NULL);
-- 
2.21.0

