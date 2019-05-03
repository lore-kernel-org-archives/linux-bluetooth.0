Return-Path: <SRS0=8q+o=TD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5912AC04AAA
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 May 2019 08:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9DA2089E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 May 2019 08:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpEkDWad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfECIpw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 May 2019 04:45:52 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44086 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbfECIpw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 May 2019 04:45:52 -0400
Received: by mail-lf1-f68.google.com with SMTP id n134so2047974lfn.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 May 2019 01:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sJGE92oE4Jz1YOV4GEYgBupNI6ZSiaKwlyuNmR0DgWE=;
        b=qpEkDWadIgMacLRn2JNe4hh4txhx7Xu49+nJaTvoxD83LTxKUSAHF19Yui5Uxb77Pl
         JaVSSkJDjOlP52ih9SxG/7Vj+b7ttoYl9LvsF7Fd6CDlQzywHPoQrOrSD8sNB/+jNBVZ
         i0BJO7mDLeKNUG2ijAFVS3uw1A7bhMagz559TyJl3kM1ITFPQtNPPw+uDUSAa7Mlsn1q
         xXfkY4GJJSptuxjHBVeVNmPJIa1mkHE8BYuvgCMVTseG1oDj3gyTDUNSocSbJoZPqsfo
         q81GRoiz6nDYFYRnLWE5xFg7OoFxmLCQplNaQyZ6e1HYLgX12CIuLhjA1YjiL4NsiohX
         +wkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sJGE92oE4Jz1YOV4GEYgBupNI6ZSiaKwlyuNmR0DgWE=;
        b=J2Ph7083It0koxaXuTtbOHPVyGB10xazq1Wyxwqr5YTASY8Xii3UOd/pGWNjfFDh/C
         YJsqMTzWylZEuCkin1TRzNHjZeUxNVfwgUPLUTK1sxSRbN6satxCAfv58ClRv2xo9gZ4
         HVGMRMTEzKEq9U+co9SzWyrt3aH5SJTadOcKu3cqtKZz1LnQStgv/qGo93MJpckbPl5m
         xi5s7okLUsgHJEcMO4aSLMfNTztYNB+ho0nli6+k6gjUMBZUGGrICCD9YhL/dnzDdZc/
         eq+hFaivQ6XEwWjGxvIHKECt10PKpKHqWC7m9lhj2hMNv+La0GNkQyVxbpQjkTpNHlWO
         VhjA==
X-Gm-Message-State: APjAAAXfJg2n8bc4IR97zfjx4oEDW3kzHLM7ia2bf/BGKEKV1Qr3Eo0r
        npGhHOakrCT9NXroPPzPOVHoJWCj31DmGQ==
X-Google-Smtp-Source: APXvYqx0y0skk64X9NIqZDwXul5mMpLSMyA04U2jy5PXGJpHJOVQxb7rQhGOJ+lM9Am3vuqX/fx8kw==
X-Received: by 2002:ac2:51da:: with SMTP id u26mr4466647lfm.32.1556873149869;
        Fri, 03 May 2019 01:45:49 -0700 (PDT)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id h26sm311360lfm.11.2019.05.03.01.45.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 03 May 2019 01:45:48 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] a2dp: Fix crash when endpoint respond with an error
Date:   Fri,  3 May 2019 11:45:45 +0300
Message-Id: <20190503084547.15743-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If endpoint respond with an error the callback will be called with size
set to -1 not 0.
---
 profiles/audio/a2dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index d0676b577..74ada3bbe 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2418,7 +2418,7 @@ static void select_cb(struct a2dp_setup *setup, void *ret, int size)
 	struct avdtp_media_codec_capability *codec;
 	int err;
 
-	if (size) {
+	if (size >= 0) {
 		caps_add_codec(&setup->caps, setup->sep->codec, ret, size);
 		goto done;
 	}
-- 
2.20.1

