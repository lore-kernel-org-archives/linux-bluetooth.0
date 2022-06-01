Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3245AC43334
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jun 2022 21:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiFAVW6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Jun 2022 17:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiFAVW5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Jun 2022 17:22:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80AD2ADB
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jun 2022 14:22:56 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id u12-20020a17090a1d4c00b001df78c7c209so7504104pju.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jun 2022 14:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gES99xrNSJ18ruTbh4NezxpzBfZc63RCDVbHgxPY/eI=;
        b=T5wjSEs+W1vAL6tHEBlcppWH9ubzGzdr+4ohGjMDWiphArP8ciNiNI6rQYNggS8hCU
         VyJ7wFelHaC9keqJDxRMCaJRyJMhVw1kMWtD7Ajsk8xtMniJuT0IAicuMnxsauHQBpX1
         zMh9fS/2tgFLL1dUb/4kjlKXNS9UxDZW6JO1vqNha94OtUKOOJ2fK8JvN/e8OjRVKq3w
         sRqX+XWjHztJOFvD8WPZCHp3Idq30trFB4KbEpscZ1lNzf+N1gHO3LcvJf4fAlvsjcaW
         BdSeUObaI23tQjUQhAAeMQ6kjfv5g/l3UbbC2bxnIfS5pYurlf3hzia+mNy3z+tewvRs
         dy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gES99xrNSJ18ruTbh4NezxpzBfZc63RCDVbHgxPY/eI=;
        b=GbcFoWSkEP3Kn2Wj6znAo4PNJmzNGfMzx0xOyIspcccZNvtZM4/0tr3HoDIy0Ku9LJ
         V0BcfbIS0EpokiRG9Vn2eq12k58UHmJW5/PfyYjK9esqjUArP/x37HtqJJ0954XCJ1Jp
         Yg3FrEWPwq1MC0XkR+Blx1hMZI3vEcr1c1Sii/ai9tf49c/tKn8iDr3P8N55HwGuk25x
         gdTdeF595bAw9Ptk1qGzGflEmvK3iaYKfwYxCpSHzivstZAENQ0oY44qHZ6A3xYCmjlC
         MVTJ27wydvDOmnDvhrRAW4NyCXZeIkhbGjDxxAN0oZxsX0anWKzBlW2F85oKVMHW3Na0
         KTRw==
X-Gm-Message-State: AOAM530Zc+qKrZyvF/BX0m/kvxuEKOmqzY4CxN4staKbmB3fEOXLrgRn
        EnupIfA783p1LK2QCRwTCHe3JY0IWdg=
X-Google-Smtp-Source: ABdhPJy5jJ8fKG1SaFmovc7rcwRFf+O3K/p1cGXH5b7LKJ1A9HF/jNf8T00f1ndmndmXiBjSftaryg==
X-Received: by 2002:a17:90a:9b08:b0:1e2:837f:bcce with SMTP id f8-20020a17090a9b0800b001e2837fbccemr1433617pjp.144.1654118575996;
        Wed, 01 Jun 2022 14:22:55 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b00161fab018dfsm1951048plg.256.2022.06.01.14.22.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 14:22:55 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] test-runner: Enable BT_HCIUART and BT_HCIUART_H4
Date:   Wed,  1 Jun 2022 14:22:55 -0700
Message-Id: <20220601212255.1356507-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These options are required when running with -u option since that uses
H4 headers to serialize the communication of host and guest.
---
 doc/test-runner.txt | 2 ++
 doc/tester.config   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/doc/test-runner.txt b/doc/test-runner.txt
index fe0a0d479..683c622a2 100644
--- a/doc/test-runner.txt
+++ b/doc/test-runner.txt
@@ -41,6 +41,8 @@ For Bluetooth functionality:
 	CONFIG_BT_HIDP=y
 	CONFIG_BT_LE=y
 
+	CONFIG_BT_HCIUART=y
+	CONFIG_BT_HCIUART_H4=y
 	CONFIG_BT_HCIVHCI=y
 
 	CONFIG_CRYPTO_CMAC=y
diff --git a/doc/tester.config b/doc/tester.config
index 011475661..4429a7222 100644
--- a/doc/tester.config
+++ b/doc/tester.config
@@ -34,6 +34,8 @@ CONFIG_BT_MSFTEXT=y
 CONFIG_BT_AOSPEXT=y
 CONFIG_BT_FEATURE_DEBUG=y
 
+CONFIG_BT_HCIUART=y
+CONFIG_BT_HCIUART_H4=y
 CONFIG_BT_HCIVHCI=y
 
 CONFIG_CRYPTO_CMAC=y
-- 
2.35.1

