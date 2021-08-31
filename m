Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88AEC432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 05:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1F7A60F6B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 05:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237146AbhHaFkE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 01:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbhHaFkC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 01:40:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6088BC061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 22:39:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k187-20020a2556c4000000b00598b2a660e2so4586748ybb.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 22:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=O9ROyX82d1ic8lY+iEzgSnvao9UCu6YLwS6D67oV3yU=;
        b=MCym82D5gLjo4YJC3BTk9xX16w4+xyWCDRHsnAOXCFb9LnTME5TDltRbiBZYzf6M7S
         3wmSdS7+x3EnCgtF8McqkRdCuvuhihejEhFicL6+i8Wg9IDL8hsyB59kw5jNNkaVM9AR
         /N9KZnVG2jkDhbhEkdy9JNlfRjaBYW6up1xe10AKwR+4mhAJ2BfTP8Ptnj4zg1e/3gI3
         nmtPt4+awWcjyZD+6jjasFd5yhu/xd9CB37nJdPa0CmK8B0sUyUUTveno0Hi5e00PbaB
         LXLK9guU2S6iRB/b9kQlHwvXf1ly4KATNytSPZQrHTfWI3+c+lTlIz3SejQ+2HP+7zTn
         CdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=O9ROyX82d1ic8lY+iEzgSnvao9UCu6YLwS6D67oV3yU=;
        b=sE5gP2Iwe2+3Op+E0KgJmvsGLlVoZNBk7ZwYNNDY3pWasgyQ+fUkTumPlOpUKBhxKT
         tHHiDHpfDFzYYyIAfr5Ee/zo/V4a14YqUcME+SSQbWvvXBSyJJyAZAoC2DF+dsGJ+vxl
         K76+sI3Ik8ijBR8BNFJmpPnUtsynZLigpBpnZxfb2nb1v4o+TrYMpxWNpmJSe6Kv+E7r
         sAF0N1yZadA0/3ykLRdbPiA+s68g1IZrnjMj1Xj/pcu/iWuxYxfnFppNymxhwoYJDYiv
         /ztol0zbrvWpvq7DUfpmSELH9PmXa3o4FSMYjge6lmeEv/IQRwOb1VhrIjz1bPUfHhL5
         Y7FA==
X-Gm-Message-State: AOAM532j4szrRnAt47PbsM3A5EM8Ueb3QURXRq1F/S9CZkn3r264doNn
        wwxTZGYKhyIEzbNymBtC5ZpgANfjb5ecZEqEyvIwrQVNb0yv6ErgjwnpIMfZsZwaS4Kzfo+KO/U
        eBbz2ru2nCE8pQQFeXsJzMPy2y0BFsOjkf7DlIJDxQZBbDTUtScyLRr44X+9Ptdc/0HH4ALQLnS
        Uk3qq4/wDL5dw=
X-Google-Smtp-Source: ABdhPJzefQBuQ7osnf2pmnlRTXnGru4uz95NjIwgwhVGTo5KwdhVTZyw/EWAC/X5/rFsbMu0pbEC3+hxjj4LhUTj3A==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:93c2:6f3f:e782:13b0])
 (user=howardchung job=sendgmr) by 2002:a05:6902:1502:: with SMTP id
 q2mr848822ybu.284.1630388345583; Mon, 30 Aug 2021 22:39:05 -0700 (PDT)
Date:   Tue, 31 Aug 2021 13:39:00 +0800
Message-Id: <20210831133844.Bluez.v1.1.Ia40feb9cf37fd87db5b5b4910c08882c9cf21688@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [Bluez PATCH v1] plugin/admin: fix set empty allowlist no persistence issue
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This patch fixes a bug when setting empty service allowlist, the
allowlist sets successfully but it fails to be stored in the file.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---
Test procedure:
1. set empty service allowlist via bluetoothctl
2. cat /var/lib/bluetooth/admin_policy_settings
3. restart bluetoothd
4. get service allowlist via bluetoothctl

 plugins/admin.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/plugins/admin.c b/plugins/admin.c
index aea33cb71ac2..02fec04568ba 100644
--- a/plugins/admin.c
+++ b/plugins/admin.c
@@ -196,12 +196,17 @@ static char **new_uuid_strings(struct queue *allowlist, gsize *num)
 	char **uuid_strs = NULL;
 	gsize i = 0, allowlist_num;
 
+	allowlist_num = queue_length(allowlist);
+	if (!allowlist_num) {
+		*num = 0;
+		return NULL;
+	}
+
 	/* Set num to a non-zero number so that whoever call this could know if
 	 * this function success or not
 	 */
 	*num = 1;
 
-	allowlist_num = queue_length(allowlist);
 	uuid_strs = g_try_malloc_n(allowlist_num, sizeof(char *));
 	if (!uuid_strs)
 		return NULL;
-- 
2.33.0.259.gc128427fd7-goog

