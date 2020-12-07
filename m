Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F971C4361B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Dec 2020 17:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1135723888
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Dec 2020 17:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgLGRFE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Dec 2020 12:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgLGRFE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Dec 2020 12:05:04 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C461CC061749
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Dec 2020 09:04:23 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id y16so15793145ljk.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Dec 2020 09:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jGPJwRRnXv6HUwDi2/v5pS3LOQbataffNavfqIsZAQ0=;
        b=SoPC2krBw3AmgnM5i3UFRlnWrbxJoLWBDNG6CAIJIIJ1ZzS493sf6xoxstUMNabzud
         9CFR6GD4hhBepi2EKnqI3UEX01pob8IJf0ASv1nsM1LSRQyxX7ONL7O46aJGhMHlsQle
         IoaG5jwq/CvpQmnlD9DvH+H7WHoAkcZlmlnR3ul4Jg/BvclAL9osvUBJdizEUy14GEE0
         hkyt3NzOAuTVgoynuuNw1iBk0Yw+xjRECsifx2rQ7TnBeeINHDKj1JzG9e545Wrefiuu
         vMZIbnMQsq/AkYqINJCS//R1W/PVsJFFOS+i3JIL/bje53tgyKt88DQm5uBHlUC+sl2P
         oFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jGPJwRRnXv6HUwDi2/v5pS3LOQbataffNavfqIsZAQ0=;
        b=eI860JzElVyr53wxbON8Bd/R4xApS9MtJAeD6OGzuMGvrUP2IQS+CWdhbbDOogHebX
         6UNoILzlx/6+JCG+aby56v6SM2WmHdaYPJSv0vE0VR7p9++UUzFcC0WR+uoe76vz3yjm
         FpLJaXeo0f9zo7lNstOZrfOsFqniuVMf0UjtQYkL1G9PMH7GcNh035Rd8HblSmMVhCvj
         NWLirgrhZwe34ggTQ1LZuND9bzXqRmipg23zPk4NYqenTLLIHhF5iQOCjK58WaiR0nZ2
         KS61Q5cEz8Qj/KRwNnfu7wVibo2k+6CUZa7JKRbzuqsPrDGCnT6xrav7AsyvSXT2W1bh
         E2wQ==
X-Gm-Message-State: AOAM5332Y4sFPZ8Gi35J60/HSkqHAAseg53u69zqkWCxFOWBDrjd1W3U
        qLow9IAW1BOkO/xLg3UtGr6O4yI+3WhuLWOuPw+bB6zwC7b+Hw==
X-Google-Smtp-Source: ABdhPJy3RBBaNfv6nXkAh3FvHTJHB6gkcm3xPkmVKhqxE08O7X8eKVExDsGrNV/9nTv7AIbFwx/fxY2oaDKEKnJhlW8=
X-Received: by 2002:a2e:804b:: with SMTP id p11mr8366384ljg.54.1607360662053;
 Mon, 07 Dec 2020 09:04:22 -0800 (PST)
MIME-Version: 1.0
From:   Lionel Jeanson <lionel.jeanson@gmail.com>
Date:   Mon, 7 Dec 2020 18:04:10 +0100
Message-ID: <CAMxp894ThdL9qxNz49561WrDj3XhWxpFMf+9afMD9WqMbSPBbw@mail.gmail.com>
Subject: sixaxis patch proposal
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi;

I'd like to propose the following patch to fix the following issue :

 - if an already paired PS3 DualShock is plugged to USB, while it is
turned off (PS button wasn't pushed or no more battery for instance),
then it's connection will be reset and it will have to be paired again

 - to fix this, I removed the device connection check

 - tested on Ubuntu 20.x (bluez-5.53 and bluez-5.55) and works fine in
all cases.

Thank you;
Lionel



diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index d693a86c0..ccede193e 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -337,7 +337,6 @@ static bool setup_device(int fd, const char *sysfs_path,
        device = btd_adapter_find_device(adapter, &device_bdaddr,
                                                        BDADDR_BREDR);
        if (device != NULL &&
-               btd_device_is_connected(device) &&
                g_slist_find_custom(btd_device_get_uuids(device), HID_UUID,
                                                (GCompareFunc)strcasecmp)) {
                char device_addr[18];
