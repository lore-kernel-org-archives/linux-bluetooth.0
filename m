Return-Path: <SRS0=3U9n=EK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD65C55178
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 23:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05B4020786
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 23:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilBoYZZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732863AbgKDXmm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Nov 2020 18:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732861AbgKDXmh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Nov 2020 18:42:37 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C96C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 15:42:37 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b12so89306plr.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 15:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GioplUM0BRUba4km2iUOfXJ3MZny2/Sz0TzOafj3MFE=;
        b=ilBoYZZWduAKQ+zAhFA77qwfZEGD4H0rs1qbmTs46ikvzyRx/REqYU7Q+7oW5ZGc/w
         GKFEYIIsosOcUhOBVm5YgJ021RnAwLT9BcWPDrYxSjP6PbHExEhtqmn1nEz6i83MwFZF
         9u2/90KXZcmS4/iXIGjNd9LAHHDmBFigzDbxHm1Q9UX+3moh0KMgTT3Kr5TQiRURU0IC
         Rz2+KuN+q9JdnEZxZErn2c/K9kNBpZRqtcW8kcekgFugO4/qdqp9j0/2l8jInffcW44Q
         2g7r5upJi2b+vSWlKqN3y02forNOtUhC6QQAwsdvOwnWujva9LkNHE061/dXypI92Gg/
         ieEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GioplUM0BRUba4km2iUOfXJ3MZny2/Sz0TzOafj3MFE=;
        b=LwPM0HmOpKNBD4kujGhDvyd9q/qFP+BGg5M9KplE0rga75vuaS1wtua4w76ddBaTZS
         ENFOUaBJoOKZAwXVLSNW0khBn49TveyxOtWk6bW9WPpBQ4wu8eei/Ia70SpupreK21v0
         5L01oTg/JJARyFmPDrKNFClhhQ37SgS7rrGuChC/ImiJ/YflKyLe2umGOhpMsW4OZgTN
         0ZMgdbyESBi1Kr+2WlKbGB0/jjP0EhDe9mBgK0FOFQaE8yEvcNow6DUqtPnwPbo7xCF0
         VagAnuf0eHy7bqmS+qC/KiZqwGWbuwO7EHt5HfCVx1j9kQV46h5hqwZ8kHr8KuqgixCj
         em9w==
X-Gm-Message-State: AOAM531e0R8+AnOGP4GKuIqaJazPYvaMWQID/3txRuG3MaMO55Z0jhVk
        8JHfBZjeZtb89+ubW7nPAwfqlyjBOcldig==
X-Google-Smtp-Source: ABdhPJz74nHZz5vISKD1nJ4pZbUsHF2q9y+4ewfED84PgECmN4tAkLivI6+1ipGNz6aQtBjtTT5KpA==
X-Received: by 2002:a17:902:6bc2:b029:d6:e0ba:f2ff with SMTP id m2-20020a1709026bc2b02900d6e0baf2ffmr464168plt.10.1604533357249;
        Wed, 04 Nov 2020 15:42:37 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 30sm3361513pgl.45.2020.11.04.15.42.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:42:36 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 7/8] mgmt-tester: Fix failing pairing tests
Date:   Wed,  4 Nov 2020 15:42:27 -0800
Message-Id: <20201104234228.2257427-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201104234228.2257427-1-luiz.dentz@gmail.com>
References: <20201104234228.2257427-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Just-works pairing does request user confirmation.
---
 tools/mgmt-tester.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index f6eac30a5..d8554411f 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -6051,12 +6051,6 @@ static void user_confirm_request_callback(uint16_t index, uint16_t length,
 	struct mgmt_cp_user_confirm_reply cp;
 	uint16_t opcode;
 
-	if (test->just_works) {
-		tester_warn("User Confirmation received for just-works case");
-		tester_test_failed();
-		return;
-	}
-
 	memset(&cp, 0, sizeof(cp));
 	memcpy(&cp.addr, &ev->addr, sizeof(cp.addr));
 
-- 
2.26.2

