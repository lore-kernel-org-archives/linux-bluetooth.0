Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC4DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Apr 2022 18:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346177AbiDGSJO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Apr 2022 14:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244273AbiDGSJL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Apr 2022 14:09:11 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE711FE24E
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Apr 2022 11:07:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bq8so12507751ejb.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Apr 2022 11:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N786B+Z+5vlVwsQOnoiYjc/IkPQynqYX06I75P9c9ao=;
        b=RGKUDjdn1BLQZbXwmMfR4XiZnQ7FCC8wCW1zN/WxOMcYH54Kt3WA4D3QTyfwtgxBWs
         dqEcT1ED0iJXyvL5kUmpXWf7/5yqFygeHeqPxvy85kSOLmjQuC4xMFFJhjIAsm1uA2g7
         57L0YcuNITiNg90eNkgXMHJN850+ZQ+0iDZ7ZEbCgXBywZ5VGSZhvJJEC2imgIWqHaY0
         fy0HaTic1jSvEV1cpry7cNJ8O1eQUuJa3o3ZymscrL4ccIDxhJcKDqVMXHIdVUu4ENdy
         mtSBHq4rx9zajFEygovYgmHUXRTB7xSTRC2T4kOPM2rQ1StBrnZc/anapt3zihneUa1v
         hqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N786B+Z+5vlVwsQOnoiYjc/IkPQynqYX06I75P9c9ao=;
        b=j85ua0htdZle9z96UEtXoTAK9E7lvUzNIK2zcCnbIfStGh1A0row0BUI838ZObnhOU
         7ja6FBhFpQi04vSyQqngBPXZL/NFJz0SnUS3oIhtXra5KJsHPJS9EzNzYL9UlPM+u2AL
         duMUFIua7KOE3hqTIQHS5bCYFlBUtBHQuD9MAopZZX7Y7bCefExLd6a3Ap2kHOC6hMWj
         DX8agIasvmyTv34mfC7wv1Gk0sUqnsbH8K3Rq6wa3V9YZRvbe8kbNNn9v3PSc1WwvYqh
         PpXBT4r6E+ybTs413s75EijfpNXjwRVF1Si6I/s/19mkogVAj90aqO7kVwni8XXxZMem
         fRaA==
X-Gm-Message-State: AOAM533KGcLLl/Q40YmM1tsfIqzT1LVA/T5jxCE4RNcHS91Tk2TEX1Me
        J409DHELxWcActik+Ss3yMNih7KueZw=
X-Google-Smtp-Source: ABdhPJxLY128ipEeUUDU+usgGn/Ia9RqHDRL88g2uyIe40ejQyA/QVmkaTJFD1gO+sP2ErKaESbkFg==
X-Received: by 2002:a17:906:3a4f:b0:6cf:86e0:586c with SMTP id a15-20020a1709063a4f00b006cf86e0586cmr14523732ejf.626.1649354828848;
        Thu, 07 Apr 2022 11:07:08 -0700 (PDT)
Received: from nlaptop.localdomain (ptr-dtfv0poj8u7zblqwbt6.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:f2b6:6987:9238:41ca])
        by smtp.gmail.com with ESMTPSA id za11-20020a170906878b00b006e7f5d17d4dsm4495599ejb.140.2022.04.07.11.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 11:07:08 -0700 (PDT)
From:   Niels Dossche <dossche.niels@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Yun-Hao Chung <howardchung@chromium.org>,
        Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH] Bluetooth: use hdev lock in activate_scan for hci_is_adv_monitoring
Date:   Thu,  7 Apr 2022 20:06:52 +0200
Message-Id: <20220407180651.14871-1-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

hci_is_adv_monitoring's function documentation states that it must be
called under the hdev lock. Paths that leads to an unlocked call are:
discov_update => start_discovery => interleaved_discov => active_scan
and: discov_update => start_discovery => active_scan

The solution is to take the lock in active_scan during the duration of
the call to hci_is_adv_monitoring.

Fixes: c32d624640fd ("Bluetooth: disable filter dup when scan for adv monitor")
Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---

Note:
I am currently working on a static analyser to detect missing locks
using type-based static analysis as my master's thesis
in order to obtain my master's degree.
If you would like to have more details, please let me know.
This was a reported case. I manually verified the report by looking
at the code, so that I do not send wrong information or patches.
After concluding that this seems to be a true positive, I created
this patch. I have only managed to compile-test this patch on x86_64.
The effect on a running system could be a potential race condition
in exceptional cases. This issue was found on Linux v5.17.1.

 net/bluetooth/hci_request.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 42c8047a9897..f4afe482e300 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -2260,6 +2260,7 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 	if (err < 0)
 		own_addr_type = ADDR_LE_DEV_PUBLIC;
 
+	hci_dev_lock(hdev);
 	if (hci_is_adv_monitoring(hdev)) {
 		/* Duplicate filter should be disabled when some advertisement
 		 * monitor is activated, otherwise AdvMon can only receive one
@@ -2276,6 +2277,7 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 		 */
 		filter_dup = LE_SCAN_FILTER_DUP_DISABLE;
 	}
+	hci_dev_unlock(hdev);
 
 	hci_req_start_scan(req, LE_SCAN_ACTIVE, interval,
 			   hdev->le_scan_window_discovery, own_addr_type,
-- 
2.35.1

