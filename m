Return-Path: <SRS0=5fpF=AO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC50C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jul 2020 01:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C7EB20747
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jul 2020 01:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gf70XC+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgGCBLs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jul 2020 21:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgGCBLs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jul 2020 21:11:48 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E07C08C5DD
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2020 18:11:48 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id m9so3020013pfh.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2020 18:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GR99GIZZjMuYiZzLF19Koiioj28kl/2jLD/QPVbsMmo=;
        b=Gf70XC+FENM8wk9LD/IhT3t17C7HyY4bCdWxH2/yBHTDClzfDME3YPjnA3reqYxscT
         tan/vmiTxI4TScYutZAEUAubtTfmezTcSfcMxG8/xTshXGM4haDnyswOHyd4QuZXFPwT
         FPrSXRYFiRANfbKgOi9wsvCyIvCwZ/PkLVkqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GR99GIZZjMuYiZzLF19Koiioj28kl/2jLD/QPVbsMmo=;
        b=bBVvtUYGUeYotc+PZFKBU+1cxmN9lAwyErbaJxpuds6zEnDQSTXbGhAeI6nd3+/V90
         pH1z2OeuF82J6I30nYuv2oyl7IcUAPZTprDAlKvmhOO05/yOhcGSJPpXH8BUa+fMm5al
         Nl/DqblTrCLJKQN0oKxDTMu7lpv/abFDytTmYgTKrA2h3Czle2rbFOLKuNiCOabf2M/C
         LA6SEgQL5P5xTqmxjOA3D42TnqvOJmKE/6e11XAUfidYiav0cBMgWnhoV1PIgJz0M12q
         qwO71PdlQRxT1ewfLR8MMGtY5EhIHyMjWve3Pm5yfNE1J2TuxSsi0XYe7pCRcX72GMcN
         WEgg==
X-Gm-Message-State: AOAM533/ZNkD7/4rdKFICLyQ5HmONw64lbzi0ezLLArqaji/6Xb3I9ka
        TMhZ6pFuWj1VtPKxClsjOVsgQMdyajTUJw==
X-Google-Smtp-Source: ABdhPJytWvIWeK1ATDg3B20v4sgj59qnn+uhC1n/GMs05mdtVBs9Gt4NyvBkIjNx6BlJ/vdoEyr9xQ==
X-Received: by 2002:a62:cdc4:: with SMTP id o187mr9910453pfg.200.1593738707606;
        Thu, 02 Jul 2020 18:11:47 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:de4a:3eff:fe7d:ff5f])
        by smtp.gmail.com with ESMTPSA id e12sm9662721pfd.69.2020.07.02.18.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 18:11:47 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: add Realtek 8822CE to blacklist_table
Date:   Fri,  3 Jul 2020 09:11:32 +0800
Message-Id: <20200703091124.1.I63705bf6abab9cb79c14f7959a59b201af2b8827@changeid>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the Realtek 8822CE controller to the blacklist_table
to support the wideband speech capability.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 0e143c0cecf2a1..34a84c64e4c83e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -359,6 +359,10 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x8087, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_IGNORE },
 
+	/* Realtek 8822CE Bluetooth devices */
+	{ USB_DEVICE(0x0bda, 0xb00c), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	/* Realtek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_REALTEK },
-- 
2.27.0.212.ge8ba1cc988-goog

