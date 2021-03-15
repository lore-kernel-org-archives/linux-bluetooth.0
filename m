Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880F8C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 17:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FD3664E98
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 17:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbhCORbP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Mar 2021 13:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbhCORbH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Mar 2021 13:31:07 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C36C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 10:31:07 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d23so12438053plq.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 10:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b2bZ+Yse0ie4H9JIUlwhRsDt1s5TrPDpc6H360k2Svw=;
        b=ZSFPi3urfEDtvNX7z3HLxT8w3C2F8ciTm/tN/GOOXee2WjnOVQowIUZ8VVpdoC7iyu
         pQDbGrxERay8l5QLTFAsRNIU8m1L00b+UFPUir8B8a5dHCXbmK5fXd8Trg6g8O3BJLPL
         zJ0F1+QLYa8IW714wgxdTbUhgmt5Q3DAQTp18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b2bZ+Yse0ie4H9JIUlwhRsDt1s5TrPDpc6H360k2Svw=;
        b=taX9ASoTgxqXUOKoO55N3MbgVVIfy4Hjnp3Ay1+Zaq/K6cIhE5EPK92g37xkVA6lVG
         eA804BRR0vZgOPvs9DkY84CkGrGr1JVzW5lRPg4iylTNtPDCIEDl/AnX+dZqqcbXcyxc
         QUYP6UIvFZ8tixsXd0R+BhoDTl/h7dAFb9AIvzF2cjN9/L3YyupxIKNjtWaI4hp0RIqZ
         xI3m6k8zz4VAd2A74WqvF0vYZtad/scvhuMhkmQKMM4jDZfyZ3V7qPN91k2MaRqjZKi6
         sSxKP3249dc0tzaqRfZeWG8WaAU++J8pkN+453HrJ83iD98oCWCPcsA7NJWdgPvoIYfe
         1ogQ==
X-Gm-Message-State: AOAM533kI4DDJZvR+09Zu950UqWTtJHm588/YYPM/1BSXl3u+dOQic9W
        vkrb52EoEtBgHMPFg4/Hdh6shMO24F2aKQ==
X-Google-Smtp-Source: ABdhPJxEWwWm/LNrGTfcBdTYvMlXao8QkZXDMHA8xZvlwwsW+yf0o3X/UDCJ8jZvksjqmIuA19JWNA==
X-Received: by 2002:a17:90a:868c:: with SMTP id p12mr179580pjn.82.1615829466073;
        Mon, 15 Mar 2021 10:31:06 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:a974:ebe2:501:4ac8])
        by smtp.gmail.com with ESMTPSA id q5sm13687597pfk.219.2021.03.15.10.31.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Mar 2021 10:31:05 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [PATCH v2] Bluetooth: Cancel le_scan_restart work when stopping discovery
Date:   Mon, 15 Mar 2021 10:30:59 -0700
Message-Id: <20210315173059.74030-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Not cancelling it has caused a bug where passive background scanning is
disabled out of the blue, preventing BLE keyboards/mice to reconnect.
Here is how it happens:
After hci_req_stop_discovery, there is still le_scan_restart_work
scheduled. Invocation of le_scan_restart_work causes a harmful
le_scan_disable_work to be scheduled. This le_scan_disable_work will
eventually disable passive scanning when the timer fires.

Sample btmon trace:

< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
        Type: Passive (0x00)
        Interval: 367.500 msec (0x024c)
        Window: 37.500 msec (0x003c)
        Own address type: Public (0x00)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
        Scanning: Enabled (0x01)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
...
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
// Background scanning is not working here onwards.

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Sonny Sasaka <sonnysasaka@chromium.org>

---
 net/bluetooth/hci_request.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index d7ee11ef70d3e..8ace5d34b01ef 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -3252,6 +3252,7 @@ bool hci_req_stop_discovery(struct hci_request *req)
 
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
 			cancel_delayed_work(&hdev->le_scan_disable);
+			cancel_delayed_work(&hdev->le_scan_restart);
 			hci_req_add_le_scan_disable(req, false);
 		}
 
-- 
2.29.2

