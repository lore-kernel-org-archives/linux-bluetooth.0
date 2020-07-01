Return-Path: <SRS0=mBsK=AM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D2FC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 21:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC38520870
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 21:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m4oeAeMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgGAVJA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgGAVI7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Jul 2020 17:08:59 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACBCC08C5C1
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2020 14:08:59 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id b24so702790uak.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2020 14:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ka+PnVHK/1B/CrRrAZfYxcFHrqbNySjfxP7d7NkszAU=;
        b=m4oeAeMQkY62Y9pJCbsP2LJM44KZ2NxAjS1RZqeUD+uY9llI00BqEAcix5XIm//OCA
         Jkj6we/QqJ7VgCfsjBN/PL+RtDETarYm+q4hoYwc6vJ7eAMM76MM0VmSQ3o7uQcC2ulM
         503PhAYUeTyD/tn3+KWz/LaZyRGGxgk/LAJOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ka+PnVHK/1B/CrRrAZfYxcFHrqbNySjfxP7d7NkszAU=;
        b=MoWT9Nwugxw8z9eOjkZv3n9Xz0gfX2Hg4V1rqTnsaj8OZNRTDOFh8DiUwsakaloYT3
         RVQigmsNxMQwZwjrDA0SuJqn3cnpT4U5RNwvFx4sEhD7QjUiYOqmzvtbIl4oz6rLaMg5
         k2h2FJ2u2JlZeEpNmwVqLC39tAad1i48EmtBMZ/AsxjrPlt1oHcmDpenKP+MlHPZsKpi
         u9Mo5P22hZ70fgDdQZeywdqVU/sBYAy6HcOvxIiNID0/T8zGaNZlv2+10VjK8JHQmG1C
         FhiQ2ZgJ63OYVe0C0tYQQCzCAehiKZ6CSqHKeFZwxRLtNlv/TO6j/2duVWGJ3uV0In0r
         oMhw==
X-Gm-Message-State: AOAM531r2/Solh+Ef/2MQfjoETHk/lCFHqhTWVK5/fOFfxnrpdixJFJo
        cuaRm1OMCarbYonhoVVoXvEjjNHAudM=
X-Google-Smtp-Source: ABdhPJxLN0QM6HGgzDG6i9b4Dza95ez5N+UiN44S1w4R8cUTgXi/wWXRu4ExuMHMaeQRH/F0Fl9bDQ==
X-Received: by 2002:a9f:260b:: with SMTP id 11mr19897956uag.49.1593637738606;
        Wed, 01 Jul 2020 14:08:58 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id d200sm1148839vkd.16.2020.07.01.14.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 14:08:58 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v1] Bluetooth: le_simult_central_peripheral exp feature
Date:   Wed,  1 Jul 2020 21:08:55 +0000
Message-Id: <20200701210855.351671-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds an le_simult_central_peripheral features which allows a
clients to determine if the controller is able to support peripheral and
central connections at the same time.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 net/bluetooth/mgmt.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5e9b9728eeac..b34547d7a897 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3753,10 +3753,16 @@ static const u8 debug_uuid[16] = {
 };
 #endif
 
+/* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
+static const u8 le_simult_central_peripheral[16] = {
+	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92,
+	0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
+};
+
 static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 				  void *data, u16 data_len)
 {
-	char buf[42];
+	char buf[44];
 	struct mgmt_rp_read_exp_features_info *rp = (void *)buf;
 	u16 idx = 0;
 
@@ -3774,6 +3780,13 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 	}
 #endif
 
+	if (hdev && test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks) &&
+	    (hdev->le_states[3] & 0x10)) {
+		memcpy(rp->features[idx].uuid, le_simult_central_peripheral,
+		       sizeof(le_simult_central_peripheral));
+		rp->features[idx].flags = cpu_to_le32(BIT(0));
+	}
+
 	rp->feature_count = cpu_to_le16(idx);
 
 	/* After reading the experimental features information, enable
-- 
2.27.0.212.ge8ba1cc988-goog

