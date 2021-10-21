Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202A4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 22:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0338F6128E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 22:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhJUWjS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Oct 2021 18:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhJUWjS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Oct 2021 18:39:18 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E72DC061764
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 15:37:01 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id e10so1406163plh.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 15:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pOzYnkkWqaBMXGpyGgnfaClb7wYdESOmkRnYvzvxpjA=;
        b=LdqQweOZCgRyQVpOUltNxn9N2fnMLoOj9+cEBsxXcdBs1gaEbHFVrwkAU88gSp5csH
         HY3DJI0jYGQNBAJ8iKw2/Cp/c4m+oUE3cI494/+KmIRLvaDzYddM+0gfzv6SHitjNsxt
         aJ2X1wWvOCEX2aPJ7/O62has5NhiRk2xVe15a0kqrcCNLoHhDauV4p1cbdSXQDsL321Y
         V9cOUTDODFJ4pOo3GQtruUPQTfTzYKPf0saZx48JhXkQUwRzDT5b3x1w5Ws1+ZmLcKrb
         +0y/X8nqKGyC1kiiw2/O/k9cD9RU8NihNecKa7cjrf6rsTH/oXT0RL/TrtPwKwiGy9jo
         GxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pOzYnkkWqaBMXGpyGgnfaClb7wYdESOmkRnYvzvxpjA=;
        b=7ItAQI5gDU/6T+q/9veCJ53gzE0LkPVBYQKElJt6kwqlTuXAZZ2/nB9Wie4MP/2wCQ
         SwgDaKH+slnD0K9HOUvwbcWNYQOpuSecsSWu6lY2IE7coSDnh7TJfD4ez8ncyNmWCAKc
         OqG4LPuOxgbuNt/hfe1Ltjw+G9NfhAtJLr2PQUy0pgIIFfQUDvctViziRvoe6zmvbEza
         ecONMdiwfRdDZuCF+bcLb594ftjB3BamfmXvhGYipYrvB6edOH+Ly/VMdGC5eLXhMlrg
         UUq/Y7IT+QP+G8JUiIamopw+Zub/RehV+Y0Gg3DnWxNoKmxqutLKJqu+5Fw7qD/0/n0a
         fHxw==
X-Gm-Message-State: AOAM532STKK1crWFLXXzX5JFRKWO6wR+8U+Cyfm3JiZvxryVArbibxnH
        Ox27bRRAOu+V5D5dUl/Y69e2BLGpQ/Q=
X-Google-Smtp-Source: ABdhPJzlysysYRZ+Ikt2I6TUGoDLbbDb3x8dIWDXd0JJoN2hSR0+8GQyzY4GW/CCt96GxJlt+ymVqQ==
X-Received: by 2002:a17:902:d501:b0:13f:1b44:baa2 with SMTP id b1-20020a170902d50100b0013f1b44baa2mr7815804plg.56.1634855820828;
        Thu, 21 Oct 2021 15:37:00 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id w13sm10509035pjc.29.2021.10.21.15.37.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 15:37:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] mgmt-tester: Fix expected manufacturer
Date:   Thu, 21 Oct 2021 15:36:58 -0700
Message-Id: <20211021223659.654744-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The emulator is now using Linux Foundation manufacturer ID.
---
 tools/mgmt-tester.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 64a5e1c3d..f490dc261 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -462,7 +462,7 @@ static void test_condition_complete(struct test_data *data)
 		user->test_setup = setup; \
 		user->test_data = data; \
 		user->expected_version = version; \
-		user->expected_manufacturer = 0x003f; \
+		user->expected_manufacturer = 0x05f1; \
 		user->expected_supported_settings = expected_settings; \
 		user->initial_settings = settings; \
 		tester_add_full(name, data, \
-- 
2.31.1

