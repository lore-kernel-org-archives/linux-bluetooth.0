Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13068C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 May 2022 21:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358370AbiEDWBk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 May 2022 18:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352006AbiEDWBi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 May 2022 18:01:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735424CD4C
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 14:58:01 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p6so2431809pjm.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 May 2022 14:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5dpjhNl6Sv2T0WhsV8Jse8ptGivXz8AoHBpG+W50tKY=;
        b=dEcYuIHN+MCAsojLO2HXc7JEFh5L3yMnaiuEDjNfC+q5u2Bk98hivkBqTfk5fOBTTK
         YSzrxIEp8jg2m6lsRW/TZO+TsS1wD4/Baj2Gqo3hNHWZUCoj+e07csTEDp+pD+23cxcC
         Uaa59OIPoPEjDs1AVjztDI8f/WM8iyAzzp6ueiew0wtpNHbeieb5PmBuFUJ2hSqDFZiH
         vnjjBHDBCkdhc5JteM/yXcWXoD7/9pM77M2BdczWfdrla08Reg3LI34MojXUd/DZA3yV
         REVZtjuoYghif4Kw702KRQ/Jz4Dya0BNxPIUkiCKt9vtx1mVm72Vl5xMfx82gVHWofy5
         xn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5dpjhNl6Sv2T0WhsV8Jse8ptGivXz8AoHBpG+W50tKY=;
        b=NbAwNiDVxGeVwpoRKPlpRDJhGUZ1EINOetNmYowgzuw/3snLNsFFFTg20mz4jpJC2S
         34YTZvjrbYsPecxyoAzZjUWgr6jkHhB281yewEoCXyWSDEMEeM35U1r20nNZ6VcdvxzH
         RPjirww3gDL4iAr4V0D0NlyooItww3SjFc1E5aZGi2FratkKcqbBxZ6SaTeJE+Goiyex
         N71J/PnJz4CPILpPxOKlqOl7AeSwkkIKBrCzjpmIqN2foAfXiYWieiTXFJQ7H7ES9I+P
         fzrVMOBYTnY/SJhV0EwFKmk2Dvknf2hmmfpA+3s+1FMjGJaZCsBGzDi6f54hAjqFoQai
         MJXw==
X-Gm-Message-State: AOAM532wm0m3nlIV9KaY/ETAnfirONP0zcryn2+vqD6OGD0lIzA/my3Y
        BkHji5rCg6LRrgCDGf+YF/2MmZRPX+j8d29EOY3ErSvL
X-Google-Smtp-Source: ABdhPJwXwMZrmNd+Dn1sbwfqmpFwIqLbR8OhfmsuNu45g8EElcqkbuVQhsUXTZ+3icjvPPYP14MkAYh9xg9HM6BYV0U=
X-Received: by 2002:a17:902:ecc7:b0:15e:8685:77d with SMTP id
 a7-20020a170902ecc700b0015e8685077dmr24499900plh.20.1651701480825; Wed, 04
 May 2022 14:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220504210948.2968827-1-jiangzp@google.com> <CABBYNZL3cfwK7THDwUbg5AKx4GFfrZij2FhHfSPCgmRM1B7L+g@mail.gmail.com>
 <CAB4PzUrFr+ZXMNpToM+c4pfNJoAdVyfV2XoCGKtUGg_3MMCtag@mail.gmail.com>
In-Reply-To: <CAB4PzUrFr+ZXMNpToM+c4pfNJoAdVyfV2XoCGKtUGg_3MMCtag@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 4 May 2022 14:57:49 -0700
Message-ID: <CABBYNZJ8wEWqjNr1t17HN4WHQ9xy_YiCbq0MDo26boSv5f1k0A@mail.gmail.com>
Subject: Re: [Bluez PATCH v3 0/3] Adding bonded flag to D-Bus property
To:     Zhengping Jiang <jiangzp@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Zhengping,

On Wed, May 4, 2022 at 2:54 PM Zhengping Jiang <jiangzp@google.com> wrote:
>
> Hi Luiz,
>
> Sorry for the error. It should have been fixed in patch 2. I think I upda=
ted the wrong version.

Don't worry, I'm fixing it myself.

> Thanks,
> Zhengping
>
> On Wed, May 4, 2022 at 2:49 PM Luiz Augusto von Dentz <luiz.dentz@gmail.c=
om> wrote:
>>
>> Hi Zhengping,
>>
>> On Wed, May 4, 2022 at 2:09 PM Zhengping Jiang <jiangzp@google.com> wrot=
e:
>> >
>> > Currently BlueZ client can't know easily whether a device is bonded or
>> > not. This is causing issues for a number of applications. For example,
>> > in the Nearby Share case, the peer device is paired, but not bonded.
>> > This series will add the "Bonded" property in org.bluez.Device1 D-Bus
>> > interface. Changes are also made in bluetoothctl to show the status of
>> > the bonded flag as well as a list of bonded devices.
>> >
>> > Changes in v3:
>> > - Move documentation update to a separate patch
>> > - Add description to bonded and paired
>> > - Add an optional argument to the devices command to filter device lis=
t
>> > - Remove paired-devices command
>> >
>> > Changes in v2:
>> > - Move one variable declaration to the top following C90 standard
>> >
>> > Changes in v1:
>> > - Add "Bonded" to D-Bus interface
>> > - Send property changed signal if the bonded flag is changed
>> > - Show the status of the "Bonded" flag in bluetoothctl
>> > - Add option to show list of bonded devices
>> >
>> > Zhengping Jiang (3):
>> >   device: Add "Bonded" flag to dbus property
>> >   doc: add "Bonded" flag to dbus property
>> >   client: Add filter to devices and show Bonded in info
>> >
>> >  client/main.c      | 72 ++++++++++++++++++++++++++++++---------------=
-
>> >  doc/device-api.txt | 12 +++++++-
>> >  src/device.c       | 38 ++++++++++++++++++++----
>> >  3 files changed, 91 insertions(+), 31 deletions(-)
>> >
>> > --
>> > 2.36.0.464.gb9c8b46e94-goog
>>
>> src/device.c: In function =E2=80=98device_set_bonded=E2=80=99:
>> src/device.c:6141:9: error: ISO C90 forbids mixed declarations and
>> code [-Werror=3Ddeclaration-after-statement]
>>  6141 |         struct bearer_state *state =3D get_state(device, bdaddr_=
type);
>>       |
>>
>>
>> --
>> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
