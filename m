Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4212DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 02:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 277A461039
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 02:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhJLCDi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Oct 2021 22:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhJLCDg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Oct 2021 22:03:36 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D37C061570;
        Mon, 11 Oct 2021 19:01:35 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q12so11700349pgq.12;
        Mon, 11 Oct 2021 19:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YKkn0NVrltQd/Qztob6Bs+1BsbN0FmhuUke3NPdT/ko=;
        b=A2yuQ1qJBNu0OHhh2BgmBMh3VEtbT+TVJDVCvEVYzYclAiUJQdIbqFW/vjjdHtYV5z
         uz6Thab7lZrwP2h8MQidkvXSHxKV/icN/HO411wTSAqqkIwnDbR0ZDaxvYDR9Musf+KW
         cYByq8Npw6F4MfZvyFWFM4xV0Br52fCEL0uFedNMJl2GnhkSKDQWyeLA2QHbZ05CpxLA
         L62tIo9b19erlmK21C5RaTLe47E3nm2ceNfHNr4zV+5uBfwU3zOaZswtbLGlehbmgy4R
         8gkrG2WZ8q25Do/GU1kEcs4+MKKBQBOsb0zYCbTa1Nq9tkM5quKzRQWBgL6DetqRvljw
         Cpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YKkn0NVrltQd/Qztob6Bs+1BsbN0FmhuUke3NPdT/ko=;
        b=FsGYMBsefjza37eQLbYozx/yDU76q0TkxXO0fLAFgX4D9LOFUYrCvZXeWZrg/4Y+em
         D0OgpSpigA2C5w828CEqPU27Fe9vNuSmh01kBZjqPk7RgUVO7l3bJ+EEaWxX98sqxxdC
         Yq/hxoKcEEVrw5ESNKPw1cmbHx9S+Fre/nV/uVafEeoDtBB4xxcR8bZH219nNImGGQeW
         hlEamtiZHCCw0DS8WzrGUl/o0LOMLDxkynXRDC3y9njivknK3wlLKM1/LXBVxPQij7z8
         UdOtk5hDHD3HspGtcZIWygJvZtRamgcCMbjb0Tfdm9H8dguwbOZMkEDWWjiMag5OdNYf
         9aQA==
X-Gm-Message-State: AOAM530Yj8/IROEYqAzVeSEs8QOvpd6V+H2AFKkEpWHLF+XjXaQjcJnS
        JL8zL77Nl/T91DNqaMBcRWM=
X-Google-Smtp-Source: ABdhPJz/ITmLlHxwdKh6JamvAYlVF5Zg6dZiaODeOydzcZqvAkHSRxn11UHRzD7zK1WO1CnhbdCAuw==
X-Received: by 2002:a05:6a00:1242:b0:44c:2025:29e3 with SMTP id u2-20020a056a00124200b0044c202529e3mr29080352pfi.59.1634004094219;
        Mon, 11 Oct 2021 19:01:34 -0700 (PDT)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id pi9sm708855pjb.31.2021.10.11.19.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 19:01:33 -0700 (PDT)
From:   davidcomponentone@gmail.com
To:     marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Yang <davidcomponentone@gmail.com>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH btusb] Fix application of sizeof to pointer
Date:   Tue, 12 Oct 2021 10:01:13 +0800
Message-Id: <20211012020113.176098-1-davidcomponentone@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: David Yang <davidcomponentone@gmail.com>

The coccinelle check report:
"./drivers/bluetooth/btusb.c:2239:36-42:
ERROR: application of sizeof to pointer".
Using the "sizeof(bdaddr_t)" to fix it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 75c83768c257..ecc56723aa5f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2236,7 +2236,7 @@ static int btusb_set_bdaddr_mtk(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	struct sk_buff *skb;
 	long ret;
 
-	skb = __hci_cmd_sync(hdev, 0xfc1a, sizeof(bdaddr), bdaddr, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, 0xfc1a, sizeof(bdaddr_t), bdaddr, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
 		bt_dev_err(hdev, "changing Mediatek device address failed (%ld)",
-- 
2.30.2

