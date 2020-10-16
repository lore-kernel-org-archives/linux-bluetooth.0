Return-Path: <SRS0=5gFq=DX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B2AC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 03:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C38BA20789
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 03:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG+OFdBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgJPDC6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Oct 2020 23:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgJPDC5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Oct 2020 23:02:57 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5484FC061755;
        Thu, 15 Oct 2020 20:02:56 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id j7so813667oie.12;
        Thu, 15 Oct 2020 20:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=McYZZik4fIHL0VEeWhKi1o+kiNuK7LpqqmBBnYMHOL4=;
        b=UG+OFdBfdcOPb4hcq9ram7HV+hj/jj9uvNXAKIZZktB5iqzxxgpv/p0IMCsDbfV7SC
         KMPz4oQ7hGa8eLYAaKacDgghYC+cI7Zj2kX5BxhM1YMrV0FyzeOqD6TdwLeneqIFXeV7
         hI14EPeM+JgFoAxWq5fDvbYIhqeY5yW3zsLqLU9/x6Au8v03y2XLjZRX9mz1l3jJgpPw
         Y7p91KqZtMbxSVULE+lASrhPJNlC88gUvnzQ0I2ji0YMVeimup1RWBBmH9mEhbCqPIVD
         djme8SgwRz5pItH/9NBTYHS4MdTL77OVDkrhO5DSEBb0wZeGCJMCjIwxgp6a6WKh2o4V
         6D3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=McYZZik4fIHL0VEeWhKi1o+kiNuK7LpqqmBBnYMHOL4=;
        b=ldximWZpdX6Bhftv/OxLqHsxnw+jEHDD/C3bHihUvLUZpr/kmv9NFtXV5k3dmUH9kW
         fBCZUw2jV9RFOy1Eo/sUZDuB2Rq6KgeFWoxcvsByo5G4We/mzeaVV3HQULIYLrEY/yPC
         LKmDTzbY+1J0RKQh56J8CP5ZVqTwHoE0QoSrt3nwd+OLQKjfLeCeCHCuiYy6HQ7zPjck
         n1NPv2EgXyzCqMk9cMWQ4gd3Pw01jdGlcCFVBu7NpbfybdzVWeoi2p3j9KESCsZCCUfD
         qB1qph+46kCbtwn3q8n4B4B2EjYjylvbYxZQ/Wteyr7dZazLtFDeprRwRbpMExAjbn8j
         T8bA==
X-Gm-Message-State: AOAM531S1TE1TM4zafoL8g5oa862eyX5LpFiv8m2ZKBI8EfQu3BxdKfJ
        Dx5+ude/FEruS7ubn0lxd3o=
X-Google-Smtp-Source: ABdhPJzMbKPMOT8ic7315SSWAFHBV1F39iCs0xE1BAB4TIwDF8Th+O8Mmbc0MCwoFjpr6La5yMAeOg==
X-Received: by 2002:aca:7210:: with SMTP id p16mr1061996oic.77.1602817375546;
        Thu, 15 Oct 2020 20:02:55 -0700 (PDT)
Received: from localhost.localdomain ([170.130.31.90])
        by smtp.gmail.com with ESMTPSA id x15sm601662oor.33.2020.10.15.20.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 20:02:54 -0700 (PDT)
From:   Forest Crossman <cyrozap@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     Forest Crossman <cyrozap@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add support for LG LGSBWAC92/TWCM-K505D
Date:   Thu, 15 Oct 2020 22:02:38 -0500
Message-Id: <20201016030238.1033559-1-cyrozap@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The LG LGSBWAC92/TWCM-K505D/EAT64454801/EAT64454802 (it goes by many
names) is a combo WiFi/Bluetooth module that's used in several models of
LG TVs. It uses the MediaTek MT7668AUN, which is already supported in
btusb, but this device has a non-MediaTek USB VID so to get it to work
we just need to add it to the list of devices to probe.

Signed-off-by: Forest Crossman <cyrozap@gmail.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5f022e9cf667..58259b6a43c7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -366,6 +366,7 @@ static const struct usb_device_id blacklist_table[] = {
 	/* MediaTek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0e8d, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_MEDIATEK },
+	{ USB_DEVICE(0x043e, 0x3109), .driver_info = BTUSB_MEDIATEK },
 
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
-- 
2.20.1

