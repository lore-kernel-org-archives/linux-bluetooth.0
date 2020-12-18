Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAEEC4361B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 19:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B30723B83
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 19:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgLRTHm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Dec 2020 14:07:42 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41072 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgLRTHl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Dec 2020 14:07:41 -0500
Received: from mail-ej1-f72.google.com ([209.85.218.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dave.jones@canonical.com>)
        id 1kqL5f-0004GJ-IB
        for linux-bluetooth@vger.kernel.org; Fri, 18 Dec 2020 19:06:59 +0000
Received: by mail-ej1-f72.google.com with SMTP id s17so1207903ejm.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Dec 2020 11:06:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jx62sIYKnFhcgAdqyjVTawTLwOoFSw9tBfRQFyWi7nI=;
        b=HpqLngmYOliP46JL7f4C0wxZzEE+friAh3GN8YxtSvqfqJ/DQkpNxuyqucwQ2IdNNC
         U0SUFhPCSzeqNy6GAd0mo9bPvuCd2cAw5FYWElMqMcJ3RNB2QnDezyxlUDYHQbDNjBF8
         HKT05LbzFOcjjzXm5oeIukUoFjODo6EqM9Og9DOLtnFIzOxIltvLPiYdRFY5XSd5KLtK
         kDHCW1VRYwJmILG8c1Y8Rjyw/nOl5nJ9B0DKxp83PrLrruv/DF09ZvTNzhv0HPrjHbgy
         IN4EPvwxxN6LbOccsAA0cBKdCkuM6pmOYV1487cF7ZQuAFztezEdao6bnTaD6VaT6crY
         nTAw==
X-Gm-Message-State: AOAM533J4u9XdcXoPd47M2jVoGfUfrcesmyBADcT0W/InKYXQBBBolz+
        y4F9O/LTBAXLw5CdsHyFqUvFujFzMC0ieXyS0wUsFT6glIPANvALu3BQ1T+3RbIBotYk/eklvM8
        4ThmLJSPbgw8xRf3qBwN6jbO9YgTip5+OzNr6YuqrfFohtA==
X-Received: by 2002:a17:906:7fcd:: with SMTP id r13mr5575889ejs.242.1608318418952;
        Fri, 18 Dec 2020 11:06:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1SwuevLssLE71wYTes2YuLNBTYWmySzJ1eBwYokc8peD+EegjXE8K5ELxBC039EhzhXFHng==
X-Received: by 2002:a17:906:7fcd:: with SMTP id r13mr5575866ejs.242.1608318418770;
        Fri, 18 Dec 2020 11:06:58 -0800 (PST)
Received: from localhost (waveform.plus.com. [80.229.34.140])
        by smtp.gmail.com with ESMTPSA id zn5sm5943127ejb.111.2020.12.18.11.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 11:06:58 -0800 (PST)
From:   Dave Jones <dave.jones@canonical.com>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Dave Jones <dave.jones@canonical.com>
Subject: [PATCH v1 2/3] bdaddr: Treat Cypress devices as Broadcom
Date:   Fri, 18 Dec 2020 19:06:08 +0000
Message-Id: <20201218190609.107898-3-dave.jones@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201218190609.107898-1-dave.jones@canonical.com>
References: <20201218190609.107898-1-dave.jones@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Adds an entry to cause bdaddr to treat Cypress Semiconductor devices as
Broadcom devices; Cypress (vendor ID 305) acquired Broadcom's (vendor ID
15) wireless division in 2016.

Signed-off-by: Dave Jones <dave.jones@canonical.com>
---
 tools/bdaddr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bdaddr.c b/tools/bdaddr.c
index bc0478d46..de17416e9 100644
--- a/tools/bdaddr.c
+++ b/tools/bdaddr.c
@@ -303,6 +303,7 @@ static struct {
 	{ 48,		st_write_bd_addr,	generic_reset_device	},
 	{ 57,		ericsson_write_bd_addr,	generic_reset_device	},
 	{ 72,		mrvl_write_bd_addr,	generic_reset_device	},
+	{ 305,		bcm_write_bd_addr,	generic_reset_device	},
 	{ 65535,	NULL,			NULL			},
 };
 
-- 
2.27.0

