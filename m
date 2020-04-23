Return-Path: <SRS0=6Duj=6H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08B1C54FCB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 14:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CAD120857
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 14:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e0YXc6jk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgDWOn4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726380AbgDWOnz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Apr 2020 10:43:55 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC70AC08E934
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 07:43:54 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id c17so5884784uae.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 07:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KGjHlHj2yLZ30uJ1TR1oOXoayTLW/J80Sb28kEteyy8=;
        b=e0YXc6jk4BECICTBKHOujB3/h2gy6FK1YB9/i5hoLOBXzDnjJWx+1bHUufDBDwBLHN
         oQyVXr2uB83EjqvXhjT4zxGI1vwpIzYXdwlnJMcm4tVHdhTBKwOlX2O8ndU81/4Bw8IY
         fG1t2DPcXi0HVtPHmbnFtY8HLinIjqrEU2OZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGjHlHj2yLZ30uJ1TR1oOXoayTLW/J80Sb28kEteyy8=;
        b=XbMpgoh9/WEoyD/G/mEg8aQeLJdtdYdbeQifeCjxeoU2E1AetjuNiX/M6ANt1pWPlE
         2LGYf97fRr2itGiWsYgoeDRYEOlgL1A1WCKjWfOj6uMViD8dPw5avD97uoIqPTkEY84b
         nGhdVPaDJx6Txuvy2TfKvX0A2fr+b+pULopkpmwU6EFocWMxmw3VU8Nq1OFk9yjxm2oX
         NDn7elUH8nMrE2rD/mUfLG98ZtE5E9i0rpP9o+vSmRY0QGvOsvQuvGNriNEwKBk+NQAL
         gn43ycan2Pf7qS38RJr0ccoVPZNG0R4m+lnfFIb2kZBBakmGwPFOZXkYrLJ3c5KxpAMu
         /JLA==
X-Gm-Message-State: AGi0Pua7Oxulu8hnkBsO8Gv9MndQVxVOJSL7zOUJ9TJYmwYYhfcx0nKW
        aUhaboi3l+OVuADErivcJbDnMrAQ8lQ=
X-Google-Smtp-Source: APiQypLC6nXVkzMgxPJeFkuR51s4MJewdxEKy56D0OznkAs6Sv3D3dACwCKEj/20TlXA6fEnA1AvuQ==
X-Received: by 2002:a05:6102:4d:: with SMTP id k13mr3488005vsp.198.1587653033644;
        Thu, 23 Apr 2020 07:43:53 -0700 (PDT)
Received: from alain.c.googlers.com.com (161.138.243.35.bc.googleusercontent.com. [35.243.138.161])
        by smtp.gmail.com with ESMTPSA id d83sm762107vka.34.2020.04.23.07.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 07:43:53 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v3 3/3] bluetooth:btusb: Adding support for LE scatternet to Jfp and ThP
Date:   Thu, 23 Apr 2020 14:43:31 +0000
Message-Id: <20200423144328.82478-4-alainm@chromium.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200423144328.82478-1-alainm@chromium.org>
References: <20200423144328.82478-1-alainm@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds support for LE scatternet connections to Intel's JfP
and ThP controllers.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 drivers/bluetooth/btusb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index dd27e28d4601..d801c332b85a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -335,7 +335,8 @@ static const struct usb_device_id blacklist_table[] = {
 
 	/* Intel Bluetooth devices */
 	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_NEW |
-						     BTUSB_WIDEBAND_SPEECH },
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_NEW |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_NEW |
@@ -348,7 +349,8 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_NEW |
-						     BTUSB_WIDEBAND_SPEECH },
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 
 	/* Other Intel Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x8087, 0xe0, 0x01, 0x01),
@@ -3877,6 +3879,9 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_WIDEBAND_SPEECH)
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 
+	if (id->driver_info & BTUSB_VALID_LE_STATES)
+		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
+
 	if (id->driver_info & BTUSB_DIGIANSWER) {
 		data->cmdreq_type = USB_TYPE_VENDOR;
 		set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
-- 
2.26.1.301.g55bc3eb7cb9-goog

