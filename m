Return-Path: <SRS0=1j7M=2I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27BEC43603
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Dec 2019 19:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7494C2082E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Dec 2019 19:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L52GTpe3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfLRTCo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:02:44 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44116 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfLRTCo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Dec 2019 14:02:44 -0500
Received: by mail-oi1-f194.google.com with SMTP id d62so1638945oia.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Dec 2019 11:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TNfprp8nc75kh5zAluNCqfSsBco4a1uiDSYyXoDQzSI=;
        b=L52GTpe34dvN5XUxc9qH29l0XbqRp8ZSS2+CI53HV0YWl5HETHU06rJrfSa+Zaco36
         RC2FUqDAJySDIrkd7z0dqtJcUTsTcepJxf621ECk8L0N35ulN5uEw0POvA7J8P3oxY1E
         YL8ctH/Tryr+Y1O15ybFdLL+/yhHKC06oq47gRID3pLiJpGfTORRcTrvRz1HqrvpXHbG
         TYP67Co9ErwfIAJLLj40f5+viEWVjnGceUJqMHiZsvv0pJYCVo1MMcXcPDb0JE6FaU9e
         OdJn1+tLP/E3N0+9uNKzQKLn3IlP8RCNqzAljRvt1KvwXuwaRGcDS7kSIXyFY9H0M6EO
         Te0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TNfprp8nc75kh5zAluNCqfSsBco4a1uiDSYyXoDQzSI=;
        b=BJ3oS1Ou1XU3XWKrBOMDrjf377NpcLmMy2ANJ/7phQivlRKsOx9bH+N9Psqf+vjxof
         v0E3n1WpRHXR3BwiIVqz8wkZ54sLrzTTvxOLHvZAoR8P3YOLzZxH4WxRigdSa7kkozhS
         3OjdkYY26EF/qy9IzApT9yPC9CMkyZsClpzMLrNSfcIL1r1wIKHqc9BWSoVM1FBoqkdN
         xn1kutrG4fNaBNsPZPTKKjw2q4Va8QWvCgwlnT8S/OW+fk/0YldKaMInvjECi3ydRpKX
         88NhFQmmFSPJSoABl4Tl6PDr1H8cjHwXQQZuWbxModYuIjBOc5eBUCB9jTbr6eoloQj2
         QfDg==
X-Gm-Message-State: APjAAAVZ0tAFhVzGYabs9+aM00vzcnwSRSWVRkUAIFTFvAHdU5xq4ARh
        LEeYKGDT8Hy73b2I6PjfzBvWBabhohfC3nGL4jqkKGPFc5Q=
X-Google-Smtp-Source: APXvYqwqH724arFENC7rR14qxLtcaHTP9gzkb9nzZKFYIrSyJCnFm8rQt+FUdCyF4Zf9S8ign2jkBhrWLZMwC02xXfo=
X-Received: by 2002:a54:4f8e:: with SMTP id g14mr1163492oiy.8.1576695763613;
 Wed, 18 Dec 2019 11:02:43 -0800 (PST)
MIME-Version: 1.0
References: <e4a4844024f9c1fd4da044a6d837e2dba17e6ea6.camel@peiker-cee.de>
In-Reply-To: <e4a4844024f9c1fd4da044a6d837e2dba17e6ea6.camel@peiker-cee.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 18 Dec 2019 11:02:31 -0800
Message-ID: <CABBYNZLpKQ8q7j0VjKKyyf4W8DuOnez2f35RYHj8p3SnmzenXg@mail.gmail.com>
Subject: Re: GATT server does not forward written attribute to application
To:     Konstantin Forostyan <konstantin.forostyan@peiker-cee.de>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Konstantin,

On Wed, Dec 18, 2019 at 2:36 AM Konstantin Forostyan
<konstantin.forostyan@peiker-cee.de> wrote:
>
> Hi,
>
> During Bluetooth Qualification tests with PTS I found out that if an
> attribute provided by a GATT server created by BlueZ 5.50 running on my
> IUT is written by remote, the value of this attribute is not provided
> by 'bluetoothd' to the upper layer. With a minor modification of
> 'bluetoothd' I managed to get the tests through, so I'd like to get
> feedback from the community, whether this modification was necessary or
> may be there's another way of getting attribute write working.
>
> For GATT tests I used 'btgatt-server' application provided by BlueZ. In
> order to test writing characteristic value I made "Device Name"
> provided by the application writable. It turned out, that the
> 'gap_device_name_write_cb' function that is called by the daemon upon
> writing "Device Name" always receives 'value=NULL' and 'len=0'. The
> reason for this is that in the 'gatt_db_attribute_write' call in
> 'prep_write_cb' in 'gatt-server.c' file in 'bluetoothd' both 'value'
> and 'len' are hard-coded to NULL and 0 respectively.

Well not actually a write but a prepare write, so until execute is
called nothing shall be written, so except if I missing something this
is the correct behaviour, if you need that for authorizing the prepare
the you should look into:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/gatt-api.txt#n104
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/gatt-api.txt#n273

> With the following modification in 'gatt-server.c' the callback in
> 'btgatt-server' application receives the arguments it expects and the
> GATT tests can be passed:
>
> --- a/src/shared/gatt-server.c  2018-06-01 10:37:36.000000000 +0200
> +++ b/src/shared/gatt-server.c  2019-12-13 12:16:58.000000000 +0100
> @@ -1291,7 +1291,7 @@
>         pwcd->length = length;
>         pwcd->server = server;
>
> -       status = gatt_db_attribute_write(attr, offset, NULL, 0,
> +       status = gatt_db_attribute_write(attr, offset, pwcd->pdu + 4,
> pwcd->length - 4,
>                                                 BT_ATT_OP_PREP_WRITE_RE
> Q,
>                                                 server->att,
>                                                 prep_write_complete_cb,
> pwcd);
>
>
> Best regards
> Konstantin
>


-- 
Luiz Augusto von Dentz
