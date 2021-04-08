Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BCAC433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Apr 2021 02:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B453F61139
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Apr 2021 02:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhDHCgc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Apr 2021 22:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhDHCgc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Apr 2021 22:36:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9212C061760
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Apr 2021 19:36:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 71so809612ybl.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Apr 2021 19:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9P94XPzyhu54mxeLpaqaTNwt22nENhiWy81YfXq9m4g=;
        b=PT3SM2aN7e9WwbcobQRwv+lU1jTLBwNwoSFqJ5RwmKnECLap8sMpuk041haf8aYQ5v
         O2WrYps/ywX6/2Skz7d3H8LFLQZhjjkmZAQPIj505SaA4DgbMN93Kd7R9YN+/FOegF4S
         XlyBenvOxjeAsnKhQJ7/fxK/19Of7JWkXzK0TmPmJ+eowQUgOwl5H0KLVJDCMbHwqwl1
         /Kh4b7Ss2k7eDmx94wKDwtUMqDlD9GtAK6kH21olu+m9UVbtiVcEQN1ZzmNXuU1xju3P
         M/l8JdNmzLn8no61q/tBZdNjjT77irAW0vCJoRfcmzQrDxLWjyD54aLGQuRCPoQnAbQm
         iGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9P94XPzyhu54mxeLpaqaTNwt22nENhiWy81YfXq9m4g=;
        b=tRhsb9V16cbA/t0xgggCN+mGb54NHxn+jfdRFOl9uskUercKX+kCP4n0TovI0L7+Sp
         7ZMBqee+AP6OXn/5K97JejDKfutx0Y9iwf4ZLOof0qBrFzehcJHlpV6ZzAD1mKcGBnnA
         6HyNHD+xzuAG0fEJuP+doH+t+O9XXq+PCegpwDyTEUfnVmzN8+rJpiCHYUIpMpnwJPG0
         XWFgcihbKDG6+E2ANYG969VhJRknSS80SIQGlUKlgyLD1zBtgbZqZWuUvappR6CNqFkh
         viKmMJx/omtzdiIXBeLPIl39ePQKOQz2IFqu5vVLBda8NCPL1tSEHZplZ+b2Zn+RwPIN
         s/Zw==
X-Gm-Message-State: AOAM533gVbRIgOnu+ImMKJdwInb7jTuSB5pwxHzhYXkziXAqFCYfvimY
        c5XiICMvIcyvF3qzMbvZztiy1xzQZQtEug==
X-Google-Smtp-Source: ABdhPJyWnMXxgGZq1oXRGSOG5fCi+cG+ZwhfZEyBt7SbR+VA6evWsTWyeVEbW8liUdm4LqT7OkwpC4xcZKmQlg==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:c5c0:d290:d725:ddeb])
 (user=mmandlik job=sendgmr) by 2002:a25:afc3:: with SMTP id
 d3mr10445737ybj.83.1617849381086; Wed, 07 Apr 2021 19:36:21 -0700 (PDT)
Date:   Wed,  7 Apr 2021 19:36:17 -0700
Message-Id: <20210407193611.v2.1.I14da3750a343d8d48921fffb7c6561337b6e6082@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v2] Bluetooth: Add ncmd=0 recovery handling
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        Alain Michaud <alainm@chromium.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

During command status or command complete event, the controller may set
ncmd=0 indicating that it is not accepting any more commands. In such a
case, host holds off sending any more commands to the controller. If the
controller doesn't recover from such condition, host will wait forever,
until the user decides that the Bluetooth is broken and may power cycles
the Bluetooth.

This patch triggers the hardware error to reset the controller and
driver when it gets into such state as there is no other wat out.

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

Changes in v2:
- Emit the hardware error when ncmd=0 occurs

 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 15 +++++++++++++++
 net/bluetooth/hci_event.c        | 10 ++++++++++
 4 files changed, 27 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ea4ae551c426..c4b0650fb9ae 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -339,6 +339,7 @@ enum {
 #define HCI_PAIRING_TIMEOUT	msecs_to_jiffies(60000)	/* 60 seconds */
 #define HCI_INIT_TIMEOUT	msecs_to_jiffies(10000)	/* 10 seconds */
 #define HCI_CMD_TIMEOUT		msecs_to_jiffies(2000)	/* 2 seconds */
+#define HCI_NCMD_TIMEOUT	msecs_to_jiffies(4000)	/* 4 seconds */
 #define HCI_ACL_TX_TIMEOUT	msecs_to_jiffies(45000)	/* 45 seconds */
 #define HCI_AUTO_OFF_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
 #define HCI_POWER_OFF_TIMEOUT	msecs_to_jiffies(5000)	/* 5 seconds */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ebdd4afe30d2..f14692b39fd5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -470,6 +470,7 @@ struct hci_dev {
 	struct delayed_work	service_cache;
 
 	struct delayed_work	cmd_timer;
+	struct delayed_work	ncmd_timer;
 
 	struct work_struct	rx_work;
 	struct work_struct	cmd_work;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b0d9c36acc03..c102a8763cb5 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2769,6 +2769,20 @@ static void hci_cmd_timeout(struct work_struct *work)
 	queue_work(hdev->workqueue, &hdev->cmd_work);
 }
 
+/* HCI ncmd timer function */
+static void hci_ncmd_timeout(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					    ncmd_timer.work);
+
+	bt_dev_err(hdev, "Controller not accepting commands anymore: ncmd = 0");
+
+	/* This is an irrecoverable state. Inject hw error event to reset
+	 * the device and driver.
+	 */
+	hci_reset_dev(hdev);
+}
+
 struct oob_data *hci_find_remote_oob_data(struct hci_dev *hdev,
 					  bdaddr_t *bdaddr, u8 bdaddr_type)
 {
@@ -3831,6 +3845,7 @@ struct hci_dev *hci_alloc_dev(void)
 	init_waitqueue_head(&hdev->suspend_wait_q);
 
 	INIT_DELAYED_WORK(&hdev->cmd_timer, hci_cmd_timeout);
+	INIT_DELAYED_WORK(&hdev->ncmd_timer, hci_ncmd_timeout);
 
 	hci_request_setup(hdev);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cf2f4a0abdbd..114a9170d809 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3635,6 +3635,11 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 	if (*opcode != HCI_OP_NOP)
 		cancel_delayed_work(&hdev->cmd_timer);
 
+	if (!ev->ncmd && !test_bit(HCI_RESET, &hdev->flags))
+		schedule_delayed_work(&hdev->ncmd_timer, HCI_NCMD_TIMEOUT);
+	else
+		cancel_delayed_work(&hdev->ncmd_timer);
+
 	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags))
 		atomic_set(&hdev->cmd_cnt, 1);
 
@@ -3740,6 +3745,11 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
 	if (*opcode != HCI_OP_NOP)
 		cancel_delayed_work(&hdev->cmd_timer);
 
+	if (!ev->ncmd && !test_bit(HCI_RESET, &hdev->flags))
+		schedule_delayed_work(&hdev->ncmd_timer, HCI_NCMD_TIMEOUT);
+	else
+		cancel_delayed_work(&hdev->ncmd_timer);
+
 	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags))
 		atomic_set(&hdev->cmd_cnt, 1);
 
-- 
2.31.0.208.g409f899ff0-goog

