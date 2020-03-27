Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EA4C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 15:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC972072F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 15:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QvkRIEZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgC0PEA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:04:00 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:38618 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbgC0PEA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 11:04:00 -0400
Received: by mail-vs1-f44.google.com with SMTP id x206so6383375vsx.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2020 08:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ubMlfbWSBH6X4MfC0LrwIRdfRqIQiVk2vIaVkYCPiV4=;
        b=QvkRIEZIcI2zUWCuDzaDKsOkdPHCbhqDc68ecajEUf1KmBie6RHVLAAZ83r4uJgim2
         a+ZbPQ6WIjskWjwiYo+sDgLpGkwyhIy5gl0sXmhL6QFf5zKD6gQiVolyTGxhtsK/fqnO
         GzB90SrH7CaSiuoEPjaa7+uX8ss+wVv1vXyM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ubMlfbWSBH6X4MfC0LrwIRdfRqIQiVk2vIaVkYCPiV4=;
        b=GKOX+2uM3AsrO5JGPDpxGqpgQVUGECH8KYqztDBX9kLTnWpbUD+b75mBh2+IMc1ICx
         fidkzAdmnFOdUS4/KQ46BVpboePtMU1b1sq/8H+z57UQz+xHjBo9MixhH6YTlm3VtUOl
         XqxkOObwG95zlu+Q6r+4l6g0Y0CVJUxQ+hhhxPQ9mrJxDOewhrho0ES7g4mH6Wl1vHgg
         SYIU1lUr8JIKJxwayGRlPQ0AkEn4Ne2DTS5OYoqJsoxMB+HZQvVZuWzWGU7Uh4/i3Zef
         rlHR0JEUb7RA31sEYyLIfkZDkaKI/lqUZ8xELD42V9QmByoCcrAnhKIFjCdg8ptvjktY
         yaIQ==
X-Gm-Message-State: ANhLgQ3rmz6Onwam3gb4ULdfmzULgnRMziijXqspQgE9SxHtZUcR8Cjl
        d15KIHgJgXvlNtJjGyxf4w1/r1Rwpug=
X-Google-Smtp-Source: ADFU+vvfOPqywqCEdq1QrlX+Z0kypgEQnjgozpGfO2yMTKr5AcHwcQgCTGdFFo1/vm28EUckqZIwIw==
X-Received: by 2002:a67:30c4:: with SMTP id w187mr11543663vsw.77.1585321438574;
        Fri, 27 Mar 2020 08:03:58 -0700 (PDT)
Received: from alain.c.googlers.com.com (57.152.190.35.bc.googleusercontent.com. [35.190.152.57])
        by smtp.gmail.com with ESMTPSA id d20sm2847694vsc.6.2020.03.27.08.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 08:03:57 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [Bluez PATCH v2] monitor:Adding missing settings descriptions in btmon.
Date:   Fri, 27 Mar 2020 15:03:53 +0000
Message-Id: <20200327150353.32468-1-alainm@chromium.org>
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
index 1e9054db3..6dfefd05f 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -200,7 +200,7 @@ static const char *settings_str[] = {
 	"powered", "connectable", "fast-connectable", "discoverable",
 	"bondable", "link-security", "ssp", "br/edr", "hs", "le",
 	"advertising", "secure-conn", "debug-keys", "privacy",
-	"configuration", "static-addr",
+	"configuration", "static-addr", "phy", "wbs"
 };
 
 static void mgmt_new_settings(uint16_t len, const void *buf)
-- 
2.25.1.696.g5e7596f4ac-goog

