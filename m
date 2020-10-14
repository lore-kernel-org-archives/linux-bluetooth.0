Return-Path: <SRS0=CDO+=DV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5525CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Oct 2020 12:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E46F5208B3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Oct 2020 12:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AM20Glar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387910AbgJNM3I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Oct 2020 08:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387863AbgJNM3F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Oct 2020 08:29:05 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA04C061755
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2020 05:29:05 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id c20so1883844pfr.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2020 05:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ouQ8cRYMceTUmNAA4f1Lby4MW/urEqOOQLwdbMnn3x4=;
        b=AM20GlarRQjV5iu975j1m0M15+BevoiFht+ZS7HhKqhOTnSCuT739bJb5kpoftJLX6
         w9gT3LdUHprcCIh9HBR2XC5JNPdY0bYKITHujhtKCvuF3kmiJi1kworjxHy9n2JXCOMI
         5FChroKaPnhBRty470IbWw9YjcpgRLNPLsPD62uhx3s3O0TU28ElqIC6oa3eDWuWKuEu
         Xd0lZK/oXHKU8xn7f4KLBNVsN1jUC13xzBR3YWBnyTs+iVruEgvqlmk4EcQI63Zphxol
         xN9c0JWLC3sVhey1+1aGhpYkI3LttmHkKuX7zf1JwSusA9QmqWhB4vIlQw5Msi7+i1VY
         oWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ouQ8cRYMceTUmNAA4f1Lby4MW/urEqOOQLwdbMnn3x4=;
        b=Ac7irSjZZA6Ep/bXcc2Yq7KTHDt3GYMDyKA73jd5vljTxz9J1X32rEtwf0+ZbTu04t
         8p6iUI6pusIVvIJZcgu+IvB7f2IORclN604/u8XJxLOMCEBCIswqvQmJvXVLkn1+mH3s
         EQqqqIcbwAeIKFy+Ynn+2Bu+5dgcVbUArRwMPR4USq+wi2OK/ORKDruG/U/q83Lr/SRG
         jewYqdA88pMGNVY7Z8haDKsvymykvljvXhfDvyZumDG2QPBkMPiEOKm5fUDEa2aJd/yp
         aTOjoXjz9ODnedQrkWd4VS1pn1tMFzEXHMS7ih/zlmQ5G8FABXFHgukLLoo2iQfBqpUF
         0KZw==
X-Gm-Message-State: AOAM530Qx5fB6eJVXqS7v/xM7zTXX00mcle8cqzG2P2JDktb3n0jhuCD
        0HElP00360IBalQyPhZDYIscDJBwIHyN5Rcg
X-Google-Smtp-Source: ABdhPJwdOPqfb4zjnAXWNI7ikeMlGrtGN9UD/KcX1RfQN2dQ3Z2QGwuG3cMVm2r/+2AaUlDrxYL6Jg==
X-Received: by 2002:a63:481f:: with SMTP id v31mr3632949pga.187.1602678544566;
        Wed, 14 Oct 2020 05:29:04 -0700 (PDT)
Received: from localhost.localdomain ([122.179.122.132])
        by smtp.gmail.com with ESMTPSA id r16sm2930000pjo.19.2020.10.14.05.29.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Oct 2020 05:29:04 -0700 (PDT)
From:   Kiran K <kiraank@gmail.com>
X-Google-Original-From: Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     sathish.narasimman@intel.com, chethan.tumkur.narayan@intel.com,
        ravishankar.srivatsa@intel.com, kiraank@gmail.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v7 4/4] Bluetooth: btusb: Map Typhoon peak controller to BTUSB_INTEL_NEWGEN
Date:   Wed, 14 Oct 2020 17:58:37 +0530
Message-Id: <1602678517-9912-4-git-send-email-kiran.k@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602678517-9912-1-git-send-email-kiran.k@intel.com>
References: <1602678517-9912-1-git-send-email-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Map Typhoon peak Intel controller to BTUSB_INTEL_NEWGEN

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
---
 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5d68cdb..3e21d5e 100644
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

