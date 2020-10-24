Return-Path: <SRS0=OoyO=D7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3867FC388F9
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Oct 2020 00:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E27252225E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Oct 2020 00:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2v6YsFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756239AbgJXAWz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Oct 2020 20:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756220AbgJXAWz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Oct 2020 20:22:55 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CDEC0613D2
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2020 17:22:55 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o1so120984pjt.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2020 17:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+3aaflF5Tz0VrPCtbEIRim7aCcJTv5mtklnSSPu1iQc=;
        b=U2v6YsFXe2xwPzhhsYnWQm3boWHJ+JnRjS7A0/F4pEtrj5Q4n0yHBsJVoV6cOCPOae
         IbLIutTjTkmsTJYZ/4fxu64mogEbu69KCvo8GGyga246ByEWtz0nJD9/jB1NcdvmArF3
         p/nUzYVL41O48nM1m63KimYdepXnpy4KNvdJlZWQIWpLejO7F24iETXDuxUWw/4Z1o0x
         Hw+qTjvpMVyMlWNjimsJp64pLCullSLaSHpPYFhFLBJIR5HHtgtReWQz/+oFGVnTSprQ
         vQ/SR5rAbGVHpaGrA72Nre5qLw4eZJI8JNz+3jRyGaJYbeoHCc09LjkJG8MtRHEQ3e1F
         QUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+3aaflF5Tz0VrPCtbEIRim7aCcJTv5mtklnSSPu1iQc=;
        b=LmFW5FRF/Z0YMHno81Yi0prJcT+BAqlTrjnE6JxDD83w/l/98DF+s9jll5I8OkLfGx
         iVInRpIV+gOtlU6Y4TIZfl0YpMJh5UgXqfOWbfSjOddXfuTBZo4yPz7E1Qb5JMvN8kzr
         z0elagI8KwlHeLE0dM1Rwr/+6VBdp8xaL/9cKVT0rCTwO/eUu0rz3K3O5zxDme3trucB
         0sgDicVFCGjiBn4c+LzODw8a/drfhxOQSiCdo5oROb+WTuRyh1ysUASytiigY0JKOL2S
         yx+w5dCAxu6RWBI+pDPlgdP3OiKiBZ7alP+GO8XweJ9IJn+tGtT9SWgay0/P9Daq+J0V
         8Blg==
X-Gm-Message-State: AOAM531M4YjVCFAIFFGLfZQLolUVmNNm7PwcB8EgMX5eEYCLl5lYz9Me
        ykKP3nZFmRR4DdXICw3ze4uw1ugQnscrbg==
X-Google-Smtp-Source: ABdhPJyfgLikVrGvBXhqBm/oBXzjdLH2Ym9Qd02YESRFirEcHRe4Pw8a2rlG8j63lDd+vh967WnX+Q==
X-Received: by 2002:a17:902:724b:b029:d5:a5e2:51c4 with SMTP id c11-20020a170902724bb02900d5a5e251c4mr1494132pll.80.1603498974351;
        Fri, 23 Oct 2020 17:22:54 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q8sm3195099pfl.100.2020.10.23.17.22.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 17:22:53 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/2] Bluetooth: A2MP: Fix not setting request ID
Date:   Fri, 23 Oct 2020 17:22:51 -0700
Message-Id: <20201024002251.1389267-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201024002251.1389267-1-luiz.dentz@gmail.com>
References: <20201024002251.1389267-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes not resetting of the request ID when sending
A2MP_GETAMPASSOC_RSP.

Fixes: eddb7732119d53400f48a02536a84c509692faa8 ("Bluetooth: A2MP: Fix not initializing all members")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/a2mp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index da7fd7c8c2dc..7a1e0b785f45 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -381,10 +381,11 @@ static int a2mp_getampassoc_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	hdev = hci_dev_get(req->id);
 	if (!hdev || hdev->amp_type == AMP_TYPE_BREDR || tmp) {
 		struct a2mp_amp_assoc_rsp rsp;
-		rsp.id = req->id;
 
 		memset(&rsp, 0, sizeof(rsp));
 
+		rsp.id = req->id;
+
 		if (tmp) {
 			rsp.status = A2MP_STATUS_COLLISION_OCCURED;
 			amp_mgr_put(tmp);
-- 
2.26.2

