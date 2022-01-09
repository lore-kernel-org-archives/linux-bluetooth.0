Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C04C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  9 Jan 2022 05:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiAIFVt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 9 Jan 2022 00:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiAIFVs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 9 Jan 2022 00:21:48 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BDEC06173F
        for <linux-bluetooth@vger.kernel.org>; Sat,  8 Jan 2022 21:21:48 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id i8-20020a17090a138800b001b3936fb375so3014405pja.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 08 Jan 2022 21:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3tFDJ9l2EzucFWxsNk41wS3QV1dITJi/rl4TOKkJVzc=;
        b=hZA4ZZoWd36xHOIbgEoUW6g0pJnKrU9otlkx53pmLwd95IVQdg/H0V7jolUP7hOntk
         d9YRy1YX2keALwaIyhiJhkdVOGNpdXBEGOQfxRkhnWSLJ9Bh5sRk6zap2c8ribu5xa75
         ooxcYkUYoSJuqs+JhNKKzl8MJq0bvtcbI1Qb79t9SLSXRFw06gAt5xSKKF6RCJdDgL9S
         5F6V/11ZYoZA2EFeThe0W4Oc4pyxHtVqPZJe9a/lnErbtvjoD/eGeDXWXTDH09jjWxT9
         YwdQUfof0UNX2LWyqxsq/MWPUFD7Co+EHEVkh69bQ3TYabxgVeB8c6aDEaj5CBRkUKB6
         T6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3tFDJ9l2EzucFWxsNk41wS3QV1dITJi/rl4TOKkJVzc=;
        b=FO9eFbgghhezmfxVQFKe+SocGRRyJpbFKhDy4WN1ELyqZ8t57x3wNFgK50Ua3au9yH
         4Iy1EMP/Cwo9erQaaNP7UfD42r8F1pGtGQtyHCAMTvGUMh8eLrqi9gWsFC8PEiSkH97c
         VSWevXAGVUHZSz+xQPvHax2Hc3e/uLFsg329AfF4PjO/dVezqo3iyU8gjALL7Ka+PPIv
         bK8KHw4FCzodRxGLTSC86D3ABN/DkizlaU5uB5k7eBwKg7bRn8Kf5I1LfDODqU5pUJ8o
         dAJakxM84FnxlGEGYXPUNXVsmxWG3wbDa0XjAb4o27kuu2rtR2UkpFfkD5GC6hG5yMll
         d6Gg==
X-Gm-Message-State: AOAM5334Dv9TK/2WpulrUDaZK35AIA4R35mbbRo1/SE5kA3hP5fwR/RK
        RVYfsrfwCW0B2JhChgcMw0kA79TcZDE=
X-Google-Smtp-Source: ABdhPJxalctuywy2goVS+Clo8rF66XUizkXcQSNKyNbmczvIjUffHvWs/YTVDl9sgXj2Bjd0EqL00w==
X-Received: by 2002:a17:902:d64f:b0:149:4d01:fb42 with SMTP id y15-20020a170902d64f00b001494d01fb42mr69847393plh.13.1641705706877;
        Sat, 08 Jan 2022 21:21:46 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id nn16sm4299200pjb.54.2022.01.08.21.21.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 21:21:46 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Fix compilation warning
Date:   Sat,  8 Jan 2022 21:21:45 -0800
Message-Id: <20220109052145.4081797-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following warning:

net/bluetooth/hci_sync.c:5143:5: warning: no previous prototype for
‘hci_le_ext_create_conn_sync’ [-Wmissing-prototypes]

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 0feb68f12545..2fe8c60dc62b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5140,8 +5140,8 @@ static void set_ext_conn_params(struct hci_conn *conn,
 	p->max_ce_len = cpu_to_le16(0x0000);
 }
 
-int hci_le_ext_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn,
-				u8 own_addr_type)
+static int hci_le_ext_create_conn_sync(struct hci_dev *hdev,
+				       struct hci_conn *conn, u8 own_addr_type)
 {
 	struct hci_cp_le_ext_create_conn *cp;
 	struct hci_cp_le_ext_conn_param *p;
-- 
2.33.1

