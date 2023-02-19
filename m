Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C14C636CC
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 Feb 2023 21:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjBSVpA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 19 Feb 2023 16:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjBSVo7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 19 Feb 2023 16:44:59 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC481817C
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Feb 2023 13:44:58 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id l16so503903iok.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Feb 2023 13:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3wYZB9ERreaEbrfGNUL0w2ZhteCfwV9C+BaGcB7Czuc=;
        b=d763ywGHgI78IhhS5qoHRBigK2QDmWAzJJVubnwG0un2LTlT/BldddbG2SAiHmiP3b
         djKVcUW39ynKECk3Qxt+qeSCWifpatAe8X090Zi6LyjwgkBZmMf5NiIhfkOjH9kQiWvc
         Kzw2vgBc2gQDKE2P8yPrE/eBMJWwJMSeG1mG7ScyF+QhfgovXVmM8ZyOWLE0O8LyisvV
         Fh5GJvd/WWj6fRLFo7TV4ycI35960omOgVFK9QwcjNEB/+9ZyCQpjbGd/TtdXCvLIT9D
         VkaaZ9PX94R+77gtEqHFKQ0YZHRiqweMVA4+ZctG6fznotkgUMeC/yEvxcYGgAqaY/m3
         POdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3wYZB9ERreaEbrfGNUL0w2ZhteCfwV9C+BaGcB7Czuc=;
        b=vBt9+iIYirK9wq/mFIx8Dj0bYkYQx3zEGhYSJJkBRhnuc5tkO+FCkXvI34dokp329l
         hQLRcxWwg+gneoT6ie3mHR5JzknI8f1FEivje7zlEXK8TnTYESlNtDDUeBwkpHf9llip
         ihlLPPnFOrmLF3GpaUEmo1L+yQwBcz4vBMWjGUwpKBfgeG6GmsSpaxGbWKFnCzwg6+Cj
         NL8wAqxZNQtvDdVjdkoEfuOSWC7mhGfpC7bKF/Xwm9NSMAeAL5G6lBxCCTCn6pSggxBg
         tisvbP7oOaXh1VAG/cSDtkzKrATOLWgljY2ovRdWb0AeSGgl8+xnsyH1yhahv9XOdhRA
         fWgA==
X-Gm-Message-State: AO0yUKUqL9/sQinRmwxPIRtorrj161PgbeuFzAHUUqUdL0thmNlmu/ks
        jiZl4ZazdNE3VlZnLqHcUmmlGb6jP0kzDkHFfuewr5Tvar4=
X-Google-Smtp-Source: AK7set9qspwxNGXAZ8sPqT+J9z99GmDUh3UHFp2Pu6Qp07z4F4lEkl7IfVyKR9muP4kDSMkqAKl/FR1Nu4I6ogn0RAc=
X-Received: by 2002:a6b:6a02:0:b0:734:11db:e655 with SMTP id
 x2-20020a6b6a02000000b0073411dbe655mr1442881iog.45.1676843097515; Sun, 19 Feb
 2023 13:44:57 -0800 (PST)
MIME-Version: 1.0
From:   Neacsu Cristian <neacsu.cristianstefan@gmail.com>
Date:   Sun, 19 Feb 2023 23:44:46 +0200
Message-ID: <CADBWZmVixR1u979idTDKr0_Hi6Xaj-B5JKwjHwEJLF+p6=Q=Pw@mail.gmail.com>
Subject: GATT ReadValue in c
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I am trying to develop my GATT client using DBUS
I have the next code in order to read some data using ReadValue, but
i'm not sure that I convert properly the results into string.

If I'm using the next gdbus command:
gdbus call --system --dest org.bluez  --object-path
/org/bluez/hci1/dev_C7_5E_38_E7_67_25/service000b/char000c --method
org.bluez.GattCharacteristic1.ReadValue "{}"
([byte 0x48, 0x45, 0x4c, 0x4c, 0x4f, 0x21],) // it means HELLO!

If I use my code, is giving me nothing:

        GVariantBuilder *builder = g_variant_builder_new(
G_VARIANT_TYPE("a{sv}") );
        GVariant *options = g_variant_new ("a{sv}", builder);
        g_variant_builder_unref (builder);

        GVariant *args = g_variant_new("(@a{sv})", options);

        GVariant *result =
bluez_adapter_call_method_sync(tx_path.c_str(), "ReadValue",
"org.bluez.GattCharacteristic1", args);
        if (result) {
                GVariant *received_data = g_variant_get_child_value(result, 0);
                cout << g_variant_get_bytestring(received_data) << endl;
        }

tx_path is initialized with
/org/bluez/hci1/dev_C7_5E_38_E7_67_25/service000b/char000c

Do you have any idea what I'm doing wrong?
Thank you in advance

Cristian-Stefan
