Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938D0C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 13:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CE32074F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 13:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gbZZroAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgC0Ny5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 09:54:57 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:39362 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0Ny5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 09:54:57 -0400
Received: by mail-vs1-f54.google.com with SMTP id j128so6210396vsd.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2020 06:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xu0gEbWA6ibWlugXTRQRW6Xk60MCl0M+uNU3j+DifZQ=;
        b=gbZZroAWhm3UmcvI6ud2dMuQu+JwyLC47zRWnLp8C/FdXd/GrQApuYoCf83CwmqU+S
         CAsgGMYo7/OguyaXZEr6JBkPTsM5ZwBE5hdcZU9nDGTCkhx7fc+65He0G820Nk+cYTU8
         bBFnq3GZFGkkLISNkn0IelW1EKAd1WXs+vDwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xu0gEbWA6ibWlugXTRQRW6Xk60MCl0M+uNU3j+DifZQ=;
        b=gkcS3zKqmWxRnjR7PX8tDvcMQKGtJKevdyy8lEHuoy+beb8Vszjg3NlTuIbhTv40JS
         EtBwTnpj55J8GJmQuJQuAsx39OZWAk1nP0Qc6mRZzYZpCbkxB22D1HrG4bV/a/cUaGss
         5lOIay8TZpMGsRthG4t3A9am6TdhgGHlfQ9cdo+w6R7yhC56MR55SYshPmv5HSNYXMFf
         a1e7SkACygVUFGEEGctDxCfAOTQrUhD+44FMlxlpN2gQdTrzd5EgGULdUL+ERj3phjnV
         W/8Xh5+9yiIYxtEcFf1IJSP2sluFaTIKMtruZQyh0WqyJwa4kzMCPj1ArsRDofrpO0uL
         iL0A==
X-Gm-Message-State: ANhLgQ0jxpCX7OMPQdje5scLHa9Yj/KbAumR0wjIjMlt0MVlZ76Ug06g
        vHXDQ6466+H7hw5YPzSoIT+PUnvGmlQ=
X-Google-Smtp-Source: ADFU+vtmLKIUM0kg77Jyx7atWriUCSeakhGAA7KH0k0KvMLBdi4TRhmNuhikCdBv397McO3WrnSDzg==
X-Received: by 2002:a05:6102:1090:: with SMTP id s16mr12017551vsr.224.1585317295835;
        Fri, 27 Mar 2020 06:54:55 -0700 (PDT)
Received: from alain.c.googlers.com.com (57.152.190.35.bc.googleusercontent.com. [35.190.152.57])
        by smtp.gmail.com with ESMTPSA id z79sm2460663vkd.35.2020.03.27.06.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 06:54:55 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [Bluez PATCH v1] monitor:Adding missing settings descriptions in btmon.
Date:   Fri, 27 Mar 2020 13:54:51 +0000
Message-Id: <20200327135451.18972-1-alainm@chromium.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds the missing settings descriptions from btmon.

---

 monitor/control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/control.c b/monitor/control.c
index 1e9054db3..4907c1c0a 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -200,7 +200,7 @@ static const char *settings_str[] = {
 	"powered", "connectable", "fast-connectable", "discoverable",
 	"bondable", "link-security", "ssp", "br/edr", "hs", "le",
 	"advertising", "secure-conn", "debug-keys", "privacy",
-	"configuration", "static-addr",
+	"configuration", "static-addr", "phy-configuration", "wbs"
 };
 
 static void mgmt_new_settings(uint16_t len, const void *buf)
-- 
2.25.1.696.g5e7596f4ac-goog

