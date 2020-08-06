Return-Path: <SRS0=ILT4=BQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC46C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Aug 2020 17:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D26A4221E3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Aug 2020 17:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="2N0Axslg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbgHFR0E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbgHFRCZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Aug 2020 13:02:25 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C25C0A8885
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2020 07:12:19 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id b30so26190077lfj.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Aug 2020 07:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wOtQVCByMmS8zx5JVOBX8sDiqkGOFDwGVLmWAyBfyyM=;
        b=2N0AxslgghBHb0YltaKyY6lgeayRTAdDNJuWzYsJfNblHHseaPieELqxGyfc1E3L1U
         OFZB9Vo7doQwVZg+edxevNNZGp3zDAKYyhqiVgUbKH9uImmUklkCGMQsZ8UdFIveNw96
         62oFVlITf/gYrgUy3LkW1hZZvV5xy0MtLcloy4xwbsHofP8g+uXUYZSb0kjlqasGLeQ7
         Xf90RSf3WCBkixHxL/+ncoGfKRVSeikHZ98qqkEC/yJckQpc+GuAJ1ItBVijSiU570U/
         v/OB89Ef4OPDRhoGsFBkGybbzmES3TCvZQbcBFvPf2FgzLPlHNe7zpMLxCTBnH/KZ7JI
         kh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wOtQVCByMmS8zx5JVOBX8sDiqkGOFDwGVLmWAyBfyyM=;
        b=CEFZfRmAOHJVblcwzr02UMsleH6cKWXkgy2tGnqYZqB5Immh+y3awgiVwfJcaJKZwm
         Biatdpon1MTM6U6FIGwPhS6XORowXfQzwOayzY6OC7hMoAGKxSvNXO4aNKedQS4Ac+VH
         qQA6NQqr8RWmaEZ83IuYLfQhHRF0ZFha1+7MpWL5CfbEyQFKWxgSPQyp8b88zyIzTfue
         XB/rBFzHI3wOnXAoI4nWeeG6yAbmlgFWaIZ/LiaaWV2GAM9d2R3GNgG0AHPoRSq7EPe0
         PfP8LFJrpqGi2JV5zBOiu0o1nKie2us5QMDegkSjKqANBdi3v4NLbgEVIEuCG9tqE8aD
         X0Ww==
X-Gm-Message-State: AOAM5318HaI5jar2hI4cjVE/zJ21EJq3H0EdBZk9y36FQ5WIyVwZ0u0N
        XsdJfgvR62M2A/lPfut4Lj+PG0iCRi0=
X-Google-Smtp-Source: ABdhPJynn5ckzq8aBaLTIKM7skF7KFvpQ1jr+fTsO8HXyR12QrhnDoOF9/F3w2dQXqFi0p0FGPTwMA==
X-Received: by 2002:a19:9149:: with SMTP id y9mr4153141lfj.81.1596723130890;
        Thu, 06 Aug 2020 07:12:10 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id h6sm2750937lfc.84.2020.08.06.07.12.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 07:12:10 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Allow deleting non-existing app key
Date:   Thu,  6 Aug 2020 16:13:09 +0200
Message-Id: <20200806141309.26007-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Mesh Profile v1.0.1, section 4.3.2.40 Config AppKey Status

(...) The Status Code shall be Success if the received request was
redundant (add of an identical existing key, update of an identical
updated key, or delete of a non-existent key), with no further action
taken.
---
 mesh/appkey.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/appkey.c b/mesh/appkey.c
index 45d604007..a4771bd7d 100644
--- a/mesh/appkey.c
+++ b/mesh/appkey.c
@@ -320,7 +320,7 @@ int appkey_key_delete(struct mesh_net *net, uint16_t net_idx,
 	key = l_queue_find(app_keys, match_key_index, L_UINT_TO_PTR(app_idx));
 
 	if (!key)
-		return MESH_STATUS_INVALID_APPKEY;
+		return MESH_STATUS_SUCCESS;
 
 	if (key->net_idx != net_idx)
 		return MESH_STATUS_INVALID_NETKEY;
-- 
2.20.1

