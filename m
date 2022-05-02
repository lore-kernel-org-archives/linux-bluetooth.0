Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54BAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 May 2022 10:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353681AbiEBK2S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 May 2022 06:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238667AbiEBK2Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 May 2022 06:28:16 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CB5334;
        Mon,  2 May 2022 03:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651487088; x=1683023088;
  h=from:to:cc:subject:date:message-id;
  bh=aIQiPVQV8Y+lL7j3g3uZDmsRTkL6UUd0G/jOVDvWS0Y=;
  b=KkHm87N6r/L7viu6B1Esk8UdSi03rb/xnGG+Vq+KXbTKX6jzl2mWPMNd
   KTQq8qKUBXUP3zWToKQ5qE091ZBpDC1EUm8Q+ZI8oJAMza0VKImwC1ZfC
   szJWKhnk6/54ye2SA1mr42Bj1gSA7UZuwnb5oA63+1A8OShQnc449x2eC
   8=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 02 May 2022 03:24:48 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 May 2022 03:24:46 -0700
X-QCInternal: smtphost
Received: from hyd-lablnx377.qualcomm.com ([10.204.178.226])
  by ironmsg02-blr.qualcomm.com with ESMTP; 02 May 2022 15:54:30 +0530
Received: by hyd-lablnx377.qualcomm.com (Postfix, from userid 4035820)
        id 0334420ECC; Mon,  2 May 2022 15:54:30 +0530 (IST)
From:   Sai Teja Aluvala <quic_saluvala@quicinc.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, quic_hemantg@quicinc.com,
        quic_bgodavar@quicinc.com, quic_rjliao@quicinc.com,
        quic_hbandi@quicinc.com, abhishekpandit@chromium.org,
        mcchou@chromium.org, Sai Teja Aluvala <quic_saluvala@quicinc.com>
Subject: [PATCH v1] Bluetooth: hci_qca: Return wakeup for qca_wakeup
Date:   Mon,  2 May 2022 15:54:08 +0530
Message-Id: <1651487048-30298-1-git-send-email-quic_saluvala@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes the return value of qca_wakeup(), since
.wakeup work inversely with original .prevent_wake.

Fixes: 4539ca67fe8ed (Bluetooth: Rename driver .prevent_wake to .wakeup)
Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>

---
v1:initial Patch
---
 drivers/bluetooth/hci_qca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index eab34e2..8df1101 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1588,7 +1588,7 @@ static bool qca_wakeup(struct hci_dev *hdev)
 	wakeup = device_may_wakeup(hu->serdev->ctrl->dev.parent);
 	bt_dev_dbg(hu->hdev, "wakeup status : %d", wakeup);
 
-	return !wakeup;
+	return wakeup;
 }
 
 static int qca_regulator_init(struct hci_uart *hu)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.

