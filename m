Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B22ECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 23:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbiIAX5E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 19:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiIAX5D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 19:57:03 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063E86C747
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 16:57:02 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id q7so1009209lfu.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Sep 2022 16:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dgTzRK/VqQMj3ZrBHwtt1T24KxQHKgnaXZqsUrvpkeA=;
        b=JCpHuh+Bw7iiLTkbiShfNw51dfnp4cqWTOZ29W4TTeyidO5kcut7b/RwWGXgY7DeHK
         q+xMVKh5fPzx9fcBu0CFfaeCtjK7GvOmDjydC98lR0+Zu7h5qdIL49k3qRMr8/CrBgRw
         rB8U5SPiV2xoMgHyPaZcjo6AD/CZQmVsX+8DliXTHDkMNtUvnh7w9pLuVpZajf23xlWk
         MGCSyyRcliSOqgZiYqmP1RTNNu4f8gj2PANxruMoanOFIShFVucSLWSGog1l9L94bHwe
         8SAPIGNzJ7qT8liuzXVoSlc24AUXg380N0Clx8iZvIcUJG3dGWrhpvEDg5G3I3bEpHkt
         FAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dgTzRK/VqQMj3ZrBHwtt1T24KxQHKgnaXZqsUrvpkeA=;
        b=q4h1OlaovpwG92xC4pmimD/4kh1Tu7/eNwm9Z+qKeOnwNY9lKkWLS8zRmaGZ7Izakx
         +tJ1tujNNcWbtkXboJi2M3r8OUgdgBtvuAEjtoA6lXN2OpuOEKUGHtrahsST1F7CChW4
         SO0MOTaXOa8XE/46yv23XNq5AEMSL7bkaqG0NvQfa6W0MF4vPlQSBliVY+DFzWtFNdRW
         fHtk3dosuE9ZQMd3YRWslYQHmzEat/o9qv1yhNBoe171EHbthDtX+1TM+pEq0R7Dro17
         Wx7XK+YMk+bPI4qkpCIPMXvqbkR2I/W7TjIddT2XBRS+Pgk3HACjfcwHe9SWwcKNgcA5
         TnZQ==
X-Gm-Message-State: ACgBeo1a31gPLG0ms6SN5OOGVIYSmUBmjR9HZXmJbYEhdfTk447jyIvP
        +8rhDbifck9rJMu1z/SLp2YdY8vsCxwwI/EL3FQ=
X-Google-Smtp-Source: AA6agR6yz7lUN+DZlo7lBtZs24mQPIaoECeREzJEx/v2c4S79R3PGDUHV+vdWYarfAk892tRTPLCvPVdUC4vB6ZIK3o=
X-Received: by 2002:a05:6512:1ce:b0:494:81fc:e755 with SMTP id
 f14-20020a05651201ce00b0049481fce755mr3827699lfp.106.1662076620056; Thu, 01
 Sep 2022 16:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
 <CABBYNZJGc2Y3UULighw95un9mb8khLM2dfTOB3jRV8D3ksVDXg@mail.gmail.com>
 <1ef5e51d2103b6f02826777ebf5415f74018e317.camel@hadess.net> <01070182fa3f5ac6-66cb5385-fab0-4916-9e97-bdf54ef3a3f6-000000@eu-central-1.amazonses.com>
In-Reply-To: <01070182fa3f5ac6-66cb5385-fab0-4916-9e97-bdf54ef3a3f6-000000@eu-central-1.amazonses.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 1 Sep 2022 16:56:48 -0700
Message-ID: <CABBYNZ+An68giBXb=6c-W3+-8tpvSHsWtV_GGJMXMQwUWbhh-w@mail.gmail.com>
Subject: Re: [PATCH] plugins: Do not try to autopair with Nissan Connect devices
To:     Florian Leeber <florian@ubports.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Florian,

On Thu, Sep 1, 2022 at 11:10 AM Florian Leeber <florian@ubports.com> wrote:
>
> Am 01.09.2022 um 12:46 schrieb Bastien Nocera:
> > On Wed, 2022-08-31 at 13:18 -0700, Luiz Augusto von Dentz wrote:
> >> Hi Florian,
> >>
> >> On Wed, Aug 31, 2022 at 12:44 PM Florian Leeber <florian@ubports.com>
> >> wrote:
> >> gs as default).
> > FWIW, gnome-bluetooth has its own database on top of bluez, which we
> > prefer to the code in bluez. I'd be happy getting rid of it.
> >
> > Loads of devices that need pairing despite their class and Bluetooth
> > version, and devices that need special handling like the Navman GPS
> > that expects a non-numerical PIN.
> >
> > The database:
> > https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/blob/master/lib/pin-code-database.xml
> > The code to parse it:
> > https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/blob/master/lib/pin.c
>
> Oh my, this escalated quickly ;) - tbh implementing this as a fully
> fledged config-based feature might be over my head. I am not proficient
> with the Bluez code at all, and my main work currently is being the OTA
> release manager for Ubuntu Touch. I could only work on this with some
> support to get the basics established.
>
> Thanks for the hint with the database, we did not know about this.

Can't you solve the problem in the agent thought? Or does the current
logic make the pairing fail right away?

>


-- 
Luiz Augusto von Dentz
