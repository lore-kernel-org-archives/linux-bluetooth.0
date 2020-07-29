Return-Path: <SRS0=Z40G=BI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958E3C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jul 2020 07:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 705DB206D8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jul 2020 07:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzoKD1v7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgG2HQg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jul 2020 03:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2HQg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jul 2020 03:16:36 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97321C061794
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2020 00:16:35 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a21so23200359ejj.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2020 00:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/5ABK+eA36c0ZVESFTkjpcE0rr+cIOhB5EPocStv7k0=;
        b=kzoKD1v7bqKf1htaxYKCzZpk1oJXbqeDaRnGRhBXNT1QfhYnUEtXBLkPIRcKR/B5i5
         mFo/8Oee7oPHws+x2UOZeK0DBJI4y8s//M9lpWs52NYUzMttIHRNRl5Ce4Kg+dPYNAlL
         b/7pIv41ehMuXOvbwQTuuaLkemCHMn95Z086EwXClFwbvf/X5QmNDWG8llAxoVog0929
         Kw0juE1tu4tdKB4AbF1ajkmklzlM6W97FMUyR/Qi8NPpFZ+txO0VpD4SmhrwQDDhqwAM
         niW1/wkpgvRaT5KRahgpD3mcrMO/ziDLTXIwgT15SxCh6Wa+FmG4OwWWbMDgQYwYvYYL
         QrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/5ABK+eA36c0ZVESFTkjpcE0rr+cIOhB5EPocStv7k0=;
        b=YX0CPE5EkE0ni+bfqBDMzyNHMoJWDWuClrqo4PwJou+raLjAn0mLEuZ/4PlYiZGsd2
         h0l/orn4Y4iAqf5QOuyaKqMcbKHj6p74Lbaxg0uFz3gOe1MSNPb9G/Rrso+117LFJycw
         XBifNm7TrorM4kRUpXHe4kGTxqtoZwEPjRSB35zxLxoE5+LdwOpwCgQP+ot1wMF9F5XL
         P7dTJ9JqSol3jX4v2IaPsVkG7qJqs9HH5nZXWWTMNwmOcZWX7vyPHQYNlbJvmxdvrYRI
         KGhGtZ6j6oMzVvsgS+Tl0WO7QiT0PmSh97TCbHSa9ZkQZq0tVd7eM3295OR2z3D6WBh+
         K3LQ==
X-Gm-Message-State: AOAM533HtPMTUNJ6oVHuXrdpVIMVXaaYpL5VzMJjtGmFdPEP00o//Fyb
        Jd/1N1wVWl/Fbf/t9UUXyO1czERG4sY=
X-Google-Smtp-Source: ABdhPJwYjjzKxuUn70nbK8GCVjgcPZ9eGfobET2BnmBTw3WEspN12Hy9KnuoTHoYYYBKq2Uu+izfjA==
X-Received: by 2002:a17:906:c56:: with SMTP id t22mr30617962ejf.50.1596006993978;
        Wed, 29 Jul 2020 00:16:33 -0700 (PDT)
Received: from niels-laptop.telenet.be (ptr-usc1wvbea8yt39w15k.18120a2.ip6.access.telenet.be. [2a02:1810:1c80:7200:d1cb:60bc:b806:b2d8])
        by smtp.gmail.com with ESMTPSA id cf10sm867853ejb.4.2020.07.29.00.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 00:16:33 -0700 (PDT)
From:   Niels Avonds <niels.avonds@gmail.com>
X-Google-Original-From: Niels Avonds <niels@nobi.life>
To:     linux-bluetooth@vger.kernel.org
Cc:     Niels Avonds <niels@nobi.life>
Subject: [PATCH BlueZ] device: Don't mark services resolved on error
Date:   Wed, 29 Jul 2020 09:16:02 +0200
Message-Id: <20200729071602.12868-1-niels@nobi.life>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes a bug where the service UUIDs were not rediscovered after a
failed bonding attempt because the svc_resolved flag remained set even
though the uuids list was empty.
---
 src/device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index bb8e07e8f..e20c2d240 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2591,7 +2591,8 @@ static void device_svc_resolved(struct btd_device *dev, uint8_t browse_type,
 
 	DBG("%s err %d", dev->path, err);
 
-	state->svc_resolved = true;
+	if (err == 0)
+		state->svc_resolved = true;
 
 	/* Disconnection notification can happen before this function
 	 * gets called, so don't set svc_refreshed for a disconnected
-- 
2.18.0

