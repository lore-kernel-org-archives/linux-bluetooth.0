Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3A1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 00:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30FD660E0C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 00:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbhJMBAt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Oct 2021 21:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237295AbhJMBAK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Oct 2021 21:00:10 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66A4C06176D;
        Tue, 12 Oct 2021 17:56:49 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e7so696818pgk.2;
        Tue, 12 Oct 2021 17:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jk+dJudPrE0+XDIqtsyqRFyo5a48Ow5IdBOK3OS2dpg=;
        b=ix+LdVAgj9+4E3/cmxG0azr2mcljAALqBRbmxBgnk5n2oCwqjZKRSf4SdXdfYtk/mT
         /PzPoE9u97opybyE09cQRNKRgys9blC0s/KpKaVXaq7iZG5K7r0fE/zNJEtEYbREagwv
         FemXTYnvq9zc4jFPZDFuvk4y/2LMQPLDAeycz0XvS/+7lukLiHlAshvIHZbxi/nOoQRZ
         Jwrxsc0dtTSL9HI5VgAUdp7Cw2FbOp9EywdwDd7mxCUO49zP0eFB75NgSbUtBlWtPK/3
         qXm4Rj1SoLPORgw5hH9K34ahUVOy7d8RkReCRmpST/0ViBGydqaF6zS6WWGY2N4MUsfw
         ReQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jk+dJudPrE0+XDIqtsyqRFyo5a48Ow5IdBOK3OS2dpg=;
        b=U79Od3n4iEYcFybe4CDnBUAr7SfY2bU4i5nEELYpmnwTVu0zL7y9OdRoiHFucctnc3
         p7naBWoif7o+CktbLb9JaY2DtJWX4MoWet0CGtV0mIGCxEkxBvcS3IAo1scmNHm1HCbc
         SYGFxb3STbUT8wAYiC5CTlwS6zmtRMhuTL4/uIBIHoT8RtlhohapoUnPbSGQGz03Ctyo
         er9U2Pjri3aEgv6SDOEg5bvHuOvxoG88X70tefMbkKnAsdW/dR2I3x1+uwxuIj2+oC2G
         3N0NnwGGCtntlE+Zx+xWasqRaQSq759NwWSzBe+SfWKi8nMw4NDKhd8HIKFr/AluO2FJ
         8yYA==
X-Gm-Message-State: AOAM533X6VnB45Mxw8JA1A5Fpg5tzHvikXoA1kbSp6o5wtn5v6u6re8h
        2c63hjTrRoJ4S5PGWX7gr0U=
X-Google-Smtp-Source: ABdhPJzonkb+ywewn9SiNlJWit2XGKYp4ld1IuBU91HkiXS2jZgklCrSG1z7+2yVoukZtXMdbTGTKw==
X-Received: by 2002:a63:6e07:: with SMTP id j7mr11363723pgc.6.1634086609279;
        Tue, 12 Oct 2021 17:56:49 -0700 (PDT)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id t126sm4069791pfc.80.2021.10.12.17.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 17:56:48 -0700 (PDT)
From:   davidcomponentone@gmail.com
To:     marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Yang <davidcomponentone@gmail.com>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] Fix application of sizeof to pointer
Date:   Wed, 13 Oct 2021 08:56:33 +0800
Message-Id: <88c30c5f6238a096d1d431634f3ea93d97f66215.1634086268.git.davidcomponentone@gmail.com>
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
Using the real size to fix it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 75c83768c257..3e26f60b457e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2236,7 +2236,7 @@ static int btusb_set_bdaddr_mtk(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	struct sk_buff *skb;
 	long ret;
 
-	skb = __hci_cmd_sync(hdev, 0xfc1a, sizeof(bdaddr), bdaddr, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, 0xfc1a, 6, bdaddr, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
 		bt_dev_err(hdev, "changing Mediatek device address failed (%ld)",
-- 
2.30.2

