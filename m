Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A817C12002
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jul 2021 00:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 732A0613C2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jul 2021 00:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhGOAiZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jul 2021 20:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhGOAiY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jul 2021 20:38:24 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD55C06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 17:35:31 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id j199so3524037pfd.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 17:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=maz5Id7GN+kd9MSFFSJeDZW5ZeqTYNSfGoJr7u2cTOs=;
        b=R6Y9j/0kFkbRi+sduMF4dUKWCfL8WYv6usVfywtERedqCc+Cq+pGVziOxL2MWH6qYp
         /WhuwLoN4a4IRjOezgrsdcYB/1i6iUeRev6Bf3SLvOCiTZcLAKfQVSN5p44lUn9vlADE
         XzEfb7tZ1z0pGPyNnAeVCVN5Q+7Xa4y0Lry/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=maz5Id7GN+kd9MSFFSJeDZW5ZeqTYNSfGoJr7u2cTOs=;
        b=iUmGu7cAWq7pJCiqRlzp2DMmHf0ZYHY5QHMbEmRucUqp387EeutirazPiqzNWkO4mE
         a3TpPHjmeeCbGJz9GE6cSEv6EMCNtatA4p2+Di7Rdd2r1TZdNxKNQube7gCNzdS1MmFS
         gx2ANjVNFKB/McHzzHw5y/tMsYPsdZJaRn5mc1yPD5jazcadE1xD8xQRzwBi9bIglo2N
         qASctYTRS9wsnkfUWvEsAhyIEbhvxe1TAzR0cLslY0IFgnZhlZZIRc6g0SshAMuLAKqS
         mrUguQW4DIJu0f6i1eh5QsQcgZJk7FGK8hxkemLLSKbJOwFippflok9Ehpcbc/U8JYs3
         cIZg==
X-Gm-Message-State: AOAM5331FuoaXVkNT1iZIzXULIq8n7+vQuJru0WbXj3P9IyfYXvR3PMq
        1gaw+C4zbvjqC5bzVCmIywlf82f9HRjJBw==
X-Google-Smtp-Source: ABdhPJwAZ6GhXsVUseFUuZThxNUg5OUv7P/ZRrqS5pVG8r4ZG2dZFrl13MUuLp5xVm44VR9w6ZDUSA==
X-Received: by 2002:a63:3d0:: with SMTP id 199mr751809pgd.159.1626309330851;
        Wed, 14 Jul 2021 17:35:30 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:93fa:43e6:d832:c6a5])
        by smtp.gmail.com with ESMTPSA id j129sm4164909pfb.132.2021.07.14.17.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jul 2021 17:35:30 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH BlueZ] monitor: Print EIR of Extended Advertisement Report
Date:   Wed, 14 Jul 2021 17:35:21 -0700
Message-Id: <20210715003521.2222-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It's useful to be able to see Extended Adv's EIR flags just like the
legacy Adv.

Change-Id: I4805e589837733e7ecf9d33218e4135e8f822a7c
---
 monitor/packet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index fbde71101..51c0bacae 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -10602,6 +10602,7 @@ static void le_ext_adv_report_evt(const void *data, uint8_t size)
 		print_field("  Data length: 0x%2.2x", report->data_len);
 		data += sizeof(struct bt_hci_le_ext_adv_report);
 		packet_hexdump(data, report->data_len);
+		print_eir(data, report->data_len, true);
 		data += report->data_len;
 	}
 }
-- 
2.31.0

