Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD0FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Oct 2021 03:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A080261989
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Oct 2021 03:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhJVDRP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Oct 2021 23:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbhJVDRP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Oct 2021 23:17:15 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EEDC061764
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 20:14:58 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso2039060pjb.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 20:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ufiigiRR7wpzGJhB2N55K0St53evQ5rjC5FnW13VhTM=;
        b=q0D69iGyAyIgPKqMcSN5n7iegzIEreQHrsDm47crb5dPKGaHVYbDlaCIGdl7gMghDY
         rhnjJeTDrad4GYQpJNNzmFgnxj2keYZhoiSXmbEg5Z7oyb0wdfKhxqQtbW5b0NvEtzrw
         0pRLViu+wGiV/A+bpeKs3lBmbbrBQ46YcIQUjQGC8oipgBe+pK+cYGrsFDQZXK7vavWQ
         IqXYkbzP55PIKVmV1QAzSJzxISrV5gYH7b1g2dzEovlHe2SfUS3N2K9e24qpMR+gjRsT
         jveGVCAboZvzOEWrjjMXQx7SCH0Y5y2hMkAFJiU+fPKbv9kIY//bMq9eAGQg9UkcDQ2W
         n/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ufiigiRR7wpzGJhB2N55K0St53evQ5rjC5FnW13VhTM=;
        b=as5Cmu1yIQ+pFWQwZ4vNMuTk/kavHMk5Ws5+GaZ9A0BDPyLZZ5nSOfErm5PB8EewR5
         1KFiiW4YwdNMX603biXTZJPasstaT8Z3D5nE+hCQSmTo5X4S6kzus0MjknD17AyYeJBh
         8Jj14gQ/G+5oWVqK1kvTrh2PtLR5i6DWVVQ1DVwA1LP0lqdxo2j4+zIjPsDwNsnmopyg
         nKztammPfuueKM02UTfIhfRHIkP6gBcP74YaFhLlHA5VikPMJ4wF6OKvbyNfJJ9qMrt/
         sdE5yl+hPGTyfHJMGy1bPZiAR3A7E/DW/t/UOGl+RpCxbL2Uf6fVHvRdaMXacqz8yz7D
         shEQ==
X-Gm-Message-State: AOAM530s2gwPF3Taa/i2pZsnOs9aV3fHgLUNMEkxMQVGWq6iN3Qu8nsh
        DOgN4qEH/f/EdONuZYT2WZIqs1NgdbyZeA==
X-Google-Smtp-Source: ABdhPJyliGQqrwWqp6iwPBMaICqT0yFrn0GpFSp/8ks8wVgnXMrUilhQ8piWALZtZVElBiKgLndiEQ==
X-Received: by 2002:a17:90b:4a81:: with SMTP id lp1mr11276682pjb.124.1634872497540;
        Thu, 21 Oct 2021 20:14:57 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:c1c6:6862:17ea:e60a])
        by smtp.gmail.com with ESMTPSA id t3sm6540766pgo.51.2021.10.21.20.14.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 20:14:57 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] src/device: Fix glib assertion
Date:   Thu, 21 Oct 2021 20:14:56 -0700
Message-Id: <20211022031456.373471-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the assertion by resetting the GError variable to NULL.

bluetoothd[370193]: GLib: g_file_set_contents: assertion 'error == NULL || *error == NULL' failed
bluetoothd[370193]: ++++++++ backtrace ++++++++
bluetoothd[370193]: #1  g_logv+0x21c (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6) [0x7f314559455c]
bluetoothd[370193]: #2  g_log+0x93 (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6) [0x7f3145594743]
bluetoothd[370193]: #3  g_file_set_contents+0x68 (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6) [0x7f3145577a68]
bluetoothd[370193]: #4  store_device_info_cb+0x3b6 (src/device.c:475) [0x55be0a3591e6]
bluetoothd[370193]: #5  g_main_context_dispatch+0x14e (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6) [0x7f314558d04e]
bluetoothd[370193]: #6  ?? (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6) [0x7f314558d400]
bluetoothd[370193]: #7  g_main_loop_run+0x83 (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6) [0x7f314558d6f3]
bluetoothd[370193]: #8  mainloop_run+0x19 (src/shared/mainloop-glib.c:68) [0x55be0a394149]
bluetoothd[370193]: #9  mainloop_run_with_signal+0xf0 (src/shared/mainloop-notify.c:190) [0x55be0a3945b0]
bluetoothd[370193]: #10 main+0xabc (src/main.c:1212) [0x55be0a2d9d9c]
bluetoothd[370193]: #11 __libc_start_main+0xf3 (../csu/libc-start.c:342) [0x7f314521e0b3]
bluetoothd[370193]: #12 _start+0x2e (/home/han1/work/dev/bluez/src/bluetoothd) [0x55be0a2dac7e]
bluetoothd[370193]: +++++++++++++++++++++++++++
---
 src/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/device.c b/src/device.c
index d5aae9576..f3cd69003 100644
--- a/src/device.c
+++ b/src/device.c
@@ -399,6 +399,7 @@ static gboolean store_device_info_cb(gpointer user_data)
 		error("Unable to load key file from %s: (%s)", filename,
 								gerr->message);
 		g_error_free(gerr);
+		gerr = NULL;
 	}
 
 	g_key_file_set_string(key_file, "General", "Name", device->name);
-- 
2.25.1

