Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECD2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 May 2022 21:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358836AbiEDVxS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 May 2022 17:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiEDVxQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 May 2022 17:53:16 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66C750B36
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 14:49:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso2381154pjb.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 May 2022 14:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3PENCAX1FrS0t7CtTF0v18ZKj8TqqyTZuIXGTxRioV0=;
        b=HC323SE6jXcILDLraSWgsO6U0ZVBO+ByOLiPryt7UCuyc64mZqp5O4t2LdTcfqJfb4
         dAvREkBo6zGzgN3pjRMYbpEFBRfzZGMZVS7aoqNZa+9idZbmruiP2EWjUy52YZc/jlxd
         LwDQqiuXgFrAexonz7mAO8uRQKmoseKkaRNCyJih+1MdTVmoZ3/rlodVW4lNAodbvbRC
         5hsUnxIdLRFkCXPJ49QsLamM4IFUWN3r0ZarPIFrSFUPsahwRUhKREGmZy9t+VCkloW1
         +wl4tnw/Sbe8gugURGfvxUK9HDtTiZTa1ysdNLoOOkiSdTCzb0a9nON65urXYEni7g6+
         t/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3PENCAX1FrS0t7CtTF0v18ZKj8TqqyTZuIXGTxRioV0=;
        b=WXZvDg1XNrfj1uCXgW92IYsnZjL3MwxEcW79tIAMWCs1PcFamiCdDX9kJ0W8lddmA4
         XUkgLdPS49dCEtuSpLVQmtoXaJP/t+s6cnCYhfOrMFDQngMj2orSpiiSKgkJg92IUNBz
         gGvaEi0q81G5r5Cl1aYmHRdj89CBDqvJVUkVEi0FyoOQTOe9Y97XxLfTeSbSrz9FSPv+
         1NbPW2zPbJJnCeDDzOfhhlVcTksU/LcBWVyPSPmTRnDANfjxBIiAFJa5zliuMragzrQN
         Z2u4TTk6Rsy2Bpg5JLvCtkkwYKBSxd9ojZxzw7+oSaVT9UR4qW9Mdc+yg3hw8rNJ6QSD
         fvDQ==
X-Gm-Message-State: AOAM531hr2FT6oAAZvrV2GL59AxOPGQE4yiU5Idwi8fxwg9JChfGadSx
        h439C0/u8D0s6Tjfpb9Sc+CM/+YihIXq9WhQ5PE=
X-Google-Smtp-Source: ABdhPJzkvUh+LZMllE+2QoHEUoS66UGw2Oug6Lbt06DMhBXeZD+Tjkf5eB+PhiV9gkrQZULgfbtkUZbkudlot/ttbLE=
X-Received: by 2002:a17:902:da8b:b0:15e:c0e8:d846 with SMTP id
 j11-20020a170902da8b00b0015ec0e8d846mr7169164plx.34.1651700979360; Wed, 04
 May 2022 14:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220504210948.2968827-1-jiangzp@google.com>
In-Reply-To: <20220504210948.2968827-1-jiangzp@google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 4 May 2022 14:49:27 -0700
Message-ID: <CABBYNZL3cfwK7THDwUbg5AKx4GFfrZij2FhHfSPCgmRM1B7L+g@mail.gmail.com>
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

On Wed, May 4, 2022 at 2:09 PM Zhengping Jiang <jiangzp@google.com> wrote:
>
> Currently BlueZ client can't know easily whether a device is bonded or
> not. This is causing issues for a number of applications. For example,
> in the Nearby Share case, the peer device is paired, but not bonded.
> This series will add the "Bonded" property in org.bluez.Device1 D-Bus
> interface. Changes are also made in bluetoothctl to show the status of
> the bonded flag as well as a list of bonded devices.
>
> Changes in v3:
> - Move documentation update to a separate patch
> - Add description to bonded and paired
> - Add an optional argument to the devices command to filter device list
> - Remove paired-devices command
>
> Changes in v2:
> - Move one variable declaration to the top following C90 standard
>
> Changes in v1:
> - Add "Bonded" to D-Bus interface
> - Send property changed signal if the bonded flag is changed
> - Show the status of the "Bonded" flag in bluetoothctl
> - Add option to show list of bonded devices
>
> Zhengping Jiang (3):
>   device: Add "Bonded" flag to dbus property
>   doc: add "Bonded" flag to dbus property
>   client: Add filter to devices and show Bonded in info
>
>  client/main.c      | 72 ++++++++++++++++++++++++++++++----------------
>  doc/device-api.txt | 12 +++++++-
>  src/device.c       | 38 ++++++++++++++++++++----
>  3 files changed, 91 insertions(+), 31 deletions(-)
>
> --
> 2.36.0.464.gb9c8b46e94-goog

src/device.c: In function =E2=80=98device_set_bonded=E2=80=99:
src/device.c:6141:9: error: ISO C90 forbids mixed declarations and
code [-Werror=3Ddeclaration-after-statement]
 6141 |         struct bearer_state *state =3D get_state(device, bdaddr_typ=
e);
      |


--=20
Luiz Augusto von Dentz
