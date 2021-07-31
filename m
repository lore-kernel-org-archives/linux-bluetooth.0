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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9C4C4338F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 31 Jul 2021 15:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0162C60F3A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 31 Jul 2021 15:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhGaPlP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 31 Jul 2021 11:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhGaPlP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 31 Jul 2021 11:41:15 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD81C0613D3;
        Sat, 31 Jul 2021 08:41:07 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id a192-20020a1c7fc90000b0290253b32e8796so8873021wmd.0;
        Sat, 31 Jul 2021 08:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=L+dmgbj+bVwO8E/tSf1gwHCr2j9+KZpfrmwTyXXdAvQ=;
        b=qUtgfaVvIr5FUvC+rLRDT4EGaMTXePTgo6MGL5tJ85WgWy6pJclGaBChTZSga+9ZER
         /JeYeehywW/7lTd9HwxD1Pl590MhXwVlGdgk4Hw8L316k8Wipbt55hkxYvuK2Kpg4YIc
         FXY27oHX70ZwKi1/nudOZTUI12l3S6xj0ieENv265Ewp9JNLwKUwJxK5oZcAenGbAE65
         rwpERw4u7ewcBL5JALsaTNrX95FLTjafeIbYPH6sG7oxsRA5bVh5QPIEkMQhjESL/mEl
         HY8LR/Q1pQ7H6ceNxxkZXB+BtAtn6P3au0Mzkohckkm7oGK8jxzdXDAU03yzwiOkgXCT
         qbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=L+dmgbj+bVwO8E/tSf1gwHCr2j9+KZpfrmwTyXXdAvQ=;
        b=LDqSHc946ggtpY1L474FjaxLcIWUu88wQdwrHRwDzrs9HUDM6hGYUeITIxOBkq9ZtY
         y1qcZreIFgiBAA/vfv9ajwd5DeLLc0ed+WHcAv3fBZEWMVhdqTqDvh700JYHTWFTAfOq
         LWcA4oAHOFRlhgIIMm5HEnoI7nyas0CIv3u46XqcpFxjPbn4htDREY7VzG3AdQNnotwG
         mDO0S1Uh+mVDQ0sypoN3T/LuMVrSLFkT8p80MTxC8eXtIgSjgKDDD/3oLnZtMAaw62LD
         8b0ZSY7zmmm4PRnwStemsMwcj2GTZGWyQt8Tywg4dMNGffm85YIETLGlaS6Qb1EV0bzM
         p/dg==
X-Gm-Message-State: AOAM531N5MJ6okX6jel4vkQXA9C8R3gTTYIPhVxT2lnpvasLWSbXW983
        yiwaknzKscsZ4FrYcMMMaY8=
X-Google-Smtp-Source: ABdhPJxkxGAxtfZMajKJVhD9qEOC0tN7TegMrahh4vI6y88wPw9uNlp8vhU/r7tp/jtn+i73bNOVRw==
X-Received: by 2002:a7b:c409:: with SMTP id k9mr8502927wmi.117.1627746066210;
        Sat, 31 Jul 2021 08:41:06 -0700 (PDT)
Received: from pc ([196.235.233.206])
        by smtp.gmail.com with ESMTPSA id t8sm5730882wmj.5.2021.07.31.08.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 08:41:05 -0700 (PDT)
Date:   Sat, 31 Jul 2021 16:41:02 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] bluetooth: bcm203x: update the reference count of udev
Message-ID: <20210731154102.GA908767@pc>
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

 drivers/bluetooth/bcm203x.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/bcm203x.c b/drivers/bluetooth/bcm203x.c
index e667933c3d70..547d35425d70 100644
--- a/drivers/bluetooth/bcm203x.c
+++ b/drivers/bluetooth/bcm203x.c
@@ -166,7 +166,7 @@ static int bcm203x_probe(struct usb_interface *intf, const struct usb_device_id
 	if (!data)
 		return -ENOMEM;
 
-	data->udev  = udev;
+	data->udev  = usb_get_dev(udev);
 	data->state = BCM203X_LOAD_MINIDRV;
 
 	data->urb = usb_alloc_urb(0, GFP_KERNEL);
@@ -244,6 +244,8 @@ static void bcm203x_disconnect(struct usb_interface *intf)
 
 	usb_set_intfdata(intf, NULL);
 
+	usb_put_dev(data->udev);
+
 	usb_free_urb(data->urb);
 	kfree(data->fw_data);
 	kfree(data->buffer);
-- 
2.25.1

