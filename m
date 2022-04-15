Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7694C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Apr 2022 21:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355126AbiDOV0e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Apr 2022 17:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355072AbiDOV0Z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Apr 2022 17:26:25 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F4FE1252
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 14:22:55 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id k29so8592909pgm.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 14:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=b5Twos+p4hSu1P5iPCm13kYMd+uhzpPNeflKVvMpzNE=;
        b=TBRUx1oGPuxqc1MGOV9C2Si7nU7ebFtVqVq4ccCEm8H2L9gIyy6wYOX9hFAO68DN3T
         83wVVuQxyZ5iO7UPvWIkU8TdggRcMv0CFcv6NfL8Z0uWNWNajar44cc2FbKXkCP1vtgH
         SYYDZGjI9J4QYQsZUmMpC/XWpePJy9GVtsTZY9I8DKcRKgJJX5UVe/QTYY9NPgU8WRco
         quI85XmzGecZXL7SdbI/+95CivaWmL4Ff9XhwnVEuSPF6/mY/op1dZrnhYCGhT4JvUrq
         MdfJh0bJUEi8kBqJuwGNJzRVUxPATG5jjjBp+zv36Y6tFkqpkhKkcducNdk2dgM2rYvq
         t4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b5Twos+p4hSu1P5iPCm13kYMd+uhzpPNeflKVvMpzNE=;
        b=Ug3UUBzNvSznl/7zXmqRPbBiPOccnnrtRBCUCOoQJ0WPzxoIaIOZzDREpt222iQ3XD
         DK7PC8CJvfT4XipcWGp9IQ/LCJLi8OBXLXa1VuuhyxzmF0FoGKPfmAqLB7YUkvzJwM60
         J71WReU+Q2tuW+1NgrITIlMbnllWn2NdHqnGSShVTLBuk9BOlj/9GAQwX/3Kta8whB++
         JpgJ9ZWhaIPsdaZcARri/QDHUDx0Mq8GqNV5k+Jr2n/QONAC43eo1O7mTCLIIFW/91Wr
         7Pq7CROmfGCOKJPlhhIAmhvJJXKe0zVNG9+86VG+g30m9hN5MJ9fjegx0F3uUYlbN9f4
         acDA==
X-Gm-Message-State: AOAM5300pXDHl3Eur/CDNqvDEDEcQt/SJfmqulQd4NSeFqzNfh0IOyqK
        UTu8gbduGkU8Q2/Kd9nJ9mVbpyiNItg=
X-Google-Smtp-Source: ABdhPJx8N92dMxr1wDSJsQX9E0Mlx2AdKKG8zBB4AIby+ZZmh4vtYpvAJQrL1I/wJeNnZf63epv4qA==
X-Received: by 2002:a65:6955:0:b0:380:64fd:a2dd with SMTP id w21-20020a656955000000b0038064fda2ddmr664339pgq.383.1650057774565;
        Fri, 15 Apr 2022 14:22:54 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f4-20020aa79d84000000b00505f920ffb8sm3740494pfq.179.2022.04.15.14.22.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 14:22:54 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] build: Make use of StateDirectory and ConfigurationDirectory
Date:   Fri, 15 Apr 2022 14:22:51 -0700
Message-Id: <20220415212251.1065432-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415212251.1065432-1-luiz.dentz@gmail.com>
References: <20220415212251.1065432-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of StateDirectory[1] and ConfigurationDirectory[1] to
inform systemd what those paths are used for instead of using
ReadWritePaths and ReadOnlyPaths which can lead to issues.

Fixes: https://github.com/bluez/bluez/issues/329

[1] https://www.freedesktop.org/software/systemd/man/systemd.exec.html
---
 src/bluetooth.service.in | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index f18801866..4d39ad49d 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -15,12 +15,12 @@ LimitNPROC=1
 
 # Filesystem lockdown
 ProtectHome=true
-ProtectSystem=full
+ProtectSystem=strict
 PrivateTmp=true
 ProtectKernelTunables=true
 ProtectControlGroups=true
-ReadWritePaths=@statedir@
-ReadOnlyPaths=@confdir@
+StateDirectory=bluetooth
+ConfigurationDirectory=bluetooth
 
 # Execute Mappings
 MemoryDenyWriteExecute=true
-- 
2.35.1

