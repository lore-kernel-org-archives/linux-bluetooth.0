Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9C0CD37AF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Sep 2023 23:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbjIOXs3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Sep 2023 19:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbjIOXr5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Sep 2023 19:47:57 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534542119
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 16:47:48 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-79834a7a5d8so94037039f.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 16:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694821667; x=1695426467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gExfKyu4P+fXvrhV3DJ9X7Q/b/774ORr0erJfRAHkMQ=;
        b=e509Whwql6g42F0fL3Slzp4soqTaAs7heasjIwNIkfWl5JXA8GTCzIz+5iWXEEeYvI
         k0uOh/iyr3fLxYqsTprL6o0CVrX+D6iFupjIjT6WPse5UicsKrDGk2GEn8Fk4Tmc1wGr
         pygEcCbwVA9KsA9nwmDPQvX395bNCvlXt739PWn+HRcjX16GlAgwjQSxJodBzArAD/hS
         IddFNw4RMGyLLpwNfjYIvTR3Vr08aZ7fLSZWeN3cE4bD27aOwkD2F0CmRuLi0AfjmRC2
         qhCXNFINQiCuJ3+egvsHts4silgXsWq6nRCTw8UK+G5f3tjLD9TvAP6c/ZQRe335LfMe
         57hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694821667; x=1695426467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gExfKyu4P+fXvrhV3DJ9X7Q/b/774ORr0erJfRAHkMQ=;
        b=TRz8cxGyZGlrpqTfqTn1kAwjWSjjRlko/Ux2Ea15WjyIlFQFzxZhTBbhyK4xT78uJW
         l3ttL41FTsqG/lPD5yvy5bhgZNSVW5FlCIlWVdo9YNQt/ZcB4kcg20UrwJ9j1UC2pDfP
         wYzItlslIS1UOs0dLuLtnLoVay22xGrKIT+O1BpDzz9BEzS1nD6yreYKMvB81yWo/L4W
         FqVrYDTL2dcPM1DZf7I4HzhnxwhbiMs+uuK3Wy7bq3l+xIxSzx9K1OtBr//LgTzLjFs9
         rnvUGKZUG1SSDXh1uFDGBAmSsequnCUMaB5pj0iDNHjltJagUjTDvSk1iw7H7q0F+j6U
         3hXg==
X-Gm-Message-State: AOJu0Yw6dToAQcI0A8CKaWfOjfF2vQ3vGAEpcgkOE+wOKDHOXqGMsqpm
        fMt8dubmTuIdCdfPTxbeypLAoVbIrMU=
X-Google-Smtp-Source: AGHT+IHXWhRHRayR7aQNSH7HbVJBr1XxZPSa5iy0u7LhQ7xJMvfsnD9dETY9FRw3zIVHMVcouFNakg==
X-Received: by 2002:a05:6e02:b23:b0:34f:4300:8839 with SMTP id e3-20020a056e020b2300b0034f43008839mr4565828ilu.28.1694821666746;
        Fri, 15 Sep 2023 16:47:46 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id k22-20020aa790d6000000b0068fdb59e9d6sm3438129pfk.78.2023.09.15.16.47.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 16:47:45 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/2] Bluetooth: hci_codec: Fix leaking content of local_codecs
Date:   Fri, 15 Sep 2023 16:47:42 -0700
Message-ID: <20230915234742.3739283-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915234742.3739283-1-luiz.dentz@gmail.com>
References: <20230915234742.3739283-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_event.c | 1 +
 net/bluetooth/hci_sync.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9e89843c259b..195aea2198a9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2786,6 +2786,7 @@ void hci_release_dev(struct hci_dev *hdev)
 	hci_conn_params_clear_all(hdev);
 	hci_discovery_filter_clear(hdev);
 	hci_blocked_keys_clear(hdev);
+	hci_codec_list_clear(&hdev->local_codecs);
 	hci_dev_unlock(hdev);
 
 	ida_simple_remove(&hci_index_ida, hdev->id);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d532f4c139f9..d242f956dea8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -33,6 +33,7 @@
 
 #include "hci_request.h"
 #include "hci_debugfs.h"
+#include "hci_codec.h"
 #include "a2mp.h"
 #include "amp.h"
 #include "smp.h"
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 1be5763c261c..3640d73f9595 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5074,6 +5074,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	memset(hdev->eir, 0, sizeof(hdev->eir));
 	memset(hdev->dev_class, 0, sizeof(hdev->dev_class));
 	bacpy(&hdev->random_addr, BDADDR_ANY);
+	hci_codec_list_clear(&hdev->local_codecs);
 
 	hci_dev_put(hdev);
 	return err;
-- 
2.41.0

