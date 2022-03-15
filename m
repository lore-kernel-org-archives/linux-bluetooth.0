Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F393FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Mar 2022 18:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244930AbiCOSv0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Mar 2022 14:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiCOSvZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Mar 2022 14:51:25 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC1556C3B
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Mar 2022 11:50:12 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w4so5288edc.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Mar 2022 11:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Euhy+u3ZvFRmOyJITc3F/l6IY1RO55ftFt7yfjZpi7Y=;
        b=CeOURO41HT7gHWQ7A9UL0rcVtX6vK+nYh39avpy8ns7jU/k4BjiBSut0ZEMRAb7cOX
         SAOfUFwFjpmvqmcuKgxU/EqWIKdam/7bVZMorkHMk3dJxXqeW7AyOayKwJzSIana98wT
         A3oJWDRgYc9ikBuWp7QyNASt4AhhR724/D+IuRqOxIdgmDVVFIeWj92MjGB9ywDY/rTM
         bMRUwy+8Jlqj0yTzoIQho8qKaN3zxb/Q8EhEx2H58EHBwojyXyKi6O4DO3iPk483e2o1
         LPu55R7sprLc/WE7fkjF0B/bzB6VyI0groqb4r1WILO6U0L688PjCMe+WBbirdRyzysI
         h5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Euhy+u3ZvFRmOyJITc3F/l6IY1RO55ftFt7yfjZpi7Y=;
        b=ZGrYsJW8KGqfIFD0JJ1GiLb63kAb0kQOIVtddJ9ERkX4vohq+LQECck/cnrPknB3ak
         kw/HheiExo9ij+5ngkA5j1D5WtmMNllva0KebozbJiSaxg35++4b/qsvCVEO8FXwxycI
         MCoVvqxceflwxMlKnhbvkSJVR6pvGlBZEdC9HJ76j2fYXAA/pbMNxTt7YV6km0qhc+2O
         Owx4ljTihmTdNoWAFq47aKoJiv5Txw/0plaVx6+YemMqNYx1nbmT4OTvZLuCa336pASG
         vxjJCDN0wK8R6SqUMfS+yzTcNS1tpbV5+WBX1jUzwwIlIG7wi8A8Qbu5xIkJBcJWyJcL
         WaUw==
X-Gm-Message-State: AOAM5309HBV24OJNsZ0q5V6tJwwkBqaYWSGWwXscyop53HfvXO+bSsnK
        MyO8RbMSHrhzyk9Qw8Ip8wkhS7LfoSKPevKPaPgOYFyVHfo=
X-Google-Smtp-Source: ABdhPJzjPYw5UrBX0KMfhUkkoXL71hQm8MqQVveyS4KcFXk3yko1C7PUvBIrDics5q16bAdi16IrShmchmWF2J9DJxg=
X-Received: by 2002:a50:bac5:0:b0:416:4651:7782 with SMTP id
 x63-20020a50bac5000000b0041646517782mr26018190ede.219.1647370210871; Tue, 15
 Mar 2022 11:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220315095129.15254-1-tangmeng@uniontech.com>
In-Reply-To: <20220315095129.15254-1-tangmeng@uniontech.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 15 Mar 2022 19:49:59 +0100
Message-ID: <CAFBinCBQzs6zY1p8E3gn9jhm8EhiH5YpZpzyBc0C5c6ziOpgFA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Bluetooth: btrtl: btmrvl: Fix firmware filename
 for rtl8723bs chipset
To:     Meng Tang <tangmeng@uniontech.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

On Tue, Mar 15, 2022 at 10:51 AM Meng Tang <tangmeng@uniontech.com> wrote:
>
> Firmware for rtl8723bs chipset is as part of the linux-firmware
> repository in filename rtl8723bs_config-OBDA8723.bin.
>
> This patch fixes mwifiex driver to load correct firmware file for
> rtl8723bs.
This raises some serious questions for me:
- the subject states that this patch is for the btmrvl driver
- mwifiex is for Marvell based chips which to my knowledge are not
related to any Realtek chips, so mwifiex should never try to load
Realtek firmware files

[...]
> @@ -88,7 +88,7 @@ static const struct id_table ic_id_table[] = {
>           .config_needed = true,
>           .has_rom_version = true,
>           .fw_name  = "rtl_bt/rtl8723bs_fw.bin",
> -         .cfg_name = "rtl_bt/rtl8723bs_config" },
> +         .cfg_name = "rtl_bt/rtl8723bs_config-OBDA8723" },
This change is incorrect, see btrtl_initialize():
  if (btrtl_dev->ic_info->cfg_name) {
    if (postfix) {
       snprintf(cfg_name, sizeof(cfg_name), "%s-%s.bin",
btrtl_dev->ic_info->cfg_name, postfix);
     } else {
       snprintf(cfg_name, sizeof(cfg_name), "%s.bin",
btrtl_dev->ic_info->cfg_name);

This suffix (postfix) can be either OBDA8723, OBDA0623 or just be
absent - see hci_h5.c (h5_acpi_match, h5_serdev_probe() which sets
h5->id and h5_btrtl_setup() which uses h5->id).

[...]
> -MODULE_FIRMWARE("rtl_bt/rtl8723bs_config.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8723bs_config-OBDA8723.bin");
According to the driver code "rtl_bt/rtl8723bs_config.bin" is a valid
value so I think it should not be removed.
Adding "rtl_bt/rtl8723bs_config-OBDA8723.bin" is fine for me - if
that's done then "rtl_bt/rtl8723bs_config-OBDA0623.bin" should be
added as well.


Best regards,
Martin
