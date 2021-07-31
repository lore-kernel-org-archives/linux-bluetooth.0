Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C662C4338F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 31 Jul 2021 15:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C4D61019
	for <linux-bluetooth@archiver.kernel.org>; Sat, 31 Jul 2021 15:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbhGaPt0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 31 Jul 2021 11:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhGaPtF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 31 Jul 2021 11:49:05 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26C1C06175F;
        Sat, 31 Jul 2021 08:48:58 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d8so15458523wrm.4;
        Sat, 31 Jul 2021 08:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=r2v7CpG4OdpnaaYd3iRtcTuOXqy15xpa9SEwFeqjXi8=;
        b=g1frEp2/eDadKDGkXWQTUtN4Eg2LwTHVB7rMt09E33OtAaTZk0pwq9oIAWIo1PVnKb
         Ik6OYJWDGWGvSor+SL2SbbqdUrijcOaTbGvzKnUP2qj4ieifJg6pCGZD9Ad7MjYAIEC2
         2fN5sSGnsQKKp+341xMFFKyN1DA56/Akyc+lEef09p0Oao0qXJ1EW3E3BGLRWe7tTyH6
         TmTikS3LEVcrccwDqEYD5TnCKiulKrs99qF9fFHfe5RCLN4YAfYwVEToiuq1QgiNpasz
         zq9X/TFIHRKfrLblmbH1rKG5Njkeqa8WCd//hMrKmURVVrm1c4txCpRPl6kotYa+WplT
         h3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=r2v7CpG4OdpnaaYd3iRtcTuOXqy15xpa9SEwFeqjXi8=;
        b=amwYJ+V6k96Z6qSQ3P34wd02BH9WPeXqRSeLlO5PJDIomWNO0uA78sGbgFHll19+n4
         z5Lb03z1qcIf3Idh2xPH8sco9XRb1N5QBmWBaM7BxxJtiU4GpSsXMRzRMLNM+4eSimPx
         Kdm4jol9KWe9I52MbJOSZT1cKlfolC7lIguS4gZ1mb/9w2/ymx7ln+UgNY6Wr6krPs8t
         J6tKS2CEJG7PjBaxct41vmVB2mL9cLOJQ3cF8+I6sHTNIJIlHStFR9fkBjAB6CKgg0lY
         yi8XhpjYQL5KQCnJp3nEib1NL8f24pEcNEIEiolrXGIk2erFeE7ck02GGnICFp5uNRmh
         hFEQ==
X-Gm-Message-State: AOAM5314810F3MAJ5KVLBv5hq6CtwOdMilARzcdmQKnZoHzGnSsSeZRs
        9TSfmM8GuzsS2sAaROxLDp4=
X-Google-Smtp-Source: ABdhPJx5jyMRbr+ae5Vwb35rgfVXIE3t+ZrAeE0ZGrQAoiU24Zqt6u03JstNRVj68DIv1LEGd//7cg==
X-Received: by 2002:adf:d225:: with SMTP id k5mr8735320wrh.10.1627746537489;
        Sat, 31 Jul 2021 08:48:57 -0700 (PDT)
Received: from pc ([196.235.233.206])
        by smtp.gmail.com with ESMTPSA id j14sm5367966wru.58.2021.07.31.08.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 08:48:57 -0700 (PDT)
Date:   Sat, 31 Jul 2021 16:48:54 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] bluetooth: bfusb: update the reference count of udev
Message-ID: <20210731154854.GA909036@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use usb_get_dev() to increment the reference count of the usb device
structure in order to avoid releasing the structure while it is still in
use. And use usb_put_dev() to decrement the reference count and thus,
when it will be equal to 0 the structure will be released.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Change since v1:
	Modification of the description

 drivers/bluetooth/bfusb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 5a321b4076aa..c9145c914451 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -623,7 +623,7 @@ static int bfusb_probe(struct usb_interface *intf, const struct usb_device_id *i
 	if (!data)
 		return -ENOMEM;
 
-	data->udev = udev;
+	data->udev = usb_get_dev(udev);
 	data->bulk_in_ep    = bulk_in_ep->desc.bEndpointAddress;
 	data->bulk_out_ep   = bulk_out_ep->desc.bEndpointAddress;
 	data->bulk_pkt_size = le16_to_cpu(bulk_out_ep->desc.wMaxPacketSize);
@@ -699,6 +699,8 @@ static void bfusb_disconnect(struct usb_interface *intf)
 
 	usb_set_intfdata(intf, NULL);
 
+	usb_put_dev(interface_to_usbdev(intf));
+
 	bfusb_close(hdev);
 
 	hci_unregister_dev(hdev);
-- 
2.25.1

