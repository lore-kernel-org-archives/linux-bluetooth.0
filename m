Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910D1ECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Sep 2022 17:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiISR5G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Sep 2022 13:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiISR5F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Sep 2022 13:57:05 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61C92126A
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 10:57:04 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so6867762pjh.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 10:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=W7vEFLk6QOfSRmXvCpDLpduid5L6BjW+taPCJs38jnI=;
        b=LviMVcqr/wwIaze+cqG6AXrxv1MqWLhNq6oEaT9bZWIx+0I6sLrJgalldIoFjZbFUM
         7r+MSYaFENO2Ki1E0H9rXj/FSX3fpXQpBxDNvIMkwGm/mbTyA8rIEt0r3tCGqBtOsnBy
         b1rTA1kX6Hm7B0k5ln/w2X5wHhK5WmiKm2NEUgUx/OEngyAYpUNEUhxCrTRXL1VkPhn4
         Z9EsGMQ1IRG/udWFdwTSyJK6enA6wFc9QT5Fsr5Ps1hkPXlMLJnNU/Bh0/PXGYWAr+PI
         ZMhQ9EBU1K6g1QkCFOC/HqxKx+R4Fn2CqtsMQfsfCsch3i39WEq55J2f+blEcpbvPvfl
         Wriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=W7vEFLk6QOfSRmXvCpDLpduid5L6BjW+taPCJs38jnI=;
        b=ytYMWlWkspdI/3FqZowhhacZ9ER62suNEwFTrLqi8JZDzQPPRUNzhmXz8kcJrmhH8Q
         rLUgcPq0QbSM5yYvC7cnupUUO3gv0ohLqcxa4XWNNc0eW8iiYLcdo6Azhq9CRU5bijWN
         LYU1liJNMnxCU27Gyv3lbRgQqJkCLlty/VHeP9BUwwwaA8nKh3wRHRw5VM9HdOr2j8Ns
         a0x1IPcbEiKcnOAMNk4Lz2RWhcyQl8jt7BitFj2tlsAiAou+WPYOwUx9oE7hbFTzccQx
         5GEpF6iujYxY6DpLHLsmA5CBVGz1B2Aa2+Cnu+kHKEQv0MjbrJBNkZ/zel3+D4xHbapn
         E94Q==
X-Gm-Message-State: ACrzQf04fJ57C7ToRJo5rpkGnd+zBGZvkoyqfIN0XvCon6AgA+7P0ntI
        vw4db8R6ALH+iA5Rai1MX8K1zPQhQDo=
X-Google-Smtp-Source: AMsMyM4FifZNfZJlFu533cNJEhLWF1v440PPvT2o99ZYJ/9scgpRsmXR3et3h/OlJbNV9fnRn9mzyQ==
X-Received: by 2002:a17:90b:3a87:b0:202:d8b7:2c03 with SMTP id om7-20020a17090b3a8700b00202d8b72c03mr32600086pjb.199.1663610223810;
        Mon, 19 Sep 2022 10:57:03 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a1-20020aa794a1000000b005361f6a0573sm20579120pfl.44.2022.09.19.10.57.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:57:02 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: hci_debugfs: Fix not checking conn->debugfs
Date:   Mon, 19 Sep 2022 10:57:00 -0700
Message-Id: <20220919175700.1649726-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220919175700.1649726-1-luiz.dentz@gmail.com>
References: <20220919175700.1649726-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_debugfs_create_conn shall check if conn->debugfs has already been
created and don't attempt to overwrite it.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 902b40a90b91..3f401ec5bb0c 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -1245,7 +1245,7 @@ void hci_debugfs_create_conn(struct hci_conn *conn)
 	struct hci_dev *hdev = conn->hdev;
 	char name[6];
 
-	if (IS_ERR_OR_NULL(hdev->debugfs))
+	if (IS_ERR_OR_NULL(hdev->debugfs) || conn->debugfs)
 		return;
 
 	snprintf(name, sizeof(name), "%u", conn->handle);
-- 
2.37.3

