Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A04C5519F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Nov 2020 03:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E6F221FC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Nov 2020 03:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xh1DMgOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgKRDrP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Nov 2020 22:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgKRDrP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Nov 2020 22:47:15 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0002C0613D4
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 19:47:14 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id x17so488598pll.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 19:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=zIp48gXeRw7ew+UF0SUfolKoelguTvQHDZcJoTCapBE=;
        b=Xh1DMgOBo9QLUN0ZCPY9vzrp59cPfrnWOJL70n4FSbAkAzh5GVo3GoZNLIWjAE11Tc
         60GlTsd9aFVgCaEJl9vl9hODoEYa2t87yomSBNo+5VrFN9TStKmcgUfmRbDDEwcjrnda
         /8pm1otP87etY7+QTFtSI588E3Aaigl+SASYCwl1MmItquaL+MqvhfDKKTXEZFugzHMD
         Hb7ck1lvGZNHdzFkbZpRq9sAXl9XMMZTaandyaWeuaypU6ff82c/5H1RF8ElUt7hnj8U
         6UvCG/DgGFcqRMgI/o/ESci/CxvEc1Y8pTyUH0UQ+MC9SluU/AVUiYKyiDp7gy3zPunP
         aEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=zIp48gXeRw7ew+UF0SUfolKoelguTvQHDZcJoTCapBE=;
        b=kmQKzj8YU8ruMxrXUBhC8PqnSNsCKWF5+gCdQgXMEdWTm7LAWx5O0OyOY2mctX7FTA
         x929HfyINLa72h8vId8iTIzXPP8DAEJG/mSyb9Ot4fLPTm+FiJzFgHntaY+3/UaWh7Ab
         BCpcwyN3fWXuph4FX3UUx4lh2AWlBl87wFrxdF897ukYq6WiK1kAgWvsFYG3u+ze6bqb
         XtZO42GNWRs3sgrklahOuWlyHhbEAyv4hpeiLIpm+TCi5+n9ybwDVWBx7ArDCJ4+P5lf
         64cWCtN2wSDE8b0xJlI0FgiEdu3A2JyanL+032yo9XSZ22wW7JUS5eeWmPe0fd0nNYCZ
         H4aw==
X-Gm-Message-State: AOAM533vremCCxA0Yhg6fGN+s/DtMs3/P+ZWB5kP0p/oHatWbOgYPjmC
        t/B3WfH+z/YLdqxONfwrDrja3rBtTbJR3ZELeqz2sNAlYHCUix7bTy/2rUeWpcynD2d79TLwEuf
        HG7muYJcUPSFwzPe27KQKoKrHrKG1I4svkUS4sVvUtbTalZLA3CIJLKhN9mba8Bwn4anPXxEcB8
        0op3C668pwOso=
X-Google-Smtp-Source: ABdhPJzXIL1sQTfxZZ3kvssZQc4sLXcjEnTFZC6X0FKxu+iZBLzrdgavE0YEB0j3TXk7OBg5dakUul0mxaCCPu9F3Q==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a17:902:ed52:b029:d7:d0af:f89f with
 SMTP id y18-20020a170902ed52b02900d7d0aff89fmr2772910plb.26.1605671234308;
 Tue, 17 Nov 2020 19:47:14 -0800 (PST)
Date:   Wed, 18 Nov 2020 11:47:09 +0800
Message-Id: <20201118114650.1.Ib657f37256b0e7adf3915ac5341c9d20db2fd2ef@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH] core: Align parameters name of ScanAdvMonitoring
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

ScanAdvMonitor parameters are defined as '-AdvMonitoring' in main.c
le_options, while they are referred to '-AdvMonitor' in other places.
This replaces '-AdvMonitoring' with '-AdvMonitor'

Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---

 src/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/main.c b/src/main.c
index 33c0f0d15c49..69a53122d0a4 100644
--- a/src/main.c
+++ b/src/main.c
@@ -106,8 +106,8 @@ static const char *le_options[] = {
 	"ScanWindowSuspend",
 	"ScanIntervalDiscovery",
 	"ScanWindowDiscovery",
-	"ScanIntervalAdvMonitoring",
-	"ScanWindowAdvMonitoring",
+	"ScanIntervalAdvMonitor",
+	"ScanWindowAdvMonitor",
 	"ScanIntervalConnect",
 	"ScanWindowConnect",
 	"MinConnectionInterval",
-- 
2.29.2.299.gdc1121823c-goog

