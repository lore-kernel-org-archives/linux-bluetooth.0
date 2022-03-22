Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF53C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Mar 2022 05:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbiCVFuM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Mar 2022 01:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236898AbiCVFt6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Mar 2022 01:49:58 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD47563D2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 22:48:30 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id l2so31807711ybe.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 22:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rn8C0GuJ2RNVx6ouus+6VmV1ySibv9XiXEr22pDFSSg=;
        b=MUoClIj+g4EPJxwxKwhVqWI1gGtmSIFG1W7+S978bKAaVVL1tioFjkaYIlAUj0LAcV
         hLafEP/qkr6bWEU/oZtYAuh6xbflo114W2Jt/iEqNhWW0+DniIJP/SyM1poy3C+vzxMT
         0NrgnM+hs8hQ5Owj6zjeZoMANADBSrXKEM5DJL1C8TqD2vBM61K2Ece2P50QYzsnD6Nk
         sXzQMYJ9xhr0rcTG4X6gBWCo8hNHgTUBuyPkG+o5Z7lyt+LB6W9bJe7u+4x2uFAvZ6JS
         4rpWXSsdTtIJe4xFXcV1S6/ejla1leuAdZve7wBksDE+g9r9jWF2T8Lo6aSfuOB3T+bz
         Sj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rn8C0GuJ2RNVx6ouus+6VmV1ySibv9XiXEr22pDFSSg=;
        b=Kg2WuuODEeuc3S8wTM09640eaeHu0JguMNb7mWGSQTcdp7+/Knu10HPlZkVJmf02jo
         c7qNbOu6GRwn+KKXN/rjl5jw4vZgwAu5xvKxsTW87l28StzMeZbjHePmnq/dA/dEYeiY
         n9ThJTJ3wwc5pl47KD6sWCwA2XNeSnsdbHrwyZcS6FuWX5npF1MI8unuwWi8KYAT4dIA
         ByyumSjhLcQXsH5c6s48GDZVFuyjkvv4W7001+4tkf3lzD/Qu3wMyv0lLvPTUWDwuXLg
         9Xinherw3bhD9BTviZ9iuSXd2ntCEbnjsMGsK8VUaZlwS8ZtxFPyE4cXwWzlxFT6WSI0
         DmhQ==
X-Gm-Message-State: AOAM530WVfF2wIUB7YrALofadUyDDXaaOMq5BI013MtnWleau2J+9rdi
        Pbqje25CB+YDTAYZqGY1zH1UOtv14Zt8PrNAlFwtKlWmcX8=
X-Google-Smtp-Source: ABdhPJwkOarvgzNl1HaPE5G2gMrntEjrMcGTAW4fLXdkpCPDB4IREnkJi71jJrctgOR0/4weAYnwg+Z+3a5smVnp2LE=
X-Received: by 2002:a25:19d7:0:b0:624:7b8b:1bd3 with SMTP id
 206-20020a2519d7000000b006247b8b1bd3mr24566832ybz.401.1647928109279; Mon, 21
 Mar 2022 22:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <f610b069-07ab-1004-e8f1-b84533593c92@gmail.com>
 <CABBYNZLA6bRCxd=Tse_XbUT8ReBo4QjvstSassfQAcTX+Fk9_g@mail.gmail.com>
 <b50b9b75-96ea-0d93-3687-3a79cdec5419@gmail.com> <CABBYNZKAUMOZ8vhk2ATPOaVHbcqCTg-DMD2vypkx_CTOjeVg2g@mail.gmail.com>
 <6bec2be7-a411-c5bf-6e5d-b3efee33b834@gmail.com> <CABBYNZLAZGoB1JKW63SNJuFB-4raDvHjjEk4w8y0K1MLwe4b7A@mail.gmail.com>
 <b7a2b073-fd69-36a4-6ce0-cb1b942ccde6@gmail.com> <CABBYNZKjUYAqctfpap2f36TcBuJFk0wX5P8jkUjpw1qqupeb0A@mail.gmail.com>
 <72b3b0ee-cca0-3804-ce78-1345c4590963@gmail.com> <CABBYNZJL4YCpXHL8ihSFh04fEGAqcB7K8a9aR22E6TwB2Wj0Tg@mail.gmail.com>
 <12462d5d-b140-6b08-2e72-d8fd77105086@gmail.com> <1494b7b733480882272c16c402115c247bd7dd61.camel@hadess.net>
In-Reply-To: <1494b7b733480882272c16c402115c247bd7dd61.camel@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 21 Mar 2022 22:48:18 -0700
Message-ID: <CABBYNZ+bNNdkcaxZfv3qEj3tJ8pcoOgsgSO6VLYfbguK0-ZEcw@mail.gmail.com>
Subject: Re: Lenovo Legion M600 wireless bluetooth mouse connected and paired
 yet not working
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Andrey Butirsky <butirsky@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Tue, Mar 8, 2022 at 2:30 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Sat, 2022-02-19 at 00:26 +0300, Andrey Butirsky wrote:
> > Hi Luiz,
> >
> > On 2/19/2022 12:15 AM, Luiz Augusto von Dentz wrote:
> > > Hi Andrey,
> > >
> > > On Fri, Feb 18, 2022 at 3:55 AM Andrey Butirsky
> > > <butirsky@gmail.com> wrote:
> > > >
> > > > Important addition: the mouse does work on Android 8.10.
> > > >
> > > > Does it mean Android has that special HID driver that missed on
> > > > Linux?
> > > > 8.10 came out long before the mouse even existed..
> > > >
> > > > Do you have explanation?
> > > No, in fact android seems to also be using UHID, does it uses a
> > > vendor
> > > app to set it up?
> >
> > No, it just works right away after connecting from Settings.
> >
> > Also, the mouse works on Windows, without additional software. It's
> > detected as "Bluetooth Low Energy GATT compliant HID device" there.
> >
>
> Can you please try using "hid-recorder" to capture the HID output out
> of the device? It would show us whether we're receiving any events from
> the device, and allow us to test whether there are problems at the HID
> level on other machines.

Looks like there are others models affected as well:

https://github.com/bluez/bluez/issues/320

It is very weird that it would work with Android and doesn't with
Linux since afaik the very same interface is used with uHID, are there
anything on the kernel side we can switch on to see why reports would
be discarded, because from the looks of it we do receive them but they
just don't have any effect.

-- 
Luiz Augusto von Dentz
