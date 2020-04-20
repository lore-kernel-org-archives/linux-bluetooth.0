Return-Path: <SRS0=YdAw=6E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1E5C3815B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 12:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B6F206DD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 12:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="UYUXPEie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgDTMHO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726381AbgDTMHN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Apr 2020 08:07:13 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFED5C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 05:07:12 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id w20so3338599ljj.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 05:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BaP5pgd7yRmBH3fNqfHwEiNp+pwbVq/XO4Y9gOYtEDw=;
        b=UYUXPEiekNznSL8WbTQG1bwkDqoZc4aO8whWoGaI+RrpVyuklGi4JRWxv7DKsRblNJ
         E1ipoKNUfs/TVJZE104y3CKIM6Q25lw6ZZ4v9e79gHQHet16eL2iWspS8SQly4y2276B
         dWDSU9hdUghd/8SvGvhwJaj52LJN7oL/SEeEi8+rlNfmhRB6McYH7BJqQ6XQnm4E6ZHo
         1+uDCevp39Ig5hzWZYzm71PsvXGdpSdog58XlVWkOZjSwmz/qPuSrLKJpExLaBMElVal
         RJ17baFa42sbs8LOuCZOyLAaIgiNZ8JBrqVBfTX4UJ0cHk6bOIRKQjIc/SvMpcgoills
         z9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BaP5pgd7yRmBH3fNqfHwEiNp+pwbVq/XO4Y9gOYtEDw=;
        b=AsvpBUzXVEdkBqrhH36O1CQzOHhRw+NFPVyM16bPhqE0RwTo07j4F5B9KLaBP505i0
         iPI78zfhQLo/eoQ+7MJRpglCBi7PfP8e+RhEfHUxvoyhZucN+Qt5ZL1XdoSkPHqkG5QD
         fLKcvCr4WeoZaqn9p4/olHxSll7/0M0ewU8ATRHrfPy2lOFUmZobXKPSj5KUHQctXcQJ
         w9DT3l9LBIQynsSfjpboel8LVnJiVowUpMi+9X120bvCPLT8Y0ufLZDZPoY1wwMgebF8
         4rOnz0OqLonkP7nMv1zg5y4M5r9wTIUlaisjjO9uu1s9nCHNDECLnYB7/TlNH9OpkFBb
         bIUQ==
X-Gm-Message-State: AGi0Pub8iRnY3oI5dwtu7RyvZtglGwLScUN3orMZNuqzKqHjbNkeMK7V
        LoCx3BWCg3ZEz9XO+jMpsOJwb8WMzNM=
X-Google-Smtp-Source: APiQypLmQxHu/XTLm2aM8vN4gfmorCifYTyw5MEQ74gvIkGqveZljEzYu+Wi5xvDqDO+/q1QESRjgg==
X-Received: by 2002:a2e:3209:: with SMTP id y9mr4192148ljy.154.1587384430736;
        Mon, 20 Apr 2020 05:07:10 -0700 (PDT)
Received: from localhost.localdomain (45-11-60-42.ip4.greenlan.pl. [45.11.60.42])
        by smtp.gmail.com with ESMTPSA id i18sm666814lfo.57.2020.04.20.05.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 05:07:10 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 1/4] android: Fix build with GCC 10
Date:   Mon, 20 Apr 2020 14:07:02 +0200
Message-Id: <20200420120705.89691-1-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

status and state are used to hold various enum types depending on test
and callback passed. Define them as int to avoid warnings about enum
assignment from invalid type.
---
 android/tester-main.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/tester-main.h b/android/tester-main.h
index 8a7384c57..6bdfdbcdb 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -653,8 +653,8 @@ struct map_inst_data {
  * matching with expected step data.
  */
 struct bt_callback_data {
-	bt_state_t state;
-	bt_status_t status;
+	int state;
+	int status;
 	int num_properties;
 	bt_property_t *properties;
 	bt_uuid_t *uuid;
-- 
2.26.0

