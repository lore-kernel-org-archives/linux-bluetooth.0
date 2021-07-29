Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C73EC432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 17:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B73160F21
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 17:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhG2RLH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 13:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhG2RLH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 13:11:07 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79E0C0613C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 10:11:03 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id o2-20020a05620a1102b02903b9ade0af31so3726346qkk.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 10:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7QYjLUUqEA7QJtp6uP4L96pWeYbMtWuBy88IlWBrbUs=;
        b=GitGuPFN7VBWLpKFt0v1/hktZg429tIvceF80bLzkFbR32YQ/YcMnH8Teqgja1oso6
         s3KMBnYF5rqp5okurqP0N+mxGdLdhhMxBzlOwpA0LR5Cm2aYe9C+a948MWYoM+lCv/0c
         9sA2Y3uP+udORQmrkpo86lU33HFiU7fybTIg+W03UgB4mbI4b5TE3MkZspuwWxT/szgK
         kFFluWoT7Ma3m+ZhKwVpPOZkVoS56RUlobsfiIIzYP1k/V7b4d8mBKyFIQhTeo7rkYt5
         GjKJbKVWfYio+Qhk6KYtgIDJlKBikxy3KTL5hQvaudIaxEK/I5avhFbREGxPpmt9oX2n
         nJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7QYjLUUqEA7QJtp6uP4L96pWeYbMtWuBy88IlWBrbUs=;
        b=dXA3sl6eWnuT7uQPuh0xFtmFvm34YCSZB0WtTjCmnuDOwBxZxGhXX9aNgCLzk6Ojzv
         vyMg6JsNQkWQT+3oeAyMkAbKJw/kx3ix7FDiDVmncxM1yEAhLjQ+ZFHenuNmrp8aix8t
         Vkmb+k5x/C3g44r/6Z8GUvRlZ1PivPOHoQ2qA/bbOYvEQe06Uwu2rscHagnmHpFOpzWf
         9ZHm3a0fZ5WDNBlzajHG6hnBRvFSpPWwyvDjydsBnuR1+lBubEyfl0uNCN9tcNA7q3aE
         6sojP0kQLbwPiWDXLkhTKrp/T7MYB1O+bESaKm2HuUzu+a2Y6fcVab0qUANGn1fSaXDp
         4Fpg==
X-Gm-Message-State: AOAM5302rBLGNODrtrFJp0gvx34RbxeQVPup0tlenLRmluxRdDgV5zVh
        GKBXraKN/3EzagSIGj0s7zxb//sRVxsfK7cA1hNLKECuup4zf3LP7yeEyf1skqDN768gxqTcET7
        itQrJZi/88hR1VhOFKmPg8JhtreYFiHciF+BfIqpsetFzkDdFxjb6Mn6sZsm3rQfpuJVnws5AZ/
        4fLlYZ6gnzUC0=
X-Google-Smtp-Source: ABdhPJy36b6GeGbxRVtXuY9CMyJWfNPDbOYW8W1+t+m0QitXepHvJiP1Q389FHGvtpmShE09ePMHXwqChVjxL+2CkA==
X-Received: from michaelfsun.mtv.corp.google.com ([2620:15c:202:201:9678:c075:a4e7:f144])
 (user=michaelfsun job=sendgmr) by 2002:a05:6214:1909:: with SMTP id
 er9mr6387577qvb.26.1627578662750; Thu, 29 Jul 2021 10:11:02 -0700 (PDT)
Date:   Thu, 29 Jul 2021 10:10:59 -0700
Message-Id: <20210729101036.1.I20af1cbaba1aed4ea5978c97339df5e035f08625@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH] Bluetooth: btusb: Enable MSFT extension for WCN6855 controller
From:   Michael Sun <michaelfsun@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Michael Sun <michaelfsun@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The Qualcomm WCN6855 Bluetooth controller supports the Microsoft vendor
extension, enable them by setting VsMsftOpCode to 0xFD70.

Verified on a WCN6855 device through bluetoothctl show

Signed-off-by: Michael Sun <michaelfsun@google.com>
---

 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1876a960b3dc..d9376380fcc2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4735,6 +4735,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_bdaddr = btusb_set_bdaddr_wcn6855;
 		hdev->cmd_timeout = btusb_qca_cmd_timeout;
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
+		hci_set_msft_opcode(hdev, 0xFD70);
 	}
 
 	if (id->driver_info & BTUSB_AMP) {
-- 
2.32.0.432.gabb21c7263-goog

