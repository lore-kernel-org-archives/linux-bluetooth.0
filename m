Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B30C49EA7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jun 2021 06:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 951DF61628
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jun 2021 06:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhFZGch (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Jun 2021 02:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhFZGcg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Jun 2021 02:32:36 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EBAC061766
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jun 2021 23:30:14 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x16so9207502pfa.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jun 2021 23:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=O2yNI2PTWw1a9ykSOnZCwMF6hNIEJVbPjIZGoxyblqg=;
        b=SYnrgECvZvVc6A9e1hX66RI25nzGSz6eLipgNKRcCd9ILuKlMrnzFC7BTq5p1Z6YVp
         zEAUrGY4DHamj3XsFeGbZU2C8pgMBOA7nmC5jK0t5x+sue3V8Ln8DC+k+w2qT7BlknMA
         L08Z/vatuaNX61v8ZG6J5/A7aJU3ZbHWxHzOoBrE8te6Q2lukGmuwnKt6MkyMFX0YgNP
         GR29jOi2PPtVwc/WweYwjwARRHxkTUKFw9ipjA5lQl8SPVeIbRrWs/+7M3vTVyz8CEco
         ZA61DshAwvTSEOg7c0cdYf1uvC6HEa2Eys78zdE3+oSgAg+fX5cw2+tm7YsLsOFOXNf/
         cPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O2yNI2PTWw1a9ykSOnZCwMF6hNIEJVbPjIZGoxyblqg=;
        b=LRjbSIyma/4FCgFo5Pps2ltva2pht8d1mfMWuRT8fs0F3sldMpbktA8Z+cET47/0Kc
         gCNMbUHZ7KiR8PLK1jcXNrWYKO/Biqhx2m43NhhXDsZcMGGPoJH++94GROkL1TbhxlLU
         mUL5TrW0V60TcFrgMEpswf7Xs2N8b2/cCK/a3FYH0cVF/1dfCV99R8+xn07h/YT0UXVG
         apM6yiQ/Qkji3e0pbwFD9jzCrpLogmNsNTZUVcsQM/cyO6NefXXtsxM3r48eopF/esuD
         Sij25cwTo4/hXYWzkn0KPD+L4WmiRjjTRq/D+tyyPM5vZA1+FWnjJZ2njsJA6DjiILhL
         v+MQ==
X-Gm-Message-State: AOAM533ly3QXrAMwj4Ubx4ANb0zO91+cXvPkFRm7NdKgojvTfuBF1/Kz
        golTP58QTLIZDkzm/Dlh3M1lBHUFnoY=
X-Google-Smtp-Source: ABdhPJxdKpXe0xfjCVISqJ0NfgARlU89hxy+EAK+e9TtBBt7Q5rOI5GNnr4kXCZdDLFWs0KresasDg==
X-Received: by 2002:aa7:8806:0:b029:302:f067:7b52 with SMTP id c6-20020aa788060000b0290302f0677b52mr14326042pfo.13.1624689013486;
        Fri, 25 Jun 2021 23:30:13 -0700 (PDT)
Received: from han1-mobl3.intel.com ([2601:1c0:6a01:d830::5820])
        by smtp.gmail.com with ESMTPSA id y21sm7587880pgc.93.2021.06.25.23.30.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 23:30:12 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ PATCH v4 2/3] emulator/btdev: clean up the queue before closing the test
Date:   Fri, 25 Jun 2021 23:30:09 -0700
Message-Id: <20210626063010.152987-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210626063010.152987-1-hj.tedd.an@gmail.com>
References: <20210626063010.152987-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch clean up the queue for connection before closing the test to
prevent the potential memory leak.

==50== 32 bytes in 1 blocks are definitely lost in loss record 18 of 32
==50==    at 0x483A809: malloc (vg_replace_malloc.c:307)
==50==    by 0x14A37E: btd_malloc (util.c:33)
==50==    by 0x149D9D: queue_new (queue.c:47)
==50==    by 0x13B3C0: btdev_create (btdev.c:6042)
==50==    by 0x13178E: create_vhci (hciemu.c:229)
==50==    by 0x13178E: hciemu_new_num (hciemu.c:403)
==50==    by 0x130E2C: read_index_list_callback (mgmt-tester.c:357)
==50==    by 0x14AD91: request_complete (mgmt.c:264)
==50==    by 0x14BD34: can_read_data (mgmt.c:356)
==50==    by 0x14E794: watch_callback (io-glib.c:157)
==50==    by 0x48B578E: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.6400.6)
==50==    by 0x48B5B17: ??? (in /usr/lib64/libglib-2.0.so.0.6400.6)
==50==    by 0x48B5E32: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.6400.6)
==50==
==50== 32 bytes in 1 blocks are definitely lost in loss record 19 of 32
==50==    at 0x483A809: malloc (vg_replace_malloc.c:307)
==50==    by 0x14A37E: btd_malloc (util.c:33)
==50==    by 0x149D9D: queue_new (queue.c:47)
==50==    by 0x13B3C0: btdev_create (btdev.c:6042)
==50==    by 0x1318F7: hciemu_client_new (hciemu.c:332)
==50==    by 0x1318F7: hciemu_new_num (hciemu.c:412)
==50==    by 0x130E2C: read_index_list_callback (mgmt-tester.c:357)
==50==    by 0x14AD91: request_complete (mgmt.c:264)
==50==    by 0x14BD34: can_read_data (mgmt.c:356)
==50==    by 0x14E794: watch_callback (io-glib.c:157)
==50==    by 0x48B578E: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.6400.6)
==50==    by 0x48B5B17: ??? (in /usr/lib64/libglib-2.0.so.0.6400.6)
==50==    by 0x48B5E32: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.6400.6)
---
 emulator/btdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 202fc7996..75cca7549 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -624,8 +624,10 @@ static void conn_unlink(struct btdev_conn *conn1, struct btdev_conn *conn2)
 	conn2->link = NULL;
 }
 
-static void conn_remove(struct btdev_conn *conn)
+static void conn_remove(void *data)
 {
+	struct btdev_conn *conn = data;
+
 	if (conn->link) {
 		struct btdev_conn *link = conn->link;
 
@@ -6056,6 +6058,7 @@ void btdev_destroy(struct btdev *btdev)
 	bt_crypto_unref(btdev->crypto);
 	del_btdev(btdev);
 
+	queue_destroy(btdev->conns, conn_remove);
 	queue_destroy(btdev->le_ext_adv, le_ext_adv_free);
 
 	free(btdev);
-- 
2.26.3

