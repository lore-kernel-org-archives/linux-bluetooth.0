Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FF5ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Sep 2022 17:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiISR5F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Sep 2022 13:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiISR5E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Sep 2022 13:57:04 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675B92126A
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 10:57:03 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso6931973pjq.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 10:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=lsxoKrT8ToOYn/aj8iT347uk6DO4+sXKNJGwFCPI71k=;
        b=EfXggWyDV3RG2luy1BeTubBMkOqxpwaun9uObHWTJX/FNVGo8HgtCnsKfCGYQnU6Y2
         3scjuR1+4MG7CiF41UNe5rtZGub9aPEj+aFXgTkDX0qGFWXER75L9xtS6IyspzvWc4Lb
         lNUkd7j8l+ao9gwpq7UMlF1v6mLha6EltP2fhu6bc3xvUz0JVh8bAFKs35A8p2ISZIiO
         Fd7d5K/5TFbTfeOuI5nhX68P+0kgmIuabwLOVfFkJNr4FNJuE6s+h9ZFFlSO1enPqkWP
         B+A6QkJNgsuqcccw1EnmuB5rtEt0gC9x6YmLod6dDp2htBCkWrmlxJkGcw39OxOZ7QBp
         KPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=lsxoKrT8ToOYn/aj8iT347uk6DO4+sXKNJGwFCPI71k=;
        b=SGc4qa8wQPvhNUQXFwVNoe/rFs/lSCbyjm+zU5vmG7uWjbbn8VkWfeaGldEc2I19vN
         WU3QX/FjVNdPsi1/MAMnD7Rhdy36QzYpP4fysQNbKH1H1MvSQPDclR33kEOB5DJ17Fyd
         pGcXcJSaxCRpQxVzNyarVjeZ3+XO3KTDRBoXbg9tPj7eN7MmP5ryyD7AHFD952DDAtIM
         JytSn7CsDd2VDqg0hVJx3wUtopXNIbeowKJgc3cURztkUnXfQaLvuywj1SlHoc+1aMhk
         +a0AH0qcc/hsbCnSoK+6htwdjis1Fc8Y18GzUeYfOMMQAZU+rQ9QSZoYVXhm7+si+iwJ
         fVxg==
X-Gm-Message-State: ACgBeo1l6RDJ7WPPr+/23Ij357JQ9pFgvlTRglGbXZjV7kxRUO+U1llm
        5kp4UI4Yd3YZL/RvaSA0Bq9+/Sbeh1U=
X-Google-Smtp-Source: AA6agR5cooExW0Ts4Rs0aZ3rLc4YoH07wao2AtDQRoE1PB1+0mpF42f2+XKGX3W2NIOxQ7wwrXnxog==
X-Received: by 2002:a17:90b:4f4b:b0:200:876b:c1c8 with SMTP id pj11-20020a17090b4f4b00b00200876bc1c8mr33115481pjb.32.1663610222354;
        Mon, 19 Sep 2022 10:57:02 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a1-20020aa794a1000000b005361f6a0573sm20579120pfl.44.2022.09.19.10.57.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:57:01 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_sysfs: Fix attempting to call device_add multiple times
Date:   Mon, 19 Sep 2022 10:56:59 -0700
Message-Id: <20220919175700.1649726-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

device_add shall not be called multiple times as stated in its
documentation:

 'Do not call this routine or device_register() more than once for
 any device structure'

Syzkaller reports a bug as follows [1]:
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:33!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
[...]
Call Trace:
 <TASK>
 __list_add include/linux/list.h:69 [inline]
 list_add_tail include/linux/list.h:102 [inline]
 kobj_kset_join lib/kobject.c:164 [inline]
 kobject_add_internal+0x18f/0x8f0 lib/kobject.c:214
 kobject_add_varg lib/kobject.c:358 [inline]
 kobject_add+0x150/0x1c0 lib/kobject.c:410
 device_add+0x368/0x1e90 drivers/base/core.c:3452
 hci_conn_add_sysfs+0x9b/0x1b0 net/bluetooth/hci_sysfs.c:53
 hci_le_cis_estabilished_evt+0x57c/0xae0 net/bluetooth/hci_event.c:6799
 hci_le_meta_evt+0x2b8/0x510 net/bluetooth/hci_event.c:7110
 hci_event_func net/bluetooth/hci_event.c:7440 [inline]
 hci_event_packet+0x63d/0xfd0 net/bluetooth/hci_event.c:7495
 hci_rx_work+0xae7/0x1230 net/bluetooth/hci_core.c:4007
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

Link: https://syzkaller.appspot.com/bug?id=da3246e2d33afdb92d66bc166a0934c5b146404a
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 4e3e0451b08c..08542dfc2dc5 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -48,6 +48,9 @@ void hci_conn_add_sysfs(struct hci_conn *conn)
 
 	BT_DBG("conn %p", conn);
 
+	if (device_is_registered(&conn->dev))
+		return;
+
 	dev_set_name(&conn->dev, "%s:%d", hdev->name, conn->handle);
 
 	if (device_add(&conn->dev) < 0) {
-- 
2.37.3

