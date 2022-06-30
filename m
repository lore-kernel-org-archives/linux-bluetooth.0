Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4F0C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jun 2022 22:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiF3WO6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 18:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiF3WO4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 18:14:56 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D8057232
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 15:14:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id w1-20020a17090a6b8100b001ef26ab992bso839722pjj.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 15:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BY74aJKawL8ZJHJdZMpTNWRQDCAFbo7G5NU4C+yjJ6Y=;
        b=Td4OY5+SbPBTQt+0C11lMrXG/yhC6pWEtm3xRVThWq9dKq1jVubNHvvQD26Zr7CScC
         nj+tZ5eZUK/0NHKghpFq0UX+CkfarcBIhheU4EM7452mLO+8ju9oVvY4Vw9vtptGlKqJ
         ppLbwSZeYSyqiYYL61sIMmCmAFQc2B/DuVM/XIZbbHoy+lEq2krPSD38b5ToDY/K0rVu
         ht5AfkOezqfRr8ynYnFnubeioFxTNJd9e0YLeHzoWuVUIbh3mfO9pDcr+BIJbn+abXdO
         ixTyHjYQSR1MJU/I/fDAnjck2zhalnKyBLze/Y/TrMtSrV+wW+ReifyWfkrD0QMmzZw1
         QL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BY74aJKawL8ZJHJdZMpTNWRQDCAFbo7G5NU4C+yjJ6Y=;
        b=to4TW7/RzrlT7ZEc75ywvwDKIrJyflbyKWXMp8V+5k7iDUQIpnSSuRTXyG26w/bI6f
         3yj+fPIWJlHu/NLirT6wHCL7yolLIS10JOgRPiF0ZU5Id2gDW8w7RMNDQz39xVWcYo+l
         fnZ2O9vaEvi4AH8NXs8n9mtXH60PdvhPyndj8ZiR0KUgQvjlBRGY3JFXL19E3PT5lHIB
         AIXFFfVRuCzPsiZ/v6s4g+1s6plgdSgrZe2LimJw2eh7d7n5PCqosOswCEtYNDeJaGK5
         LjFmb12rot2iT4p/GJbxDMAvAu8h2v/yuBjhktl9KrljvP9zP/qI3RccJ3lYqj5pSzHb
         fsxw==
X-Gm-Message-State: AJIora9YSz6z+F+8nMVoymI9q4/cQGZ00CBD57Kl0aApe163vSFQSC3l
        /zbNsK+tVbgB5cVqiiisqeVXr9ftINOakQ==
X-Google-Smtp-Source: AGRyM1upvQ2I88ccKjmoSa4CGjJmMuIKu73CYHbEjU1j3du6+6mqaW3KCEw4TprapHd4EMrhuxwWEw==
X-Received: by 2002:a17:902:d48c:b0:16a:629e:2f21 with SMTP id c12-20020a170902d48c00b0016a629e2f21mr17014907plg.148.1656627295344;
        Thu, 30 Jun 2022 15:14:55 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id me3-20020a17090b17c300b001ec84b0f199sm3460333pjb.1.2022.06.30.15.14.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 15:14:54 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v8 2/8] shared/util: Decode BlueZ Experimental ISO Socket UUID
Date:   Thu, 30 Jun 2022 15:14:46 -0700
Message-Id: <20220630221452.638591-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220630221452.638591-1-luiz.dentz@gmail.com>
References: <20220630221452.638591-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds BlueZ experimental ISO Socket UUID to uuid128_table so it is
decoded by the likes of btmon.
---
 src/shared/util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 33196bf8b..b74a005ce 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1149,6 +1149,8 @@ static const struct {
 	{ "330859bc-7506-492d-9370-9a6f0614037f",
 		"BlueZ Experimental Bluetooth Quality Report" },
 	{ "a6695ace-ee7f-4fb9-881a-5fac66c629af", "BlueZ Offload Codecs"},
+	{ "6fbaf188-05e0-496a-9885-d6ddfdb4e03e",
+		"BlueZ Experimental ISO Socket"},
 	{ }
 };
 
-- 
2.35.3

