Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4AAC4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Aug 2021 22:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 854656128A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Aug 2021 22:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhHXWw4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Aug 2021 18:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhHXWwv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Aug 2021 18:52:51 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D6FC061757
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Aug 2021 15:52:06 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so3421979pjx.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Aug 2021 15:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s3zJx+BBvFd+TAbRE0aWTTn6Sf9zYcRbYxXdefZR0p8=;
        b=JcLvpb9+MaWfFuF1ccPYiVileqsmAhOrIbBkrL9eZh4uYpr/lzL+IWDaST4DUov4hc
         86DzlfMuos/6sGgGzXk3gc6PfOr5gnORx9DLQduI1MPnFtJ4JSjmXIF3MOVZ7B2Ghuy9
         /iqkgiP2OOFj6bGfcKhffK/aqfG7RVp9ilokJui7eeKoEtE69LMS6M9W27nooOrVK8LO
         M7C12mfnmkEe+CcKUeApHAGIoQUE05b8kK/fX3WneSV0RqeMeKqQmnQff5onKJNqFE/d
         NwFH2cyqcy7DX9TdEfJDtdsgSyoeqsqm6TCPAfJwmidGqUTRc5cefI5ZLlQjb5l9n/Xp
         UROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s3zJx+BBvFd+TAbRE0aWTTn6Sf9zYcRbYxXdefZR0p8=;
        b=RMzZUtOEY+iAWioJQ9VeSZjXoDh+bPplMfqI0Bv5Lz8+CcjLhGRnZLqYtGxPzRhXTC
         Xh5ONhTYcvUD5qbfktz9/iyLEfrZbbxMRLd7NbsYDVqBbYrDPvbFJNms9896vu+cDzsr
         3SM4FKhUH88CQNyS3XHsDRCApCAOf3uoLyTHHtChwH95P/B6f8gGR+tL4Um6ZdOwFGoQ
         oWSZ+gzpGScjq45LkRbfkacExKsXbNEnDK/t3y0RMen4Ei0FlbBFrEvvGPG8Qs/215sm
         tbqNJZKEg/rYkXFy9miYWiaLWA5IlXp56iPGQ7OArwxqDuQnsb1wiFWvAYxyaAlt3wrJ
         qSpA==
X-Gm-Message-State: AOAM533bNPH1qOzTl5Hke8Qeb//oPLvSaMbY99xfeZVa6HlMVfLpUv+A
        8mVB1eXdCTfF+1a8NIGHL5OP+N8WuVY=
X-Google-Smtp-Source: ABdhPJzpjYDevhrwSuSyMJazfgrNDGZAlf0RnFpxPpNkcqtXWMPFvqiUUWCoWZts4fXc+xfzZz8Mcw==
X-Received: by 2002:a17:90a:4a0c:: with SMTP id e12mr6987159pjh.218.1629845525713;
        Tue, 24 Aug 2021 15:52:05 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b190sm23273200pgc.91.2021.08.24.15.52.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 15:52:05 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] device: Remove GATT Attribute when device is removed
Date:   Tue, 24 Aug 2021 15:52:02 -0700
Message-Id: <20210824225202.826941-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes the GATT Attribute cache to be removed when device is removed
just like SDP ServiceRecords.

Fixes: https://github.com/bluez/bluez/issues/191
---
 src/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/device.c b/src/device.c
index 807106812..998485be7 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4511,6 +4511,7 @@ static void device_remove_stored(struct btd_device *device)
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
 	g_key_file_remove_group(key_file, "ServiceRecords", NULL);
+	g_key_file_remove_group(key_file, "Attributes", NULL);
 
 	data = g_key_file_to_data(key_file, &length, NULL);
 	if (length > 0) {
-- 
2.31.1

