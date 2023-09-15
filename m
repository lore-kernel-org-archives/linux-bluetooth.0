Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A52DCD379F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Sep 2023 20:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbjIOUZT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237331AbjIOUY4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Sep 2023 16:24:56 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6B2A8
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 13:24:51 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-792623074edso89108239f.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 13:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694809490; x=1695414290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ns8P9Z10HMTzOjykwX8RS5y4bUiNGwqqv6tCRmJH6Fw=;
        b=Zu66iduPLw7vXpXJOi+0GI75JzxLfhVlCTJ2DCpcbwfsl+BBlEB0W4c0SUFpR1v11E
         E96A/lduS0OnUQyfVF1MGji0b3dQjp9iwJM/SSxYHS5ZTvQsGKDFaZo/Jniuo8ipeBsZ
         rT3Oay+uQtVl6WuR0qyHm1Hv8avmALn1NIhh1bYfdvyf4mDAdjVfSmJe/Z7ekZWM0XO2
         6g+Afhgcw3lp6LjT9vjNowf0tqjriOmecWiFKS3JjvfRWll5yF9Opw3GiyjdPX9gjhrn
         3PdXJdgikqIMLqeuS7NCCLUf46aGzec99JZUGlOkvMmt8MwCIEVggHRanYv8gHhbVdg/
         uxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694809490; x=1695414290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ns8P9Z10HMTzOjykwX8RS5y4bUiNGwqqv6tCRmJH6Fw=;
        b=kwfYF3c96tQ+0C9+1nOWu+P8uNEkJWFzFmUsv6bA4+czdj0PYboE4SwPtBF1rWnIdt
         TKlh8jkD13hhY6c1CQNY+ZUgynmlEU0cgYFEFv1SxO29fa5FOUdwxC36gmERW/2JuCgU
         3efIaa82sg2dEodbiK12FnhSbxug+7p52VU/x3IOxLygJlA6DrbRRXSK9fYks+/GLKaF
         fxpaPTlNJstbOTjwNtspVpdfoFf7BQg1+JOFq1H7n9JYihz8hiWe5QlxRNqXi2J8e4yk
         B4ZJsHHhq51KfTFyzk1UQWEy5Wy/EVmKRN9hxjIv+lgMWH0bwUUc4lw8mPb7hkobAs87
         Kf3Q==
X-Gm-Message-State: AOJu0YxBAcmjVH5f+W8y78D3oX3yV9ff6VcDIcza9mYRkNGYRP7uxz7N
        CF0cw8R3+jMDirJVcaV7UGXtcvxj9eI=
X-Google-Smtp-Source: AGHT+IH6udJ60yEeGRi3rJCBAwpOythuGb7tpwepOlkx53tI89uesCUq/YauWliiknG+XRtxcZSoLQ==
X-Received: by 2002:a05:6602:4884:b0:791:ad01:3f3e with SMTP id ee4-20020a056602488400b00791ad013f3emr5584855iob.0.1694809489998;
        Fri, 15 Sep 2023 13:24:49 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id x7-20020a056638010700b0042b4b1246cbsm1273308jao.148.2023.09.15.13.24.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:24:49 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_codec: Fix leaking content of local_codecs
Date:   Fri, 15 Sep 2023 13:24:47 -0700
Message-ID: <20230915202447.3521406-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The following memory leak can be observed when the controller supports
codecs which are stored in local_codecs list but the elements are never
freed:

unreferenced object 0xffff88800221d840 (size 32):
  comm "kworker/u3:0", pid 36, jiffies 4294898739 (age 127.060s)
  hex dump (first 32 bytes):
    f8 d3 02 03 80 88 ff ff 80 d8 21 02 80 88 ff ff  ..........!.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffffb324f557>] __kmalloc+0x47/0x120
    [<ffffffffb39ef37d>] hci_codec_list_add.isra.0+0x2d/0x160
    [<ffffffffb39ef643>] hci_read_codec_capabilities+0x183/0x270
    [<ffffffffb39ef9ab>] hci_read_supported_codecs+0x1bb/0x2d0
    [<ffffffffb39f162e>] hci_read_local_codecs_sync+0x3e/0x60
    [<ffffffffb39ff1b3>] hci_dev_open_sync+0x943/0x11e0
    [<ffffffffb396d55d>] hci_power_on+0x10d/0x3f0
    [<ffffffffb30c99b4>] process_one_work+0x404/0x800
    [<ffffffffb30ca134>] worker_thread+0x374/0x670
    [<ffffffffb30d9108>] kthread+0x188/0x1c0
    [<ffffffffb304db6b>] ret_from_fork+0x2b/0x50
    [<ffffffffb300206a>] ret_from_fork_asm+0x1a/0x30

Cc: stable@vger.kernel.org
Fixes: 8961987f3f5f ("Bluetooth: Enumerate local supported codec and cache details")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c  | 1 +
 net/bluetooth/hci_event.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index db4f28d68d71..91895bfb6b2d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2784,6 +2784,7 @@ void hci_release_dev(struct hci_dev *hdev)
 	hci_conn_params_clear_all(hdev);
 	hci_discovery_filter_clear(hdev);
 	hci_blocked_keys_clear(hdev);
+	hci_codec_list_clear(&hdev->local_codecs);
 	hci_dev_unlock(hdev);
 
 	ida_simple_remove(&hci_index_ida, hdev->id);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d532f4c139f9..ee2c418f8e06 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -33,6 +33,7 @@
 
 #include "hci_request.h"
 #include "hci_debugfs.h"
+#include "hci_codec.h"
 #include "a2mp.h"
 #include "amp.h"
 #include "smp.h"
@@ -301,6 +302,7 @@ static u8 hci_cc_reset(struct hci_dev *hdev, void *data, struct sk_buff *skb)
 
 	hci_bdaddr_list_clear(&hdev->le_accept_list);
 	hci_bdaddr_list_clear(&hdev->le_resolv_list);
+	hci_codec_list_clear(&hdev->local_codecs);
 
 	return rp->status;
 }
-- 
2.41.0

