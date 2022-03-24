Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13661C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Mar 2022 22:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346968AbiCXWT4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Mar 2022 18:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiCXWTz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Mar 2022 18:19:55 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A34727142
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Mar 2022 15:18:21 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id t2so5128281qtw.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Mar 2022 15:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TaAuXatjmavn52ASJ9uP9pd0GETblCdz9KR/zoYFrN4=;
        b=NxSw7nSlofLN169d772C7Mj0MMoOtHWYMNhtA2RIIuLMfg3dGzm702aETN5pixcZxw
         OT3qIfGhrczt+2Mv9eYVzht/gWTwxNf2WCS4ZkNfEINHDwBZfmWtcGkLyqo/Z341Vcba
         ZxTDmPDqB8whAlcYIViZxpW3nBp3J7vaSv3Wa+O/AZkQyjjIG26JBO8aOrcctjhEVn+F
         RWwRmzU7JW/Qq/MZRI2rS1f2poh+dtls+pD6RSzbL72F7RubF8EZW1dcSPR7EMGpZiti
         CSZp2djAjaBSh+8D2E69knbQQ7BZEIoZc8gAt1+gBjdW5ihVEJyXrhE9fm8iMDw5WgUx
         tgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TaAuXatjmavn52ASJ9uP9pd0GETblCdz9KR/zoYFrN4=;
        b=73clagAK1bMi16FnBDdOcRvTPUR8MnA9aeha+dVkeW/IQirVWQA7xKfJ7plV8cS2Sj
         M00gHVhnxdx7LD5I6FergEwwOQJyMGRFcMRf8fluKW++6eJfpSFZ8F7CW4H7op8k3wVo
         sVAfQoFw/UKCaPXCx8oxXe8WjbInk0uf35lFBvuKB1X9XYFdp5Xg39NRuJvTBVwaO93y
         +VPNeDM8/M2v4eDNhMd5X95C3H6P4RlsOjkVG5a/S18xlZX/hZf90koCD327kB8oLHF/
         WIRZvJ3V+3AfbHSS5VmpcDSHraFipHL5/tJa6At5DxGSHfEZ5zRKUrF0cD9tL6E2T8DA
         4qNQ==
X-Gm-Message-State: AOAM533lV4eVrEzrUNqMyDFYG6aHVX7OKOJTGPw+3nD2xUuZ8bwEKmij
        OidpOYitO54LR7XdAZ0acc5BunAZbuQ=
X-Google-Smtp-Source: ABdhPJxX1tvbaMpx4PVU7r0JRKQv0TUCkkEL1zUNeN0SZFtUBqy856/ElDJ34rBGi0uu6DGPu+hGdw==
X-Received: by 2002:ac8:5747:0:b0:2e1:e152:f257 with SMTP id 7-20020ac85747000000b002e1e152f257mr6646591qtx.74.1648160300265;
        Thu, 24 Mar 2022 15:18:20 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h6-20020a379e06000000b0067b30874b90sm2200907qke.41.2022.03.24.15.18.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 15:18:19 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] a2dp: Always invalidate the cache if its configuration fails
Date:   Thu, 24 Mar 2022 15:18:18 -0700
Message-Id: <20220324221818.81338-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When a configuration had been restored from last_used cache but it
fails invalidate it so another sep can be used.

Fixes: https://github.com/bluez/bluez/issues/313
---
 profiles/audio/a2dp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index d66c22b2b..c3ac432a7 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -872,12 +872,10 @@ static void store_remote_seps(struct a2dp_channel *chan)
 static void invalidate_remote_cache(struct a2dp_setup *setup,
 						struct avdtp_error *err)
 {
-	if (err->category == AVDTP_ERRNO ||
-			err->err.error_code != AVDTP_UNSUPPORTED_CONFIGURATION)
+	if (err->category == AVDTP_ERRNO)
 		return;
 
-	/* Attempt to unregister Remote SEP if configuration
-	 * fails with Unsupported Configuration and it was
+	/* Attempt to unregister Remote SEP if configuration fails and it was
 	 * loaded from cache.
 	 */
 	if (setup->rsep && setup->rsep->from_cache) {
-- 
2.35.1

