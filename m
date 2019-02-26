Return-Path: <SRS0=ehmo=RB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5967CC10F0B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Feb 2019 19:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1938021850
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Feb 2019 19:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F5fUgMUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfBZTrT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:47:19 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43675 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbfBZTrF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Feb 2019 14:47:05 -0500
Received: by mail-pg1-f193.google.com with SMTP id l11so6681892pgq.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Feb 2019 11:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=roYG0axyDU0OwD9X6ZaY8fEvyd6yEJJ2RZdTSFnsCR4=;
        b=F5fUgMUoE/RoKHbt/nBIgKf0fzHv73KQbUyfrjbi/f9pUrbye05/yTwGmWVmeMV4bA
         CulG+h+hd2k0xyCdRbXGzo5MK9Y1tQ+ra9zacHCYjUivnFvG1yPrQlvgL1PWbfFRghbl
         8NtTfwtJOfT7jf5a6ur9qEzjwTgDZ5JOqeE6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=roYG0axyDU0OwD9X6ZaY8fEvyd6yEJJ2RZdTSFnsCR4=;
        b=VhoV/mb/SjcimY0cqFU5l71AYKQMb8fSiV2HquQJ9DsP5Mh3utopC76O2rYHgPHv2Q
         5xwTjCJlpcli8mqnrfMGZaG3wTXBVDPalqN96SRpkD6npQMGqJ/yXYdVjk/yuSRjVqiQ
         gyB7m1OEqGDl9aLB5x2+oFjxps3OLs4NGQBloJH+HqfZxK1Dz/cMUkTzPCmaZ3zZ6//9
         GzYcvc6U5/V1uwTdEIRqVga4aq5V067FLSD6xrzv+19jm9ju5851/i/mqN6RWcAN3RXt
         sWS1QvvE5NojSApPltnJ9uKf2avxMrXHu2kL3h2oK3BVVZAKtuvnGnsKTf/QyH+yPM8/
         X7iQ==
X-Gm-Message-State: AHQUAuYT/gyd48j4nSNyhGmt+P1hgGwF3CNCXn46h2jBVEeE5OTkV89s
        zhZDmIk1dyCZsJxhYHZRiyQJWw==
X-Google-Smtp-Source: AHgI3IbdSun8UUhur06jXsc1kJqkM1hY669vZ3c+VsKbrj4Si9rhkBC4PKmgKDhkLMePVkD8qWu6FQ==
X-Received: by 2002:a63:2bd5:: with SMTP id r204mr26424578pgr.48.1551210424340;
        Tue, 26 Feb 2019 11:47:04 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id r6sm15766498pgk.91.2019.02.26.11.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 11:47:03 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 3/3] Bluetooth: hci_qca: Add delay after power-off pulse
Date:   Tue, 26 Feb 2019 11:46:47 -0800
Message-Id: <20190226194647.146078-4-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
In-Reply-To: <20190226194647.146078-1-mka@chromium.org>
References: <20190226194647.146078-1-mka@chromium.org>
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
off. Remove the previous short settling delay, it isn't needed anymore.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
Changes in v2:
- removed previous short setting delay
- updated commit message
- added 'Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>' tag
---
 drivers/bluetooth/hci_qca.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index eacc108c422d0..3f77140798dd1 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1031,13 +1031,13 @@ static int qca_send_power_pulse(struct hci_uart *hu, bool on)
 	}
 
 	serdev_device_wait_until_sent(hu->serdev, timeout);
-
-	/* Wait for 100 uS for SoC to settle down */
-	usleep_range(100, 200);
 	hci_uart_set_flow_control(hu, false);
 
+	/* Give to controller time to boot/shutdown */
 	if (on)
 		msleep(100);
+	else
+		msleep(10);
 
 	return 0;
 }
-- 
2.21.0.rc2.261.ga7da99ff1b-goog

