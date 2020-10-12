Return-Path: <SRS0=4Twx=DT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A3DC433E7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Oct 2020 08:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F1872145D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Oct 2020 08:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DP0XN9w3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgJLI1B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Oct 2020 04:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgJLI1A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Oct 2020 04:27:00 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9D2C0613CE
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2020 01:27:00 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f19so12821136pfj.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2020 01:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RaC3L0ABjKdFJIsHYOxhamtRwxamP8ZylCpgI1epGGU=;
        b=DP0XN9w3TP1d11AI7BJwNwc3f5t/8LqEUJRFurRMCQBMs2QIgHrdoqrsyTZ5fNYKxx
         Vvk93bHJ2gbA2EY16scM9BxmUR0zCp0DVEKzid8IjfWdj+wOJ0rhWa2R17apvZJ0X5t0
         rS4TolmnF3bETIvbcznGtnaESUW5cKH9JLcCshSwVrKrHpmT5V5fjfsvwrv2XLYUxsNF
         KLHe6DZVi8LTcuftLcxoP2zfFtRp2Vh1+z8++VVfziWF93zZWUR8tA09/Pu7S2sTg/iO
         Xn0Kvo3bkqs5FNzM1iUdKdwfw+GlJ1TOu4NW84sgwKukdQ8Ir85BiexAzF8i3v/o8LbO
         hZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RaC3L0ABjKdFJIsHYOxhamtRwxamP8ZylCpgI1epGGU=;
        b=C1JydJO1vdgicRQZ+REpGMYV12L0lgqmHBCyTUhESNSjrSrOEUf0jKxHGtfCuDdYbt
         RiEp4IM+UCV7BejAneL8ExKiZsjlly3BLfQ2lf2tPnAeL9z3g7hYzxqkRnaRLKXiEtCn
         W+Gs/8RLoz054EoDDBuI4dVFX8vXmvHDYR1QTuxk31VVxwSjsmFssjEvGyPUNWv/Z34X
         PjPRTmbwrwePEbOKF5G9TOFvAt3qjZDr6tF0doxADLoTkXlNCvLY/13Av+k/rxJ+FXg9
         idHw9qd5tEiQUCsyEL0Z9yjXDYAvxiMku8bf6kj6G0BcW5cYYV0lvMuwrPROxSmNdyc3
         CPSA==
X-Gm-Message-State: AOAM5320RnB26DzPDK0eUZw51x8NRQG+OF5qiy3vYovz+cvP375xhIBE
        aX9yTAwmVbhkuXY9Z9mqLCr7whXgm4Wm8w==
X-Google-Smtp-Source: ABdhPJyPnSwwy5YKOxfo9ruzCzQtqevRGsTcRfgXlr2mRhjQHDJDZtJFcAhWY5FkReZu9G1Y0rdaEA==
X-Received: by 2002:a17:90a:c68c:: with SMTP id n12mr18831177pjt.98.1602491219902;
        Mon, 12 Oct 2020 01:26:59 -0700 (PDT)
Received: from localhost.localdomain ([122.182.224.145])
        by smtp.gmail.com with ESMTPSA id 128sm10809974pfd.110.2020.10.12.01.26.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2020 01:26:59 -0700 (PDT)
From:   Kiran K <kiraank@gmail.com>
X-Google-Original-From: Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     sathish.narasimman@intel.com, chethan.tumkur.narayan@intel.com,
        ravishankar.srivatsa@intel.com, kiraank@gmail.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v6 2/2] Bluetooth: btusb: Map Typhoon peak controller to BTUSB_INTEL_NEWGEN
Date:   Mon, 12 Oct 2020 13:56:40 +0530
Message-Id: <1602491200-16493-2-git-send-email-kiran.k@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602491200-16493-1-git-send-email-kiran.k@intel.com>
References: <1602491200-16493-1-git-send-email-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

A new flag BTUSB_INTEL_NEWGEN has been defined for new generation Intel
controllers. Map Typhoon peak Intel controller to BTUSB_INTEL_NEWGEN

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1082736..5e51749 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -366,7 +366,7 @@ static const struct usb_device_id blacklist_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_NEW |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x8087, 0x0032), .driver_info = BTUSB_INTEL_NEW |
+	{ USB_DEVICE(0x8087, 0x0032), .driver_info = BTUSB_INTEL_NEWGEN |
 						     BTUSB_WIDEBAND_SPEECH},
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
-- 
2.7.4

