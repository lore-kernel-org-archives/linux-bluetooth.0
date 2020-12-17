Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA56FC2BBCD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Dec 2020 23:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8970C239EB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Dec 2020 23:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732318AbgLQXE4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Dec 2020 18:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730245AbgLQXE4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Dec 2020 18:04:56 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D52C0617B0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Dec 2020 15:04:16 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 11so351345pfu.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Dec 2020 15:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xuN3s87sgv5dYv1RWZnvVr37IV4kzzDZbC355KoF86s=;
        b=gNYVoiuPmDtcwNGgz1b29ap/WFF1trap8wB+8F3/ztzMefmOEU7saVMs3StoaqtlAH
         9Q8N3sf1nJNiAhPl30mLWT9rNWcMRL/4jESUIXbVfkLi8FQUqfpdgxGE7cbX+EuWkw4P
         1zxaKNqHwd03cw5UeRIIdyo4kxBqKz2+CUimc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xuN3s87sgv5dYv1RWZnvVr37IV4kzzDZbC355KoF86s=;
        b=YAlXg9ehCQsLTHJt8EnmmTImqCvv3H/RYkv4A7+yRE+gMT2xxa5TPzS01nLLM5WBL1
         HIhGRRIToGx6rHrlYzynKtZjwcpQ7B2ypVu3IGhZSvNomJ7JFPsNnc7q71Ht8j3+LVdQ
         Ohfjie/xSa2DhL4L6G7+Qfx3/T1Y5s+Eqn+QarKI8WFr37GZguLkwi91nVj6vgqWXMeh
         /zd3cApSPldYAOpOyWf9xbtPJwdRW+jU11z0i9HAhPooFHjllZYgB6+W/UI8vWsE5IgM
         VA/LxEgLUFnSlbzBTag6caiOu4RCm+9hNU7QZXK3nfyOVaBM5y1I2tpjUagW4NnvPaGn
         yU7Q==
X-Gm-Message-State: AOAM531d5IakwT2k/YVyQIsixEE53dxKJBlrSHEFDa7es/QVMH5Fy4Ay
        CPr8qCY2EeyGj55i8RW6CPp+tA==
X-Google-Smtp-Source: ABdhPJyY7LcYcKznwl8cdcSmFXO7wsiD2aQSfSQOfEtl4hhRILKgwPonDiZBJATkFfNdYx2HSVXcDg==
X-Received: by 2002:a63:eb4b:: with SMTP id b11mr1435362pgk.351.1608246255566;
        Thu, 17 Dec 2020 15:04:15 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id q23sm6001004pgm.89.2020.12.17.15.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 15:04:15 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: Pause service discovery for suspend
Date:   Thu, 17 Dec 2020 15:04:08 -0800
Message-Id: <20201217150346.1.If6feff48e17a881af9cb55526db7f53bf0db40f1@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Just like MGMT_OP_START_DISCOVERY, we should reject
MGMT_OP_START_SERVICE_DISCOVERY with MGMT_STATUS_BUSY when we are paused
for suspend.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
On ChromeOS, we started getting reports of scanning failing after
resuming from suspend. The root cause was that Start Service Discovery
was being called while discovery was supposed to be paused for suspend
and it was screwing up some internal state. Adding this check
immediately fixed it.

The fix was tested by doing the following:
* Set Discovery Filter ({'transport': 'auto'})
* Start Discovery
* Suspend
* Resume
* Check the Discovering property

Without the fix, this test failed when checking the Discovering
property above.

 net/bluetooth/mgmt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fa0f7a4a1d2fc8a..608dda5403b7327 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4798,6 +4798,14 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
+	if (hdev->discovery_paused) {
+		err = mgmt_cmd_complete(sk, hdev->id,
+					MGMT_OP_START_SERVICE_DISCOVERY,
+					MGMT_STATUS_BUSY, &cp->type,
+					sizeof(cp->type));
+		goto failed;
+	}
+
 	uuid_count = __le16_to_cpu(cp->uuid_count);
 	if (uuid_count > max_uuid_count) {
 		bt_dev_err(hdev, "service_discovery: too big uuid_count value %u",
-- 
2.29.2.729.g45daf8777d-goog

