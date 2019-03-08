Return-Path: <SRS0=I3Ez=RL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20748C43381
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Mar 2019 21:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18EE2081B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Mar 2019 21:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvK3/SKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfCHVSG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:18:06 -0500
Received: from mail-yw1-f45.google.com ([209.85.161.45]:45755 "EHLO
        mail-yw1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCHVSG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Mar 2019 16:18:06 -0500
Received: by mail-yw1-f45.google.com with SMTP id r188so17385048ywb.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Mar 2019 13:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=MR7LzeUQKh8wLy2TQuCS6Bi9qCnRs4apJgPx+YRzaKk=;
        b=kvK3/SKOv2AX0ReuNjoreCkvNrtvkUG+CGHcL9aN85w3/s/acjL3/e4qgkN3Is+RIq
         4i3D98rHj//4t/fR6jrD7FdYDedojQVdKgM0KMIUS1SZH6//8nWa7/n3XLvFKRz76O/T
         tiUeyV/pfmkQGbom0Z1UbiJyxovajWBj10Ljcp0KpTiPRTNk6eOKWDwpBpmYwM/1Nd2E
         rpidtGX8Zz0991yXiiCwqCMOVVVIyX2Y+ksjUuxnMOFP1tAKGwVol0M34LWfrHGXuq6V
         oIFrM5p485wr5uqsZbLqFmKrhSBIn9WIcEqRC/cstoa6chfF5BNqCKjOhNhfTvZ18nNK
         abZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=MR7LzeUQKh8wLy2TQuCS6Bi9qCnRs4apJgPx+YRzaKk=;
        b=oJVMKhFmq16aBn/KVoTH3TxO5zdQ/uty6jSqXCizjSNLQAlM63532tdUs2mWuEfDYh
         fqN/CvsbB7LA+iS7FEOuLy5cbPq786mREPmNeWI+BKO77qUzWvT3UVTFymHYzGlaAzbk
         shgGTD3pQU7D+iGApdmyhp7FooTT3bCVD0ZFM2u3cZx+MnrhvhznFQ/EXMgyGSkwG4vI
         c+OvZEPxPPNB83z25GA4RuIvSKczHTCHvln1uPXipWc66dTxWxdNWPP03iGmYG6O5mAq
         TPjqh+dVOjNiAqDQveXr9m97hZD2O+5rE4b7iklZuDIEUlZEQRnfsbHdI7WbrYRbLea3
         x7sw==
X-Gm-Message-State: APjAAAWBep12qN/pW1qTgTPxetAle5mv7/bF6VhuFw7HHZURMHmnKwXg
        piy8ZSzJxcNxzxGwJNBcLuk1e8bWTdi1G8hYVFf+o+xa
X-Google-Smtp-Source: APXvYqxTDnvhh2i1J9ljfPW7aRoVj9WAdrAsZ85shA9KOtO8TLgH/JVSkaGaM6pNCow2WRfwH3u0Hu0CwFrscCtWgs4=
X-Received: by 2002:a0d:e850:: with SMTP id r77mr16674993ywe.291.1552079884603;
 Fri, 08 Mar 2019 13:18:04 -0800 (PST)
MIME-Version: 1.0
References: <CAAu3APbx4njmmBgu4_U=9CEahhK-f8BnhMuAwp0=XgFRZhexvw@mail.gmail.com>
In-Reply-To: <CAAu3APbx4njmmBgu4_U=9CEahhK-f8BnhMuAwp0=XgFRZhexvw@mail.gmail.com>
From:   Barry Byford <31baz66@gmail.com>
Date:   Fri, 8 Mar 2019 21:17:52 +0000
Message-ID: <CAAu3APbP02yHgtJE6k4D4iQ4ukFRjQhF3rs0A=jPL-J_DZKZMw@mail.gmail.com>
Subject: Re: Peripheral notifications not showing up
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I have tried the same experiment on a Raspberry Pi.

$ uname -a
Linux raspberrypi 4.14.79-v7+ #1159 SMP Sun Nov 4 17:50:20 GMT 2018
armv7l GNU/Linux

I ran the peripheral code I have and it worked fine on the Raspberry
Pi. I then rebuilt BlueZ 5.43 and reinstalled it and I see the same
issue with getting notificatins.
That is, reading of the characteristic in the Nordic nRF app on my
phone works. However, when I activate notifications I can see the
status change on the peripheral and the notifications show up on the
DBus. The notifications just don't show up in btmon or on my phone.

Does anyone have any suggestions of how I can debug this?

Thanks,
Barry


On Wed, 6 Mar 2019 at 22:37, Barry Byford <31baz66@gmail.com> wrote:
>
> Hello,
>
> I have a system that comes with BlueZ 5.43 installed on a single board
> computer (SBC). I have downloaded, built and installed various newer
> versions of BlueZ but I am having problems getting them working
> correctly.
>
> I have a peripheral (very similar to the gatt server example in the
> test directory) with one characteristic. My example was working before
> upgrading. However after upgrading, when I turn on notification for
> the characteristic it is not showing on the phone.
>
> I do see the notification turn up in dbus-monitor but not in btmon.
>
> signal time=1551910979.743011 sender=:1.38 -> destination=(null
> destination) serial=339 path=/ukBaz/bluezero/service0001/char0001;
> interface=org.freedesktop.DBus.Properties; member=PropertiesChanged
>    string "org.bluez.GattCharacteristic1"
>    array [
>       dict entry(
>          string "Value"
>          variant             array of bytes [
>                78 14
>             ]
>       )
>    ]
>    array [
>    ]
>
> I have tried going back to version 5.43 again but now that is not
> working either.
>
> The configure I ran was:
> ./configure --prefix=/usr \
>             --mandir=/usr/share/man \
>             --sysconfdir=/etc \
>             --localstatedir=/var \
>             --enable-experimental \
>             --enable-maintainer-mode
>
>
> To get configure to work without error I needed to install the following:
> sudo apt install glib2.
> sudo apt install libdbus-1-dev libudev-dev libical-dev libreadline-dev
>
> I have tried various variations on this and done a lot of searching
> but don't seem to find an answer.
> Is anyone else seeing this issue?
> Anyone have any suggestions as what I could try?
>
> Thanks in advance,
> Barry
