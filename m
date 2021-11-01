Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A6FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 20:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54C8060EB8
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 20:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhKAUYJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Nov 2021 16:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhKAUYJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Nov 2021 16:24:09 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58C6C061714
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Nov 2021 13:21:35 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id i6so19786553uae.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Nov 2021 13:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B1yCBHmKZ9hZTjOyMm8hp8RdEN/Gn4kF3VWP61FM7Lk=;
        b=HyoQH86snD4Iri5PXe5LoHTiJMCaj6jncolAfLzR+xoAOmfVh6VpS/BSlYNTsO2+MF
         O5o3sqrvmxvoQUI1txefqchXKV631AjgwrolxtDEddDkDN7HwlXwmttZtIjFEg1fIRxk
         0eDjDuFQrda3cHQkB+3UNbCq0ai0a2EaATGWd64SD0NdNppDXVf9zp6/zaAPFB+aW4eP
         BlLuxgAAjcCjw+p4U6y2gHb9mkYcey0hvvkKzOjR+/qpPEDcnyb3SPioEMeCTTQXoi9J
         V3cZWgcjAEzw6imagCnECH8U7TwBvLUiyNRuuZyjcadIu+zH9IOVwu9lxzAjLLPQz5Ax
         ve4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B1yCBHmKZ9hZTjOyMm8hp8RdEN/Gn4kF3VWP61FM7Lk=;
        b=g1Zep5CPmK277nRHKLBo5P3MQmBijPMlimRXK4nMxwyQvLY8TiA+cNo5hksVBD/Yyq
         YepivYb4ClQEhYR3rHr+KXZNEwKtGiYP5rU4vaDvuFRMABrcNg3AlyXXnYtOya1tFFiR
         SJ7GvMi6TpURj9P4xeaMPyzJUn9UwASu/xSdmWD5pXdtnskDsoCbvhlpzuT2b6uNimbk
         8lSaQ5eLDzoqynE/pBsTg2M7x79VTP3saT1vxHqSqq3lIV3jSntJpzGz362hABgdbDeD
         //KIPXLcpo0RpU8Faa1HdJ5GIHIeaJaeHZkL+NbQ2z+AHaAyRJ4Tku7AXNOJj+W2KIxD
         /pAA==
X-Gm-Message-State: AOAM532sbh4x0SyjM8E9vLCVO8X4ehm1/A5DwuBnb6RiK15mUw17lWLH
        Gx3uNPo4p/U4wihQMOtRJK2wiA8w/bmkp7pHXzPBEU9Yvck=
X-Google-Smtp-Source: ABdhPJws1naUfMJc53llWAlhEJKyBjwxiOHy4rnR70MiQJe5+AcgXK2sMclFi7PavY3oCyUGK1LuJgk4yEZ3IiR370w=
X-Received: by 2002:a05:6102:3589:: with SMTP id h9mr18077604vsu.39.1635798094662;
 Mon, 01 Nov 2021 13:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <585f70ee-e8f0-dfbc-6d61-f5082a1c18aa@jajcus.net>
In-Reply-To: <585f70ee-e8f0-dfbc-6d61-f5082a1c18aa@jajcus.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 1 Nov 2021 13:21:23 -0700
Message-ID: <CABBYNZ+fffyc-wmbHn+Ecy-y3mqOgXVn2xbQARyaXnVras6tBw@mail.gmail.com>
Subject: Re: Is there a way to force legacy LE pairing for a device
To:     Jacek Konieczny <jajcus@jajcus.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jacek,

On Mon, Nov 1, 2021 at 10:26 AM Jacek Konieczny <jajcus@jajcus.net> wrote:
>
> Hi,
>
> I have a problem connecting to a BT device from a Linux desktop =E2=80=93
> pairing fails, while an Android phone pairs properly.
>
> The obvious difference in the btsnoop logs is in the pairing request.
>
> Android:
> < ACL Data TX: Handle 65 flags 0x00 dlen 11
>
>
> #995 150.491086
>       SMP: Pairing Request (0x01) len 6
>         IO capability: KeyboardDisplay (0x04)
>         OOB data: Authentication data not present (0x00)
>         Authentication requirement: Bonding, MITM, Legacy, No Keypresses
> (0x05)
>         Max encryption key size: 16
>         Initiator key distribution: EncKey IdKey Sign (0x07)
>         Responder key distribution: EncKey IdKey Sign (0x07)
> [...]
> > ACL Data RX: Handle 65 flags 0x02 dlen 11
>
>
> #1006 150.571137
>       SMP: Pairing Response (0x02) len 6
>         IO capability: NoInputNoOutput (0x03)
>         OOB data: Authentication data not present (0x00)
>         Authentication requirement: Bonding, No MITM, Legacy, No
> Keypresses (0x01)
>         Max encryption key size: 16
>         Initiator key distribution: EncKey (0x01)
>         Responder key distribution: EncKey (0x01)
>
>
> And on Linux:
> < ACL Data TX: Handle 16 flags 0x00 dlen 11               #53 [hci0]
> 132.273100
>       SMP: Pairing Request (0x01) len 6
>         IO capability: NoInputNoOutput (0x03)
>         OOB data: Authentication data not present (0x00)
>         Authentication requirement: Bonding, No MITM, SC, No Keypresses,
> CT2 (0x29)
>         Max encryption key size: 16
>         Initiator key distribution: EncKey Sign LinkKey (0x0d)
>         Responder key distribution: EncKey IdKey Sign LinkKey (0x0f)
> [...]
> > ACL Data RX: Handle 16 flags 0x02 dlen 6                #57 [hci0]
> 132.362160
>       SMP: Pairing Failed (0x05) len 1
>         Reason: Invalid parameters (0x0a)
>
>
>
> So it looks like 'Bonding, MITM, Legacy, No Keypresses' used by Android
> works and 'Bonding, No MITM, SC, No Keypresses, CT2' used by the desktop
> Linux (bluez 5.62, kernel '5.6.2-050602-lowlatency' from Ubuntu) does
> not (note: I am still quite ignorant about Bluetooth stuff).

What android version are we talking about here?

> So my question is: is there any way to force using legacy pairing? Even
> if that requires bluez or kernel patching (though, I would rather avoid
> that).

So Invalid Parameter is normally used when the stack doesn't
understand something in the request:

'x0A Invalid Parameters The Invalid Parameters error code indicates
that the command length is invalid or that a
parameter is outside of the specified range.'

From the looks of it Android doesn't set SC nor CT2, which were bits
introduced after 4.0, so perhaps with this version of Android we
cannot use one of these bits (CT2 most likely).

>
> Greets,
> Jacek



--=20
Luiz Augusto von Dentz
