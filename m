Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF42BC77B7D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 May 2023 09:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbjEJJ1f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 May 2023 05:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjEJJ1e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 May 2023 05:27:34 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6733A88
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 May 2023 02:27:32 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bc4b88998so12438996a12.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 May 2023 02:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1683710851; x=1686302851;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JBKGh73QpqEYJqax38l5dJYavyHBNPUc6IQPM+Q4Z0I=;
        b=iPH+ouFoA5GOEgnT5bLA6aVtT6mZ8/JMWvWbyo7xN+jXlp6nS10XYkdja8PCRH+3HD
         j90pzE45kJTfAuCLCDQvuFmSszJC11Pigyyzs+BntJUG7/t1lUZfGegsNzHlxg4JJcLw
         B1x9uQrKunyqkx0KF7YCBrwlyAdaNBFW9yPsVVw7O3UxvB9WyqWuDpiYhqxKHKSmvWoe
         Rr0G+TAqbG2pGAPndeufdxCeF02J0zrWO8vCZN8AmxAVUdqcHt065YS+u1s7rB07fZ4f
         Oi63pSAk1bFSVleunPCl+RM9T+N676GJgE5aTCKjpWEolxVwuxtL6jdQWDlA+cvUmepM
         a/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683710851; x=1686302851;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JBKGh73QpqEYJqax38l5dJYavyHBNPUc6IQPM+Q4Z0I=;
        b=KVX7ud+sHqCXwFLGFkKQug/oC+FXW9IJFs426cnjGjUffDTQ2O73WQkRDDv45ha8Gl
         QU8s1KKHjBFFRb68HjrAOdmrhUuBxB2cDkb8b5vKQ+1h/tVu1g7DOLOhQZ5MidcuuSWg
         EvB3sPGgLUPjx6iJ+tudC1wUPIwVxMW+1pfX0odTZIzgqqpbD9JskO5gt1WJQqga1ci5
         MyPe+YY/FJnImUGja8bIw3hj1So+5NJGzA6rpPYp7mF8wapmqMSiFLKTfXlIqjsafMuF
         NKfVbZomHOkucTOkIG7Kd6G2O3x6qTGjKN2sucf84PkBwmqIdxnG0EqybY7vA2KwB9il
         C0Gw==
X-Gm-Message-State: AC+VfDyZ/9/LjShCNGJ7LGF6JPHHuUhBgTgyW1B3MTpUsWxGHZoVxmlX
        67jywjiTZW8OVY3WWVt0ZL/cxw==
X-Google-Smtp-Source: ACHHUZ7Oh9r0VM9/gCBR55+JfnCFHJfLxLYN7lIg6ZiAX7201e+P7Q1p/vq5LK4BKmJ3n6Y7z+jEaQ==
X-Received: by 2002:aa7:cd0b:0:b0:506:7386:88d7 with SMTP id b11-20020aa7cd0b000000b00506738688d7mr11915481edw.11.1683710850965;
        Wed, 10 May 2023 02:27:30 -0700 (PDT)
Received: from [172.16.240.113] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id d16-20020a056402001000b0050bd47f9073sm1691639edu.39.2023.05.10.02.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 02:27:30 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Wed, 10 May 2023 11:27:21 +0200
Subject: [PATCH] Bluetooth: btqca: make sure to handle byte order for
 soc_id
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-btqca-byte-order-v1-1-82e6a371c5aa@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAHhjW2QC/x2Nyw7CIBAAf6XZs9tAq43xV4wHoItsYgAXfDRN/
 13qcZKZzAqFhKnApVtB6M2FU2ygDx24YOKdkOfGMKhhVCet0NanM2iXSphkJkGayGil9NlrBy2
 zphBaMdGFPfT5iFM/9gt+OKN9vKimVMNuZiHP3//8etu2H8inI1WMAAAA
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Johan Hedberg <johan.hedberg@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.2
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The field soc_id in struct qca_btsoc_version is __le32 so we need to
convert it to host byteorder before using.

Reported-by: Simon Horman <simon.horman@corigine.com>
Fixes: 059924fdf6c1 ("Bluetooth: btqca: Use NVM files based on SoC ID for WCN3991")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/bluetooth/btqca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index fd0941fe8608..e7e58a956d15 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -637,7 +637,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/%s", firmware_name);
 	else if (qca_is_wcn399x(soc_type)) {
-		if (ver.soc_id == QCA_WCN3991_SOC_ID) {
+		if (le32_to_cpu(ver.soc_id) == QCA_WCN3991_SOC_ID) {
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/crnv%02xu.bin", rom_ver);
 		} else {

---
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230510-btqca-byte-order-e6ea10018f1c

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

