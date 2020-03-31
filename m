Return-Path: <SRS0=zBKN=5Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE93EC43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 10:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89244208FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 10:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="odDJY3uD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbgCaKpj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Mar 2020 06:45:39 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33765 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730242AbgCaKpj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Mar 2020 06:45:39 -0400
Received: by mail-lj1-f194.google.com with SMTP id f20so21483467ljm.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2020 03:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lUnQ5NQXALt2eXnbRts4r3fDGkIzEGkynKZS5mzqXwc=;
        b=odDJY3uDnT1SODQ8YyAY5EqhmCOsvr6BalPVb6p+HyQL67JJNdCWGX6LW2VK+CeLiw
         hcEhaPs39BwAE6bmwPVNHKNQOjmYoJwwSKpRMoRm8diK9o0dTBDXrS/jjJP3OfC5C27I
         oPr2sYw1cbmPARyKacvBBq2eG1aI+Nt5+J1YYG2nBfaIgKSPNarCs4oojzj015xSmZBJ
         BWQLdkFNK33IFcRDCxTcrUVFcc5a8uVobw9ZgmUBOp2/25MAnsgYaerIAmuk3kzwZ9Hx
         YuofqgONekwHGOqCz7qDjTGM2LXhdLUQFhTh4nBUSDMIkMwOHogeeT8Jq/X+6/j3/PWI
         gLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lUnQ5NQXALt2eXnbRts4r3fDGkIzEGkynKZS5mzqXwc=;
        b=eh+0VC3erI5pG9rPoyglAhBgkCMWsX+lFvinutlQw0PURknFBj03lvc9H4+iwccDoV
         F8tK7hVMUEY0pAhcclGZ/pF1q4Jgl6NgtvNU7/qrWCSu2DGYpIs3nBfQDDOER0dmpts3
         f3U+IEGXotlO7eAz0DdOQ8TcYz1BfeDg4elF2YrSkys14fP8CcwsY8Q3Nc+DZ/v+iq1n
         j6slDGvwuB6kZAySQB+uDPcO279dZf80o1Uu/XlHioNPQAV3f5H6vlzRDv/O53t3jXEM
         i1cBwLhBC7133uk+KLseAX2LgGd4WNUka5Xs00TmpCkVFIr9Rqf++ScPOuzD1+Z25Kfr
         4RNw==
X-Gm-Message-State: AGi0PuaTMnDZ4jScO1KsVhBCj+Xn2lbyKMkkOIYQajOX+75xCDCJCqMm
        D/FNQkeJGlGf1F4808tsqep3nEKwHCg=
X-Google-Smtp-Source: APiQypJ1A0KNVVmJWq2GzsM/2e5PAilrHA4yCDOPXxmWTEsq9qAVKpel4IfWRhf4O4uyPLlMDupnBQ==
X-Received: by 2002:a2e:884d:: with SMTP id z13mr10100244ljj.158.1585651536680;
        Tue, 31 Mar 2020 03:45:36 -0700 (PDT)
Received: from localhost.localdomain (45-11-60-42.ip4.greenlan.pl. [45.11.60.42])
        by smtp.gmail.com with ESMTPSA id v21sm8788062lji.81.2020.03.31.03.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 03:45:35 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] shared/gatt: Fix NULL pointer dereference
Date:   Tue, 31 Mar 2020 12:45:32 +0200
Message-Id: <20200331104532.365961-1-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

bluetoothd[363094]: src/device.c:device_connect_le() Connection attempt to: 00:AA:01:00:00:23

Program received signal SIGSEGV, Segmentation fault.
write_complete_cb (attr=0x55555580aa30, err=-110, user_data=0x55555585f7c0) at src/shared/gatt-server.c:793
793             util_debug(server->debug_callback, server->debug_data,
(gdb) bt
 #0  write_complete_cb (attr=0x55555580aa30, err=-110, user_data=0x55555585f7c0) at src/shared/gatt-server.c:793
 #1  0x00005555556a5852 in pending_write_result (p=0x555555866030, err=<optimized out>) at src/shared/gatt-db.c:162
 #2  0x00005555556a5ac7 in write_timeout (user_data=0x555555866030) at src/shared/gatt-db.c:1879
 #3  0x00005555556a9b15 in timeout_callback (user_data=user_data@entry=0x555555864b20) at src/shared/timeout-glib.c:34
 #4  0x00007ffff7e1f081 in g_timeout_dispatch (source=source@entry=0x555555864f00, callback=0x5555556a9b00 <timeout_callback>, user_data=0x555555864b20) at ../glib/gmain.c:4705
 #5  0x00007ffff7e1e570 in g_main_dispatch (context=0x5555557d9630) at ../glib/gmain.c:3216
 #6  g_main_context_dispatch (context=context@entry=0x5555557d9630) at ../glib/gmain.c:3881
 #7  0x00007ffff7e1e900 in g_main_context_iterate (context=0x5555557d9630, block=block@entry=1, dispatch=dispatch@entry=1, self=<optimized out>) at ../glib/gmain.c:3954
 #8  0x00007ffff7e1ebf3 in g_main_loop_run (loop=0x5555557d75d0) at ../glib/gmain.c:4148
 #9  0x00005555556a9dbd in mainloop_run () at src/shared/mainloop-glib.c:79
 #10 0x00005555556aa36a in mainloop_run_with_signal (func=<optimized out>, user_data=0x0) at src/shared/mainloop-notify.c:201
 #11 0x00005555555bb9e3 in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:770
---
 src/shared/gatt-server.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 7e5d652e4..4e07398d2 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -790,14 +790,14 @@ static void write_complete_cb(struct gatt_db_attribute *attr, int err,
 	struct bt_gatt_server *server = op->server;
 	uint16_t handle;
 
-	util_debug(server->debug_callback, server->debug_data,
-				"Write Complete: err %d", err);
-
 	if (!server || op->opcode == BT_ATT_OP_WRITE_CMD) {
 		async_write_op_destroy(op);
 		return;
 	}
 
+	util_debug(server->debug_callback, server->debug_data,
+						"Write Complete: err %d", err);
+
 	handle = gatt_db_attribute_get_handle(attr);
 
 	if (err)
@@ -914,14 +914,14 @@ static void read_complete_cb(struct gatt_db_attribute *attr, int err,
 	uint16_t mtu;
 	uint16_t handle;
 
-	util_debug(server->debug_callback, server->debug_data,
-				"Read Complete: err %d", err);
-
 	if (!server) {
 		async_read_op_destroy(op);
 		return;
 	}
 
+	util_debug(server->debug_callback, server->debug_data,
+				"Read Complete: err %d", err);
+
 	mtu = bt_att_get_mtu(server->att);
 	handle = gatt_db_attribute_get_handle(attr);
 
-- 
2.25.1

