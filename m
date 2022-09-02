Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E02C6FA82
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Sep 2022 20:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiIBU5I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Sep 2022 16:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiIBU5H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Sep 2022 16:57:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCE7FE056
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Sep 2022 13:57:05 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id z187so3012310pfb.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Sep 2022 13:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=8cDfzwjM0finE9g//xgVBrtc5y6T2crNYeGbazEZAvw=;
        b=OmU/Jbb5ky0EptnU3Qu3ovGxRNLkjA9xyS4G7J2tr+YvL8jatr/2bVVY4BCHwtZRC3
         cZaeFm8i7t6el/ezI6lx5OUs7qg85S8iEvJCzUhW42VRSWTt0mVc94/KPCLVjS+tQcUD
         Ts2hNcZE8kYSoxXRmRXgwg/Q0em8k89DEd4EWnbkDADZSpYm4Yr2t191I47wmwXIVyHN
         160qnoccxVzLxv+KNbPpLKCk3hZDnUAcddReWgTpSBMuuNS6Un8cXuqvGX81A3obz+PW
         bFCEA6sdohvZAvQNyXUwE4c5DvrkEAfyuYacbsb34V39FQeIPJyCoDZdKwC4FA5NOltD
         ohdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=8cDfzwjM0finE9g//xgVBrtc5y6T2crNYeGbazEZAvw=;
        b=j4HUGIypl/PL3w5Pyqtm1bPv0PayF3S3y/Z7tioj0X2yJl3pRJpWfRXiKDhA9kJfHc
         DAimvD00uX5wHWoKjLVm8VrLYEJ962NypyLo1nqYtw8qf1Sxcy4Ug38tv0QvniZZxe62
         0cvL0UnX9S7wXrjCBLsevCAhMigropHGeQRtKQOyADaaglHudTUiBIun6qTydNEiMre0
         lQQbxanKGkUwVfhmsIaSuEgnorXpJdhpoopg8AVaPwD/Z2KxXdECsL83C1WGMCKdLSW3
         8XDNYxHp9OslqNg0k3bxTkv5ppqoTHI7Wxcj2Uq2cZ9XrJm7r+qBAXj4V4uwlW99W6q/
         M0kQ==
X-Gm-Message-State: ACgBeo0WVhFSmiqK08orbX7RNBH+a8ne/xVeL+BR8twRQIwhCEVEFQHd
        2z8b8gLQ7nhyJm/HM36FLUjtagFiFFg=
X-Google-Smtp-Source: AA6agR7sp7q9AAWkIO7TYWD2D4GxKzAczu0S6jl+x/qWEww0PPTdPNhTVllp7tAmLvuoRSHTSyvPTw==
X-Received: by 2002:a62:8e09:0:b0:53a:729e:9955 with SMTP id k9-20020a628e09000000b0053a729e9955mr19608850pfe.52.1662152224393;
        Fri, 02 Sep 2022 13:57:04 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d134-20020a621d8c000000b00537dde5ff7csm2319187pfd.176.2022.09.02.13.57.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:57:03 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] rfcomm-tester: Use latest Bluetooth version
Date:   Fri,  2 Sep 2022 13:57:02 -0700
Message-Id: <20220902205702.1955891-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes rfcomm-tester use the latest Bluetooth supported by the
emulator which is useful the detect regression related to ACL data
transfer.
---
 tools/rfcomm-tester.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index 32c0d6058d14..d594ebf345ce 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -788,7 +788,7 @@ static void test_server(const void *test_data)
 		user = malloc(sizeof(struct test_data)); \
 		if (!user) \
 			break; \
-		user->hciemu_type = HCIEMU_TYPE_BREDR; \
+		user->hciemu_type = HCIEMU_TYPE_BREDRLE52; \
 		user->test_data = data; \
 		user->io_id = 0; \
 		tester_add_full(name, data, \
-- 
2.37.2

