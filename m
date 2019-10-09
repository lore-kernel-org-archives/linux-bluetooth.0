Return-Path: <SRS0=7chU=YC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C45C47404
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Oct 2019 08:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABC8206B6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Oct 2019 08:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dYt29wLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbfJIIvX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Oct 2019 04:51:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33636 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfJIIvW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Oct 2019 04:51:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so1198937pfl.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Oct 2019 01:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=In7lAtEYz40LWfmW5FUqo3PU26fK6KeFFUXZm6ciSko=;
        b=dYt29wLqZTFg8WlcHAi/6yG/WQQcQ8I0R93gGpxHkNHDIIqsICqRvc0kAZF94I4kMy
         fBraO+UARhK7ZoZ6I2WmK2snoiEqgdxt49h8/+ZJTzYGyKWOTPx910pLLY/TMAb4Am3u
         b20ydM1OvAcs7lv131FiryRJI2gJ3lTeOoSmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=In7lAtEYz40LWfmW5FUqo3PU26fK6KeFFUXZm6ciSko=;
        b=mk7ZDifBn9aTQ9RWsLIumW3KN4k9TB4ZCbH3TCOJdv1SWeMuFOtBgGwuXlG7g1qKCO
         wt3va8913eWsPo9T4zz2BL2JeEz7QIBr9JNTDw4LgfVqA4ucXBDc2QnWYjcd0KRphn9d
         yM61XUg1XO9KVWhfUQLSkjoF3aMyqE+iiZWTVVhtu8bxV0OYtvIW22JtLu2oa0iw0WaB
         c1uBiJ9weUBdot+Mx8N8vl2mRNixaLNmZAAJSf38ToI2UlsM+ENHSw5DS2P6Utc2ouDq
         SRfEOVut6fB+ifxSd58AP1ZwyNMuzP+lQAusnz06y2KSPE5SBIxoAOzb/eGrlyjOJnRm
         kilA==
X-Gm-Message-State: APjAAAX+nNqaeZ9mGIjq1gI3ATtAEika+/qPJb5yxw2IElgFeskUBnu9
        /lHxrE3P/kSvWtxj+/e26D5TDA==
X-Google-Smtp-Source: APXvYqw+p6lVwH/R34JigHtj9JxYN6M1A5y1JJmqaZ+wjVVzbJzlOboDC6D/oNEY9AWUlK9aARTFdQ==
X-Received: by 2002:aa7:92c9:: with SMTP id k9mr2588834pfa.215.1570611082215;
        Wed, 09 Oct 2019 01:51:22 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3db2:76bf:938b:be05])
        by smtp.gmail.com with ESMTPSA id g7sm2479081pfm.176.2019.10.09.01.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 01:51:21 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjliao@codeaurora.org, rongchi@codeaurora.org,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH] Bluetooth: hci_qca: fix in-band sleep enablement
Date:   Wed,  9 Oct 2019 16:51:16 +0800
Message-Id: <20191009085116.199922-1-tientzu@chromium.org>
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

