Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A127C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 18:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345716AbiC3S3L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 14:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351726AbiC3S3F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 14:29:05 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8604D9EE
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 11:25:55 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n18so21235369plg.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 11:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XQT701YRSJ402y6Tka71w5G5iKmRXtCUkDwtxSadIvE=;
        b=P2uGWij1zp3GMbtr1HsvXJ5RHwyuiAJNhx1j7hbkhdQJZfasFIsE8l+bZyoPIcsIU/
         jP+hPNbkxgk2cTEwMGODXFqiD4h3yBRtFbSjtvpZ6SzrxZZwe8h/WhOliYMx66khraSr
         S3lHLN4lQram7C7Z4f8Jkyl9373WB2tuoJNc3s2KF1Cy84sLtkevxMqPBTy6PllpKTqA
         8bpdqRxBSIpuyurBdo/fllpORD82hAU4NB7qJrLkH9vwBuy3tDVX6zMlI5TPLK/uKgWM
         WaW2VXVBiQyYF9b7/+EqkzlJAIIeeLRGdXlPHwjMqAHljfytPOysPdCSeHcaoAZvULyQ
         kbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XQT701YRSJ402y6Tka71w5G5iKmRXtCUkDwtxSadIvE=;
        b=Tbf82Tc2bAFn4T/zflVnjwH96mV9hxIZYjpiU3sRv8hh4M0AEF7Jf4jvi5TmpcHEnG
         MCrBMpAXnV2DOTj7t499051+gdkXtTLHZyXZ952argZOC5GDbPdfoSmxo7yyI0jvYPCJ
         +kJsmjfgvplXGFTlWgrt931l+KXeWybN2LH8jIKrgnqWzhVEunY97Ic7g4PKxXOUxS5E
         pbh8oTSwF3Jcc8pmO+KSMshXH274IcJuSkpA3iGZXF2r8/73tTh23s70aXc1vg/UNMkf
         dYgH3tvW8j6iYlmBNpROom9cxgkDCfoXrdREun5jAszR9hcTJahVrUdw8mumQkQXPiVq
         eLkg==
X-Gm-Message-State: AOAM532/mY6r4hRrfzfthGpKYGai40t9CHENOiiSdw+7X6hPI+YK8UNw
        TKkGqym8CI4a98C5GxAQjrI9RAE8SsI=
X-Google-Smtp-Source: ABdhPJxeaYVry+aRFY8Z0S6zMlFuqphes/LRF7T3wzOXvUBlsb9muAoS2t8W6S6eit55HlDb6tuqMQ==
X-Received: by 2002:a17:90b:3a82:b0:1c7:bc91:a87e with SMTP id om2-20020a17090b3a8200b001c7bc91a87emr852848pjb.7.1648664754643;
        Wed, 30 Mar 2022 11:25:54 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004f1111c66afsm26758551pfl.148.2022.03.30.11.25.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 11:25:54 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/3] Bluetooth: btusb: Set HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for QCA
Date:   Wed, 30 Mar 2022 11:25:52 -0700
Message-Id: <20220330182552.2613523-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330182552.2613523-1-luiz.dentz@gmail.com>
References: <20220330182552.2613523-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This sets HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for QCA controllers
since SCO appear to not work when using HCI_OP_ENHANCED_SETUP_SYNC_CONN.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215576
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 50df417207af..2470c3d4ef0f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3335,6 +3335,9 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 			msleep(QCA_BT_RESET_WAIT_MS);
 	}
 
+	/* https://bugzilla.kernel.org/show_bug.cgi?id=215576 */
+	set_bit(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN, &hdev->quirks);
+
 	return 0;
 }
 
-- 
2.35.1

