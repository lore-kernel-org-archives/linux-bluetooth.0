Return-Path: <SRS0=JOhI=EL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77522C388F7
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 22:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED97C2083B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 22:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g3SJd+fG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbgKEWuW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Nov 2020 17:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgKEWuW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Nov 2020 17:50:22 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D2EC0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2020 14:50:22 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id x23so1498367plr.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2020 14:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qjEW48iqNOIEJkng92xffd5UTNQ6qj4/CxAzhaz5mss=;
        b=g3SJd+fGUC+VinzrF55zAvgPyKEv+MX78tBd0B88kM+Tb7gjWN36WUwcDSs+KTBV6C
         SsyNTCcoLDXhjwo7NYrSo9X+ExnK6cZI5gTpARQyzxnlny6EuAE1jYP3QMkMzqN4L1eL
         CqSCfVSAw3F+2bRDz+1Xg8HctSlRyKJboMcPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qjEW48iqNOIEJkng92xffd5UTNQ6qj4/CxAzhaz5mss=;
        b=G3USHYc83RTwBf7/xl80l/FqfnjNU4ihcg9xc9POgd9depGgSQzFiIKo9N3ZRci8fx
         OOH6HjXt7CpkGaxGJ0T3ym3dPBksDZVAvvRbXXJ45EDss5F/xVKJmW9Sf3fZY0/sON3j
         6mPYeXn+wSAQZgKoV7P/H2EfGxXbqnvFq7ZfrVdYCZnaD5Oyvc6/TczRPghcGD8qm5Dy
         5UBZnPxcc0+KvwpMP9Uyo1Ab4feKmqw/7gWbfqJuklot83iG3jl6qiTSVJ0LSy6amvwp
         0VMAnr5AW1SR40aCBd13lt+MPV1J//B133PWbO9500h8fKOHkkkrBZMU4l72pmfnJj1j
         jExQ==
X-Gm-Message-State: AOAM532WXQjsZvFR53PBpdSotGA3YxaOlyM4sQwl8/tdr2KDJl4Fjcq8
        ckHYdOv0DVmVr78eEdFKZEVYBp1P5mLJFA==
X-Google-Smtp-Source: ABdhPJzyUkz++bla1K6nwPbXDKTSr8AWriGrwxdRsIp5CG1YJh1syIZVbugaxXwr33aIupDDYxXvHA==
X-Received: by 2002:a17:902:a717:b029:d6:e91:d02b with SMTP id w23-20020a170902a717b02900d60e91d02bmr4211527plq.23.1604616621283;
        Thu, 05 Nov 2020 14:50:21 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id p127sm644974pfp.93.2020.11.05.14.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 14:50:20 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH BlueZ] Cancel GATT client operations when cleaning up GATT cache
Date:   Thu,  5 Nov 2020 14:49:23 -0800
Message-Id: <20201105224923.377-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

A crash is found when discovery_complete_op is invoked but
gatt_db_attribute objects have been freed. A solution is to always
cancel GATT client operations every time we clean GATT cache.

The crash is reproducible by connecting to an LE mouse and then calling
RemoveDevice immediately, triggering disconnection while GATT service
discovery is in progress.

Sample crash stack trace:
0  gatt_db_service_get_handles (service=0x1751130, service=0x1751130, end_handle=0x7ffcd600806e, start_handle=0x7ffcd600806c) at src/shared/gatt-db.c:569
1  gatt_db_attribute_get_service_data (attrib=<optimized out>, start_handle=0x7ffcd600806c, end_handle=0x7ffcd600806e, primary=0x0, uuid=0x0) at src/shared/gatt-db.c:1657
2  0x00000000004983a8 in discovery_op_complete (op=op@entry=0x173b320, success=<optimized out>, err=err@entry=10 '\n') at src/shared/gatt-client.c:406
3  0x000000000049a548 in discover_descs_cb (success=<optimized out>, att_ecode=<optimized out>, result=<optimized out>, user_data=0x173b320) at src/shared/gatt-client.c:915
4  0x00000000004a1d87 in discovery_op_complete (op=0x1748450, success=<optimized out>, ecode=<optimized out>) at src/shared/gatt-helpers.c:615
5  0x00000000004a2379 in discover_descs_cb (opcode=<optimized out>, pdu=0x174d551, length=<optimized out>, user_data=0x1748450) at src/shared/gatt-helpers.c:1465
6  0x00000000004966db in handle_rsp (pdu_len=4, pdu=<optimized out>, opcode=<optimized out>, chan=0x17483c0) at src/shared/att.c:814
7  can_read_data (io=<optimized out>, user_data=0x17483c0) at src/shared/att.c:1011
8  0x00000000004a0853 in watch_callback (channel=<optimized out>, cond=<optimized out>, user_data=<optimized out>) at src/shared/io-glib.c:157
9  0x00007fb3f2d7fe87 in g_main_context_dispatch () from /usr/lib64/libglib-2.0.so.0
10 0x00007fb3f2d80230 in ?? () from /usr/lib64/libglib-2.0.so.0
11 0x00007fb3f2d80542 in g_main_loop_run () from /usr/lib64/libglib-2.0.so.0
12 0x00000000004a0e25 in mainloop_run () at src/shared/mainloop-glib.c:66
13 0x00000000004a11f2 in mainloop_run_with_signal (func=func@entry=0x43f200 <signal_callback>, user_data=user_data@entry=0x0) at src/shared/mainloop-notify.c:188
14 0x000000000040c72e in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:959

Change-Id: I17b8ccc5322b0a83fc63d711e83c9f4a58a0374c
---
 src/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/device.c b/src/device.c
index a5ef46730..d5e884ff4 100644
--- a/src/device.c
+++ b/src/device.c
@@ -569,6 +569,7 @@ static void gatt_cache_cleanup(struct btd_device *device)
 	if (gatt_cache_is_enabled(device))
 		return;
 
+	bt_gatt_client_cancel_all(device->client);
 	gatt_db_clear(device->db);
 }
 
-- 
2.26.2

