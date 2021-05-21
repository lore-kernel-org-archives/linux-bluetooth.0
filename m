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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6893C47076
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 May 2021 17:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 848E4613D9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 May 2021 17:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbhEURFe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 May 2021 13:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbhEURFe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 May 2021 13:05:34 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B251C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 May 2021 10:04:10 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ot16so9354287pjb.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 May 2021 10:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OrE+aYLfm13yOMdJc6r05vZKjSQx3iCKFks6PE7gp0g=;
        b=EDIY7DwKRDbFrFHqQ0Qx/iDq/hSivIqD+TC00NzcF+EgiIUkHHASMw5nw1Mdaf5aQH
         4Bau6SqnNTcnU8Ha6kR3GUXR/p+7bz6czkjwaMUQVd36x00+Lc1nNwzJ1y9dzwlEx1u3
         Nt6/v/Rf7wdK4CmL/jftyCr5Xa1TglBDhjrQ2XxCotYRr/VWPPdXrcCsPGEG+vQwQU7z
         XIHfNUTyyeC509iLOg6AqhWNdlYfz0MCb8dYUKDQI17EsfLJ4Ywi0E3lGmUsD39/edz6
         IuqZwuUNeZ5t94O73xVa/nstRzaqVKWZrH5Q4dHjlN+g6psWiV/05anAQ6Ik9xuNd4dV
         2sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OrE+aYLfm13yOMdJc6r05vZKjSQx3iCKFks6PE7gp0g=;
        b=QJKJhdhBgx5DaotXseRBJoO3+6WGwxU5BMnB1gU8iPqZykuD57LMeNAwmn3cfv0r17
         yVEDw6vcjXr5QjwJVKagfwlky6YsdkLxNJegQtfzg6vlycHWn0TYJ4WlCPSyeeh/RWuG
         pyaHgj6Y7CBlODVG1LYxT06mmCO7nftqo01LlIbfde+xd7oiDXEKPntp6TKJDkfi7s8b
         W3JK4KdAfcEBr1aZcvZKrnY4BXtE+fiSJc+o0RROR5YAP6UEhzF5zz5lXyuHmR4dsdsh
         nWUqXfZxi9GY6gnjWo7+IRDaOYHVrmQWe2zwrV/g0l/o2J3SfGiTc5NMEuNi7iBamd4Y
         +bHQ==
X-Gm-Message-State: AOAM532FX/cr6ZkBC0EHOcWAAtIQNT/kpIiUMAxlllS1sP7D6fy2iefz
        PoWMZT4Gk8KD/dql7mJsP9f2B82bKQT/Hg==
X-Google-Smtp-Source: ABdhPJytYQXUfWL+dHDdTQAOgys65erNKRtvYFRYaEli018oNs0vOZleWezi9HSVVdDDY54wP8Iz0A==
X-Received: by 2002:a17:902:c406:b029:ef:7ba2:f308 with SMTP id k6-20020a170902c406b02900ef7ba2f308mr13290548plk.9.1621616649686;
        Fri, 21 May 2021 10:04:09 -0700 (PDT)
Received: from han1-mobl3.intel.com ([2601:1c0:6a01:d830::e853])
        by smtp.gmail.com with ESMTPSA id y14sm9056094pjr.51.2021.05.21.10.04.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 10:04:09 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] src/main: Fix double free str
Date:   Fri, 21 May 2021 10:04:07 -0700
Message-Id: <20210521170407.180152-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the double free the string.
The string variable is always freed within its if statement so no need
to free it again in the end.
---
 src/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/main.c b/src/main.c
index ed19e3e28..57db9c134 100644
--- a/src/main.c
+++ b/src/main.c
@@ -804,7 +804,6 @@ static void parse_config(GKeyFile *config)
 
 	parse_br_config(config);
 	parse_le_config(config);
-	g_free(str);
 }
 
 static void init_defaults(void)
-- 
2.26.3

