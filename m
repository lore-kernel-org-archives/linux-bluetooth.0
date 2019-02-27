Return-Path: <SRS0=vyxk=RC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE858C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Feb 2019 23:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A92D218A4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Feb 2019 23:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Joq/Y6+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbfB0Xwk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:52:40 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34319 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbfB0Xwj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Feb 2019 18:52:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id d15so8801721plr.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Feb 2019 15:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G3DCIQE9PdZhWyBTGivGzFKHVIFOsdB5cOCPoAJqUA8=;
        b=Joq/Y6+0U3HaOT0wB/Sis+J2Tdhwe6E91IftJ4uhMC8IAUW1RNpMLdccvt+6GLD0ZN
         +lwsXBKRjN6B06tOzbLb6bhEmBmYEfXe5N8jNtRXlEfIGkwiDhOzz7c7xmH4rYXiVSOT
         j7l+nz8WgHwHUSyp/H5i+k0JQ1s4QGBSoty24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G3DCIQE9PdZhWyBTGivGzFKHVIFOsdB5cOCPoAJqUA8=;
        b=WYFILgOCkZX0emby59NXv8ZdOeRK5BkaZifOq7Z6q/SxEb2IG1Nhg5ZXEEZIIXIrKR
         6EBWEs0Cha1oprubkQ+Enpv1SbRhDrdivh/RjzqBwd9Q6ACODIX1rDiNzqzOQieW5300
         uJqCDbjw9zLPtT5vB+/ZII9+qB/0v+qricg8uiqldPHPQipkaFQiQ0TCzL1KvbWxvPlv
         Tg0R+Z1pgtzdYJO6MGPjIQ12na/vV+EhwW6943FXbXA5dmdIE4K5jCuo9eXiyd5pMjUO
         hJK0bhORINGmgasee+PmoyaAWHZ2iJMoM1Sd4vk2F+a8ZE9P5E+s5HQiBq1RZPN9sGjI
         ysjQ==
X-Gm-Message-State: AHQUAuaGzwp3n1BqmW/iK36ChVFvYGI7n5o+7OXkoAysChAwtryFVRxh
        izX3TEpqcxj3oDZWsOTlykxfFA==
X-Google-Smtp-Source: AHgI3Ibj+20WwEWQSqqarF05i5xZqsxCriX//MOA8QkQfSPb14Uwfr5Js2Hrsx9mQiKs9iJMRYcApA==
X-Received: by 2002:a17:902:b70b:: with SMTP id d11mr5043429pls.178.1551311559053;
        Wed, 27 Feb 2019 15:52:39 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id a7sm29174533pff.54.2019.02.27.15.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 15:52:38 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] hci_qca: Reduce delay after sending baudrate request for WCN3990
Date:   Wed, 27 Feb 2019 15:52:23 -0800
Message-Id: <20190227235223.68668-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The current 300ms delay after a baudrate change is extremely long.
For WCN3990 it is sufficient to wait 10ms after the baudrate change
request has been sent over the wire.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- moved wait for the request to be sent into the common code path
- s/WCM/WCN/ in commit message
- rebased on latest bluetooth-next (5364a0b4f4be0 "arm64: dts:
  rockchip: move QCA6174A wakeup pin into its USB node")
---
 drivers/bluetooth/hci_qca.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 82f6cec4f71ee..237aea34b69f1 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -59,8 +59,7 @@
 
 #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
 #define IBS_TX_IDLE_TIMEOUT_MS		2000
-#define BAUDRATE_SETTLE_TIMEOUT_MS	300
-#define POWER_PULSE_TRANS_TIMEOUT_MS	100
+#define CMD_TRANS_TIMEOUT_MS		100
 
 /* susclk rate */
 #define SUSCLK_RATE_32KHZ	32768
@@ -964,6 +963,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	struct qca_data *qca = hu->priv;
+	struct qca_serdev *qcadev;
 	struct sk_buff *skb;
 	u8 cmd[] = { 0x01, 0x48, 0xFC, 0x01, 0x00 };
 
@@ -985,11 +985,21 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 	skb_queue_tail(&qca->txq, skb);
 	hci_uart_tx_wakeup(hu);
 
-	/* wait 300ms to change new baudrate on controller side
-	 * controller will come back after they receive this HCI command
-	 * then host can communicate with new baudrate to controller
-	 */
-	msleep(BAUDRATE_SETTLE_TIMEOUT_MS);
+	qcadev = serdev_device_get_drvdata(hu->serdev);
+
+	/* Wait for the baudrate change request to be sent */
+
+	while (!skb_queue_empty(&qca->txq))
+		usleep_range(100, 200);
+
+	serdev_device_wait_until_sent(hu->serdev,
+		      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
+
+	/* Give the controller time to process the request */
+	if (qcadev->btsoc_type == QCA_WCN3990)
+		msleep(10);
+	else
+		msleep(300);
 
 	return 0;
 }
@@ -1005,7 +1015,7 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
 static int qca_send_power_pulse(struct hci_uart *hu, bool on)
 {
 	int ret;
-	int timeout = msecs_to_jiffies(POWER_PULSE_TRANS_TIMEOUT_MS);
+	int timeout = msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS);
 	u8 cmd = on ? QCA_WCN3990_POWERON_PULSE : QCA_WCN3990_POWEROFF_PULSE;
 
 	/* These power pulses are single byte command which are sent
-- 
2.21.0.rc2.261.ga7da99ff1b-goog

