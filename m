Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249B8C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Aug 2021 12:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00D2D60E9B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Aug 2021 12:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240840AbhHJM4c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Aug 2021 08:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237431AbhHJM4b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Aug 2021 08:56:31 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4277C0613D3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Aug 2021 05:56:09 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id ot9-20020a17090b3b49b02901788da7ea1aso2289457pjb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Aug 2021 05:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KtCVbHtDUdM6UuVJzk/1PydaXIHIB8v9kLUIgi00N3k=;
        b=lLEY77b11NwvSsPja7IA1b6GH/Eh7AyR5fM2Tabwcwa30gKlpY7HtZU+HFq9jGYy4a
         tc0emc9Z+M5S0F51GqGMquhCrUmwV1GND0XVD5cbB6U+iDGzZul7+fNqgFCeb+4baHpM
         VNSQb65hukRtgmPF30MZ0pdvPf00kV0JMvEVgyO9f6nUnyHDVyuzNevdHpEF1s3MWMr1
         JbhLPxIrX7w5N2hPaQSmhhjXTO21hutDAshcbhPS2Ll4wBWkEmHDsTpxFXPEsnmWIlKi
         eIzQaglLBF3t+KUNETXD0DV8AgcobMbtS6l6WPRZ3x2fIrwkXP75tGez2DJWl5XWFNPA
         fi+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KtCVbHtDUdM6UuVJzk/1PydaXIHIB8v9kLUIgi00N3k=;
        b=SbByJucDiSSiSIc36M0b8zyO+L+M+EmQt7Z4glxANPmgroO5JpWWQ3fQBk03vM0vUO
         /jNRqX57yq2APNhVL92P+1ViJyAEqBNVhF8RJnxpRF8+OfYNfnm9mKt6JP/lF3GdCDT5
         7PHze69xcWnmnakKEce8n1/z7PEBvDiN6D6yP0BwBo82EMDP/zwspE/aU0OHQExVxUOf
         DmwNw3xz6jbDx4ZQoyyV2zt4RuFV743utBDNaVUtMBnqsDfP/FyZ2CX6XaK2oaM7tNZz
         l7kunw/6wo0gstaITPN1jjs7r2JrBJphzjf6TjjJEdDhkAMLOEmdA8TR6G1Yz2Rxxz/n
         szCg==
X-Gm-Message-State: AOAM531Bx+oKaP1QtVGgwfx7LlEdFdkn92eZ9huyRiIePMnwVKpVDRAa
        WCF/Zhb2v8KTu/NnmZ79D/QF/DxcBtOvcRJDHUyvlXKdUlDVQGtmOjrWl8BUhdCYLW+znh0u0Ke
        PeXy3okwKJiswD6qskq+FpMtZGdUyLr4GmjU1WJByBMwLjNjNR/sKi/OafGSpQY9CNjtKA447dW
        cKWrQZxITnGIM=
X-Google-Smtp-Source: ABdhPJyvneo9WM02dcG15ihYw0fh9zA6JppmwI33WxJL82EwEDDajk9SgkRHEaFJbmzozsugL8GicovcH3XiaCDq/g==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:3ad5:58:f287:2aa7])
 (user=howardchung job=sendgmr) by 2002:a17:90a:8b07:: with SMTP id
 y7mr4949072pjn.30.1628600169199; Tue, 10 Aug 2021 05:56:09 -0700 (PDT)
Date:   Tue, 10 Aug 2021 20:56:01 +0800
Message-Id: <20210810205522.v2.1.Ie7d876ad0b7defabfa86beb64e83f655f12be7ab@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v2 1/3] shared/shell: fix missing stdbool in shell.h
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

bt_shell_menu_exists_t returns bool, but stdbool.h is not included.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v2:
- refactor command to |allow| instead of |set-service-allowlist| and
|get-service-allowlist|

 src/shared/shell.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/shell.h b/src/shared/shell.h
index 415194a40736..cc4f822fbf1d 100644
--- a/src/shared/shell.h
+++ b/src/shared/shell.h
@@ -8,6 +8,7 @@
  *
  */
 #include <getopt.h>
+#include <stdbool.h>
 
 #define COLOR_OFF	"\001\x1B[0m\002"
 #define COLOR_RED	"\001\x1B[0;91m\002"
-- 
2.32.0.605.g8dce9f2422-goog

