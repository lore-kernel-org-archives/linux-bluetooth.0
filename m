Return-Path: <SRS0=ZhIC=B5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A275C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 18:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BB442083B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 18:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQDJHmbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHSSTQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHSSTO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Aug 2020 14:19:14 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF09C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 11:19:14 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u24so20707983oic.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 11:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m0yXXFotQWroHLaVKba/7dhmvFCGNHuFoGGgLqaXvDA=;
        b=JQDJHmbp5ZXBQhpzSe7Q88DuMFh0mAh3S2t0cvF+7IXcPBibqH5IZLbLonyuV7RMuH
         UqlBUQjIrXKnGlmjxHH4/rkAntqpJ/W3QvXFdzjcXz8YiKl7f4wyGUG5q9iRopp8xfpQ
         qirWenKn/6RqJrGDJS2OIVrK+3HGVaS+u5/W2/lsAbtRfiz7RGQjyrAxvbhNUhtp0Gqe
         S244ojAn5EHaUh+7etuw0XSyTFadcXY6JTaUAg+TWZ2Jyg61vXOpy8esvAbuoKYjtDAi
         o/6nNsVBUxntciXD8ZOPqqzExd7sA8MWsp5IQYA/yPAQrYNjpjDZbqmcWm0QxJ0PIT/N
         JOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m0yXXFotQWroHLaVKba/7dhmvFCGNHuFoGGgLqaXvDA=;
        b=CXcpJNOqLO2GKYANhD16hugW7rk5vjP/98HuKg2V8ovXVNoYVauf2EpkCYfg0xoSio
         vbf2qvlwo16y4XeaKjHkwtek1P+l2TwZnAYa9dmCuyFC78KQfGtG6NGskvcCz/LorORg
         QvBc9vQSRsglk3tRpTyPeMFFd88OsdDIYc26lSUknP1gl+JDf31MqxzxcQ+OKC4G2iGy
         81T0WLodieC5F9Pirg0xGp8LvNsydfeldYxNMdX6/agw//iGGPSFPEQ4JTAMn/bFtf5L
         MTjXCxVilqhDE4BnQ4iqB+x4LImzt9aiTBVZhYtOEa19ur9MRIh6/ULYaZkpDnTUWrXf
         MnnQ==
X-Gm-Message-State: AOAM530GhBdFvN0q/ZAw/BfwXHDkTGcs+zn4q2vTbz8NDNw3kT5tMhNF
        uE7fpjP/LqGTZwO8fobWIre6e7MyzvRUOfZhSpcQon0/
X-Google-Smtp-Source: ABdhPJxMfae1EFRxtxSX00n6JKXpJMdp1Bst+fRKB3P9Q3jVNqtUC/hjjnmOxfmfA9p4tbM/m2rIHkkcq9ZCbuLNnbw=
X-Received: by 2002:aca:cc50:: with SMTP id c77mr3837149oig.152.1597861152607;
 Wed, 19 Aug 2020 11:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <HE1PR05MB3338001B735642B334087FCBFC5D0@HE1PR05MB3338.eurprd05.prod.outlook.com>
In-Reply-To: <HE1PR05MB3338001B735642B334087FCBFC5D0@HE1PR05MB3338.eurprd05.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 19 Aug 2020 11:19:02 -0700
Message-ID: <CABBYNZJ3SG9pNYBNyusDagmwRG4PsEY189k2d31DmC=j9bTDDg@mail.gmail.com>
Subject: Re: LE Secure Connections: Disconnection after pairing
To:     =?UTF-8?B?SmFyaSBKw6TDpHNrZWzDpA==?= <Jari.Jaaskela@oulu.fi>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jari,

On Wed, Aug 19, 2020 at 12:33 AM Jari J=C3=A4=C3=A4skel=C3=A4 <Jari.Jaaskel=
a@oulu.fi> wrote:
>
> Hey,
>
> I encountered this issue in July, and I reported it as a bug here: https:=
//bugzilla.kernel.org/show_bug.cgi?id=3D208637.
> See the bug report for logs.
>
> Here's the description:
>
> I have been trying to establish secure connection to a gatt service. Pair=
ing completes successfully (using out-of-band data), and the client can rea=
d characteristic that has encrypt-authenticated security level, but the con=
nection is lost soon after pairing (as seen in the btmon log). This seems t=
o happen because the controller responds with reason Connection Timeout (0x=
08).

That is normally a link layer problem like link supervision timeout
which is part of the controller not the host stack, check if you can
reproduce this using another controller.

> Hardware: Raspberry Pi 4 Model B (Bluetooth chip: Cypress CYW43455).
> Tested on: 4.19.118-v7l+, 5.4.42-v7l.
> Tested BlueZ: 5.53, 5.54, master (commit 6ea1b038eedeca31c3796ac921e25509=
d48d70ec)
>
> Best regards,
> Jari J=C3=A4=C3=A4skel=C3=A4



--=20
Luiz Augusto von Dentz
