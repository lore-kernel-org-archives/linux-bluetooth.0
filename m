Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928F3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Dec 2021 23:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbhLHXrA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Dec 2021 18:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241214AbhLHXq7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Dec 2021 18:46:59 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358ECC061A72
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Dec 2021 15:43:27 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id h24so3103255pjq.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Dec 2021 15:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IoKxSTSHtD0MrAFhIyhTESma4cR4EuzUyiQw2MEx76U=;
        b=qcsxquah8JHvxxwnPXQNrFEoy7xcbqJ84nNZB46mrsYaLNwISzfdSsPm68enqFdU0x
         c3OUFmldtqC2LnOABzsnjuOcujvsIZ3DOb6cI82v/AdxBL21Mq8LQJKtMFNysaL2nGrK
         0Bk8mv0HWSUrFMnwep9BLAniJAPhh524xWFDyZ9b7oPfCaFyl+YYMycbXPtpOukqMah5
         51ZVFJpW4wnbZvByCrvzImo4Rprid/rmmbo4c4a5LQAL9eEwXaVVeNuu9620X/x0fqa+
         MpR/a4y+qe+C5xSkOnA+IsymXmKCYyfkP9LSLOW2DG0iVitVjkWiiKPymM+L9EQrIJeN
         nT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IoKxSTSHtD0MrAFhIyhTESma4cR4EuzUyiQw2MEx76U=;
        b=ufCaA0bIy36N0XpuiVgQxINo+ZU6hSVxBBTVIWCZWM1sRYvowpwIcPQQc+yw/sfr1Z
         BfF87zCSax8cueF8bAcKMau1NHTYvFRUbJTFa49Ftsq/Bkrfdmxngqw6+917Gcu3O5LI
         Hi2z1DLQllRNdUBoHV7sSnZ2ooATRq2NyAMC0vg//3uBayToVgOD11FAf/m5kxLGnJT8
         YjnfKCUL6OFV5W/Kg8gF3yBro+KAZa1o2y3SpC7DgInoWlINuFOw1EnhlMX/4SXLHNOT
         8Hu06fnqvSpTkO07YRH1/BZ+fhrAR0uERruDvYm+wP30IYDIhwLp0w3TV3x4Q1+2ItMq
         I7bw==
X-Gm-Message-State: AOAM5334myBt41Z/yyhDA5viGu7XsY34YDIOWBCUueS++HQwCyGzx0c/
        G4Xdyi3MK5RXv7+hAK84xrKDnefWZng=
X-Google-Smtp-Source: ABdhPJxQl1Q4L6iYpu85VxmIznQ3T8sH1j95ueHGvoh9x03bCRSKpVA2i43MCV30+RtKzfdShXKPFA==
X-Received: by 2002:a17:903:2045:b0:142:3d07:2866 with SMTP id q5-20020a170903204500b001423d072866mr62293758pla.17.1639007006365;
        Wed, 08 Dec 2021 15:43:26 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f15sm5187241pfe.171.2021.12.08.15.43.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 15:43:25 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: hci_sync: Fix not always pausing advertising when necessary
Date:   Wed,  8 Dec 2021 15:43:24 -0800
Message-Id: <20211208234325.521207-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_pause_advertising_sync shall always pause advertising until
hci_resume_advertising_sync but instance 0x00 doesn't count
in adv_instance_cnt so it was causing it to be skipped.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Add fix for l2cap-tester direct advertising test cases which was caused
by hci_pause_advertising_sync not pausing advertising when instance 0x00 is
used.
v3: Fix CI findings.

 net/bluetooth/hci_sync.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3d28ca7ebe45..fd15fb37a52a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1701,10 +1701,8 @@ static int hci_pause_advertising_sync(struct hci_dev *hdev)
 	int err;
 	int old_state;
 
-	/* If there are no instances or advertising has already been paused
-	 * there is nothing to do.
-	 */
-	if (!hdev->adv_instance_cnt || hdev->advertising_paused)
+	/* If already been paused there is nothing to do. */
+	if (hdev->advertising_paused)
 		return 0;
 
 	bt_dev_dbg(hdev, "Pausing directed advertising");
-- 
2.33.1

