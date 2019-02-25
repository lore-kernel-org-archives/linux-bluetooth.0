Return-Path: <SRS0=0pTa=RA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D8BC43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Feb 2019 23:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34477218AD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Feb 2019 23:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A/ltSMPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfBYXud (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:50:33 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45886 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbfBYXuV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Feb 2019 18:50:21 -0500
Received: by mail-pl1-f194.google.com with SMTP id r14so5234790pls.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Feb 2019 15:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=18FsJ3EIYqY47G5XG6Ckl0/smQnwz5gVJaP2swZATXU=;
        b=A/ltSMPaBexListhDs4/AsVheowqlezfquLkRw+kUh+uNgshPjq1FFVJ7+DoB8aHNG
         enC0NTqEEIr1HeG/Y/gCNumPmAeRfKmuBa+DbvRoVUm/m/F+7L4KaZv9uABTw7F4bHUl
         KwWDfOTo04Pr/wqptfsrTSSOR3oBwg93ZA1tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=18FsJ3EIYqY47G5XG6Ckl0/smQnwz5gVJaP2swZATXU=;
        b=aKqRxp0oGo84aTuaPPOEw/bGNFnjec6ZTgsOymkYFitbpwmg1FJQhTv1QS2BuAEYFF
         ypPRF5RM2rtjHuVUF7evN4We6GmCy2NA7UUgvfHXxuIjcWfNVt+DCI2nC0nIEp32GG9I
         YyfdDWQa3BwAWu9oHucKQjku6OWZ2gPaTykvwQchx9wq1nwu0u2eP9jF4FrdhoO85sKh
         /0+0ZAbGSSV5/lktL3jbDnMOv1yRUT4IgOgWLLeIxuElrg+3Dv8iUXfEIoX12ABy2BBm
         s/pmUkiTY/kPCglAyUBHIcj/uk/MjhlvsurmpQFPQa7gAxaSGwuKC5OtRCd01QfFJDaE
         3EVA==
X-Gm-Message-State: AHQUAuZd5hQ03o2RGdLEE8EfEvcI470pHToeBjoDuiyvZKoGZ1wA8idD
        PMzSVAfelfAZ+WhCX1U9tNivnQ==
X-Google-Smtp-Source: AHgI3IZHRlaTe/+VApC1j/nb1QKZP2KySOSsYMs/ay5VVrPZwsl307kiYE6egYejZg0IytZrru/3ig==
X-Received: by 2002:a17:902:282b:: with SMTP id e40mr12213655plb.111.1551138621401;
        Mon, 25 Feb 2019 15:50:21 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id y7sm17522967pgf.42.2019.02.25.15.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 15:50:20 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/3] Bluetooth: hci_qca: Move boot delay to qca_send_power_pulse()
Date:   Mon, 25 Feb 2019 15:49:53 -0800
Message-Id: <20190225234954.82942-3-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190225234954.82942-1-mka@chromium.org>
References: <20190225234954.82942-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

After sending a power on pulse the driver has a delay of 100ms
to allow the host controller to boot. Move the delay into
qca_send_power_pulse(), since it is directly related with the
power-on pulse.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/hci_qca.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index e4128774e9686..eacc108c422d0 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1036,6 +1036,9 @@ static int qca_send_power_pulse(struct hci_uart *hu, bool on)
 	usleep_range(100, 200);
 	hci_uart_set_flow_control(hu, false);
 
+	if (on)
+		msleep(100);
+
 	return 0;
 }
 
@@ -1148,9 +1151,6 @@ static int qca_wcn3990_init(struct hci_uart *hu)
 	if (ret)
 		return ret;
 
-	/* Wait for 100 ms for SoC to boot */
-	msleep(100);
-
 	/* Now the device is in ready state to communicate with host.
 	 * To sync host with device we need to reopen port.
 	 * Without this, we will have RTS and CTS synchronization
-- 
2.21.0.rc0.258.g878e2cd30e-goog

