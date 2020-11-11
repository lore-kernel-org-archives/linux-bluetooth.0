Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A213C388F9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 01:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A7A20809
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 01:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Quhva8SF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgKLBdR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbgKKXG3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 18:06:29 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424C7C061A4B
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 15:04:36 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id y7so2666184pfq.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 15:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CyCLFBOWsD7IBPaN8oe2uAyPXTqgGQd+HZN7ekvkkvs=;
        b=Quhva8SFC1z/81pmjzzvbv4wa3LFfYKMW04ueVJYYLq5MDtH8NCFmiD2BuMq6hjbZE
         wlgVMmPO9LdCohoreSTr/HMBflzkuFW+fKyz1JchPL0wT+I/pKsLIJWWOLnWuyUAxNTy
         pRftCMUxn64VRujOs1L1a/fKOIZYz44hDsjPZQcozCpgT8Pd4k+9nqLOfy+48f+OzkHx
         zts9d5LHIDqyzlop5RF5vuyvmQbX2ATQucpkIoTFW74p5Cdo04+S3oG2w/ljuH8Ks78F
         UgW30v4hIduR3MwFdGx0st/KF6T61LO0AuQ26n/GEp4yiXV/VLf0RP/TJ7yJzcapKAAP
         /o0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CyCLFBOWsD7IBPaN8oe2uAyPXTqgGQd+HZN7ekvkkvs=;
        b=fffROg1i9Uih9ybeYsxdoN2ODH88LH/L26YpUD4TD/9/k5nhUIycEWPFRf1ZKyxBAm
         saC5zIGysGcWmtrYANpnmz1mvRna5d3yfpnclSi7lsQXVDinjsSRCypZPUn115JFUvZV
         1sbvlSMrSK/l/snxher5RsDSKFXmtvZz5wwtopjk6ZBvzC4fgnr1RPTWmwzxD+wbsm2B
         QWX+DpTrJRpUyCHIGyDIlDDlY5oHS1QjrA28oJonMb2SPz9Cqu5eaBYuyDuiCKzLCA+J
         zHwRnMGUWobkI/VbZIFuJMBK3icDo0GvuBUEThTyBWfh1HWNVShBtPs0OtZl6ca8y0Iw
         MBpg==
X-Gm-Message-State: AOAM533cc9iu8XoPtBV5tzFRmb0LGWNi2hwYaUCErMc3XBp3NzNYyWN8
        DMKzvprdrLJAYTftq7Lt5KjmqHl3mSjyAg==
X-Google-Smtp-Source: ABdhPJyjdJbay7Lyr36Dhci6O+3otqzqN+Yoewbxn/Pwk7mDwlNpg1EeWXKxt00YjOMeH3PaS/8HZA==
X-Received: by 2002:aa7:9f5a:0:b029:18b:594b:fb6c with SMTP id h26-20020aa79f5a0000b029018b594bfb6cmr25697552pfr.45.1605135875566;
        Wed, 11 Nov 2020 15:04:35 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n27sm3867767pfq.59.2020.11.11.15.04.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 15:04:35 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 10/10] bthost: Fix sending uninitilized data
Date:   Wed, 11 Nov 2020 15:04:21 -0800
Message-Id: <20201111230421.3364932-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111230421.3364932-1-luiz.dentz@gmail.com>
References: <20201111230421.3364932-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Syscall param writev(vector[...]) points to uninitialised byte(s)
   at 0x4A8A497: writev (in /usr/lib64/libc-2.31.so)
   by 0x1365C1: send_packet (bthost.c:509)
   by 0x1365C1: send_packet (bthost.c:492)
   by 0x1365C1: next_cmd (bthost.c:737)
   by 0x137578: evt_cmd_complete (bthost.c:882)
   by 0x137578: process_evt (bthost.c:1343)
   by 0x137578: bthost_receive_h4 (bthost.c:2414)
   by 0x12DF49: receive_bthost.part.0 (hciemu.c:134)
   by 0x48B978E: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.6400.6)
   by 0x48B9B17: ??? (in /usr/lib64/libglib-2.0.so.0.6400.6)
   by 0x48B9E32: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.6400.6)
   by 0x14A664: mainloop_run (mainloop-glib.c:66)
   by 0x14AA41: mainloop_run_with_signal (mainloop-notify.c:188)
   by 0x149A7B: tester_run (tester.c:871)
   by 0x129C77: main (mgmt-tester.c:10219)
 Address 0x4c48c05 is 21 bytes inside a block of size 280 alloc'd
   at 0x483CAE9: calloc (vg_replace_malloc.c:760)
   by 0x136487: queue_command (bthost.c:472)
   by 0x136487: send_command (bthost.c:715)
   by 0x13948A: bthost_set_ext_adv_enable (bthost.c:2581)
   by 0x12CEBF: trigger_device_found (mgmt-tester.c:8513)
   by 0x148C9A: wait_callback (tester.c:749)
   by 0x48BA330: ??? (in /usr/lib64/libglib-2.0.so.0.6400.6)
   by 0x48B978E: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.6400.6)
   by 0x48B9B17: ??? (in /usr/lib64/libglib-2.0.so.0.6400.6)
   by 0x48B9E32: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.6400.6)
   by 0x14A664: mainloop_run (mainloop-glib.c:66)
   by 0x14AA41: mainloop_run_with_signal (mainloop-notify.c:188)
   by 0x149A7B: tester_run (tester.c:871)
---
 emulator/bthost.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index f29bda06e..3b42c0664 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -2577,6 +2577,7 @@ void bthost_set_ext_adv_enable(struct bthost *bthost, uint8_t enable)
 	send_command(bthost, BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
 							&cp, sizeof(cp));
 
+	memset(&cp_enable, 0, sizeof(cp_enable));
 	cp_enable.enable = enable;
 	send_command(bthost, BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE, &cp_enable,
 					sizeof(cp_enable));
-- 
2.26.2

