Return-Path: <SRS0=7chU=YC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8CEC47404
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Oct 2019 08:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5B8206C0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Oct 2019 08:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="igpSb/8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfJIIhP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Oct 2019 04:37:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41554 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfJIIhP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Oct 2019 04:37:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so1148104pfh.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Oct 2019 01:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=In7lAtEYz40LWfmW5FUqo3PU26fK6KeFFUXZm6ciSko=;
        b=igpSb/8DDxaxcOeTDVpkzJYbWOko7TyjaeGMbG50kIJ3hRFccwjw4BLh9h0Zt4JFo0
         n36v1mZJ31KxwfASSfzbN6fMmDlOcbW1bWKBQTOpXo7xfkMC6ZfNK7WkGWyFS3lrWzRu
         up8xE5gJfgX5BfTEbUAMY+s8seNetvPivB7Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=In7lAtEYz40LWfmW5FUqo3PU26fK6KeFFUXZm6ciSko=;
        b=V83k/iA+vURR4jKJGiw5e+T3fq/B8KaVeNtPzCD6ZqEOxJ18XWytoMlpS6SMIWYwGH
         EU9z2NV+cIKcWsl17XAcAiXR7V8XEgkLFu33K06KHXvDjCiTHXIRdfsAeZS+kMv23gfQ
         g++3N1UlRlbHvqSxUkZd253SuRayfhEKEuIXA/lo9hfXH/I38kVGSvzO91SC+jwPQMtY
         Yd/ORg13MpNphMK2Zx8wteMoG0T5I8QzVSgEoCY3dkQpn7XIVwmfcVMjKF4E2OVtG3do
         UfoGFfNBs4cJKGKkuAoD7dSin7y/vrtCjxjfIMpA8y3hIjpFgy3JD4Pwemb4/5epmLAQ
         sE0A==
X-Gm-Message-State: APjAAAUMuSvueocD8WQG0t/UJXWnH1DLxV0ho2Zqik1RyEyZbShlwGmj
        RxYgM69JGfR6xlfxkM8bCF1HUqutxBE=
X-Google-Smtp-Source: APXvYqyuRb7TMyqADlNNUzJEk9zo38FR5yBxYGgJHb1FFmciLN4vLFfky1rUnhynqgmcYoCqWAmZZw==
X-Received: by 2002:a63:5918:: with SMTP id n24mr3050345pgb.362.1570610232734;
        Wed, 09 Oct 2019 01:37:12 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3db2:76bf:938b:be05])
        by smtp.gmail.com with ESMTPSA id y36sm1478101pgk.66.2019.10.09.01.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 01:37:12 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        rjliao@qti.qualcomm.com, rongchi@qti.qualcomm.com,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH] Bluetooth: hci_qca: fix in-band sleep enablement
Date:   Wed,  9 Oct 2019 16:37:08 +0800
Message-Id: <20191009083708.194853-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Enabling in-band sleep when there is no patch/nvm-config found and
bluetooth is running with the original fw/config.

Fixes: ba8f35979002 ("Bluetooth: hci_qca: Avoid setup failure on missing rampatch")
Fixes: 7dc5fe0814c3 ("Bluetooth: hci_qca: Avoid missing rampatch failure with userspace fw loader")
Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/bluetooth/hci_qca.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index e3164c200eac..367eef893a11 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1291,10 +1291,8 @@ static int qca_setup(struct hci_uart *hu)
 	/* Setup patch / NVM configurations */
 	ret = qca_uart_setup(hdev, qca_baudrate, soc_type, soc_ver,
 			firmware_name);
-	if (!ret) {
-		set_bit(QCA_IBS_ENABLED, &qca->flags);
-		qca_debugfs_init(hdev);
-	} else if (ret == -ENOENT) {
+
+	if (ret == -ENOENT) {
 		/* No patch/nvm-config found, run with original fw/config */
 		ret = 0;
 	} else if (ret == -EAGAIN) {
@@ -1305,6 +1303,11 @@ static int qca_setup(struct hci_uart *hu)
 		ret = 0;
 	}
 
+	if (!ret) {
+		set_bit(QCA_IBS_ENABLED, &qca->flags);
+		qca_debugfs_init(hdev);
+	}
+
 	/* Setup bdaddr */
 	if (qca_is_wcn399x(soc_type))
 		hu->hdev->set_bdaddr = qca_set_bdaddr;
-- 
2.23.0.581.g78d2f28ef7-goog

