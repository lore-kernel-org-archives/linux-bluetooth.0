Return-Path: <SRS0=rXBD=UF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30ABC46470
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jun 2019 11:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA3E207E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jun 2019 11:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="EwrT+obd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfFFL7P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jun 2019 07:59:15 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44693 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbfFFL7O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jun 2019 07:59:14 -0400
Received: by mail-lf1-f68.google.com with SMTP id r15so1317458lfm.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jun 2019 04:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zIbNxTZnuAUxlVfaMi3+noYL7MgduvDP49IaZScpHDU=;
        b=EwrT+obdhTdK2ZJfDXF36x3YgAv0w200Wwth5mWSnLWTLOr894c6rwWECkSY7hmphK
         tEz8z7uxVT7ZwcSMbcjZbr43a08EoC7E/o67ViBL/wF5qlU/D8pCdPHoyGGCkTHnJYAc
         DOm6k6dknoMNYo2wvPplN1aeAaK0/H/nuYgQhU6leLKH8m8LyOXMSb17WNaXtlLFfGt1
         PPljsqcx4CookVWLUrbScFBGJT7Amq/opoPgGeWnvTrwACAsOS+L5szrNEs2nIGaE/WS
         ssE95Cwi5CWHswi0L0Lee+Pm7fIXxR1G2Xe94cpOuDU4RLW3yga5WwJulM8aVDXsnEhh
         ZxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zIbNxTZnuAUxlVfaMi3+noYL7MgduvDP49IaZScpHDU=;
        b=pZP5wZC3obAzTTNrA/0oG6qis8Ik/Gwwlg6PVCKOHYqBMmUSufmQVvBKU1Lb7r6MPU
         4Ny9/rojmzPt34GIi7soZomEPH3g+tClsKL1LaRQ9iRXVfJYIvhHdu2NBLlGU9TOFncQ
         yTOzaSyOR0+gg31t7ZSjgvlhDU0HLj3NKea6XMzqI5LSazsCvbAZ7IeVfujrAZfgnK8K
         3S/fMd5+5fqAxGafWcmeyVc4YDsnFn1wtVFHOM8TGLrr2FpDEsB1wVq6Q8W5Hp5kiZQ4
         RdT4zy57PULZ35G3NClApqmzuNOusar/gZzTkL0CnuxpVHjFqaN+/xwDf/JMJbWjaQEl
         BKCw==
X-Gm-Message-State: APjAAAXQ5AkW5UwG1QtlKZ0Er6B55Ew/i86B9TZbcgQVn0T2hUgTc5Ul
        BIEamizvB3qPT/kyCAhUzGa7DYiQIUUviw==
X-Google-Smtp-Source: APXvYqyFx8GCG1wTwSi+ruUIBhkjgqM/4gzTntOk1q6k+ACS5wtfpCPy10bRRUB7tLo89HHuyrjfVA==
X-Received: by 2002:a19:8c08:: with SMTP id o8mr4929385lfd.57.1559822353187;
        Thu, 06 Jun 2019 04:59:13 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id d5sm262170lfc.96.2019.06.06.04.59.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 04:59:12 -0700 (PDT)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ 1/1] mesh: Fix segmentation fault after adding second netkey via NET_KEY_ADD opcode
Date:   Thu,  6 Jun 2019 13:59:06 +0200
Message-Id: <20190606115906.9262-2-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606115906.9262-1-jakub.witowski@silvair.com>
References: <20190606115906.9262-1-jakub.witowski@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Segmentation fault was caused by passing subnet pointer to the
start_network_beacon() which was NULL
---
 mesh/net.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mesh/net.c b/mesh/net.c
index c7aff9ab4..87a861bf0 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -1017,6 +1017,8 @@ int mesh_net_add_key(struct mesh_net *net, uint16_t idx, const uint8_t *value)
 			return MESH_STATUS_SUCCESS;
 		else
 			return MESH_STATUS_IDX_ALREADY_STORED;
+	} else {
+		subnet = subnet_new(net, idx);
 	}
 
 	status = add_key(net, idx, value);
@@ -2490,7 +2492,7 @@ static void net_rx(void *net_ptr, void *user_data)
 	int8_t rssi = 0;
 
 	key_id = net_key_decrypt(net->iv_index, data->data, data->len,
-								&out, &out_size);
+			&out, &out_size);
 
 	if (!key_id)
 		return;
-- 
2.20.1

