Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D616AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jan 2021 20:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F562310B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jan 2021 20:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbhASUoa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Jan 2021 15:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730331AbhASUoF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Jan 2021 15:44:05 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C19C0613C1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Jan 2021 12:43:25 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id p15so694200pjv.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Jan 2021 12:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2KPL8bz/DsmwTeTaJ4A3VI/judTjbMrQhWrVgCOV11c=;
        b=GTbi5NVABmar6gXKJ2rGY5w0Kaoyj6OX4eP8CdhOHzJWUoLXhcRZajGg/NE8jsrund
         mq55GrutSYVzE7mKJG3Vk0oF/L/8KWQqzgxAwirtgJdLbmCGvLLrOXv1NrdfazU5Ihsq
         dOwiEDoKR9IKQNWfMGxKvkkPwmHW/cBYIhA7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2KPL8bz/DsmwTeTaJ4A3VI/judTjbMrQhWrVgCOV11c=;
        b=P83UCSBsh+hxFGL/d+Tn/HabYNR6Cyr7UIYs/YEZJG6oJVOiS36PnizWjhKv9xJMMB
         QU99lgTciFdZoeIkLimMRhdngoM5bbR15KDwBBisV3R4jhejFTNhWdsjZFiYU1ggGj1p
         iEvZOILecY25pu75e/3RQJPCNwACaNBej7odKpomdiKi9SODvOy8oatZPT4ewFR0VKsO
         LnnULbU+vOapUZCyJt2zMuBsyt38Tkq6loLAhCirRAoGd96cMo2XA6gqRARVJVRIRmMY
         TQ5LzaFWhLpC+WRABljA28ijBFyDJl+dta971FhnfLOJlyEMyEwg9JZpfu6vTxNY2Qr8
         5wgg==
X-Gm-Message-State: AOAM530xvVIIdA0MGpPOrCnEKMLcboEQ1k4RPOxM2QqYXkS1zy8Mc0TX
        21KsQM46HmF7DKqhUpkvowyCAw==
X-Google-Smtp-Source: ABdhPJz71RGGjKYuVOHERmx7xaJriybr2/w8Dr7ETf2Zs6/LYn1K4HSQCGy/aYohUgYfBSWAh5n9+w==
X-Received: by 2002:a17:903:1c2:b029:de:ad0a:2dbf with SMTP id e2-20020a17090301c2b02900dead0a2dbfmr6620147plh.44.1611089004824;
        Tue, 19 Jan 2021 12:43:24 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id x15sm13835pfa.80.2021.01.19.12.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 12:43:24 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, mcchou@chromium.org,
        michaelfsun@google.com, linux-bluetooth@vger.kernel.org,
        apusaka@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: btusb: Trigger gpio reset quicker
Date:   Tue, 19 Jan 2021 12:43:13 -0800
Message-Id: <20210119124258.2.I52cc5d2b62fdeb5f3c5249d41f3631ae25d8dc71@changeid>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210119204315.2611811-1-abhishekpandit@chromium.org>
References: <20210119204315.2611811-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently, btusb will only trigger gpio reset during cmd_timeout after
5 commands fail. This number is arbitrarily large and can result in
resets taking longer to occur than necessary.

Reduce this number to 3, which was chosen as a recommended value by
Intel (their firmware allow two commands in flight so they recommend
resetting on the third failed command).

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Daniel Winkler <danielwinkler@google.com>
---

 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 03341e6cbf3ed..880e9cd4ee713 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -578,7 +578,7 @@ static void btusb_gpio_cmd_timeout(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 
-	if (++data->cmd_timeout_cnt < 5)
+	if (++data->cmd_timeout_cnt < 3)
 		return;
 
 	if (!data->reset_gpio) {
-- 
2.30.0.284.gd98b1dd5eaa7-goog

