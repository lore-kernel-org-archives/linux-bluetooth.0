Return-Path: <SRS0=ehmo=RB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42EBC43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Feb 2019 20:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CEA621850
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Feb 2019 20:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZbNfc+NC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfBZUJG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:09:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36269 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbfBZUJE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Feb 2019 15:09:04 -0500
Received: by mail-pg1-f196.google.com with SMTP id r124so6726781pgr.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Feb 2019 12:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o9bydIjkJvQeP646HWra4cnTdSBpscFlb5vRPAaztmI=;
        b=ZbNfc+NChjF8exwxjDOCpAUnKf6UTVVlnDkJYd0IL+M0KR+2UmZXNrNa6BJJHzeU0U
         TEgZ83lr6zt6rsHimxcBs/OqnlWdE5YvGhj3s4F5k+NaZWvgFM5asLo863emJM3jO/UT
         yn816JtXS5kWgbqlxD0C8pT0BoXSklVL8bdKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o9bydIjkJvQeP646HWra4cnTdSBpscFlb5vRPAaztmI=;
        b=PJsz7dTcbxDYzpMTpblJQj8blwGx1dHHISL0WpQ/fPrWb+Xc6pswM8Xnao5h9XHMl2
         b/klSUlnrd0oc7TKfU7r6rU1MVt8mGX4fodculHaMptO/zlucof+fbbvG/21E8kJP0E9
         A5dkp69gY+hhSo0La2zngdeTC4HS9ZvaipyVW1pNS1yE7sM774OoqvEokccC/AH4LECL
         SgAHq73VwedB48Lca10fR0//V8esO33aYwxZs9PtpbrUiYeVHwP+Su+nIOeG25LGj/JS
         2qOXWmmdloK7q2uScoD7tSlsAAvTpmp2cIYUaxl7NGyrheguQJWDfIhweSJLqeeVO45k
         6eLg==
X-Gm-Message-State: AHQUAuYjsrmb26W/GCUXah1CDUaVtIZz70F22VbRoysj98qk2l+/h37m
        AFSbW8rvN8nUUsFs1qp6bQkiLw==
X-Google-Smtp-Source: AHgI3IbSx0W3MLt5C2sSm0Km9nAgKy6Rf0rUY0CVduDlQv8ZT4uMtNVxWIsOqlXlp9aN1EBfcN3BVA==
X-Received: by 2002:a65:609a:: with SMTP id t26mr25602080pgu.411.1551211743812;
        Tue, 26 Feb 2019 12:09:03 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id l5sm7637328pfi.97.2019.02.26.12.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 12:09:03 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/2] hci_qca: Use msleep() instead of open coding it
Date:   Tue, 26 Feb 2019 12:08:47 -0800
Message-Id: <20190226200848.154216-2-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
In-Reply-To: <20190226200848.154216-1-mka@chromium.org>
References: <20190226200848.154216-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Call msleep() in qca_set_baudrate() instead of reimplementing it.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/hci_qca.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 26efc2ef98d9a..703e099515f24 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -989,9 +989,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 	 * controller will come back after they receive this HCI command
 	 * then host can communicate with new baudrate to controller
 	 */
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(msecs_to_jiffies(BAUDRATE_SETTLE_TIMEOUT_MS));
-	set_current_state(TASK_RUNNING);
+	msleep(BAUDRATE_SETTLE_TIMEOUT_MS);
 
 	return 0;
 }
-- 
2.21.0.rc2.261.ga7da99ff1b-goog

