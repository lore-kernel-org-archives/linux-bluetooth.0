Return-Path: <SRS0=u2q6=RI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B93BC43381
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Mar 2019 21:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FF12082C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Mar 2019 21:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mY0KvB+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfCEVEb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:04:31 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36926 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCEVEb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Mar 2019 16:04:31 -0500
Received: by mail-pf1-f195.google.com with SMTP id s22so6633223pfh.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Mar 2019 13:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wm1VWzWYbhOsBYcDP2ujuuWSjZicHrsDWkC2dWj8kb4=;
        b=mY0KvB+ZMnSrpf9QxJdzYBnZ1bi35Ht7/+GsaPVNj4T36M/auinztjPFEW+gr85tWd
         OUferI2idVzb+OJGwQUTIiDAwiT0H5eMJC0E81t7ld2vEFVwQut4wN+xZxumOa2ayv2q
         l37Iyq15PfNkpV84GtB1i3hf0N//8ck5YKllM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wm1VWzWYbhOsBYcDP2ujuuWSjZicHrsDWkC2dWj8kb4=;
        b=BV6r+LhB9oMElOP36Fx1ouevPguDoZbyIYFKrINXa47PiG+fS0qmqIF9Xy+Z+mlD7g
         YrZM57zg1l4jMcNL50YUwfiIQIlEJCxy/N0DQtJ1abeCwJHko86SYA+rY9R+yOSmdJ2M
         IMP7PntY4EEdi0a72uJxmA13X9GwRQm5HNZAxl3tHwOciKL7jhJClDMK6/AtMikb90rf
         WRQ58/ri4JRiAxCO0ulNQuXrIpSx9r9XeYXD3kr3ga5Ydxvr18t5fWVsNuCTnqLn48IH
         iPLJebpanvZPjq45LKciAZxyBV2S1/vPk+zh1UGWDfDaTSkcvxAIXuXWDaXIEhc41P8P
         B8gA==
X-Gm-Message-State: APjAAAWVpC3fpHV7mtc/AMKZ6+/ultS0ugtfweSohN0G1zi98p+hWS05
        cm2/X+TXjJdgT8VlI5KDXogV/Q==
X-Google-Smtp-Source: APXvYqwxFOjUaE+Vd60yhCYXxvZZlT4tw70MOhcYJFeA7GNHq+nOH6dUCgJoY1llvgZQrveiHNasHA==
X-Received: by 2002:a62:a504:: with SMTP id v4mr3852949pfm.22.1551819870485;
        Tue, 05 Mar 2019 13:04:30 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id l79sm19791320pfb.102.2019.03.05.13.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 13:04:29 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] Bluetooth: hci_qca: Remove redundant initializations to zero
Date:   Tue,  5 Mar 2019 13:04:12 -0800
Message-Id: <20190305210412.98323-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The qca_data structure is allocated with kzalloc() and hence
zero-initialized. Remove a bunch of unnecessary explicit
initializations of struct members to zero.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/hci_qca.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 237aea34b69f1..8dccbb934e384 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -480,26 +480,7 @@ static int qca_open(struct hci_uart *hu)
 	qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
 	qca->rx_ibs_state = HCI_IBS_RX_ASLEEP;
 
-	/* clocks actually on, but we start votes off */
-	qca->tx_vote = false;
-	qca->rx_vote = false;
-	qca->flags = 0;
-
-	qca->ibs_sent_wacks = 0;
-	qca->ibs_sent_slps = 0;
-	qca->ibs_sent_wakes = 0;
-	qca->ibs_recv_wacks = 0;
-	qca->ibs_recv_slps = 0;
-	qca->ibs_recv_wakes = 0;
 	qca->vote_last_jif = jiffies;
-	qca->vote_on_ms = 0;
-	qca->vote_off_ms = 0;
-	qca->votes_on = 0;
-	qca->votes_off = 0;
-	qca->tx_votes_on = 0;
-	qca->tx_votes_off = 0;
-	qca->rx_votes_on = 0;
-	qca->rx_votes_off = 0;
 
 	hu->priv = qca;
 
-- 
2.21.0.352.gf09ad66450-goog

