Return-Path: <SRS0=6Duj=6H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BB1C54FCB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 14:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF0022087E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 14:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nwAw4p6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgDWOXO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726183AbgDWOXO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Apr 2020 10:23:14 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC38FC08E934
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 07:23:13 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id q200so1755485vka.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 07:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eTKrTYhVgB3E7suOwewnwnB8+6xS7oIEHT/PYcStCo4=;
        b=nwAw4p6w4rf+jc4QGpT9Z/c5Rhmsbq7mwwfxD0Ir0OKtmOwmN3f+dSWlqPITC8/I47
         INiiXAzJtY655AcZIci1bwWLBJSmDG10DC8ibMMyIvrHbjiCygwmKXQwbMhS5QEdVhVn
         WkqUpLw/CqXHePd3BPc7EnG20gMkOZ+NW+CnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eTKrTYhVgB3E7suOwewnwnB8+6xS7oIEHT/PYcStCo4=;
        b=rLFRXRDJoJsudS4vj26VTnhIb6pN/2iVjm0yIUxgDEkR72Z10/ZTwNx0q2d14PSSko
         y1J7cJJpsmqIYEKqVqLMy62CelnTHPcOLsHFiMu95QhE7Nrq87Ju0lZ0McPq8HJNVk/j
         UbHDOPI74PA3kVNOQNr6XaQSyO/zfAhI2LJzkGP59BgV+3YKur0XkVrUiBu8TbyFLzM6
         s8A7G6Wk61f+tvhR/2B4wQdt6Rf50l0AGQUxCQemOM69RG4Tp747222gDPyCMQdJ8mtr
         z3ydegPRYoykmJlacDWOsjy+Hq5JBxEcGez1emCFQSa06IVsyyxaOGv9f+znFxv0SBLT
         O2JA==
X-Gm-Message-State: AGi0PuZXrgSXUFqlt+Eam1iJFEBqFuunrQFZokvAixM8zJaW7cRuT/PZ
        oGfjFr17+Wn3bRwHhYilULc65frFxf8=
X-Google-Smtp-Source: APiQypKF2KikZoDYtm5iLlwb74Y+i2YCDZRgUL5GTznf0+ltm/QH9swsjGYRZMg8ZIJu/S79sgH59g==
X-Received: by 2002:a1f:a150:: with SMTP id k77mr3783923vke.88.1587651792717;
        Thu, 23 Apr 2020 07:23:12 -0700 (PDT)
Received: from alain.c.googlers.com.com (161.138.243.35.bc.googleusercontent.com. [35.243.138.161])
        by smtp.gmail.com with ESMTPSA id v16sm663264vsq.18.2020.04.23.07.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 07:23:10 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH v3] doc:Adding Roles property
Date:   Thu, 23 Apr 2020 14:23:05 +0000
Message-Id: <20200423142305.66778-1-alainm@chromium.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds a new property to indicate the support for concurrent
roles which means that the controller has reported the appropriate
LE_Supported_States (hdev->le_states) and that the controller's driver
has reported correctly handling the various reported states.
---

 doc/adapter-api.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index acae032d9..1a7255750 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -326,3 +326,11 @@ Properties	string Address [readonly]
 
 			Local Device ID information in modalias format
 			used by the kernel and udev.
+
+		array{string} Roles [readonly]
+
+			List of supported roles. Possible values:
+				"central": Supports the central role.
+				"peripheral": Supports the peripheral role.
+				"central-peripheral": Supports both roles
+						      concurrently.
-- 
2.26.1.301.g55bc3eb7cb9-goog

