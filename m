Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA475C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 18:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F0B522B3B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 18:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbhAYSA0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731325AbhAYR7s (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jan 2021 12:59:48 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475C7C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jan 2021 09:59:08 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id e70so13570773ote.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jan 2021 09:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=17Laoe1dDWDlB1+A5B/rlzlj0Hpndd49kssrXZqEyA8=;
        b=kGQQIhS8UIZafz0drfq+W/GQ1R8KQ2s+t5ZxASChV3UHBS3Gc/i0zkcIzna2dwhmZl
         pzJsmRXVECQwbs52i9j4mDnO8EXm7OWJDyRI7DgM9doRxvVOfewLwcEHxegIv8+K4cqe
         EcREwTjIGwCrWxigYWlNa1xnPPWy8yirbI8DcThbJFVSVUqkZrqHPBoW9s1xqabMpKfE
         3o6orQEXGDEdzTAJU0WqFvksbol3hopHJn4AIRhPDdiA+vzpIYGtNRdOYfOd0k0uMJax
         mJJGmuf0KC3FYtQ4r3sfgacTSfbrzWALpwTP0+F53IZhlGHsZFPaa+l1VspRuls+JuX/
         AHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17Laoe1dDWDlB1+A5B/rlzlj0Hpndd49kssrXZqEyA8=;
        b=TP1JFAaJrZAfte5mKh9cUVDMA6+ylsL2KdOUZZgHv4JfromsFz2HZu5NuOxQNB0NU/
         Jt2ksDZDMPzQrpMDPHGRaC6iiRAfwtBjT9QEw713jJqfln+Cuzt1/HRkqoeAEoQdBy8o
         Ot1zLXHj9dGoMVMQenJWp+SF2Ng9e0R1FGoijW3ul3Fs/WqIgndv7r6HshTjGckJqWJX
         gve8SQwXgz33Obz5wxlnaJCgQpgjAS7CW84CnYOLZXUgIJsTN1/59/Dx+SWreQ96k/23
         RQO3pZu81gjCZKWTdeXnBUFMeSMp2mde0/WoUoUvpBfl2R/ue7dMCXMX92xLBCz1OAzc
         siJw==
X-Gm-Message-State: AOAM530kCB8QSnrO6YD6ORAeRgxxmEBxD1QDoBn7ukAgIv5hbHHtEjml
        gHHCSYt+8exre0CmcoL7EG56phwAMcT+kJzsHEA=
X-Google-Smtp-Source: ABdhPJyVxzSlPaC/XL23tJTKLafg8dF6yWBlUGgA128ej3jlI7XQGfUoxrdIn6pkqNsBHikADV7KdcR1rO81Cl3N7Os=
X-Received: by 2002:a9d:6f17:: with SMTP id n23mr1257863otq.371.1611597547631;
 Mon, 25 Jan 2021 09:59:07 -0800 (PST)
MIME-Version: 1.0
References: <CAC9s0NazfjTcapy52XSdJSKSmoAQmBom_JTfgROKRkVmAbaMDg@mail.gmail.com>
 <CABBYNZJrb=jpuaUAC9DxRSnRrReZRQgPTKwgqQYBN-3KWoUxQA@mail.gmail.com> <CAC9s0NYvmRHQ1qrbpQtKrACi2Mp7YCTPA4oYF-TwgpnCN-vhPg@mail.gmail.com>
In-Reply-To: <CAC9s0NYvmRHQ1qrbpQtKrACi2Mp7YCTPA4oYF-TwgpnCN-vhPg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 25 Jan 2021 09:58:56 -0800
Message-ID: <CABBYNZKeLsp+QhUOZQBhFuq6ZgHpZ+VPX=LYevad1UmZb5qq5g@mail.gmail.com>
Subject: Re: How to add "Service Changed Indication"
To:     Kenny Bian <kennybian@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kenny,

On Sun, Jan 24, 2021 at 10:42 PM Kenny Bian <kennybian@gmail.com> wrote:
>
> Hi Luiz,
>
> Thank you so much for your reply. I appreciate it.
>
> By "registering the services", do you mean "RegisterApplication()" in
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-gatt-server#n656?
> If that is the case, I believe I already registered the services.
> I checked the files in /var/lib/bluetooth. According to
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/settings-storage.txt#n321,
> there should be a "[ServiceChanged]" section in the "info" file. But I
> don't see it in the "info" file. Is there a way to tell the "Service
> Changed Indication" is actually working?
> Let's suppose the "Service Changed Indication" is already enabled, is
> there a way for the mobile app to check on their side to tell which
> service(s) got changed?

HCI traces (btmon) should be able to tell you if it has been
subscribed or not, if there is an Indication in it it probably means
the remote has subscribed.

> Thanks again for your help.
>
> On Sun, Jan 24, 2021 at 7:35 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Kenny,
> >
> > On Sun, Jan 24, 2021 at 12:45 AM Kenny Bian <kennybian@gmail.com> wrote:
> > >
> > > Hello,
> > >
> > > We implemented a GATT server on Linux in Python. The code is based on
> > > the code sample(https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-gatt-server).
> > > The BlueZ version is 5.48. But we found a problem. The cached data in
> > > /var/lib/bluetooth caused the mobile app to crash if some
> > > characteristics are changed. After some research, we found "Under BLE
> > > standard 'Generic Attribute'(0x1801), there is a Characteristic
> > > 'Service Changed' (0x2A05) with 'indicate' property", see
> > > https://github.com/espressif/esp-idf/issues/1777.
> > >
> > > The questions we have:
> > > How to enable the "Service Changed Indication"(0x2A05) in the
> > > bluetooth? Is there any code example in Python?
> >
> > If you are registering the services with Bluetoothd then it should
> > generate the service change automatically:
> >
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database.c#n1185
> >
> > When a new service is registered it is indicated here:
> >
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database.c#n1452
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
