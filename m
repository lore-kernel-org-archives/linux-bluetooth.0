Return-Path: <SRS0=WywE=VB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95391C0651F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 20:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E362189E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 20:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skMT6Sa4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfGDUSr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jul 2019 16:18:47 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:45855 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfGDUSr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jul 2019 16:18:47 -0400
Received: by mail-oi1-f174.google.com with SMTP id m206so5641286oib.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jul 2019 13:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CWQ50pvAbPE9pAvMMo2T1JuTFt2HH6VXbmWbsa3gxaU=;
        b=skMT6Sa43wbLAmsF3t7aFWfOGtvQ3D5+IB0Asz/THiDvByb+OH4QcVvnAEekGhW25A
         iBOQzzTJMRHPqhEWyz5fwirsjAeh39C6JEZTCJvJMZerai/WE1l8nhJAes8mF84fv4aP
         fyap1gbOfjirnpf7I/CnnTtcoYnKJ8jH7wsLM5wmIS9pXtviOmo/tCXIT1T7g4oXqYwe
         aSKv0c5rXtX1sF0Qnz2Khp8JL1jfe8PwS0zLPuRfpuiYZDaKjFvZBud69PbFne2Xzp5d
         cE47BdTaDj69bFJdDu0tBsJpzgtXm7FLs0G7KR8LUbWozLojaTabPNgoSeOY1/M0Oq59
         Bh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CWQ50pvAbPE9pAvMMo2T1JuTFt2HH6VXbmWbsa3gxaU=;
        b=MbYfTfzibLL27okeeS95HQDlXKnv79wXROPVN30G4Y37hZsrLY9piqQOu0iczmNxqy
         EkXCdw433I7R57lBkwL3KJKglhYjDo1EO6Rfz8Qm22X296exGtWeXOBAv5nTJjkYMwJ6
         soI5Cz1OmBtDocr2H5Jb8XP15ijIFC58i6efkTTVt8ipgW3n5MRh3HobYFoXlkOko6HK
         /cgWpYGTN44mPNKZZjoT796gbaMwV//At3GMhO4Cz7C7izgorHCLaGRuOCmJa6c+qY0o
         +uC3sEA+Jc8cH55HGLhkPA2AlkSPiXivS03+f66SMFUkZNfDuBwyNJEsATNec3/BFw2S
         jO/Q==
X-Gm-Message-State: APjAAAVyH9JRL31yypVF6n+FPwvv4SHuP3cNOALzBBeJPA0OBfYY15wV
        4wTh/fxHjM289jwojheYFnUdx5ibJgPJ8J5jlhI=
X-Google-Smtp-Source: APXvYqzb8LFCkeOa6ct3ScM+pHFEDb7ixKqTW0NQ7cQG45Vdf36Ne0wVe88RNXg33yy54AT5mVcyc/Ip1X3C7I1qIag=
X-Received: by 2002:aca:490d:: with SMTP id w13mr114598oia.8.1562271526631;
 Thu, 04 Jul 2019 13:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <CACna6rxtia9EchufR9otHZD73LEHGEbgWdUpwQbogBZc0aVQtg@mail.gmail.com>
In-Reply-To: <CACna6rxtia9EchufR9otHZD73LEHGEbgWdUpwQbogBZc0aVQtg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 4 Jul 2019 23:18:34 +0300
Message-ID: <CABBYNZLV=f88N94XH0svXi8ak3qrDajkp9WGHK85wSfbO7nmSw@mail.gmail.com>
Subject: Re: Request for help on using BlueZ in C app for a custom GATT server
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Rafa=C5=82,

On Thu, Jul 4, 2019 at 5:00 PM Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> w=
rote:
>
> Hi,
>
> I'm trying to figure out how to register a custom profile + service(s)
> using BlueZ in my C app.
>
> I found some posts mentioning gatt_service_add() and suggesting to
> look at gatt-example.c. I checked that file and it seems to be part of
> "plugins" with BLUETOOTH_PLUGIN_DEFINE in it.
> In "Doing Bluetooth Low Energy on Linux" pdf I read that plugins are
> deprecated and I should focus on D-Bus API.
> Is that correct? Should I avoid gatt_service_add()?
>
> Looking further I found
> https://people.csail.mit.edu/albert/bluez-intro/c404.html
> This example seems to be using hci_* functions (like hci_get_route()
> and hci_inquiry()) from libbluetooth.so. I checked hci_lib.h and found
> nothing related to registering profiles/services.
> What exactly is libbluetooth? Is that for GATT client purposes only?
>
> Finally I started looking for D-Bus API info.
> In "Doing Bluetooth Low Energy on Linux" pdf there is a
> RegisterApplication() mentioned. I can see that also in
> doc/gatt-api.txt.
> Is that the new D-Bus API I read about? Is there some tutorial/example
> for it I could use?

You should use the D-Bus API the documentation is here:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/gatt-api.txt

You can use as example what bluetoothctl does to register services:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/client/gatt.c

--=20
Luiz Augusto von Dentz
