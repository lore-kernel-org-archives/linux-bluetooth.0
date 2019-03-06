Return-Path: <SRS0=crNx=RJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD3AC43381
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Mar 2019 22:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F2420663
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Mar 2019 22:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzPYneUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfCFWhu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:37:50 -0500
Received: from mail-yw1-f54.google.com ([209.85.161.54]:43705 "EHLO
        mail-yw1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfCFWhu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Mar 2019 17:37:50 -0500
Received: by mail-yw1-f54.google.com with SMTP id u200so11600097ywu.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Mar 2019 14:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=sPBcu1XsEHIc/iIqF10mSwam4N3Cp2ypkmMjMTVdJYE=;
        b=PzPYneUG5G2UNZYFnJSdq3iWXvFS0vX5Fyky/WiycNa0p9wWj9AkWjyUyar0TQbXqt
         63xnH4jQUlRlc8Ua3RfLxvYcglG4YO/Vquwnfw+3OccqzEY1/TQ5Rj51AQ+UJPYucl0E
         yq5Q9+Pgpa3cPodK1+wBQSmyzOTpmVTBQaILswgX8JhOGwS/FME2zaLAsYdB9hci37Ye
         deLEEwfxJxjtx6QVutlttQaQenBIo9lsReIBYsrdmIAx70a2cAHO4BltB06fVFEsFjFB
         cgoRHqB8Ia7peCAfahD6ViSvPg83xJAy1FmqXd2U2t8uoVkoqzSUrCJ9jURWHICj24yf
         ehrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=sPBcu1XsEHIc/iIqF10mSwam4N3Cp2ypkmMjMTVdJYE=;
        b=NdcGy37oAF20lgQbKULUxlEfGh3091lAxPY7Qr1j1XZGrKaOusWKzWmpncZEMz9eKT
         iEdMc11OuMTLBywrbi6QFPa+khTjHDZbGvwCTY3LFapFsTk6SCEsi9UDIrv7jwKtTpZi
         kNsGyhheSEMlRd4GqJuPSeQuuCAiUkgYz5+0lEOTzAYlfx2SAKpFtKtis3PrBYJJk7QM
         8fhS/vPx6nJpTsXkR6jMvdkH8m57TDWqXXMBO+040jqshmU98fyvitW+Z45MYwfaVQYj
         jZg0DRNhpYk7Q9xBtgeDTxTGI4+AhaPmDpV/5orXDQTeA4p1co8x8aTMC8n8PnwbW4cC
         3hmw==
X-Gm-Message-State: APjAAAUjz/bNuVPKuGvYSCU5PgzJlE2eXudAve4fzKS+ERjxyJ39FVJQ
        5i1MzHsjnWIwKDcf5NAPKdpA3/5mZIWxcTbIsc8ZI4LH
X-Google-Smtp-Source: APXvYqxnMyrVJgFQoNnjXxI3onIMReBwQypSTHIL4QDl4U1V+j7VkM2IEMDZQTXiSE6qJf704KRIElm4wabDUDsd3e8=
X-Received: by 2002:a81:2e50:: with SMTP id u77mr7392871ywu.433.1551911868831;
 Wed, 06 Mar 2019 14:37:48 -0800 (PST)
MIME-Version: 1.0
From:   Barry Byford <31baz66@gmail.com>
Date:   Wed, 6 Mar 2019 22:37:38 +0000
Message-ID: <CAAu3APbx4njmmBgu4_U=9CEahhK-f8BnhMuAwp0=XgFRZhexvw@mail.gmail.com>
Subject: Peripheral notifications not showing up
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I have a system that comes with BlueZ 5.43 installed on a single board
computer (SBC). I have downloaded, built and installed various newer
versions of BlueZ but I am having problems getting them working
correctly.

I have a peripheral (very similar to the gatt server example in the
test directory) with one characteristic. My example was working before
upgrading. However after upgrading, when I turn on notification for
the characteristic it is not showing on the phone.

I do see the notification turn up in dbus-monitor but not in btmon.

signal time=1551910979.743011 sender=:1.38 -> destination=(null
destination) serial=339 path=/ukBaz/bluezero/service0001/char0001;
interface=org.freedesktop.DBus.Properties; member=PropertiesChanged
   string "org.bluez.GattCharacteristic1"
   array [
      dict entry(
         string "Value"
         variant             array of bytes [
               78 14
            ]
      )
   ]
   array [
   ]

I have tried going back to version 5.43 again but now that is not
working either.

The configure I ran was:
./configure --prefix=/usr \
            --mandir=/usr/share/man \
            --sysconfdir=/etc \
            --localstatedir=/var \
            --enable-experimental \
            --enable-maintainer-mode


To get configure to work without error I needed to install the following:
sudo apt install glib2.
sudo apt install libdbus-1-dev libudev-dev libical-dev libreadline-dev

I have tried various variations on this and done a lot of searching
but don't seem to find an answer.
Is anyone else seeing this issue?
Anyone have any suggestions as what I could try?

Thanks in advance,
Barry
