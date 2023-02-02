Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704FAC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Feb 2023 17:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjBBRrI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Feb 2023 12:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjBBRrH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Feb 2023 12:47:07 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B1CA24C
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Feb 2023 09:47:05 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4fa63c84621so27319627b3.20
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Feb 2023 09:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YtU9CnX3cBpyenF2XQ9oEZnYd7Lwckg3sr9WC007xnQ=;
        b=AuQ1JoDOl140cHDdE+mSysSLsYrmA6SHdMNLIy6+bukO+9pa133u4WE9RaE6dZo+IH
         NAHnD6OKqnddDShq7snW9N5JW+UhY8flJJlwPoDvHCyAwohRZPLVITM5GMrGlScLMVvj
         E1IqFR3BGmI1FpBBTcORh1WiRYesGfsXfI1TjAqMuprXlhuuypMG+jDxMQwLa4T6sWHL
         D7svt0DE69yjHehpCufriBMDu5td4/of0IN637OTfFSAqDgeWAWb6by2ve586WvrzAdU
         9awYYGTlR+2NsJkO3KahX27ffLLefnnhJCAPq0k05eSKmMphdBuXn6F5O/thap/lVTHg
         blbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YtU9CnX3cBpyenF2XQ9oEZnYd7Lwckg3sr9WC007xnQ=;
        b=wI+F1vNq+FYrvdRVflaM2ckU8Vv+e8JjqOQOkBX/JlDkw+CF5oL64RWumf4C89uLAP
         A6/7Q9zERzEiaJPtUBuBuCXmQNomT+UXL12//kQD4Isa6aBYYGcAa4sVuIufg+65HB1+
         BGy6i66aC4pNsOvnOcDOSN4StdSAmdfKQ0jdlLLUKtRg63/iozAxGxND30O/OaWeG/WY
         BRTZ63d87lBraKsLbZ8CYUlLJBwLkKitM0I/55vSVNJWtXSWV4dCD0yFjwJ5XJ83b2DH
         8DYVtjO3Of0gsx7M1iwgJJ05x5V0COyrThNNYEj9EeQDNhBzyPH03cG2aYLnEwgSP8Bp
         jRrw==
X-Gm-Message-State: AO0yUKV36EPVjUMIP4o0SOtFMRlLBQ8jL1D+lfu59+SIkR4L2ZXvuOtw
        ZoGEy0B8YvUFZhQ/DdwHjw6D3JE728GLSY0Kt9aAWS5/MCOW118mbhHv7S+6kEkFWx25lEeAPf5
        zXS+eGrTat+AVyw6pbt3B8KMDzmMM7xNh2Zo7FxGc0myAiHmqSAfMSQKLD5KsUq2xfVCU8kETOA
        j4
X-Google-Smtp-Source: AK7set/pUtumSbmYthYO0RyWEklWO3fDPp1Ppdq+qBMUaWpNx51lrqWOcR0a5KfhivtIjbFwM0b6yUCcg5la
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a0d:cc84:0:b0:507:3872:5210 with SMTP id
 o126-20020a0dcc84000000b0050738725210mr761280ywd.152.1675360024329; Thu, 02
 Feb 2023 09:47:04 -0800 (PST)
Date:   Thu,  2 Feb 2023 09:47:01 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230202094659.kernel.v1.1.I7d79501f333609addbb0b39803a7bafb99e5b728@changeid>
Subject: [kernel PATCH v1] Bluetooth: hci_qca: get wakeup status from serdev
 device handle
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Bluetooth controller attached via the UART is handled by the serdev driver.
Get the wakeup status from the device handle through serdev, instead of the
parent path.

Fixes: c1a74160eaf1 ("Bluetooth: hci_qca: Add device_may_wakeup support")
Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v1:
- Get wakeup status from device handle of serdev driver

 drivers/bluetooth/hci_qca.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index a5c19f32926b..3df8c3606e93 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1588,10 +1588,11 @@ static bool qca_wakeup(struct hci_dev *hdev)
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	bool wakeup;
 
-	/* UART driver handles the interrupt from BT SoC.So we need to use
-	 * device handle of UART driver to get the status of device may wakeup.
+	/* BT SoC attached through the serial bus is handled by the serdev driver.
+	 * So we need to use the device handle of the serdev driver to get the
+	 * status of device may wakeup.
 	 */
-	wakeup = device_may_wakeup(hu->serdev->ctrl->dev.parent);
+	wakeup = device_may_wakeup(&hu->serdev->ctrl->dev);
 	bt_dev_dbg(hu->hdev, "wakeup status : %d", wakeup);
 
 	return wakeup;
-- 
2.39.1.519.gcb327c4b5f-goog

