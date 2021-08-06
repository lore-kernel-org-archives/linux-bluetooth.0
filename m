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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35442C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 09:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16BE6611B0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 09:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244493AbhHFJjE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Aug 2021 05:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhHFJjE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Aug 2021 05:39:04 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AD9C061798
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Aug 2021 02:38:47 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id l26-20020a05620a0c1ab02903ca414e2173so607102qki.20
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Aug 2021 02:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LFFb32v3xhyRKaISoTQcRhANyaQ38+5TSARoGpy4Z4I=;
        b=PgwQKpHGHZmVFJfS6aJH/XZfzsjCP6cDi5BZ5jrz5LHoQRHrl7oEoT0oeE7YAEQOua
         U2ZyNdjt6Ux4nJDxOjRZ8ss3V9DDIaYnTV7Z2dHR13vH1rvpVauEeosMoyOFJLh1XheU
         1W0OPiUBME3VG1YGL0dSb+SG8lLr2RNbAuunKslDHjKZtAc5d65wJbCzwpxiEbRRtebX
         IH/xS+GaTXFR1uYAQyEMiiK5fwaytNfG9Iq5dcrQmZHQ4k3CSAjWa32aK9FVpeWYv7rj
         NJmPrdwFA8noqIsP1XByvT/OVbElEQhyOZk2V7x8j2zzkL38V2iMaj52jVUR5NpnWpEk
         P5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LFFb32v3xhyRKaISoTQcRhANyaQ38+5TSARoGpy4Z4I=;
        b=sHPRgWJJSG9YD4XlNn2KR7pkhzhhSqIQH0+2UQYxnZcVQ9Bui/EoquugMW66YLSV38
         9iktOM3jTqJe1N1shEUl8oca2TybVsjcJqB0N386Vv8BCqqkKxtMDA7Alv+aBXBMvaF1
         3jMYIMI2IQ5BWpnRQNHR+lSUXu3nvqobRhVlqE9FWXlYM8TgH4X7nBMi7GbhiDDfg2J+
         FhUvHTJHhQRnuO6vWDLonTmCQpJgHaR3VlFcFmIezu9oe/seRmw2WwUF36k6lfgGUq66
         miia4wqxd4MQFPgzHJeq3ect5hygU9MZPCYZWnMZvjXRynoy9mqiOhrDM0sa12NHnRtI
         GgHQ==
X-Gm-Message-State: AOAM530m5BTxG1/lWLkDf55xUBYExlB9yrLDPkwDOLNspSpK4S9OHFCP
        0Tm3YSQFO67jT4bwuDQVswhNnMqqjgfvqKe6Ih8oz2rkqJqXCI0gj2KM8Uiwm5RP7GYyyzKNvQH
        mk4VjfJIbGMbv/YzvxYAOMGsoUjYYjA4FKBPCMe1wIUwikghO1e8aXF6c1VQTsxDfRZZgDRm6Fw
        ZXhvF50uIDRbw=
X-Google-Smtp-Source: ABdhPJzV66wBlgdRGTkZOX8lLmkX65w7gW3nYEwgU8yENIMjmxZ9lzztwRPrybcHwhDGZjnAR08TXiuj/slQEY6JEg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:85ab:3c41:db28:3381])
 (user=howardchung job=sendgmr) by 2002:a0c:be8e:: with SMTP id
 n14mr9864178qvi.16.1628242726458; Fri, 06 Aug 2021 02:38:46 -0700 (PDT)
Date:   Fri,  6 Aug 2021 17:38:32 +0800
Message-Id: <20210806173706.v1.1.Ie7d876ad0b7defabfa86beb64e83f655f12be7ab@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v1 1/3] shared/shell: fix missing stdbool in shell.h
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

