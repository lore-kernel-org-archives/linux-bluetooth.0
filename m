Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201B1C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Dec 2022 18:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiLISDU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Dec 2022 13:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiLISDQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Dec 2022 13:03:16 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A212FC20
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Dec 2022 10:03:15 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so5733517pjj.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Dec 2022 10:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kSetUCUMxZWbbkY9msnTdiscaYEHXzWRi+YepCkqHbA=;
        b=AKLIYKzLEPXazncfCqVuYwBP5rXeOeKSx+wvFOnx7/q0T2bnRyHkHS0cycdQTOI10W
         4x2ou3NZHyIJo3svIfyIQqxBGhdGl6NYhREB/pXex+Hm5KWDQAYb6P4z709hgOvqz8gh
         HsnHnFZjYT8RmMgpqFc6fbbkC0V7nAWTU3oXb8R/g2z4wvFY8QonFjJ6nMkwdBCXmg7a
         vkHBg87fPvAKmzsh8qmoylwAmJWZNIYoQmjXl1mUNNFNdk55cAPiUnwQVd1YRMv4nruH
         dYo+OaWQG3au9KHvCtLBH41aUiJESgNdOVZXBulNYTZ1/2TISgTSOvpTznNhWJqfo7Ho
         x5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSetUCUMxZWbbkY9msnTdiscaYEHXzWRi+YepCkqHbA=;
        b=UA94UaZV1HP1/6+nsmyF/2RmqimVoMLT08P7ymHBVOPYPAAW221wLGS/hIu3inw75Z
         Sij9eO5pyR6M6oUQ0F/JRc6yknjATsvh3oN6/vQJyURNjpxAwiQSKISIsLt/UVN+o+St
         nvJzySSSij9jvcoyyOcv+9zC6FCGkveSyi6/fS6HPXc3pohrIvB21ZuUm6IL2n/XVVid
         TJKWd5EbgvTlREBjmhXunAhJ5ejW5n1XoONw/T7vVwZY493/Mn6tDavbdPs1govX64CK
         q6Gl6k7QPSuIPSwkIyLURlPj64EkcS+srUCBHS0muiSENBDca45LU96R88rRhQSWIjpY
         SqVw==
X-Gm-Message-State: ANoB5pkjH8ZxtwDERWrXpbjxqqbsuYaycLMG//hpvFaQFjTlGoMsteFx
        tGMAAd67+t7qlv/WZhv/rwfow+1BP5NXX4iX
X-Google-Smtp-Source: AA0mqf5DnsYruUKoLCfNKCzftJ6xU9wTawXFoNyFrAkyRtILLvfe6mfyj9X/YeDczyezK1vTvNZUCQ==
X-Received: by 2002:a17:90a:4a97:b0:213:d3e4:67b3 with SMTP id f23-20020a17090a4a9700b00213d3e467b3mr6365342pjh.21.1670608994431;
        Fri, 09 Dec 2022 10:03:14 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d26-20020a630e1a000000b0047702d44861sm1234442pgl.18.2022.12.09.10.03.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 10:03:13 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client/player: Fix not calculating time to wait
Date:   Fri,  9 Dec 2022 10:03:12 -0800
Message-Id: <20221209180312.938166-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The difference of time start and current time may have advanced just
enough to add a second leaving start nanoseconds to be bigger.
---
 client/player.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/client/player.c b/client/player.c
index 7f2b26b8791a..95309e101148 100644
--- a/client/player.c
+++ b/client/player.c
@@ -3396,6 +3396,10 @@ static void send_wait(struct timespec *t_start, uint32_t us)
 	}
 
 	t_diff.tv_sec = t_now.tv_sec - t_start->tv_sec;
+	if (t_start->tv_nsec > t_now.tv_nsec) {
+		t_diff.tv_sec--;
+		t_now.tv_nsec += 1000000000L;
+	}
 	t_diff.tv_nsec = t_now.tv_nsec - t_start->tv_nsec;
 
 	delta_us = us - TS_USEC(&t_diff);
-- 
2.37.3

