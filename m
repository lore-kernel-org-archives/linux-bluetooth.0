Return-Path: <SRS0=QFCk=X4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38509C10F14
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Oct 2019 12:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3DC20700
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Oct 2019 12:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=noa-labs.com header.i=@noa-labs.com header.b="LNxXYnqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfJCMIG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Oct 2019 08:08:06 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:34790 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbfJCMIG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Oct 2019 08:08:06 -0400
Received: by mail-io1-f50.google.com with SMTP id q1so4939547ion.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Oct 2019 05:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=noa-labs.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=ieYSwOaZo+wm6Rg+13JdessdLSkyaV/fVlr7Jh+OF6s=;
        b=LNxXYnqe2RRxhjqofXZZacLxv440G/sx+w+1iQj0joo/A/lt3tj7MMys4xYbwQtW4m
         qUrPNaMowSXUrvJtMrfTGv1B6EpjFdihZaQGtJJJuvRkRcfTGWXbtvMnLZPrQuVnrTd1
         1G0OKE/Yq3zxPTYX1iNRFg2LYw85n5U4Q89rM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ieYSwOaZo+wm6Rg+13JdessdLSkyaV/fVlr7Jh+OF6s=;
        b=pXsIOAI8H7Wag7KVfQ/AKCcoseYabCGbs3AAeHVCxgcGy0eOCpFp2HgHlmKQeLD13T
         VE1KSXnI+eqMmyXnHSfJvrHDa6pYhGsnV/4Mfhgck5uSr9Ie3xM/uke8LW6M7wek5zFf
         +oR5jWeQiR2KBWaEZPv2xLEejmlq924ANJ3CIMYMK3Wj+5qk+QQOAwHtfNUPM4Coa7ka
         ZZS9FMHZb8xANhX/LtjOvtfdWIaiYLZXgcrXJmv+G+L4K4u723r63/7ms8+dHqOF2wZt
         Vp9HvoTz2iI+ESGCVE9M6OMl5clV36E8Sykpalhw+NtWH2Y2ENXekMp1gMPwNJ91G1ra
         1RXw==
X-Gm-Message-State: APjAAAXpFJUbmsSS3F363Ha8WLhNKB30/fhjztErjJs4mc5S3J0IEHb2
        GliM+D1MYzMOlCONnVU58pebvUt/eRAPzVt2m/S7SC1ysSt34o/u
X-Google-Smtp-Source: APXvYqzAMbbBOVimFPb7Oi7aVZ7jceSkgOwDF1fpt/TbIgW1a5GMaX5vFnjy0etzMTZZO9dlrB58A33XUdUkMOBp3l4=
X-Received: by 2002:a6b:fe09:: with SMTP id x9mr2677389ioh.144.1570104484942;
 Thu, 03 Oct 2019 05:08:04 -0700 (PDT)
MIME-Version: 1.0
From:   Pavel Nikulin <pavel@noa-labs.com>
Date:   Thu, 3 Oct 2019 18:07:58 +0600
Message-ID: <CAG-pW8Gjp=adimXCkKEgZPvUkRV51zb1CwZaw6FrjVxOUwQdmQ@mail.gmail.com>
Subject: Battery readouts on dbus for GATT battery service
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I have a bt 4.2 mouse that has a battery service, but no battery
attribute visible in Bluez, Rapoo m550 using YiChip 1201.

Is it even hypothetically possible that a device can have a battery
service, but no battery attribute?

This is what I see in my syslog

Oct  3 15:07:38 xps bluetoothd[1837]: No cache for ED:8E:0E:DF:E0:B8
Oct  3 15:07:38 xps bluetoothd[1837]: BATT attribute not found
Oct  3 15:07:38 xps bluetoothd[1837]: batt-profile profile accept
failed for ED:8E:0E:DF:E0:B8
Oct  3 15:07:38 xps bluetoothd[1837]: GAP attribute not found
Oct  3 15:07:38 xps bluetoothd[1837]: gap-profile profile accept
failed for ED:8E:0E:DF:E0:B8
Oct  3 15:07:38 xps bluetoothd[1837]: input-hog profile accept failed
for ED:8E:0E:DF:E0:B8
Oct  3 15:07:39 xps bluetoothd[1837]: bt_uhid_send: Invalid argument (22)
Oct  3 15:07:39 xps bluetoothd[1837]: bt_uhid_send: Invalid argument (22)
