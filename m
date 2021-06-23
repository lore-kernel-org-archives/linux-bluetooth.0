Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451CDC48BC2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 22:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 086836100A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 22:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFWWsG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jun 2021 18:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFWWsF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jun 2021 18:48:05 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9A9C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jun 2021 15:45:46 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so4702255pjs.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jun 2021 15:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SI7DNZLiE6FeiIIyxWw8tFnQ7FL+fZxSWhi94AaHhQ4=;
        b=OUOb/eoOeMdE1DTE6CDdeKMqAH1nuocaHLqQ6PKdWq/xHovsc2vYz0O2OA31z93CJT
         b1Ky6Yk8rzoUOrub0DXCa1nbKyGXh4Jp2C2ibejbCAmGzwGmRzGBqSh+I+JdI5hwmvKx
         lWSfUGIbizDN3yYVcbfdOyEq03QGuv6cfz0KM5EbNOMFiUSiQCLfr+HtP57epphPFGWj
         XWk2ua9CCaZTu63JV8ueGR68+8tls2R3hjOuKjcfJkaPHfo1bgPiYoy/COnELuYiSxon
         7a4p78VHr0B+GcW8J7kqij5nMYwQVHjZqVuKy0tP6Uqn1hQ81jlwtKyxq92C0ovg+h4O
         rzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SI7DNZLiE6FeiIIyxWw8tFnQ7FL+fZxSWhi94AaHhQ4=;
        b=sVAFJPfay/ik7uyhIWaNfHVY2wCI4+STRiQlCSJwcy7bPz2lay1cTGED9V6HL0EHwR
         BwLALUSrBKxjsR4ZgaKEz/9OGPtjPkAIWfaq+m31V1kh4z1uJZjKyy5w/8OwjSKt3Qxw
         7Iu0vfHbZ6jIK/AbZ6HDVPhvCpKIzTx9BPLxlgAsjvjoAWPEH4Hu+BIl+0tAmU3MW0oo
         umEehPuu+dlVlE5rNaiHtv3578+DLxfKYQ3f+AdkIG0gMPZH2VFQvSzMPLB157RtT0/N
         gxWqppImhrF3xpcYCO2v/BzB0jhu5bVnYHlhXSy6RODARYunYLDP32LO2wKl+J4KmDL1
         7P6g==
X-Gm-Message-State: AOAM533OxPYERKT4kDJGFuUtDK4XshmMkNHvI7NgZ6+Ls7Qlvf+duM96
        9i9xgrChKmXZvd4qwkCWdQy/qPnilGx6UQ==
X-Google-Smtp-Source: ABdhPJzZTZ4ZyZhaU47CL1qw/OIswM0nZ2RmhcH7LIaoxaEt+BwjRiMt1CmHAuaVurbgODw3ka5wBQ==
X-Received: by 2002:a17:90a:558c:: with SMTP id c12mr11670009pji.166.1624488345425;
        Wed, 23 Jun 2021 15:45:45 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id c12sm744454pfo.177.2021.06.23.15.45.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 15:45:45 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] media: Fix UnregisterApplication
Date:   Wed, 23 Jun 2021 15:45:39 -0700
Message-Id: <20210623224539.3738085-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

UnregisterApplication is not doing anything since the apps queue is
never initialized which results in not finding any application when
unregistering.

Fixes: https://github.com/bluez/bluez/issues/126
---
 profiles/audio/media.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index c84bbe22d..267722542 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -2384,6 +2384,8 @@ static void path_free(void *data)
 {
 	struct media_adapter *adapter = data;
 
+	queue_destroy(adapter->apps, app_free);
+
 	while (adapter->endpoints)
 		release_endpoint(adapter->endpoints->data);
 
@@ -2402,6 +2404,7 @@ int media_register(struct btd_adapter *btd_adapter)
 
 	adapter = g_new0(struct media_adapter, 1);
 	adapter->btd_adapter = btd_adapter_ref(btd_adapter);
+	adapter->apps = queue_new();
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					adapter_get_path(btd_adapter),
-- 
2.31.1

