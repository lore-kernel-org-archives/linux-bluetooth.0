Return-Path: <SRS0=Dn6D=YZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3119FCA9ECF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Nov 2019 14:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E472085B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Nov 2019 14:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jik2qnog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfKAOhA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Nov 2019 10:37:00 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:42128 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfKAOhA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Nov 2019 10:37:00 -0400
Received: by mail-oi1-f172.google.com with SMTP id i185so8308610oif.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Nov 2019 07:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/z0ql+Z0To/Vmzz8SGsmXnnjrrlEU+EVEPhLRCxTFFQ=;
        b=Jik2qnogplT41W8MQ1GOE+/uuu/yplspA8/j72SbL+829CAWNTds9PtUPTW8rkHXgk
         Ch8eNJk8B9f+fnNBprXO8i7/0voP7jcMXDDHIiYiBNqG9Ycv+FKBa6pAkiVcF64nZPNh
         xayhgFpodg2DMoFLG1S8mBKxG24Y2Gr/uCI9omNzfAqEult6sOpyj70YD6q9auCO1jPP
         LZcFgzCyYnBs7t+3O0awvcstoGPexM8iJ67Wi5SoD5lhDaRtuRi+PQ+J2cZCkPQ7xVQW
         XK1BR6nTsI4QHyjYyPWQg4y0ME7kwVC8FUDDyoAjNSBLq3qoIa3Jdo9emB0JZnnk2MFz
         PzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/z0ql+Z0To/Vmzz8SGsmXnnjrrlEU+EVEPhLRCxTFFQ=;
        b=ACzDXM/6twk2CARBZO9lk53rp1nBY5LBtNi1bee/4/xcrNWllDtsERqFl8icyX0VAh
         +ZL4Y/WJH1lBdZjWOX3J3lrdlgVudt7W0Ukik9azJPwSx0eb8tq1fIUlRQGhXZQ4Cts1
         zrPZqtASd5Eaqo+totWx8lqg3bFgvqdGWy6EN2+UckVsw74asCjUnagllsB29y7+RbwB
         AaQqCtb+cScHVoevMlYYfz7oWKtgEyh8PY1KW+wxtqDLEcTw+ifxses6+LxjoyN4jyAk
         c5PtM/Sv27eT6/lHtWO6c7uq/1MIHduSODcab2dsGzIbvnQzrTwssldqXADKPrwSrGvy
         +WmA==
X-Gm-Message-State: APjAAAVjJszsseR60iFPCfTY5wIAjlFJXiZYhLgzxAwey6x0sVWPArAK
        rc9u0BrCWlZwwiooPw7uqXEL4KEu2c5/GiZeI+XpKyeUQZU=
X-Google-Smtp-Source: APXvYqz1k7xwJYL+Vf5gLlIhBQ+RJ9VL7Udx23P0MsIhSQ7xDSHL/hbkl4rM3R8OJd4UDURqubdfsiic874YEmH0Na0=
X-Received: by 2002:aca:de88:: with SMTP id v130mr2874098oig.108.1572619017377;
 Fri, 01 Nov 2019 07:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <PR1PR07MB4858E3C5706803AD2DF72194C7600@PR1PR07MB4858.eurprd07.prod.outlook.com>
In-Reply-To: <PR1PR07MB4858E3C5706803AD2DF72194C7600@PR1PR07MB4858.eurprd07.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 1 Nov 2019 16:36:45 +0200
Message-ID: <CABBYNZJHWr0xdu8TKN7Hhjqt71SeTtEPJ=zr+DgPq+a4cSS3Vg@mail.gmail.com>
Subject: Re: Bluez 5.50 Qualification tests
To:     "Sanchez Frias, Cesar (Nokia - ES/Madrid)" 
        <cesar.sanchez_frias@nokia.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Cesar,

On Wed, Oct 30, 2019 at 10:17 AM Sanchez Frias, Cesar (Nokia -
ES/Madrid) <cesar.sanchez_frias@nokia.com> wrote:
>
> Hi everybody,
>
> We are currently passing BlueZ 5.50 (LE Host Subsystem) qualification pro=
cess.
>
> I would like to know if anyone has already passed test cases "L2CAP/LE/CF=
C/BV-13-C" and "L2CAP/LE/CFC/BV-15-C".
>
> Test case "L2CAP/LE/CFC/BV-13-C" seems to require authorization at GATT s=
ervice level instead of GATT characteristic level. Does it have sense? As f=
ar as I have seen there is no way in BlueZ tools (bluetoothctl, gatttool) t=
o add authorization requirement to services, is it?

The names suggests it is L2CAP testing or is it not? Anyway if that
requires GATT/ATT error 0x08 (BT_ATT_ERROR_AUTHORIZATION) all you need
to do is to return the D-Bus error 'org.bluez.Error.NotAuthorized' as
it will get translated like bellow:

    if (strcmp(error_name, "org.bluez.Error.NotAuthorized") =3D=3D 0)
        return BT_ATT_ERROR_AUTHORIZATION;

> KR,
> C=C3=A9sar



--=20
Luiz Augusto von Dentz

On Wed, Oct 30, 2019 at 10:17 AM Sanchez Frias, Cesar (Nokia -
ES/Madrid) <cesar.sanchez_frias@nokia.com> wrote:
>
> Hi everybody,
>
> We are currently passing BlueZ 5.50 (LE Host Subsystem) qualification pro=
cess.
>
> I would like to know if anyone has already passed test cases "L2CAP/LE/CF=
C/BV-13-C" and "L2CAP/LE/CFC/BV-15-C".
>
> Test case "L2CAP/LE/CFC/BV-13-C" seems to require authorization at GATT s=
ervice level instead of GATT characteristic level. Does it have sense? As f=
ar as I have seen there is no way in BlueZ tools (bluetoothctl, gatttool) t=
o add authorization requirement to services, is it?
>
> KR,
> C=C3=A9sar



--=20
Luiz Augusto von Dentz
