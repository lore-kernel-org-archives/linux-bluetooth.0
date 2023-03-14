Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5A4C6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Mar 2023 19:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCNTXa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Mar 2023 15:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCNTX3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Mar 2023 15:23:29 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0517523122
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 12:23:28 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id y2so16433910pjg.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 12:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678821807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nghr0MKmyjAv9f0/j7BN2Ovq2gZbb5qtMttnjL62jd4=;
        b=bAMRB+lcdI0YStSj0DlSGYUvfl89QUXX7TV0Q1rZPLiGNTAVpvkoE/fK6KxRI2FBWD
         jNEylPJ8Gpj/Bcgn5TvGZVkjzH80ACChqqehPRSSvd7zR4SyiJPyvXq2ne8rwu66xgxM
         r8sTH7x2sZF2EE+qimTeB241Bf+S85g9eWyli/hk+RI3QLEvGLFqbB4GusIwyc9gIBHG
         RmxVCCkMXMRDDf9gHaSvRc/FKbWpvHio6WCanWQ9zP0MLIYxLNTsrwOHCo7VSdYx6jyH
         G6Ix5YMRdri8h8jvOGo18U55PJ+wJg4kdg41tezxY0y3LzLWtrXths5vh5OJkYa6gYvq
         CYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678821807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nghr0MKmyjAv9f0/j7BN2Ovq2gZbb5qtMttnjL62jd4=;
        b=m9IahTr2WVsKPvZogTJSsWBnsQCCmdyvPENQAz0uqHwWuxQb5KeWP6xyFtmzpR4Cb8
         ZEsigjJDQ7yIUzs9/R4m8U8J/2o6hIa0yAK7gTrwvMALYahFgmGMwQcQsG4H8IS4dF93
         lfs/XSVMPclfGM/NpKp/uB+Jzq88ob3ifYmFpSOScNGlsguYjN9rgKw1IuSIgXb8IGew
         XlYxfW7661JoGfZ+M2VqEZtV1fm1mywu0voLb/7B5RtSybv/AUjULrs0pIX3bKn7Lv38
         V6Lvxig8yYreGLGQI+bZZnrH/domgS2+XJjseGNexolvjtXPGULACJ15oHzYRInV96Lq
         8+XQ==
X-Gm-Message-State: AO0yUKVy25z841Lfib/B4s6kIB9nhncFaNQiufH5+9kkDMgSob/ax7Ya
        8LpLVKnTcawcWGQIBaoXiBf2ekCcACk=
X-Google-Smtp-Source: AK7set8aIiU2zmVxXzzUtNTcjQA5UV1htoREE+mEzqYe4EUb5sCS7/HbLMkMoKw/JIV/UVaCj6xJgw==
X-Received: by 2002:a17:90a:aa8a:b0:23d:31c3:c98d with SMTP id l10-20020a17090aaa8a00b0023d31c3c98dmr4156220pjq.15.1678821806947;
        Tue, 14 Mar 2023 12:23:26 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id r15-20020a63204f000000b0050bcf117643sm1454763pgm.17.2023.03.14.12.23.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 12:23:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-client: Fix crash on bt_gatt_client_idle_unregister
Date:   Tue, 14 Mar 2023 12:23:25 -0700
Message-Id: <20230314192325.464661-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following crash:

Invalid read of size 8
   at 0x1E1E0B: bt_gatt_client_idle_unregister (gatt-client.c:3812)
   by 0x1EB6BD: bt_bap_detach (bap.c:3821)
   by 0x1EB6BD: bt_bap_detach (bap.c:3808)
   by 0x1D5631: queue_foreach (queue.c:207)
   by 0x1DCAA3: disconnect_cb (att.c:713)
   by 0x1F4404: watch_callback (io-glib.c:157)
   by 0x48BBC7E: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.7400.6)
   by 0x4912117: ??? (in /usr/lib64/libglib-2.0.so.0.7400.6)
   by 0x48BB24E: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.7400.6)
   by 0x1F4A54: mainloop_run (mainloop-glib.c:66)
   by 0x1F4E21: mainloop_run_with_signal (mainloop-notify.c:188)
   by 0x1304B4: main (main.c:1428)
 Address 0x28 is not stack'd, malloc'd or (recently) free'd
---
 src/shared/gatt-client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 3a29f807fc85..d28f5b3670f6 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -3809,6 +3809,9 @@ bool bt_gatt_client_idle_unregister(struct bt_gatt_client *client,
 {
 	struct idle_cb *idle = UINT_TO_PTR(id);
 
+	if (!client || !id)
+		return false;
+
 	if (queue_remove(client->idle_cbs, idle)) {
 		idle_destroy(idle);
 		return true;
-- 
2.39.2

