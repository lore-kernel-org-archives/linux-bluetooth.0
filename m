Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF03C19F2C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 06:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiHPGBk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 02:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiHPGBY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 02:01:24 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFA77E311
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Aug 2022 16:26:39 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s206so7791651pgs.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Aug 2022 16:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=X2MPZKPMA1t7Ei3dQp1ACWwbEt+VEpMzdmVn3LOSD68=;
        b=dhjtxMLFCK3R/VAH+BvFWq/MSfiez43sbLpFgkh4teYprXWk/YxSFqx/zCBdDkWcZZ
         mbAnqEhiMaeeTDQBYeXedVNu9NyOF6g4lDeid69YpPWMRDbX0xIlFKZBZA5cluz/lh9V
         zf5G3lwXhpZe6aH0sC37eKrYZg5qjDINH6CMY/TkVUTrvAYGlK11ERPWEg8G83sa0vtx
         T4N5B4wfbsIokoW7vSx8nDtWdCHBOSS53L06yldvDmloKMEk2SzSvErKGtOLp/VEW9g5
         wGd9VTv4qe/k4ymmTSK+7rvAFrDaG6eDpgMKsHqlOo2e5BEaLyFmSiFyBqBRBapTSc3R
         szCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=X2MPZKPMA1t7Ei3dQp1ACWwbEt+VEpMzdmVn3LOSD68=;
        b=riwIpvHTCM67ZJrQx4UF4WBoKyK6HIqF6SYdU6KRom1wlOCXzpSNTSUnEDT4kWYFhW
         BYLoFpdCySFTA2giZTiS0vxHRLRFPqT9flelh3RmFj4mqHTIjF9Rs5vJiuTvYdpEAFh6
         Z08B7vkBLoFyyDcel6hN0S+TDaG/MtsDnlBkSW1DIx+48okZZKFG7qdSGrJTmyEbK50X
         7csphGFhnIvKFUDn/xHLkIA3JrciyLI8W9kFX5tgTpdyWNvapjkhglOtrKl6b1e1Y1+4
         BFVNNXuip42RkmFrkS6qbEAojwGJBI3Vd1gNOyaAbo4IvMA826+K2TuqjLOfrQN2r/G3
         UaQg==
X-Gm-Message-State: ACgBeo3lyAnj8LhX5BfKOQVa9JC9s6rzbjKSjUf6sJjWWNMkTHlEnX1b
        zM0B6x3rDSbGp6zUxWGgUZ8AcHFOiJrbCA==
X-Google-Smtp-Source: AA6agR72lpBITjaxYOxInMo0KOHOwLg8lcaV+vH86y2zBwhbH7H6K5IJCiGL13276R5EmGC67g9zuw==
X-Received: by 2002:a65:6e87:0:b0:41d:fefe:fd9d with SMTP id bm7-20020a656e87000000b0041dfefefd9dmr15297158pgb.557.1660605998598;
        Mon, 15 Aug 2022 16:26:38 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b0016d23e941f2sm7474276pli.258.2022.08.15.16.26.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 16:26:37 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] build: Enable admin plugin
Date:   Mon, 15 Aug 2022 16:26:31 -0700
Message-Id: <20220815232631.1275861-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815232631.1275861-1-luiz.dentz@gmail.com>
References: <20220815232631.1275861-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables admin plugin with bootstrap-configure so it is normally
build by the likes of CI.
---
 bootstrap-configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bootstrap-configure b/bootstrap-configure
index 0aba3ef22295..8172840d5fc2 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -33,4 +33,5 @@ fi
 		--enable-ubsan \
 		--enable-cups \
 		--enable-library \
+		--enable-admin \
 		--disable-datafiles $*
-- 
2.37.2

