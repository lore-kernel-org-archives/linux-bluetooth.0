Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9F2C4742C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 07:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 055DC206F1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 07:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/H6zmoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgKKHCs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Nov 2020 02:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgKKHCq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 02:02:46 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC4DC0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 23:02:46 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id j2so1439961ybb.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 23:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/ezy6lAqc7MUpQhd7aVdTsjzC/c2bjGSDjWe3QgakvQ=;
        b=s/H6zmoLfEXRQNcRx7zUFU8wfrx5RJAaSHfdhk84w3Dqq1BpMLRQQLcnGQe7KGOzyD
         a67A2Hhljl2ShnN7/NFTvFO4b9IN55IAl9CcULX3/Y7h8Mg2pjSQLNdnWj923uJ4O459
         PublNtsKunIM7vnIfav+d11sNkZSJrFwRvtXcs81MrFGxeeBXS1noHnZLKF+yvqE9igb
         bY/TddyyNVGasiZRr9W2AFqbC9yoP6vNSqqQq9wejOVFbx52F6/yuevdhURow/hva6mu
         Au8f5v9OY4A8Vpcm2Iz3RTmNWgSCanNrWhEF9P6TEOG7Gz2qGx5ofh+rdJqUbWiTqwGn
         vyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/ezy6lAqc7MUpQhd7aVdTsjzC/c2bjGSDjWe3QgakvQ=;
        b=nZRf+4t/9rxnXV8rSJKUMcFTfLMrFjkBlgicyCuXVemFyjrvANyOX7hOM1ZH7Tr3dt
         Aw4wnYSh1LYMeuJVTTNgxgkd1G2ODZhA7zsxdqHhAxeFWdCrJURHlWVfUCe3S4aup9rb
         F01l2dljfB9z6ZLjnqq6TQutSqO60FmqfZsTC07pu+AUbLtKd27FuZOlriEidVT77Ebg
         JGL8kOxocOEUd+SCvw2WamJteqCRCg0bseLGrPmergBy+i+z4kXyWhElHEDMjkYlHuMH
         s8ztEeHxBpYh10t2GX527o/GV2GnZOMlkT3Rf7Li6DuiwaGw2mfZsbVS9gyMNj93opVk
         gYvA==
X-Gm-Message-State: AOAM530D14q7eNhfkR3Uf5AZcPwOhFw23yKnx1wjIvfM9DrSJ2TULFOs
        PIm9C/HzfKkZ68jl9C2RUtgPGjuHCtu6gBO2P0og9OqJ1nWww3O/MEn/XiWsDyz0W8xjYP1yKcD
        8Tz50UIF7mrK1I4vTOUjh9jrtEzyIi9Ke5WgVCaf9RMx3VbJZaxkAj6rVZO5cmqLFna1QJ70Og6
        Bv+p1HGi2//zo=
X-Google-Smtp-Source: ABdhPJzpTsl4TADfaUaX6uWEna/KkVxRUWr84P5WsPegWiLLwekP/jEttU9YuVCUBO9RwOFpxEZ5A6nPk+JgDefg7g==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:be90:: with SMTP id
 i16mr28501321ybk.189.1605078165464; Tue, 10 Nov 2020 23:02:45 -0800 (PST)
Date:   Wed, 11 Nov 2020 15:02:21 +0800
In-Reply-To: <20201111150115.v9.1.I55fa38874edc240d726c1de6e82b2ce57b64f5eb@changeid>
Message-Id: <20201111150115.v9.3.I3774a8f0d748c7c6ec3402c4adcead32810c9164@changeid>
Mime-Version: 1.0
References: <20201111150115.v9.1.I55fa38874edc240d726c1de6e82b2ce57b64f5eb@changeid>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v9 3/6] Bluetooth: Handle system suspend resume case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     alainm@chromium.org, mmandlik@chromium.org, mcchou@chromium.org,
        Howard Chung <howardchung@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds code to handle the system suspension during interleave
scan. The interleave scan will be canceled when the system is going to
sleep, and will be restarted after waking up.

Signed-off-by: Howard Chung <howardchung@google.com>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v5)

Changes in v5:
- Remove the change in hci_req_config_le_suspend_scan

 net/bluetooth/hci_request.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 2fd56ee21d31f..d943ad2885aa0 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1293,8 +1293,10 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
 		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &page_scan);
 
 		/* Disable LE passive scan if enabled */
-		if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
+		if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
+			cancel_interleave_scan(hdev);
 			hci_req_add_le_scan_disable(&req, false);
+		}
 
 		/* Mark task needing completion */
 		set_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
-- 
2.29.2.222.g5d2a92d10f8-goog

