Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7245FC0044D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jan 2021 14:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45FF823159
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jan 2021 14:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391633AbhASOyq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391802AbhASLsA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Jan 2021 06:48:00 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAB9C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Jan 2021 03:47:20 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id be12so10365861plb.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Jan 2021 03:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v7yJDey0M+HW/YQk4Qnou/+vJASlcwRgxX1tZO/12uc=;
        b=XheqXA0hvMXgSeZ/+sY8OuNzqj5RtUqLV7XUp9iDcbrxN4C/H006GSgCdY6pCRZ+6A
         YP4PN3F2p5Kr7Ty8III6swOElYekyLY5rZkqJSH4FbuFUf2Di0N21HcH2+hAssViFDSC
         S0EOkeMwd9aQEEzPqMdvZ2SeYdA5F+VvRBMR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v7yJDey0M+HW/YQk4Qnou/+vJASlcwRgxX1tZO/12uc=;
        b=E4lDOWJiUELSe/AuEJcOOi1JzgK6nWvmmZl6rzGB2xOuyC/Y6VT5Lxe9kUsSoTB5B5
         9131/0IVXoy7vruFJp2x7D7hkrAKlkT9XQX5QUJDB8x1x3u9xC79h6uC0LSaqsuZ9Pe+
         tvvYAS6ozXnq7e7FwbEceyE3khCUYI2KMilU/S0lAYVKcLTxf4p1IH+M/9wjKzNjC+J9
         yQQWuLOv2KCvWaafCwA2j6ezyFdsYIYy4JgameF2NCpMI+rcPxtJdpKlo1gkoEiiSAFK
         1CF6BTf/Za5libG6Dj9+SPsbEuzWupWLOeGKOlXM4qq4tS9bIR/aDwsT1tvRYi4I6kiZ
         0FhA==
X-Gm-Message-State: AOAM533NjNmRkp8pe9P0oErLld3gmhTJ3fF/x6mkHu5jfhmYYJWEwQFL
        CfMtfyKUIMS2075mbhJz+sD3TQ==
X-Google-Smtp-Source: ABdhPJwKkaeHsZKLVvtVi3Idy2+qMHHrfOaNv4MG3cu9uCgasAbEp6he3pKE0HDPzeG7iHBOxS8N0Q==
X-Received: by 2002:a17:90a:fd0b:: with SMTP id cv11mr5019491pjb.26.1611056840071;
        Tue, 19 Jan 2021 03:47:20 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:3d01:2769:7769:a4b0])
        by smtp.gmail.com with ESMTPSA id gx21sm3456732pjb.31.2021.01.19.03.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 03:47:19 -0800 (PST)
From:   Claire Chang <tientzu@chromium.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        max.chou@realtek.com, hildawu@realtek.com,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH] Bluetooth: hci_h5: Set HCI_QUIRK_SIMULTANEOUS_DISCOVERY for btrtl
Date:   Tue, 19 Jan 2021 19:47:00 +0800
Message-Id: <20210119114700.3662156-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Realtek Bluetooth controllers can do both LE scan and BR/EDR inquiry
at once, need to set HCI_QUIRK_SIMULTANEOUS_DISCOVERY quirk.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/bluetooth/hci_h5.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index fb9817f97d45..27e96681d583 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -906,6 +906,11 @@ static int h5_btrtl_setup(struct h5 *h5)
 	/* Give the device some time before the hci-core sends it a reset */
 	usleep_range(10000, 20000);
 
+	/* Enable controller to do both LE scan and BR/EDR inquiry
+	 * simultaneously.
+	 */
+	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &h5->hu->hdev->quirks);
+
 out_free:
 	btrtl_free(btrtl_dev);
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

