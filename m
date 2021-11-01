Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F04BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 16:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9930611AE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 16:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhKAQqX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Nov 2021 12:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhKAQqX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Nov 2021 12:46:23 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8ADC061714
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Nov 2021 09:43:49 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id t11so11905869plq.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Nov 2021 09:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cRzJB3hcj9QyTgdXCXFF8QeC+qBtBzgubQUHBkJbkzY=;
        b=Fll/quKkMLk2VOcNpzaXtxhtWJbD89GoHxrXHzS2/pahYmuabVUavbVbPIuCLpJlUI
         /xMAT7ouAIH5CQGh5QjXdyIBwv23lccLAGQI5vKpvbYdVlg8nI7xh8uvEB+mqWHAFWLW
         MTbk+eZ7LMagNPG3pObfFDYcHfuiLNOngpz+Uy+xdmiGbp+d6MWShD6AuLN60g8AHyUl
         mf5FTTklLLwUY1OIXb+VTmWMt5meUPwSnfw6YrFiSgDjXw8qHKax8Y7O8PNxLoQo3+Tl
         P/0DXONGnHdd3fQvz3wqIFymGylmfFnKNNzN+JkydYdC8kvWqx58oIf1Nj1GKsncwzSz
         vrgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cRzJB3hcj9QyTgdXCXFF8QeC+qBtBzgubQUHBkJbkzY=;
        b=TZEQTNk85rKETL14VlBGb70uyu7mCgU5DQrO/wYO7jGx4Vf2vqGkfwWdqizUY5MZAP
         C0NT5vRkSRR90D718CuTlUTFiJ5KkiHEJG/ZO/0Tw/Jk28KJeyD0G7XgXAq1AkrkEA1S
         NUlq3Fs0tfJNct4C/VDgZQBlew+0TXE075xfsbxKbnkNicoDO6l6JYx0aeDA27tkscZ8
         rnvNsEKe1vZ5ZMepwkUynxo7O1ghpJWeuvQKfmTkAR81GFtpV/BruuCbVkWmMmab/QeX
         WQEgnwPgpNbpEsgWWxoXrQPx9nUVIriIl5thZvJjuP4VAie1+UEHUOKeG9wEpk1L65dC
         CmXQ==
X-Gm-Message-State: AOAM531ueQ5y1faaTPorXlyVIspHTFpXZwq5mNNQiadVx4PKbHTvP6G4
        8j+2q6tJ+yi6FWe3GEOn6oi3vlHwc1s=
X-Google-Smtp-Source: ABdhPJzqAE9Riu3oIUYApdRdU8ffXpdK3NIWU08odzSX33vlkTCP2gqVVpLrwVnEwoyMtEuBzukMwA==
X-Received: by 2002:a17:902:e88a:b0:141:dfde:eed7 with SMTP id w10-20020a170902e88a00b00141dfdeeed7mr8672818plg.17.1635785028737;
        Mon, 01 Nov 2021 09:43:48 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p3sm15518027pfb.205.2021.11.01.09.43.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 09:43:48 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Fix missing static warnings
Date:   Mon,  1 Nov 2021 09:43:47 -0700
Message-Id: <20211101164347.2675973-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following warnings:

>> net/bluetooth/hci_sync.c:1333:5: warning: no previous prototype for
'hci_scan_disable_sync' [-Wmissing-prototypes]
    1333 | int hci_scan_disable_sync(struct hci_dev *hdev, bool rpa_le_conn)
         |     ^~~~~~~~~~~~~~~~~~~~~
>> net/bluetooth/hci_sync.c:1762:5: warning: no previous prototype for
'hci_passive_scan_sync' [-Wmissing-prototypes]
    1762 | int hci_passive_scan_sync(struct hci_dev *hdev)
         |     ^~~~~~~~~~~~~~~~~~~~~

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e3f44e621b7f..fb7ecf24b89a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1397,7 +1397,7 @@ static int hci_le_set_addr_resolution_enable_sync(struct hci_dev *hdev, u8 val)
 				     sizeof(val), &val, HCI_CMD_TIMEOUT);
 }
 
-int hci_scan_disable_sync(struct hci_dev *hdev)
+static int hci_scan_disable_sync(struct hci_dev *hdev)
 {
 	int err;
 
@@ -1968,7 +1968,7 @@ static int hci_start_scan_sync(struct hci_dev *hdev, u8 type, u16 interval,
 	return hci_le_set_scan_enable_sync(hdev, LE_SCAN_ENABLE, filter_dup);
 }
 
-int hci_passive_scan_sync(struct hci_dev *hdev)
+static int hci_passive_scan_sync(struct hci_dev *hdev)
 {
 	u8 own_addr_type;
 	u8 filter_policy;
-- 
2.31.1

