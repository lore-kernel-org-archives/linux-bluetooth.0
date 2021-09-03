Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20238C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 14:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B76610CC
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 14:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbhICOCg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Sep 2021 10:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhICOCc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Sep 2021 10:02:32 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53F9C061575
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Sep 2021 07:01:30 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id a21so4422957vsp.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Sep 2021 07:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jLr4l/e2yUPIFPLD6Z6dbCgxggzYg1YohgRbf0t5c1Q=;
        b=FPCXac0G4iMq3UvtOJtr60EL6ra8Ez/piRMpGFVdtBwB6RIXJ3rPYO7II1jfEg/s1y
         oZMWXV1e4X0uSdad349v2QNi+SeROGLZ62uPQa3XgZfVdfYOwdbCHbTAa5PSbVafdp7l
         0X2T+1YlifXHVTJftjsvPM3qclhT2mZOqmPnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jLr4l/e2yUPIFPLD6Z6dbCgxggzYg1YohgRbf0t5c1Q=;
        b=Q00oIWtectFLHGFIDL+WagjwCvrZ5H3IwHIh8czIr1S9OTp+K29Ng09pfK2+b5Uzn/
         uOwXCGl9eClr7SE1myZ+2hMCdWInZLo9NfeXC2DEHmrWpMM/PtArUEY/fTPxyxLKi9Lo
         jTS9m0+pYouIzdGvBF5VrqWeZDYWssMrKvFWityy+FnQ7KfumADoPw80Wj/lixb33hmI
         hVfQfD0eL8CbZv8jexXvsmxIros4H6hBAn6Wl5FL1KpoqZH7yuF1G+CKM09U0CERDQJD
         a+TanwSD8yphtkVoSV6SUQRjq8ugO7GDvvKYz5OK9Merzw4TJlGfspxj0bXa4tlChf4Z
         4hLg==
X-Gm-Message-State: AOAM530TBFiX9VBQiaF+lzNmfZdMu/9oWkr+rt8pD17tTPICeE/oDFbU
        cGmJHG1+SnzsgXWFOz/ozQTRMI5T4V6Ysj5H
X-Google-Smtp-Source: ABdhPJxt6K5pxfZWm5C2+/aIr8A2KIaAVRAZAZ4zdJbK/3+X9gFROuA8LzNRjeixP16McXKMAcWX+g==
X-Received: by 2002:a67:24c6:: with SMTP id k189mr2695299vsk.3.1630677689781;
        Fri, 03 Sep 2021 07:01:29 -0700 (PDT)
Received: from alain.c.googlers.com.com (39.119.74.34.bc.googleusercontent.com. [34.74.119.39])
        by smtp.gmail.com with ESMTPSA id s46sm506583uad.20.2021.09.03.07.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 07:01:29 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [Bluez PATCH] shared/shell: don't allow completion fallback
Date:   Fri,  3 Sep 2021 14:01:18 +0000
Message-Id: <20210903140118.3469656-1-alainm@chromium.org>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When using bluetoothctl, if the user enters a quotation mark before
pressing tab, the completion handler falls back to the shell's handler
which ends up printing the current folder's file content.  This behavior
is never desired in bt_shell's menu.

This was verified by typing " then tab-tab before and after the change as
been made to confirm the desired behavior and verified that all other
argument completions (such as address completion) continues to function.

---

 src/shared/shell.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 21e8b50cd..cbb9b8b88 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -903,6 +903,8 @@ static char **shell_completion(const char *text, int start, int end)
 {
 	char **matches = NULL;
 
+	rl_attempted_completion_over = 1;
+
 	if (!data.menu)
 		return NULL;
 
@@ -925,9 +927,6 @@ static char **shell_completion(const char *text, int start, int end)
 		matches = rl_completion_matches(text, cmd_generator);
 	}
 
-	if (!matches)
-		rl_attempted_completion_over = 1;
-
 	return matches;
 }
 
-- 
2.33.0.153.gba50c8fa24-goog

