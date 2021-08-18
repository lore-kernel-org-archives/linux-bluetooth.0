Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16757C43214
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 04:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1DD161058
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 04:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbhHREjt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Aug 2021 00:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237546AbhHREjt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Aug 2021 00:39:49 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFA3C0613D9
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 21:39:15 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id o10so1093998plg.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 21:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RdYh0KzVSM6GfEPOUNKGwmds8J/gMHl6yf/nm5EaGwo=;
        b=X/cmbieBqLTKIxbCHnmkgunhjwaIKPorKnk1/6Wwque4TYwFu3uY4W4ZbidEJM25fk
         rAoEl49BCTVuCri5jNEnwPyphEu3F8Utqmen8mugWkqwt9bgvmdN4AhqRyAlnnTtWHm5
         TThuObe62UlTKrCZlSHdLGZ/Ziace7M1m85BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RdYh0KzVSM6GfEPOUNKGwmds8J/gMHl6yf/nm5EaGwo=;
        b=pfCvyyozc3tpXkITeJCoLIbWY3o0GPFI/WN1uSV7JzFVJVT5H9ivcB91/uKZwyotyK
         Vc3MeSZKEwEOcsO2DlbpABOepEVhSPSAFgLDNvZSPDnEdkLcfQFSNik4rLDiI4kznnba
         38uBM8Wsw7q4IfUeiN+LfBLnbTrcxtvvbc7zDfCkEylRC3HWxS5RtgO83LTJCD/oXfL7
         U2FkPlyr9e1MNaie0/nWlE1388f39q8m3vJ3gIem0W1dy/XIFGFCrCO+C/Eo76g5U8Uw
         SCOr219YnGSH1EzNRQZSel5hnQL2+rxa6BGU4jbitNp9RTWqASXpNW3QRz878XX/bwKB
         Hu+g==
X-Gm-Message-State: AOAM530oeu6bMnUrf7idi9/j7ToTj4i9ZsMRGrsc1FT/szhRjjTraqaA
        nhxkzqJqCVkJTQCU3dky/FimEA==
X-Google-Smtp-Source: ABdhPJxFPT7wVpzSlvT8DPbADw2xJozXJw6p/wgABDmTcU0Wr38l7tW8zwD75zO5rpG9oxsfn5DFzQ==
X-Received: by 2002:a17:90b:d94:: with SMTP id bg20mr7153787pjb.61.1629261554669;
        Tue, 17 Aug 2021 21:39:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p30sm4389467pfh.116.2021.08.17.21.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 21:39:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] Bluetooth: mgmt: Pessimize compile-time bounds-check
Date:   Tue, 17 Aug 2021 21:39:12 -0700
Message-Id: <20210818043912.1466447-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1435; h=from:subject; bh=E0l6g+Q1UhnSMK4lDN7R/eQd0SuD7Heg/eD8YzK5Lic=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHI7vo8PzMk5HF85TGPbfFBW7iT4mrKvH5KZU5yn/ EkWlbBmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyO7wAKCRCJcvTf3G3AJny4D/ 9kWDf6kh3N+iOlTVivvviWpmxld7NQMSysukicQNgR4Dx8+v5gkpBVF24L+b/IjWlz1Q0bYoNeHz8Q 05okcO2+H3Z2d0C9lqy4dUvYk4v+lNQOuT1oQoc00+Ki7iMO5hIEEw0NcNALnAwNaWAZQyL316p1K0 BwBuVRms/OPZmrNjA7tNB4kTQYn8NKMEw4XmXd3bZGyPtOXHFdznKXPCHKLc7xfp9S5CWWMi74+3S7 XSRxLGCJJNwdqiSP5chMEwUzGdyMkLDloeWyknX4Qk3Mr28EyZXXkrILdpTlAPPCQ2194vXCy7tOEF b54oNbJI8g7HPCqh4oJsLC0R+OMbE/VEr/cobvPT9w6h53xo14s9rTsB7A9ppZr0xZDScpGNK/fj/H qbDej5cRTSDwG9VztYg6h+XLk3u9Sk/H23r0ASa5yszCJLho3tJLICpJhqUJXGxuH6pj17xAFZuh/S DqBArkMNxHyt2q2UmoqpGTR5Fpg4MeOxbzCNo087bCvFkXOembW+nbP7i51jiBaJf3dvtTIc7dl1df pn7CQGa5gcz+dUNskx58QRhJiyGNWpD+8BCP6Co/56dunORoba5Gnpso3ZQCi6Hf3iw/KgNd9/Ob60 YaURx0KP4qAqdhiOzeTVYgPZq+mM6wIV2p0zK/EVOB6DyUOr/U52eyoQBAiQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

After gaining __alloc_size hints, GCC thinks it can reach a memcpy()
with eir_len == 0 (since it can't see into the rewrite of status).
Instead, check eir_len == 0, avoiding this future warning:

In function 'eir_append_data',
    inlined from 'read_local_oob_ext_data_complete' at net/bluetooth/mgmt.c:7210:12:
./include/linux/fortify-string.h:54:29: warning: '__builtin_memcpy' offset 5 is out of the bounds [0, 3] [-Warray-bounds]
...
net/bluetooth/hci_request.h:133:2: note: in expansion of macro 'memcpy'
  133 |  memcpy(&eir[eir_len], data, data_len);
      |  ^~~~~~

Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1e21e014efd2..cea01e275f1e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7204,7 +7204,7 @@ static void read_local_oob_ext_data_complete(struct hci_dev *hdev, u8 status,
 	if (!mgmt_rp)
 		goto done;
 
-	if (status)
+	if (eir_len == 0)
 		goto send_rsp;
 
 	eir_len = eir_append_data(mgmt_rp->eir, 0, EIR_CLASS_OF_DEV,
-- 
2.30.2

