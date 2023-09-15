Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B29C46CA1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Sep 2023 23:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbjIOXWN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Sep 2023 19:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238001AbjIOXVu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Sep 2023 19:21:50 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F6C1FE0
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 16:21:44 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68fe2470d81so2443974b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 16:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694820103; x=1695424903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1YMwtIxdzoz0GddQJf6BDXnPkXKHzTmRRJmREH4GHjM=;
        b=UUjA5N7L53BPWi+X+SqlbZ+wPAYlZSaQNgBnvdTH+VBX9Xm7Zn/nG+b3Nn/O8PL0i5
         u8U/Z6pXeLH140xUuNtZwZYM6Xoh4VS6AcMdrzwHZOS/an3TAgPY3vXPTzfXG1oz9U6f
         xedzO8TQTjmMWrDPJ5eHgSf5sd7Ky1dRb3yz0v0RF4+AwEeT7dUSl8/AwTJ7QsOaeJHb
         m5C8v491SCMSfB2PT1UHWILS3KSqXvEpj/jQdNVC9/3ugZls0lb5OlcLwUcA8Pa/d4K4
         +N5jcrh9beotDkD6EzffYG1gk83W6400y4PpiZLfOe7GVhe1fK1Ea4oUmEw9EuB3SM1f
         z8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694820103; x=1695424903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YMwtIxdzoz0GddQJf6BDXnPkXKHzTmRRJmREH4GHjM=;
        b=OFc+8siV66nGQnHFwh820A728JEfgE//+aWVaMEAwbzGsoMvsTfUEx/s4JfFvukGdC
         t7Pqc7fWEyMVilNtVGLrMZyCj8qggFEUhUN5+KEj8m/6RbGDp8RJIsyS6KOec7tl4gqn
         arue7meNMNYsAomaq0zh2E911cmGi0jq25cNuSJk+DEJYRip+yMYfC9XjYT1fvuyQ6x3
         y8qPHMkrv3fKXM4JrfVOT/lhSaYsZhg7jSXWkEjYSm+fAknw9f8QA1m0yIL2Q1g9DRJc
         21wbhVTqiavI0H+6BOhmkahyVb5c7DqpMsJ5+6N8YWwZIoOVXrbCUihn7x3h3iJFeSVP
         FzTA==
X-Gm-Message-State: AOJu0YzI/y5A2vD/fzsrv5chvP4rO8kss2LLTwDAuRSAh0c1XsjrVmTC
        NFNbi8JkGLUVDAT0QT+5hKaDLxL+U+Q=
X-Google-Smtp-Source: AGHT+IEG7BkX7Nfp6bcnQGmRb43MTvjOBuTE70PvLFDVSGeEXcBQ3YUJbVBpLu0pbbMerwKx3YwZzA==
X-Received: by 2002:a05:6a00:1a86:b0:68f:bbc3:df44 with SMTP id e6-20020a056a001a8600b0068fbbc3df44mr3663619pfv.0.1694820103583;
        Fri, 15 Sep 2023 16:21:43 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id p24-20020aa78618000000b0068746ab9aebsm3583212pfn.14.2023.09.15.16.21.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 16:21:42 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: hci_codec: Fix leaking content of local_codecs
Date:   Fri, 15 Sep 2023 16:21:39 -0700
Message-ID: <20230915232139.3661778-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915232139.3661778-1-luiz.dentz@gmail.com>
References: <20230915232139.3661778-1-luiz.dentz@gmail.com>
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
index 5a7fb496297b..956346dcbf82 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2785,6 +2785,7 @@ void hci_release_dev(struct hci_dev *hdev)
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

