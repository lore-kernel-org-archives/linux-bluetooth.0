Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E42C4338F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 19:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A17760E8C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 19:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhGXSlG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 24 Jul 2021 14:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhGXSlF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 24 Jul 2021 14:41:05 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314DFC061575;
        Sat, 24 Jul 2021 12:21:36 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id hb6so8858253ejc.8;
        Sat, 24 Jul 2021 12:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=38DFumcmMoU73KXqfkWhA9tfukcr6eOACi13gUfIcko=;
        b=JPMJlAcrsz5AdPywDwTbTf+WHkvgaHfrJNFxaYqPQKSUZP4ZSCynqXEu84keJkWGw6
         HiJ52gtz9Vvhx/XOhiQR7GuIynffPbEjSrWQEPxtGKUsaHGnJ8UYmhbD/XWzqm+SXI29
         JqkORwscqwffh3KZVOmJBf+3BgHuhhYSgf5ry75r1yjUOnH6zci/k0/szFU7En5NZp4e
         7eQAo8sRVFbBBPq+azTU1HaMAgjh6iAlyqkb38sONkJJAoPaGUu1le76P6xwds5a87+C
         UySJ3J55QOmAVO/tenC4IgVDtrTlL8U/XkU0s0e71M0iepRRST8YTBUA2fJ0M4t4BlXH
         v2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=38DFumcmMoU73KXqfkWhA9tfukcr6eOACi13gUfIcko=;
        b=s4pg7LeBPc0LPsJFhBfdqHY59oIl2RqKIxT+HEqmnfIlQYhTQUs/0XaSs125//sz1E
         LDWmNa9thA4SYvPesHZtjnL6HMB3aJC0Mg/NbHv9YkwwhqC5GOVbDTFf9eZ0XyQV9rWh
         n8Uqnkij4K+CeHSUcFIr7tEyCYp08di0K1aW1FkggnZnHnVyyqaeEKdfK4E+1ki3lbFz
         od7tgYY4UFHV35D4RyrI2fbcgNvBjAo2o1bQ5ZFe+EElX5nQ8Ip8pKhK3cUP6UL00SG2
         apMg6onGvV3DnESAVeFMAiY/HNzoFQa4xMTn/og29lVLD3vb4nGPw4D3sUCLh8B9lYRH
         TcbQ==
X-Gm-Message-State: AOAM533dYe6KPUzzc/oLOo5CP1zzBzjMmyskAu0mRmefz4N+jC2m6Y7N
        4KJtfU1fHlk0kILbO36QylGxQe4lIakWPA==
X-Google-Smtp-Source: ABdhPJzLf/vQreGKUbLQAy9CYM1ckrD0AVavbzK7Vhypx6afd+5Jml7qJ4YY3tXX6un2TqA646UPmg==
X-Received: by 2002:a17:906:aad9:: with SMTP id kt25mr10386374ejb.48.1627154494803;
        Sat, 24 Jul 2021 12:21:34 -0700 (PDT)
Received: from pc ([196.235.233.206])
        by smtp.gmail.com with ESMTPSA id ch27sm16872876edb.57.2021.07.24.12.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 12:21:34 -0700 (PDT)
Date:   Sat, 24 Jul 2021 20:21:31 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth: bfusb: update the reference count of udev
Message-ID: <20210724192131.GA490422@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use usb_get_dev() and usb_put_dev() in order to update the reference
count of udev.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
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

