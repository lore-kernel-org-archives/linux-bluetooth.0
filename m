Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812B8C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 23:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A23261408
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 23:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbhEOAAM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 May 2021 20:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbhEOAAL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 May 2021 20:00:11 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9044AC06174A
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 16:58:58 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id pf4-20020a17090b1d84b029015ccffe0f2eso2443325pjb.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 16:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pOcHTUtC3MUClDwnYgf4UvVuP8PHsxg2YjAC+ZUhcd4=;
        b=pYL/jb8KQ3wNuEdSkOx0rr027bGcPyvc5NSoYrckQ6n/07dQ+ws1k1IWORkjAK0556
         8PmFlxLnk2TbdXKVY0xAFQ3ZbfeuTpG73yIy3D0iKPFKAeQ3Di2C9bmt9csymoajwJzJ
         wVR+NzDzOqLe33COlOSHz09Z19V/MHPY2mT3aE377TDKvXBJQpA55eLeex0fCLxpaCPK
         1bSoMorGAl3hBchP0nVM8hv6uBMGgswMs50aiMYh55DH12gNFEGG63DWBdmb/DO/XifL
         4XprKU2eTz2YJltvPOIuBe5fN4iw8yuXZ0lCobyp02QUFnSSvIfd5ttuhNjCVXSnZNM8
         Fy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pOcHTUtC3MUClDwnYgf4UvVuP8PHsxg2YjAC+ZUhcd4=;
        b=ja0fpNkHljj5WMk+20ZI5wWvZ8GlsckQrLkP4MK8yaDMRWuoSkfabm8nch52rzoMGc
         e3mMB6sOljXUHOvYoEepHLKdq+HYlvhoFkU8ZMghCv+b/eb4h8tEStOPTlvPeen16xiG
         c2A+HyywuO16N4ZK+xGJ6koj+GrG8fJKqFQ5zuWprRNpNKizP2pA2qoJl5gwW5X/beG7
         sdhGGxw2Sz2kdKeCKcGVv2lUbAR69kKHkYHNA7/3FJlU6vGakCJMruzb6tyEw/+F+g38
         BimC+o/3Zi2WIT4t87WSOPL+Q3DyXRCqpbugyQcp/oqsTyTKFkfcmuBy5F48lGlUtpbV
         RmtA==
X-Gm-Message-State: AOAM530rNcIIAprVxe9ylN0T6zLmtDYgxD7nGTz+8ysgQc5Fi5Q7eMNj
        cT4gtpktyJpP06TYe3PUgXxlV6NPSbU=
X-Google-Smtp-Source: ABdhPJzYfjHNqkxzEpLwo1oqUau1YcO4O/RGZ5d4oJbllSUK3UKlXjzf7f8Ykg3lKNyygtbipTAaDg==
X-Received: by 2002:a17:902:720c:b029:ee:f427:91e9 with SMTP id ba12-20020a170902720cb02900eef42791e9mr48607721plb.72.1621036737927;
        Fri, 14 May 2021 16:58:57 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x184sm5158089pgb.36.2021.05.14.16.58.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 16:58:57 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client: Fix advertise broadcast
Date:   Fri, 14 May 2021 16:58:54 -0700
Message-Id: <20210514235854.143010-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When advertising with type broadcast it cannot be discoverable as that
would require setting flags which is not allowed by the spec.
---
 client/advertising.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/client/advertising.c b/client/advertising.c
index 3bf12fe87..e40086c98 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -512,6 +512,9 @@ void ad_register(DBusConnection *conn, GDBusProxy *manager, const char *type)
 	g_free(ad.type);
 	ad.type = g_strdup(type);
 
+	if (!strcasecmp(ad.type, "Broadcast"))
+		ad.discoverable = false;
+
 	if (g_dbus_register_interface(conn, AD_PATH, AD_IFACE, ad_methods,
 					NULL, ad_props, NULL, NULL) == FALSE) {
 		bt_shell_printf("Failed to register advertising object\n");
-- 
2.30.2

