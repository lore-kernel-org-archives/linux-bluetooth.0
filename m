Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A63C2BBD5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 19:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20E2723B83
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 19:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgLRTHk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Dec 2020 14:07:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41068 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgLRTHk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Dec 2020 14:07:40 -0500
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dave.jones@canonical.com>)
        id 1kqL5d-0004G3-VM
        for linux-bluetooth@vger.kernel.org; Fri, 18 Dec 2020 19:06:58 +0000
Received: by mail-ej1-f70.google.com with SMTP id dc13so1197772ejb.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Dec 2020 11:06:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yhJLkzQpegL1FhdNGvwZKI/V5yoV05cxUNpwydWM8WA=;
        b=R2yp6iuqN2kko6WpSsFYrh+UVTTR7JtVPuocfImW5xptLkCeTDiHAsNY++y9FRyFJp
         egH5xSDx4Qpur1zdnLXyeGQlVLuh8FOp64lztHAwp5snHQyCMkZbfAQi0lLjveclVOVA
         k+VygRLrS5p9RSgrfiIQqAjxY8cvNNkbrTqCXTFqrNuPY4nCBy7aUztz3Tup39TZbdSZ
         s0ekUUkQtYsWWysbO7s7I6lwETHAndNrKa1Et3qKrRGpIqVACcooRyZh+ZeUpjDLYvt4
         2mYYwAyzcESkKkrNPGlY8fMVoYYSYBCJsbk0mgN19UtjJQhT1DspYnzI06WV1s/pIEul
         uLOg==
X-Gm-Message-State: AOAM532tvr2h9bL0seXA0aeYO1AldNMpxIawSBmJDjc57NkKxFzrbXtx
        dwbgciLi+JT5I3TNC+uvY8sGWANkIHM1zOayQOorniJ2LIeeFwmwODx/Ua3NsLTDmDdu3Tsbw2u
        wgW34hdjG6JmT8bGZCxGhNReG5Xv0BFF1W/IOCj9EDW/SWQ==
X-Received: by 2002:aa7:d41a:: with SMTP id z26mr2112032edq.267.1608318417179;
        Fri, 18 Dec 2020 11:06:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFzA3R5wuCUIREezV61aYnX9Jnwv1nvHE1c3VujgrtnK0w0AGmynB+Nf2cBJGzw+NHel7UCA==
X-Received: by 2002:aa7:d41a:: with SMTP id z26mr2112018edq.267.1608318417004;
        Fri, 18 Dec 2020 11:06:57 -0800 (PST)
Received: from localhost (waveform.plus.com. [80.229.34.140])
        by smtp.gmail.com with ESMTPSA id ga11sm5884714ejb.34.2020.12.18.11.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 11:06:56 -0800 (PST)
From:   Dave Jones <dave.jones@canonical.com>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Dave Jones <dave.jones@canonical.com>
Subject: [PATCH v1 1/3] hciattach: Add BCM43xx 3-wire variant
Date:   Fri, 18 Dec 2020 19:06:07 +0000
Message-Id: <20201218190609.107898-2-dave.jones@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201218190609.107898-1-dave.jones@canonical.com>
References: <20201218190609.107898-1-dave.jones@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Adds the bcm43xx-3wire variant to the hciattach tool; this is for use
when the Raspberry Pi's mini-UART (which lacks flow-control) is used
instead of the PL011 UART to drive the bluetooth module.

Signed-off-by: Dave Jones <dave.jones@canonical.com>
---
 tools/hciattach.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/hciattach.c b/tools/hciattach.c
index 276a4e56e..503f067bc 100644
--- a/tools/hciattach.c
+++ b/tools/hciattach.c
@@ -1078,6 +1078,9 @@ struct uart_t uart[] = {
 	{ "bcm43xx",    0x0000, 0x0000, HCI_UART_H4,   115200, 3000000,
 				FLOW_CTL, DISABLE_PM, NULL, bcm43xx, NULL  },
 
+	{ "bcm43xx-3wire", 0x0000, 0x0000, HCI_UART_3WIRE, 115200, 3000000,
+				0, DISABLE_PM, NULL, bcm43xx, NULL  },
+
 	{ "ath3k",    0x0000, 0x0000, HCI_UART_ATH3K, 115200, 115200,
 			FLOW_CTL, DISABLE_PM, NULL, ath3k_ps, ath3k_pm  },
 
-- 
2.27.0

