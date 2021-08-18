Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A49C43214
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 23:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8ED610CF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 23:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbhHRXHW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Aug 2021 19:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbhHRXHU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Aug 2021 19:07:20 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ACBC0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Aug 2021 16:06:45 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so10000363pjb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Aug 2021 16:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=st96kQ+4FR4ibCaq5oiepxMtDBjTquqmApin8g9gi0U=;
        b=itxcyOpQ6S6qvEb/i6VPFWxMzNPIlPW4E2/WJFT7NRp3Y5hfzUEc+0pT4M9atqmWHq
         Ril/1uo5KRxuYRD+fG14kj2n6N4hP9NVDzeLkAEqFQPVJ5Jt+PS9+DwHWLAjK312NxiG
         lmtcUbo4H+HBZxroPV0NzTW2KBOGrf6CWFOUZXE3QYtDwjFJUsXmC7/7Ha62I518A38I
         3cV3sjVwz2VrQv6JehOug5e7Ltz75sQGInK10PeeRtfkgBxxwlDYTaSjusrEI8IN+0OE
         eXByWUDr9PJ2CYdgTwC6lM+sJuUCPm8iG81X/+HThMtWx/b2309T1oWU7w67Zxa8al3J
         G2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=st96kQ+4FR4ibCaq5oiepxMtDBjTquqmApin8g9gi0U=;
        b=a71zSPjyDaKmzNeF1iN0k7UclbLlpA8y1MLTNhZ+f6YxpCBq+DxOM6m/BsO1n3n/99
         7XfBW9vEwGYvBit2Iy0bKVIin+vcqMtS+Qu2Ld1uDfvRiMRUPb57osL/OAa6QAx7citn
         ttEZctCZm/buytkNLr0EM76hxfQZ2jD7HpXWHDQ7ozali0cv8IZZpvmsNM7Gwy9d/EIV
         DaBYqrLb3wQi8Gq6/bS0LI37QBR8QAmX2jjX3k+MtOQfZ3eyUP8wKmUe9a2Za7ygOVwT
         BRGCiUb1KXENkrAF6+AvyvBbEMHPTasbyCWGRR/ZPytDItT2uclYoAJkVHAtIGx2b+8b
         OfDQ==
X-Gm-Message-State: AOAM530SccSWRxfjrwtUjN7H5/Ti+mEa4MWwgItj++4k+L2faiW0ut23
        BdkMeQ+yUstkIFgc4UmgM7RQ308Agbs=
X-Google-Smtp-Source: ABdhPJzMiVz/+Es2XOwNtk7Heh3hefFzVqXNnhpV5ixQMRd5xpU4aNNFj0HckWff+1GU0kRUmNhn+A==
X-Received: by 2002:a17:90a:c89:: with SMTP id v9mr11827961pja.175.1629328004839;
        Wed, 18 Aug 2021 16:06:44 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b6sm842830pgs.94.2021.08.18.16.06.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 16:06:44 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 3/3] btdev: Fix removing advertising set if it was terminated
Date:   Wed, 18 Aug 2021 16:06:41 -0700
Message-Id: <20210818230641.168705-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818230641.168705-1-luiz.dentz@gmail.com>
References: <20210818230641.168705-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Consider the advertising set disabled but don't remove it as the host
may still reuse it.
---
 emulator/btdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 7e9fa14c2..4a4c8bdcd 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5120,7 +5120,7 @@ static void ext_adv_term(void *data, void *user_data)
 	if (conn && adv->type & 0x01) {
 		adv_set_terminate(adv->dev, 0x00, adv->handle, conn->handle,
 									0x00);
-		le_ext_adv_free(adv);
+		ext_adv_disable(adv, NULL);
 	}
 }
 
-- 
2.31.1

