Return-Path: <SRS0=0pTa=RA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DCBC43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Feb 2019 23:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D59218AD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Feb 2019 23:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aD+Ntxbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbfBYXuW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:50:22 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46693 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfBYXuV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Feb 2019 18:50:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id c17so2078962plz.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Feb 2019 15:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=teAx+pPvAPBCVbjvvvK7BbeHJ9HrqAPEItn7BZL57Kk=;
        b=aD+NtxbzqfveWeT4s3DJJvvTlGLo2iTP8Z+xR7dtO5c/2ZXSqNrwyTOkxOP8UfqLdv
         ubZuvCJhVW2GzVYITtkGdIlV1lDSEqdlWLJyeAGZT4CcuL8QTb23pdsduk+n+j5ziyQ8
         tCe6PeEF0Q21CIwwYnxo+6F6raEvConmTJRCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=teAx+pPvAPBCVbjvvvK7BbeHJ9HrqAPEItn7BZL57Kk=;
        b=Grv1wLnjNIs2Mj48g0KG07t7rqryW+45/wic86qAWJgcns4apKcF2afKa03qsOmf/6
         aB6hDC0sJlFs4BaV4rjD3UyATYRnNTzkdpjbEzfTtCasTpZwmIPCoSKnrAsqMKmX+vNH
         wahzIAAlnQ17ekKBmOrIK2Hf+eIMZ0AOnhbIOkRCD6pnHlqudkpxMCO0fapgZh7yT5at
         a0up4JXKpbj6luG47TMe+pe0z7aFJDRUv2iiK+hTD3XjXQVOOnkOKTxSs6BwJpJohacY
         gHrjcGQVVJl1Ym2GRkmTvZeSAsmixow9Gu7qdozZDtgv1cSOI7AQkAEt2RCjRrc7mXVq
         1+Wg==
X-Gm-Message-State: AHQUAuYfNcTZvi2IrAFrDPQ5gyvCn5N9hEtk5uT5MiiY9LkLaO7IwgpA
        5552HGOZ03acvbUhC6VoQklnRw==
X-Google-Smtp-Source: AHgI3IaCSgOxMQ9qFWiygJIhbjn/P8/ULpdKJJEJ2XF/R71jbHo4hfzzx5AWCWgUVuGomDTdy/VtQQ==
X-Received: by 2002:a17:902:784c:: with SMTP id e12mr22707571pln.117.1551138620466;
        Mon, 25 Feb 2019 15:50:20 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id y7sm17522967pgf.42.2019.02.25.15.50.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 15:50:19 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/3] Bluetooth: hci_qca: Pass boolean 'on/off' to qca_send_power_pulse()
Date:   Mon, 25 Feb 2019 15:49:52 -0800
Message-Id: <20190225234954.82942-2-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190225234954.82942-1-mka@chromium.org>
References: <20190225234954.82942-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There are only two types of power pulses 'on' or 'off', pass a boolean
instead of the power pulse 'command'.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/hci_qca.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 5e03504c4e0ca..e4128774e9686 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1004,10 +1004,11 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
 		hci_uart_set_baudrate(hu, speed);
 }
 
-static int qca_send_power_pulse(struct hci_uart *hu, u8 cmd)
+static int qca_send_power_pulse(struct hci_uart *hu, bool on)
 {
 	int ret;
 	int timeout = msecs_to_jiffies(POWER_PULSE_TRANS_TIMEOUT_MS);
+	u8 cmd = on ? QCA_WCN3990_POWERON_PULSE : QCA_WCN3990_POWEROFF_PULSE;
 
 	/* These power pulses are single byte command which are sent
 	 * at required baudrate to wcn3990. On wcn3990, we have an external
@@ -1138,12 +1139,12 @@ static int qca_wcn3990_init(struct hci_uart *hu)
 
 	/* Forcefully enable wcn3990 to enter in to boot mode. */
 	host_set_baudrate(hu, 2400);
-	ret = qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
+	ret = qca_send_power_pulse(hu, false);
 	if (ret)
 		return ret;
 
 	qca_set_speed(hu, QCA_INIT_SPEED);
-	ret = qca_send_power_pulse(hu, QCA_WCN3990_POWERON_PULSE);
+	ret = qca_send_power_pulse(hu, true);
 	if (ret)
 		return ret;
 
@@ -1289,7 +1290,7 @@ static void qca_power_shutdown(struct hci_uart *hu)
 	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
 
 	host_set_baudrate(hu, 2400);
-	qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
+	qca_send_power_pulse(hu, false);
 	qca_power_setup(hu, false);
 }
 
-- 
2.21.0.rc0.258.g878e2cd30e-goog

