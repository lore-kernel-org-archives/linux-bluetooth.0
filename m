Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE810C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Feb 2022 21:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbiBRVin (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Feb 2022 16:38:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239991AbiBRVig (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Feb 2022 16:38:36 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695311BE060
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 13:38:19 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id p19so22036279ybc.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 13:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Db+CvTR7fgG6/Ey4kNTydt0mPQEmiN2qPgV2SZOEHCo=;
        b=M6tk15NJG24Rw69zmBGcZBefBw1wEgRl0HOmkqLnKukt2eLKUHQnFfVE/rq4SojEbJ
         6fO6zkvsJlHa3kDcelfCdBWqymYf8c+QMyfyJTAYfD8i9u6KGsmuM5FKlTF44KXvHqy1
         HSVkbZVzXPy7la4JfmcHCrDKJbiONkLOxHyHHw4bUwsKAnmQvgus56U3Rniq4CJ9lcA0
         IcRsYOQ+q/zUcTCb/vY9o7xLbnHEjSZff2+z01f6NFXUu6o1Uv85wvlu39xKJYQeeHDl
         Bh84cMAIp3zOhBn3wMQStmppd2PTMUm9ry7UHwaXZogwWvLsczKvLHbt34CNyoam7KiY
         K1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Db+CvTR7fgG6/Ey4kNTydt0mPQEmiN2qPgV2SZOEHCo=;
        b=ag/VS1Rzu6uvW5/CYRECb/Q4G7tq5LMttSdCkh+4UBkOqgRvxW7W5t6JA1EbrpXmTZ
         SPWxzfiFAN7jXOetcYyLfNZ1y7Kv7ORWzkrL7x+hQmREmdIwIWOgqIRcwDeYcGVe2p8b
         XZIuwPgGrAG/VRjKdDD+Mf/++NE2sDooLBTFBm/ynjwfc1Lvw5U6KgtHee1RsVXBQzx5
         atiwZlI2TyIjEFLrPsO/VemdYeB1FDAn44LsRv2p2yL62mhqWDGzuDuVEspt5rRhFzNf
         jmYk/EDRiO+i6htn7mZTLaHgLYcBwN5sDJ2+R4tNV8YRY3W1ckUaDeYeV6+3HA7ujTK5
         2ZHA==
X-Gm-Message-State: AOAM5315w5ZRzIHUTtx7LAHBVIhkiahscB9htRlczq+TzL+gXqJ3jdkG
        mf0El1YZmAeMqoACcbxW2JEG2uzbm4y3Tc44l7BFbylFPBw=
X-Google-Smtp-Source: ABdhPJy4ddmBRX3I5OlfZH5suZEiZqEk0WjWAOLjCeqZ67KR0WVjnN3YuPVtIOiZC5zCl53YjAMh5aFdgrVKC1tIfVA=
X-Received: by 2002:a25:8546:0:b0:61e:1d34:ec71 with SMTP id
 f6-20020a258546000000b0061e1d34ec71mr8962991ybn.259.1645220298511; Fri, 18
 Feb 2022 13:38:18 -0800 (PST)
MIME-Version: 1.0
References: <f610b069-07ab-1004-e8f1-b84533593c92@gmail.com>
 <CABBYNZLA6bRCxd=Tse_XbUT8ReBo4QjvstSassfQAcTX+Fk9_g@mail.gmail.com>
 <b50b9b75-96ea-0d93-3687-3a79cdec5419@gmail.com> <CABBYNZKAUMOZ8vhk2ATPOaVHbcqCTg-DMD2vypkx_CTOjeVg2g@mail.gmail.com>
 <6bec2be7-a411-c5bf-6e5d-b3efee33b834@gmail.com> <CABBYNZLAZGoB1JKW63SNJuFB-4raDvHjjEk4w8y0K1MLwe4b7A@mail.gmail.com>
 <b7a2b073-fd69-36a4-6ce0-cb1b942ccde6@gmail.com> <CABBYNZKjUYAqctfpap2f36TcBuJFk0wX5P8jkUjpw1qqupeb0A@mail.gmail.com>
 <72b3b0ee-cca0-3804-ce78-1345c4590963@gmail.com> <CABBYNZJL4YCpXHL8ihSFh04fEGAqcB7K8a9aR22E6TwB2Wj0Tg@mail.gmail.com>
 <12462d5d-b140-6b08-2e72-d8fd77105086@gmail.com>
In-Reply-To: <12462d5d-b140-6b08-2e72-d8fd77105086@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 18 Feb 2022 13:38:06 -0800
Message-ID: <CABBYNZJg0qHO4gvLh8O44um68CzRMM4PE3OymRhGfiQ1kDZO1w@mail.gmail.com>
Subject: Re: Lenovo Legion M600 wireless bluetooth mouse connected and paired
 yet not working
To:     Andrey Butirsky <butirsky@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andrey,

On Fri, Feb 18, 2022 at 1:26 PM Andrey Butirsky <butirsky@gmail.com> wrote:
>
> Hi Luiz,
>
> On 2/19/2022 12:15 AM, Luiz Augusto von Dentz wrote:
> > Hi Andrey,
> >
> > On Fri, Feb 18, 2022 at 3:55 AM Andrey Butirsky <butirsky@gmail.com> wrote:
> >>
> >> Important addition: the mouse does work on Android 8.10.
> >>
> >> Does it mean Android has that special HID driver that missed on Linux?
> >> 8.10 came out long before the mouse even existed..
> >>
> >> Do you have explanation?
> > No, in fact android seems to also be using UHID, does it uses a vendor
> > app to set it up?
>
> No, it just works right away after connecting from Settings.
>
> Also, the mouse works on Windows, without additional software. It's
> detected as "Bluetooth Low Energy GATT compliant HID device" there.

Did you manage to test with latest git? Note that windows does seem to
handle composite HoG device:

https://github.com/bluez/bluez/issues/258

Btw, it could be due to:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=aa699cb762a02ec7409940ddcfe65b788de8270d

There were some systems (afaik 32bits) with a problem with the header
copy we had.

-- 
Luiz Augusto von Dentz
