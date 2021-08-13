Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D697DC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE93B60F00
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240492AbhHMMWW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240486AbhHMMWW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:22:22 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DE4C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:55 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id v28-20020a05622a189cb029028e697f617dso6227867qtc.20
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=99b2jpqgUQXR2rTjJoouB+WKpUmZQdrmbs8eHzdxpZU=;
        b=OiZ88bprjQljL8wWJWseaJoStmm3CcHJUdigOc1m+/H9f6R49dtrk38WR4AttViq0Z
         grdTTfXwv6fwRUQJIVNfi2oO0ilHypVdeQiK9Vd8ft58h6+6BNXs4q5AHoV2/6uPpz1r
         1+oM8RL0NUU++93zi7rxAIjYGNmjN4DXpZfMpCzUhsVWpZWKysMzGyZwWgJLk1h0qL6f
         y5bYExYxJtBaAdS7+JB6aoNinKr1Wz4KGw5d+rltXpQ8Qd6V13+XMPUPJwMCQbtdhUCv
         60lugCtpFSaol51/gl6YjZweMn3Tjle3ROmxZkoRyPPLq9VdT0jsaCNYU0cFm3jSGlhE
         VYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=99b2jpqgUQXR2rTjJoouB+WKpUmZQdrmbs8eHzdxpZU=;
        b=ewrVOakVDp9xUbM3RpRvFRej1deTyjZkhBOn8ZIdHn14YLw1Fc9AtYJn+Pq4UrEkS8
         gKIQoFG5JGmFfgnhQasaWe32aCBm5dMznwlDu+CfcwUwjooVRMcDmYW5b3rkq3aHwtpC
         v5rLhaQY7oLkm5eATEjb1ywtOntUcfFVGzEUHdkdHD1/ZFts9RD3Nq6CNorG0afMVHij
         mgAQtpNvI2aAVnikPk1gGbXsni16OFUlc9EEfT0PaQkbQFihUCP8b+J9yG5koWxLK44B
         +a52eYJBcf5BJ5BhmDTSjurPqcJA0BkW3lhNrGeu6cGw0DS7dR7oz5gt7T10aI/ML5cj
         faWg==
X-Gm-Message-State: AOAM530Lcnwe/5i2vT9ij0963dgzpyaDHElG5likAxOf86B87mXeT0Ge
        dRzZoJYlUh0YP+lJeQZfWXA2+aPjRY8TlkwgdM0ZDuYlOy6hterCb4w5af5KoGChgCrR54pB/Gq
        nX1V152Xkn0uK74VPEOHYWPWcndg0MeDgkTzG1+It+79gxcRx2ZggB2SLbWB7YtQvRg1dW9Gexo
        jm
X-Google-Smtp-Source: ABdhPJyclQGfyvi+cI1fiBXl7mGsg1Bz/ldysCQGkPURqDQiHZS8DP40RZ6+VTF0IxGL2SeG3yxROOE62bzT
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a0c:e84a:: with SMTP id
 l10mr2282760qvo.3.1628857314836; Fri, 13 Aug 2021 05:21:54 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:23 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.38.Ie1dfb4a09d7cab6568d45c2632f6c0c80243bf73@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 38/62] tools/l2cap-tester: Inclusive language changes
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"accept list" is preferred, as reflected in the BT core spec 5.3.
---

 tools/l2cap-tester.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index db662117e0..d78b1e29cc 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -1437,7 +1437,7 @@ static gboolean test_close_socket_1_part_2(gpointer args)
 	tester_print("Will close socket during scan phase...");
 
 	/* We tried to conect to LE device that is not advertising. It
-	 * was added to kernel whitelist, and scan was started. We
+	 * was added to kernel accept list, and scan was started. We
 	 * should be still scanning.
 	 */
 	if (!hciemu_get_central_le_scan_enable(data->hciemu)) {
@@ -1446,7 +1446,7 @@ static gboolean test_close_socket_1_part_2(gpointer args)
 		return FALSE;
 	}
 
-	/* Calling close() should remove device from  whitelist, and stop
+	/* Calling close() should remove device from  accept list, and stop
 	 * the scan.
 	 */
 	if (close(sk) < 0) {
-- 
2.33.0.rc1.237.g0d66db33f3-goog

