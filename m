Return-Path: <SRS0=/e8j=W7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48ECC3A5A9
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Sep 2019 21:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DD220828
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Sep 2019 21:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8DGYBEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfIDVUb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Sep 2019 17:20:31 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39894 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfIDVUb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Sep 2019 17:20:31 -0400
Received: by mail-io1-f68.google.com with SMTP id d25so45120799iob.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Sep 2019 14:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=H+kx3DuCPdr/Q485XhaV4sCGhzJcFXd8MXI7fRFtmqc=;
        b=d8DGYBEKDCJzHOfBMcavVNA9t3wBsjrIST0y+f6q8Ud2BWXcGQPO7q3qB0umrZuU2s
         f+rhBxaSysTM05+F1Z5uFDCLODq/F+SGvPGuv9OrOXoGLCkp6zdO0qlfQzVSLS8brDEv
         Nx9djQIAXWIkkiGT2fpYYCzM9x6vlRc2M15QP8VxvB4JDCsBgVK1sf+Xh8byBnHzT/3W
         4Lxa37jQiqZODI+IlUfSb0SpxJgVMxVF1si58AvE8EZlXA/M6V/eTnzZz/3w/B4JsOdk
         mK4caBLct04wfQYtvdQoCxwsZdbB9ogha43pi8fgNt81XhAZXMWpeJjLBH6rcO7zOAaG
         nVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:from:subject:to:cc:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=H+kx3DuCPdr/Q485XhaV4sCGhzJcFXd8MXI7fRFtmqc=;
        b=pCVBcCamWMnc2ng5ojBteb4uO0L5Q+HexAYYJlY7g/FNuK1pQwp7S9rSfqUJzvfeOa
         NsEQ/pMSR6OSbvTvQvsMZRywHCo/rEuJHwbkrSFMzVywXHIoPw7LmdvDh3S4fUH1G1dm
         rJajAEA0Mt3vGD9jAlkAEm5N4l6sYbDq7AEpzT1mmUQkgI0ZIrf15KmoKvknGogLW2U9
         AEXiJkOg8G/4T2KAFYEiceO7qMiwMaHVR3toP0zkA0H3vERLkmw8YTXhNmfcMjlUCyWu
         2zHUMG1CJafvv0PnXBDW8B5wbSAm+K+qB5rk2nZlGjzDEHnjCqBlppnR8BZ80/mOhHtj
         xicA==
X-Gm-Message-State: APjAAAXJhV9taT3a0ssqA+eeCbq+KGCJJKLCoA/AaV7yIsFHmtghT6cW
        IZNuV2dh1+KkVrm6lbosP0BPG51x
X-Google-Smtp-Source: APXvYqw7QWjAn64OqsOd9fttPWlPHK5dJEe+WkIvhECxeAKZGF19Fp9pQ1K6rbh1Caa5umF20AuI4Q==
X-Received: by 2002:a05:6638:738:: with SMTP id j24mr320116jad.74.1567632030582;
        Wed, 04 Sep 2019 14:20:30 -0700 (PDT)
Received: from [10.1.1.187] ([8.39.228.178])
        by smtp.gmail.com with ESMTPSA id n1sm106799iob.7.2019.09.04.14.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 14:20:30 -0700 (PDT)
Reply-To: Carey Sonsino <csonsino@gmail.com>
From:   Carey Sonsino <csonsino@gmail.com>
Subject: [PATCH 1/1] bluetooth: update default BLE connection params
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-ID: <705dbccb-58a9-7adc-8430-c16b395c27e5@gmail.com>
Date:   Wed, 4 Sep 2019 15:20:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update the default BLE connection parameters.

Commit c49a8682fc5d298d44e8d911f4fa14690ea9485e introduced a bounds
check on connection interval update requests, but the default min/max
values were left at 24-40 (30-50ms) which caused problems for devices
that want to negotiate connection intervals outside of those bounds.

Setting the default min/max connection interval to the full allowable
range in the bluetooth specification restores the default Linux behavior
of allowing remote devices to negotiate their desired connection
interval, while still permitting the system administrator to later
narrow the range.

The default supervision timeout must also be modified to accommodate
the max connection interval increase.  The new default value meets the
requirements of the bluetooth specification and the conditions in
the hci_check_conn_params function.

The downside to modifying the default supervision timeout is that
it will take longer (about 10 seconds) to detect a link loss condition.

Fixes c49a8682fc5d: (validate BLE connection interval updates)

Signed-off-by: Carey Sonsino <csonsino@gmail.com>

---

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 04bc79359a17..895d17ec9291 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3181,10 +3181,10 @@ struct hci_dev *hci_alloc_dev(void)
  	hdev->le_adv_max_interval = 0x0800;
  	hdev->le_scan_interval = 0x0060;
  	hdev->le_scan_window = 0x0030;
-	hdev->le_conn_min_interval = 0x0018;
-	hdev->le_conn_max_interval = 0x0028;
+	hdev->le_conn_min_interval = 0x0006;
+	hdev->le_conn_max_interval = 0x0c80;
  	hdev->le_conn_latency = 0x0000;
-	hdev->le_supv_timeout = 0x002a;
+	hdev->le_supv_timeout = 0x03ea;
  	hdev->le_def_tx_len = 0x001b;
  	hdev->le_def_tx_time = 0x0148;
  	hdev->le_max_tx_len = 0x001b;
