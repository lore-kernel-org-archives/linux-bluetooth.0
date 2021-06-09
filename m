Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42051C47095
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 09:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B5A61185
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 09:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhFIJPP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Jun 2021 05:15:15 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:33452 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhFIJPP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Jun 2021 05:15:15 -0400
Received: by mail-wm1-f50.google.com with SMTP id s70-20020a1ca9490000b02901a589651424so2846375wme.0;
        Wed, 09 Jun 2021 02:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0WYc0ao3+NpZU/ZSpBxHKg9h0IZKQcqWTbNQs56vJ/c=;
        b=ViqgDK3BmEG50V+jidsfB9G2VZawD/u5PHOHqeN619EpljHkr7ezu11MVq7vBqo7EH
         wV2zFWixxcm3FmXWFr4yjrEpLGupH+90qjVAJ2Yk8gRIpeeFnKzcsol5P64lGQT2GaPq
         g5tUaIPKqjCYL0nGu8q7xkSnY1f9XmNMlQ+j+hER7oIu9tAYVWUk8FQ8XjoFOwtE60Ui
         8moYdZByNlmutX84OlatOPyFEmgvHycM4BoU7jTe1OxR3/bNd+ZAgCT8WHxcPOpQXvMf
         GDb2IjJVgUq3eukxwZrrbUlzf1SWYIBP/LjxSlYpV4V3D8n4CoNjynbqFQ23ouS4sXrC
         u0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0WYc0ao3+NpZU/ZSpBxHKg9h0IZKQcqWTbNQs56vJ/c=;
        b=JS+0fIB7msvMyFLLrSJtliaKculTZV1607EG/pIZnvwUuXNFw1vW0K5NtdI/Fz/sB6
         QNcjwxyUk9Rk63eWeH38MgcUm+IqHT98Lkqbf6IMQBfYbetAKHsqtG4DBF4eS+YogNPN
         MEGEmAMpPC/aOnQntHO+hp4m2RWVvnvZFvzGf9DwN/e8WJ1syqaB1FJxEX8kEi0JcacR
         9hjEdnOqaiyeqGTv+ntqNvJAFATM86pcQSYGP/OMIagkqVSIdcMk6AOlbtN5V5UJMJhu
         9Vc54bY47C7Vk18SaNNVhUSXZwdmms7alkNQXT7P1WNFqfWANdfbNSCGuxpqO4KbxEDX
         kKXQ==
X-Gm-Message-State: AOAM533V/iT4LqyLpSK0l4D1CD+NJ8l067VVwyCAEZOIv7rvUqjVrJEs
        rpsbQoLuL0Am2+2EnmPWCvY=
X-Google-Smtp-Source: ABdhPJw6PvSOTspXIp1VvdMaFwV5nY91mH7NCYenkSRFsxTuvCBsih/Y9B8B5dlnqOJXbOqxUl5eVg==
X-Received: by 2002:a1c:7e84:: with SMTP id z126mr1680531wmc.39.1623229927175;
        Wed, 09 Jun 2021 02:12:07 -0700 (PDT)
Received: from localhost.localdomain (190.1.93.209.dyn.plus.net. [209.93.1.190])
        by smtp.gmail.com with ESMTPSA id o18sm5219232wmq.23.2021.06.09.02.12.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 02:12:06 -0700 (PDT)
From:   Dhiraj Shah <find.dhiraj@gmail.com>
Cc:     find.dhiraj@gmail.com, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NULL check value returned by alloc_skb
Date:   Wed,  9 Jun 2021 10:11:49 +0100
Message-Id: <20210609091149.12557-1-find.dhiraj@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Return error ENOMEM if alloc_skb() failed.

Signed-off-by: Dhiraj Shah <find.dhiraj@gmail.com>
---
 drivers/bluetooth/virtio_bt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index c804db7e90f8..5f82574236c0 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -34,6 +34,8 @@ static int virtbt_add_inbuf(struct virtio_bluetooth *vbt)
 	int err;
 
 	skb = alloc_skb(1000, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
 	sg_init_one(sg, skb->data, 1000);
 
 	err = virtqueue_add_inbuf(vq, sg, 1, skb, GFP_KERNEL);
-- 
2.30.1 (Apple Git-130)

