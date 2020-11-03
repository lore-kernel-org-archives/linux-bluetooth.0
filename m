Return-Path: <SRS0=oxy1=EJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD583C388F9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Nov 2020 23:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F8F0223EA
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Nov 2020 23:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdH6Uj6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgKCXTv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Nov 2020 18:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbgKCXTu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Nov 2020 18:19:50 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC87FC0613D1
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2020 15:19:50 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id w65so15698753pfd.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2020 15:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Yytsr00+6Kp33M5vY3Jf40tOEkQR8081Jx2QjpPNKpM=;
        b=YdH6Uj6ABsMNcPojZFvSal1HoAr0+soOeyiMsfYrK2X5dV7xyrAuxBpIr0/J+3yjCV
         /K/ANgwz9ng1gQ3C50LigVNNluwbZ2XJAYgdYqZYbYwdFRmEZnOS0ePhRbePBVu7eXa8
         cMN6iSRcmiXeR5GaYArEXDqdvSlFhwTBGftHKl+rsfxYd6i66DKn5jQXdyM6yyPYLR+C
         JBFKDHWF78nopGE/j2CWJZHARec8ccpiTrjEVFYvb0Aci0XMcsV4roRgKf4VTjdoshmf
         rMhDqDq7Fy2+o6Bewduce4va2xbY4wkQRGCvnD2NlPclLtJoy/Nkom4OgGC96zCjYTE9
         UF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yytsr00+6Kp33M5vY3Jf40tOEkQR8081Jx2QjpPNKpM=;
        b=hC33Wrvaq46sY6iXkJ3zjj6yLW3UAVVMQYKe8htpnJu9jHy2I9Ji76x8RrUoSdwfJM
         CldsHAugnBVaC8nRzj1CEn4tooaBEfjTXkJwyLiScdvPWH1R82MtaTOQXeyZVds4mdpD
         4tqzx44O8U3RSSGfxrn4TadwGHenE7Z4di+cnhkLWYCBffVWeuJq+T4u782Q++SmODup
         GzcO2tFGijeSZQNIpi5vS4CHJZ7PoY15w1zkMVsHUXfMWzZ/vhg32A9MobXXCY94epLT
         pLgiKtjsTIdxqkhSy4SY4Dw6Q2/J5kyK7auJ/toDhB0fLGSvLhLf/xl0/51D6x97OgLq
         ggCg==
X-Gm-Message-State: AOAM532f0ewg0g9jcrCxxiCuuCyBuj5FkPGydSAyQNCZqbRB13da2BDx
        2oMU7ArkXwlFPgwtQdk3/g6f2gdjjzbnlg==
X-Google-Smtp-Source: ABdhPJzB8ztgYcyzJ4IfP9dqGHgN4twtoMS3hB051zpLeIK/m8Bu5mf6DeJGaQLUEvYNSeYcgAYYtw==
X-Received: by 2002:a63:4916:: with SMTP id w22mr18330636pga.353.1604445590213;
        Tue, 03 Nov 2020 15:19:50 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f7sm182185pfd.111.2020.11.03.15.19.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 15:19:49 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] tools/test-runner: Fix using removed options
Date:   Tue,  3 Nov 2020 15:19:47 -0800
Message-Id: <20201103231947.2053274-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103231947.2053274-1-luiz.dentz@gmail.com>
References: <20201103231947.2053274-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This removes -nodefconfig and -balloon which are not longer valid
options:

  qemu-system-x86_64: -nodefconfig: invalid option
  qemu-system-x86_64: -balloon: invalid option
---
 tools/test-runner.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 6b7c33734..5d2dbb992 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -181,7 +181,6 @@ static void prepare_sandbox(void)
 static char *const qemu_argv[] = {
 	"",
 	"-nodefaults",
-	"-nodefconfig",
 	"-no-user-config",
 	"-monitor", "none",
 	"-display", "none",
@@ -190,7 +189,6 @@ static char *const qemu_argv[] = {
 	"-nographic",
 	"-vga", "none",
 	"-net", "none",
-	"-balloon", "none",
 	"-no-acpi",
 	"-no-hpet",
 	"-no-reboot",
-- 
2.26.2

