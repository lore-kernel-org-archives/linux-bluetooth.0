Return-Path: <SRS0=UgXA=AK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4594EC433E2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 19:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23AD5206E2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 19:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vf+zZf7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732760AbgF2Tea (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733024AbgF2Tcm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Jun 2020 15:32:42 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6C4C031405
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2020 10:04:20 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id e3so5561100uan.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2020 10:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wUScfTTQZ2UEHLk7DIUgTbQZriky8XElkexhKByLka8=;
        b=Vf+zZf7k38RgimUpEM1jE0pS2fmK4blEW6nYJD1zI+Jhjh7sYhCvEDT0wU7G8PAsix
         3Z562XRHnbSia2Oiug1w+WrLVHoShaX/QQfU9RlCScO/GJAFCn6Dhfuquvrpoevo20tf
         5VijLffaBfZSS4PV61p251M2l5j5dhI8mMTFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wUScfTTQZ2UEHLk7DIUgTbQZriky8XElkexhKByLka8=;
        b=Zp15Zh1PH7WX+vHgXY0eERZA3Fe6XsbR+M8CvjtvJGuqeP4JxYH/jgMNXD8NWvpM/4
         wXmSwBBX0Gh64um4JahzZ0QFeW2KYdQHhZEgBqJntKwF4OfBFwOJWAE7idp5Ft5cZVTV
         IcNUmomMjlGFldjh8OLfAuOu/N0M6aSzMNf03Kdibyq81EVEjKs6JprCoPRcKkBpXTA+
         xYhEk9sshqjzp27JG0PlHtQzg5UKgnP0fKVZkLZH8YMsSc5MkQjAAHawavG4FZv1HhjB
         1p+FnCxzt+fQGNE94MopHQkvoeolZfyeEA3odnmcr2MgRmiCOgufqbVLtap+tc68wyiC
         QTTg==
X-Gm-Message-State: AOAM533ZcmUpASjs91rdlAehsFR2efofyFsnJtexMps7mOSbqyiiDyCd
        McZislgTzxrqC4uzUAL8yh+72rk1flQ=
X-Google-Smtp-Source: ABdhPJwwGXCfRKV0alLplVm5rbB5oQM4Fm1xbAUFauKamgRs7aOs34pi1hmuI0+n7inEy8OsNof6bg==
X-Received: by 2002:ab0:69c4:: with SMTP id u4mr11098485uaq.5.1593450259332;
        Mon, 29 Jun 2020 10:04:19 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id n9sm23669uaa.18.2020.06.29.10.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 10:04:18 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v2] Bluetooth: use configured default params for active scans
Date:   Mon, 29 Jun 2020 17:04:15 +0000
Message-Id: <20200629170415.3227892-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch fixes active scans to use the configured default parameters.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

Changes in v2:
 - Rebase onto master

 net/bluetooth/hci_request.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 116207009dde..68a2ec36e1c1 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -2767,8 +2767,9 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 	if (err < 0)
 		own_addr_type = ADDR_LE_DEV_PUBLIC;
 
-	hci_req_start_scan(req, LE_SCAN_ACTIVE, interval, DISCOV_LE_SCAN_WIN,
-			   own_addr_type, filter_policy);
+	hci_req_start_scan(req, LE_SCAN_ACTIVE, interval,
+			   hdev->le_scan_window_discovery, own_addr_type,
+			   filter_policy);
 	return 0;
 }
 
@@ -2815,18 +2816,18 @@ static void start_discovery(struct hci_dev *hdev, u8 *status)
 			 * to do BR/EDR inquiry.
 			 */
 			hci_req_sync(hdev, interleaved_discov,
-				     DISCOV_LE_SCAN_INT * 2, HCI_CMD_TIMEOUT,
+				     hdev->le_scan_int_discovery * 2, HCI_CMD_TIMEOUT,
 				     status);
 			break;
 		}
 
 		timeout = msecs_to_jiffies(hdev->discov_interleaved_timeout);
-		hci_req_sync(hdev, active_scan, DISCOV_LE_SCAN_INT,
+		hci_req_sync(hdev, active_scan, hdev->le_scan_int_discovery,
 			     HCI_CMD_TIMEOUT, status);
 		break;
 	case DISCOV_TYPE_LE:
 		timeout = msecs_to_jiffies(DISCOV_LE_TIMEOUT);
-		hci_req_sync(hdev, active_scan, DISCOV_LE_SCAN_INT,
+		hci_req_sync(hdev, active_scan, hdev->le_scan_int_discovery,
 			     HCI_CMD_TIMEOUT, status);
 		break;
 	default:
-- 
2.27.0.212.ge8ba1cc988-goog

