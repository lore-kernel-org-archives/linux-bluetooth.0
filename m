Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24BFC433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 00:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F6F361278
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 00:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhELA3a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 May 2021 20:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhELA3a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 May 2021 20:29:30 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA4CC06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 17:28:23 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id l21so20005366iob.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 17:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Wc7KeWQzM7R2bzHUOFy/yjDt8VNG6x8f3+Mc6PwEFBw=;
        b=emmLO5GF+aFAfhHoOjGwSWnN/ombwRm53u/qR2sDwFJGdJIGcWzrmTwu9D9euV5Vg4
         aob5ANNpQZjKZ0IFT3YAm7igm/iolVRJTzVCyAElmct1/osMLS20B+tsqUGQRSWl8bNw
         rxUE+OdlKd51yUgzetMP54gfjb6z04FBNqhd3r5cjeB+/l5yELokJoUgNc+4dipfnG2s
         6QgDZ+42UfrLpGn9o8YySCBZ/wwPb9iHfDhR5LIF7Ktvt4UuJiL88+j92quk0gd2xF68
         AHpMm/TK6oQ5h42sG9hfLZQfA1qTIRmGOUH9p5AAc+QiIVzbsNel1sA4bspiRnpT26Da
         M56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Wc7KeWQzM7R2bzHUOFy/yjDt8VNG6x8f3+Mc6PwEFBw=;
        b=bEOpJVtslMqnwtSgWMaj+e/pq7buAhpa6IqkmgIj7ls53/Mo1JSM9a0a+vghguSg/x
         Ke4Fd/rCPRUx2A0sspKcQYViFdtg0veyYWIrFXgcBhn4xd7ZB8rc6ULZkYyo9GMq2LaB
         C/e/GzxhmTcZdonoVmmD+mbILArwxajrt4ZEh893xjQ40XzPjE6v4EqPMVVF+Sne5IhR
         8nJ+8okbIEx2oikAkM45miVR81PKD4I6jM4edmu4bavGRTS2C19MMOgXjCAjP0v+a+FK
         ucFMD6JmCbsyd8/mTtjPAWJY9nOhbzdaLNbbxNRNq1bZWq3rw1ekMhyqrFPR+qp0loaC
         1i1A==
X-Gm-Message-State: AOAM5325dvbukFcBfKx+lhKrdnWkbKpcQcL8pmeO8eEHm1NPtVqbHT80
        H1uZ3zB/IJ2OZranXwos/s3qSTMFRPmqU3DbQPFNbHvu3CqD
X-Google-Smtp-Source: ABdhPJxjsu8O70gj7EtjNbkndE04+oHO2QfAyTIANtSmHWWS6RQ45XGAEL92ppBrs2JjWODS9+40sCvQnqBa/SuV394=
X-Received: by 2002:a5e:8c11:: with SMTP id n17mr15753843ioj.53.1620779302296;
 Tue, 11 May 2021 17:28:22 -0700 (PDT)
MIME-Version: 1.0
From:   Kenny Bian <kennybian@gmail.com>
Date:   Tue, 11 May 2021 17:28:11 -0700
Message-ID: <CAC9s0NZaXLFvf8DbdSaQC4za-TkR2Dj+r5mp313kCUjEP0S1sA@mail.gmail.com>
Subject: Build BlueZ 5.50: getting errors
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We are using BlueZ 5.48 in embedded Ubuntu 18.04. We're trying to
build BlueZ 5.50 for embedded Ubuntu 18.04 because we need the
"Service Changed Indication" feature which was fixed in 5.50. The host
system to build BlueZ is Ubuntu 18.04.

I downloaded the BlueZ 5.50. The CPU on the embedded device is
"Freescale i.MX6 UltraLite". As we need to cross compile the BlueZ, I
suppose we need to use the option "--host=arm-linux-gnueabihf". Is
that the correct option for cross-compilation? Here is the configure
command:
./configure --host=arm-linux-gnueabihf --prefix=/usr
--mandir=/usr/share/man --sysconfdir=/etc --localstatedir=/var

But there were errors when we ran the command above:
checking for GLIB... no
configure: error: GLib >= 2.28 is required

So I installed these packages:
sudo apt-get install libglib2.0
sudo apt-get install glib2.0

But I still got the same errors even if the packages above were
installed. It seems GLib is 2.27 for Ubuntu 18.04. If that is the
case, how can I get GLib version 2.28 or above in order to get
configure working?

Thanks in Advance!
