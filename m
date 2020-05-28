Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12358C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 21:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8582206F1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 21:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPb3DhGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436701AbgE1VxF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 May 2020 17:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436611AbgE1VxD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 May 2020 17:53:03 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9059C08C5C6
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 14:53:03 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh7so116389plb.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 14:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CRNf3g0aaybUiuE5w1c4KF1fNLd5dCJGW6FPC9eQZFg=;
        b=VPb3DhGadUSP1BGeqFQqps+s3nQPPWMANvCC14lri5kn2kIObVSyt8Xf2h0Pdes4EG
         yhHFcjE6R/BuhZhA4eTbQALi77K6iKRqYjLkK7tguDEBzdfjcES1IlU1GsglKKFKzTwn
         ubqsn/tQ/RnbiFJOuEe8xbaNX9XOXIQT2aqPS7/IQ6AbynaGTdmeUKTJbasMbkNH2XxR
         QtWYa2bURi+g4GnBdjJwgK4gbpG5Groie3G6qXpnMtvDp1kZs4uPFS6EPipOJRaMri0l
         v/2V5pHLp4570iIEYdaYOiDE0cP1GPm3ZGwyIRFnPjcRRZHfUMfAQ+vvSMR9vDym2pPA
         e+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CRNf3g0aaybUiuE5w1c4KF1fNLd5dCJGW6FPC9eQZFg=;
        b=NpHt16KAVZpDPBDVADZ5aqeFmDx1YcDQLS3g+xm2yD5s+Wir3md1g+8mC2KUr6cGea
         4g9BkVBA8GQfI9ro1Pq/VAyeYbwJW3VzQ7pcO+9yMMOlyqFybBf54cC/vHFsWJS56z/c
         ltOEztJSRBY3jMYHAIybyydxOTgixl6H3fmTtRBOu0l5juaGwbh3h5pTVPCt08qbH6/3
         5IUUXKqMMJ3wdxOVZX3ETDvoh+zaGURqfpxtfb/ZZp7crTVPksn9QST5JnA7LvDeq/JX
         7wLSvPj5IGUV+xcilyE23LP0r3QE7Xup5z5Rb8VEsTIdZOuF5bIyz3NQ0zAOyBprEqGC
         MNcg==
X-Gm-Message-State: AOAM531g0n/RvJlJ5Hv0mFsz91+Jxg0ue+ZYKAsf72+VrK0GsxOuFu0z
        E/6oe1xNywlE0P+ETAji6Jgg+RSM
X-Google-Smtp-Source: ABdhPJxz6lqcqeqh2b54csFT8FrpzUvimKa0m1pDsbXaW5/XlsqFbl+zdrK0LHs40NOY6HNlKmTIKQ==
X-Received: by 2002:a17:90b:1882:: with SMTP id mn2mr5964080pjb.139.1590702782771;
        Thu, 28 May 2020 14:53:02 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l4sm5126170pgo.92.2020.05.28.14.53.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 14:53:01 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/2] avrcp: Fix always requesting player settings for category 1
Date:   Thu, 28 May 2020 14:52:59 -0700
Message-Id: <20200528215300.225894-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Player Application settings is not mandatory for category 1 so instead
of always listing the settings the code now checks if
AVRCP_FEATURE_PLAYER_SETTINGS is enabled.
---
 profiles/audio/avrcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 773ccdb60..75811bf98 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3814,7 +3814,8 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn, uint8_t code,
 	if (!session->controller || !session->controller->player)
 		return FALSE;
 
-	if (!(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
+	if ((session->controller->features & AVRCP_FEATURE_PLAYER_SETTINGS) &&
+			!(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
 		avrcp_list_player_attributes(session);
 
 	if (!(events & (1 << AVRCP_EVENT_STATUS_CHANGED)))
-- 
2.25.3

