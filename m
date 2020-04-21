Return-Path: <SRS0=JHfm=6F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DBAC54FCC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 16:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 555FF2068F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 16:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HjwidcYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgDUQAh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbgDUQAh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Apr 2020 12:00:37 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF0DC061A10
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 09:00:37 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id z16so548127uae.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KGjHlHj2yLZ30uJ1TR1oOXoayTLW/J80Sb28kEteyy8=;
        b=HjwidcYG4n4aQPR2aBrmAaflorg+jxD3SPht/NTATIeB2J8q1jeo3bqFmEKs4154oF
         Lsa3/gbSkYicrCyCZhRQhwsnfdGN8wU5vEIAbtmthWaqj/DC1E5BGTO+wsDok1mXziUj
         hpDNkqwmK56oY0HwiTqlvkIV118msChguNPQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGjHlHj2yLZ30uJ1TR1oOXoayTLW/J80Sb28kEteyy8=;
        b=hde5pvTn9F4R9OW1aLDo+0oorlMLJw33On1dUVrwEvhgq8Qb2tr+A5flaix484dliA
         gDPkOZenLEtC+kwbjXQhe2ugcWrDOCs39nU44PNiU+62/Svn3nVmZ4WmE2hCpQGXpU9+
         DlA2WhKf+zSmR2yWZaJz4mJP3JxZ9eXgh625bdi5z/MZC1LgdE6Nj4h4qyJgzcxgW8Lb
         AYRyslHg2ifQF85wBg9Lx+wocobhFlZSfYOhkym9JblGIG1MJVo7GaSgnYOHkhjQsNtw
         zG/9S0GtjeXPPToZboOm/7gthxvICPBgk7I4jnteV4cpmnMSpB4Pui5V13ayoqsN7wjp
         96WA==
X-Gm-Message-State: AGi0PuZPh9hZv7x92IkdjvOZfGrYbpKb/mAkJ5T6erzEk5weIWKruike
        NCMKw6tAieAEWnrNhbC1LkwkcJIP+2U=
X-Google-Smtp-Source: APiQypJVN2Gt7EjydPTnVdfMObu6Q8ruOta8qcyDbOIuQQ0Sv8d66NSEL/gSb4ESEzhOUTNJC6Ljxw==
X-Received: by 2002:ab0:67ce:: with SMTP id w14mr12693974uar.143.1587484835951;
        Tue, 21 Apr 2020 09:00:35 -0700 (PDT)
Received: from alain.c.googlers.com.com (161.138.243.35.bc.googleusercontent.com. [35.243.138.161])
        by smtp.gmail.com with ESMTPSA id h16sm840074vkc.44.2020.04.21.09.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 09:00:35 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v3 3/3] bluetooth:btusb: Adding support for LE scatternet to Jfp and ThP
Date:   Tue, 21 Apr 2020 15:59:57 +0000
Message-Id: <20200421155954.137391-4-alainm@chromium.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200421155954.137391-1-alainm@chromium.org>
References: <20200421155954.137391-1-alainm@chromium.org>
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

