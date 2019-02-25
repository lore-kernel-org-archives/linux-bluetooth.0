Return-Path: <SRS0=0pTa=RA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D805C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Feb 2019 23:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C65218AD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Feb 2019 23:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lAdeAK66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfBYXuX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:50:23 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40813 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfBYXuW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Feb 2019 18:50:22 -0500
Received: by mail-pl1-f196.google.com with SMTP id bj4so5242353plb.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Feb 2019 15:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nZx4AbNCe6L73jZzmCjF10GRBr7OroTz9VymClKbKAE=;
        b=lAdeAK66PTFs2p1LGCNlO/0e+/CIDyEcvCkyWenoh9L1XFcOczrV8Zf/E22qv5PS6L
         wmXlAKtEOs4j3S1kEjScGXqJ1HvjwWVDsPVEEkiedxYVVsBVHyrk7XiwXfFg+6VdojES
         Bhazfdqg/deYryct67pphHAjzQP4nZKJZbuD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nZx4AbNCe6L73jZzmCjF10GRBr7OroTz9VymClKbKAE=;
        b=ul2cD1f8gue7GYqFQ/cevWlHw/HsHazm/Hkvck0WNnG5wmMAAZkaU3MIYQl83qu0Hc
         jCfXw8rjK7p61r0lRjrD8l9FJRFYTx3zRl7GEKHV+/bCC28fz9K8XuO6ocxQn96BTPOb
         +h+cAlNj6JLLBABbLKiIRwGeFtDF9fWBb4buKWI67WLOjhPgI11e231FEbXpTxcNbXT6
         UXESQrqlGdDk2Yr/o37pFVOzVIPk7oH3nKfRNpbrdzUbNppxzzeGtBlKED0lJADlkqPg
         MiNIXcRSJON7fl11G02fx5tWjJ9U034nsMHjdyZg/J1mQgJ3ktjcpQscOJPqA6zDtBQu
         amoQ==
X-Gm-Message-State: AHQUAuYOcKQ8uzl40vnG4bf35aTHWUrA9QCb1Xi1tPPq0VIORqSLmINt
        I8cfiYoXMwwsWJCTQYms3yIfxg==
X-Google-Smtp-Source: AHgI3IawLYBc9WLVggJhNMez5Ys9cXrhNGUW3K/EgP2PCaNjO/b21FSAsbJWVdUGGbuMIeorZ1Hh6g==
X-Received: by 2002:a17:902:12e:: with SMTP id 43mr23131259plb.31.1551138622370;
        Mon, 25 Feb 2019 15:50:22 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id y7sm17522967pgf.42.2019.02.25.15.50.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 15:50:21 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 3/3] Bluetooth: hci_qca: Add delay after power-off pulse
Date:   Mon, 25 Feb 2019 15:49:54 -0800
Message-Id: <20190225234954.82942-4-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190225234954.82942-1-mka@chromium.org>
References: <20190225234954.82942-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

During initialization the power-on pulse is currently sent inmediately
after the prior power-off pulse. With this initialization often fails
at boot time:

[   15.205224] Bluetooth: hci0: setting up wcn3990
[   17.341062] Bluetooth: hci0: command 0xfc00 tx timeout
[   22.101453] ERROR: Bluetooth initialization failed
[   25.337740] Bluetooth: hci0: Reading QCA version information failed (-110)

After a power-off pulse wait 10ms to give the controller time to power
off.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/hci_qca.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index eacc108c422d0..c89c1ed87ffe9 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1036,8 +1036,11 @@ static int qca_send_power_pulse(struct hci_uart *hu, bool on)
 	usleep_range(100, 200);
 	hci_uart_set_flow_control(hu, false);
 
+	/* Give to controller time to boot/shutdown */
 	if (on)
 		msleep(100);
+	else
+		msleep(10);
 
 	return 0;
 }
-- 
2.21.0.rc0.258.g878e2cd30e-goog

