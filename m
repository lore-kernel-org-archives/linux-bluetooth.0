Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B041C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Nov 2022 13:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiKUN0x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Nov 2022 08:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiKUN0X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Nov 2022 08:26:23 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D2F43AED
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 05:26:21 -0800 (PST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C83A53F328
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 13:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669037178;
        bh=gKvc2U8eYwANZy7lOYZ9bdcI/4BdKXI/Fb2/9a8b3sg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=pBt7RGBH6J/q3c81rZpw64rPhg3DsT18UHDCaJdpWPDBk4lEFXio727t8KDMajjmn
         gpzyl3QP3gMGXse6kyZrYxFal5vFROswppgvhWexN1+wMYPtaAGxv40MG8EcvVs5pO
         dda5J40gQZg4L0XVNq4VCx7MS8WpqFnzIRhd6fb/1FiAIs9RTdyvGl3rDTk0Fe46b9
         tikx9hTLBB9zfGCYY16uov3QAn6ksAEqCphRb9LOQZUhs1y8BXAuI63LS46zalp7aQ
         /N7aR0kg6gySRd/Qw95ngOF7dpLG543AKIKILcZ/C1vcX/GISuUrsbLo38nMiZlsh3
         nW7fhP5D1Nc8A==
Received: by mail-wm1-f71.google.com with SMTP id 187-20020a1c02c4000000b003d016c210f7so3275602wmc.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 05:26:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gKvc2U8eYwANZy7lOYZ9bdcI/4BdKXI/Fb2/9a8b3sg=;
        b=r7+oYrWKTjc18W44byytamuXtWmocL480TwNatpYkQzv3+JhpCb3gL2QK6OwA973iw
         jt9KEIjhrFr/kovBfMlRhbzuDVPUGsBBWexUHA4Wd29eZ1XyEBROpzMVP2Hq6ax4ac+e
         ++7mQwgnxIGWH5NOTO5myCiSMn57oFmwkfPETWBuMkUfxWckUPo7y2y0N1nHkAeHlQY6
         2OLa5pPP0QA2V0IgAcdK4uqT8nii1HVkul1rT8fKYS9au/c4skGt+wC3my5rmnZmQrgI
         QY5zlQddibsrt8XoRCls6w160ISKZ7rx21vkA7KyNSNR/VScJmOFSNxJklzk3M/fmH3J
         V21g==
X-Gm-Message-State: ANoB5plP56/mjWZRfDUuODX+Mp3pEzLYai/t6jZEavKb7xg7miEQEFCP
        UZF8GJvqdQ2Wd1kVwIaK17ypJL1S0vULCTqkqNsHE5jMRaAUjybxveZ0BY1fyRPtWZMXdlQ3f5z
        HZxWfzgnIMhlZ3CEVCHigspkjbPmmtHRG6tJTd73CL99G4A==
X-Received: by 2002:a05:600c:21d2:b0:3cf:b2b1:3c7 with SMTP id x18-20020a05600c21d200b003cfb2b103c7mr15969458wmj.176.1669037178441;
        Mon, 21 Nov 2022 05:26:18 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7kdRd3Y+KTXQIY484oaUn0CAkZUThqp6PNDTrZnQyVCgacPzv3epYied5sqcoxsPFb7WkujA==
X-Received: by 2002:a05:600c:21d2:b0:3cf:b2b1:3c7 with SMTP id x18-20020a05600c21d200b003cfb2b103c7mr15969436wmj.176.1669037178149;
        Mon, 21 Nov 2022 05:26:18 -0800 (PST)
Received: from localhost ([137.220.91.195])
        by smtp.gmail.com with ESMTPSA id hn3-20020a05600ca38300b003c6c1686b10sm17452624wmb.7.2022.11.21.05.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 05:26:17 -0800 (PST)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] Bluetooth: btintel: Correctly declare all module firmware files
Date:   Mon, 21 Nov 2022 13:26:04 +0000
Message-Id: <20221121132604.1298992-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Strictly encode patterns of supported hw_variants of firmware files
the kernel driver supports requesting. This now includes many missing
and previously undeclared module firmware files for 0x07, 0x08,
0x11-0x14, 0x17-0x1b hw_variants.

This especially affects environments that only install firmware files
declared and referenced by the kernel modules. In such environments,
only the declared firmware files are copied resulting in most Intel
Bluetooth devices not working. I.e. host-only dracut-install initrds,
or Ubuntu Core kernel snaps.

BugLink: https://bugs.launchpad.net/bugs/1970819
Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 Changes since v2:
 - encode patterns for 0x17 0x18 0x19 0x1b hw_variants
 - rebase on top of latest rc tag
 
 Changes since v1:
 - encode strict patterns of supported firmware files for each of the
   supported hw_variant generations.

 drivers/bluetooth/btintel.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a657e9a3e96a..55efc4a067db 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2656,7 +2656,25 @@ MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
-MODULE_FIRMWARE("intel/ibt-11-5.sfi");
-MODULE_FIRMWARE("intel/ibt-11-5.ddc");
-MODULE_FIRMWARE("intel/ibt-12-16.sfi");
-MODULE_FIRMWARE("intel/ibt-12-16.ddc");
+/* hw_variant 0x07 0x08 */
+MODULE_FIRMWARE("intel/ibt-hw-37.7.*-fw-*.*.*.*.*.bseq");
+MODULE_FIRMWARE("intel/ibt-hw-37.7.bseq");
+MODULE_FIRMWARE("intel/ibt-hw-37.8.*-fw-*.*.*.*.*.bseq");
+MODULE_FIRMWARE("intel/ibt-hw-37.8.bseq");
+/* hw_variant 0x0b 0x0c */
+MODULE_FIRMWARE("intel/ibt-11-*.sfi");
+MODULE_FIRMWARE("intel/ibt-12-*.sfi");
+MODULE_FIRMWARE("intel/ibt-11-*.ddc");
+MODULE_FIRMWARE("intel/ibt-12-*.ddc");
+/* hw_variant 0x11 0x12 0x13 0x14 */
+MODULE_FIRMWARE("intel/ibt-17-*-*.sfi");
+MODULE_FIRMWARE("intel/ibt-18-*-*.sfi");
+MODULE_FIRMWARE("intel/ibt-19-*-*.sfi");
+MODULE_FIRMWARE("intel/ibt-20-*-*.sfi");
+MODULE_FIRMWARE("intel/ibt-17-*-*.ddc");
+MODULE_FIRMWARE("intel/ibt-18-*-*.ddc");
+MODULE_FIRMWARE("intel/ibt-19-*-*.ddc");
+MODULE_FIRMWARE("intel/ibt-20-*-*.ddc");
+/* hw_variant 0x17 0x18 0x19 0x1b, read and use cnvi/cnvr */
+MODULE_FIRMWARE("ibt-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9].sfi");
+MODULE_FIRMWARE("ibt-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9].ddc");
-- 
2.34.1

