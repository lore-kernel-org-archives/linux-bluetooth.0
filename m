Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3901DC4320A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 18:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB6960C51
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 18:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhGXRkr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 24 Jul 2021 13:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhGXRk2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 24 Jul 2021 13:40:28 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE62C061575;
        Sat, 24 Jul 2021 11:20:59 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gt31so8591364ejc.12;
        Sat, 24 Jul 2021 11:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=VoDoE+K4ajdEkrYCeli3UDgiK2FyXtPR8yc3ofmqbUs=;
        b=h8QhkqXrf5WnnGU62G8nHUllnOhFHS7kSg7tHJfGAVvQfiISrBOvWRv9B6cc6Z+1XI
         ks2WUL1pUbuM6UiG9zjepo0XQHPy78Fz9hHKa3vRIT6Ds7QQeap1hyVBcW0aOT8g/QXi
         wGtMRqNQ+yxjxhc78SP/46YFDSw5lZF6ZD49Oe48udZmvSZvk7SV5gjHXLYB7VjRga1C
         q2sp0n6d5RZIxXPz7qQOlIaQTSFHk/4iYdFk/b5lWk8Y3gz1OPYXf6hSoXkaR5LDtcZk
         g3BTWX7N+Hp4Osi9eoMWYLVbuYpN5zBWpENr+gzA3EFegjFZAspsr31FSfyPn0KmCWww
         C2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=VoDoE+K4ajdEkrYCeli3UDgiK2FyXtPR8yc3ofmqbUs=;
        b=hpYJvIW9mxeualFZpYrzbt1msFxBa9V9hkStBC4uBh/wwdRYFsa+2aY6GbkV8R0zzz
         49QaQKeuL3FdvJeqNxy8VLTUpWlgiO8c9oGxh4wy78mtI09FhEhGKrVpu/VA2XrAsSRU
         8lPicN/Wv60uBv+cXzBh2T4KrXbEN0230WLCSr68xQk90YLC5sj1BGjYg6C/xBFXxc4k
         NxFIbXjZJ9Ljy8Ndo5XDFFh4IfM8vQog/L+IigL6kfpj6aY3c4llZ6Mq/qe01GEnbe+l
         +TfiLLQH4x3Jm1C/V2mvv1OxBXxp/3xXqphCnquSpSGmzUQIm7Di2jdYHr2T2oMpcg2p
         7SvQ==
X-Gm-Message-State: AOAM530/bgw5+MLEBAWZxgToeERPaes+QGbymfAHJ7Dz8rgBgTzGtyYD
        yTJ2VqaYr+GKaNtdq+mJPJU1evKVpAo=
X-Google-Smtp-Source: ABdhPJyX5evBzDv2P/ctYj1DMp485sTeiM34aIVR6W42yPyT64nTP2dX/I5JHaSEROElHYW3xVXA1g==
X-Received: by 2002:a17:906:f6d5:: with SMTP id jo21mr9870816ejb.444.1627150857771;
        Sat, 24 Jul 2021 11:20:57 -0700 (PDT)
Received: from pc ([196.235.233.206])
        by smtp.gmail.com with ESMTPSA id k1sm12652835eji.84.2021.07.24.11.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 11:20:57 -0700 (PDT)
Date:   Sat, 24 Jul 2021 19:20:54 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth: bcm203x: update the reference count of udev
Message-ID: <20210724182054.GA451351@pc>
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

