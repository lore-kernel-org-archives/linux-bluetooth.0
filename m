Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4032C00140
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Aug 2022 20:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiHJUNu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Aug 2022 16:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiHJUNt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Aug 2022 16:13:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D08F589
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 13:13:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id f22so20479386edc.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=zLpPPxr3uuaP/aW3OL17Yl7pr8907KVg0DCVI1xtIzo=;
        b=dN8tjRP43eCW7V3ur1gXQjSXfXlz2NOvsI7ikgTdcXLBhY8FxIdB04+0+r9oAa4kmO
         LM0fU0jqOP0qOoPvSkQjPg8Jh7EjO8Xr26JRvLuBpcfHHnijfcqfrXWbtBwl/Brf1tWQ
         yUavKVTwFr5Afrb2Vhbi42oZZ5h31vy0QVvyoz1Bjw3HY+Godx4vObteVJCqudechJS3
         fnCtfc92O4yyq8B0UdLQ8IFHjJuZqqx4njUQTeZPUO/LQ/Vg0K69/24C1clv5+AidaPZ
         PUwwlsaMDAfQmeG/1HGHok6AxUIgp69A/X3knNKuyGWzVneET2Yd+++qF+3dv9KWIDpn
         eVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=zLpPPxr3uuaP/aW3OL17Yl7pr8907KVg0DCVI1xtIzo=;
        b=oW+QoPY4lO3KNStCwHbhzQI7mIEvdM+EUffqjbemL2/EuE0pofsWuU7H8er6yv0mNS
         PJW/A49sE+zhyKuiZLY6iiKW4LDmFFUXVQLo8JLIpfpSzcN/3yF7KfZ0FXzKmJdslG51
         RE5wqcZxbalz0I0EG3Y11m7/e6VD+Fu8xbF1deeoF0TBsv7JlOQlRefoEMu6lZ+Jjsr4
         irnXf6rWLV4dFAuCCJSXpe4bX6nTbpE9ESZaLwDC9tlItRsVloouBfujFeRgxNwbfTGH
         aYac3q+kScBLQWJfgAHWXfzQtCIs/9aHFN4SDzg+GB0DamWy0FoD4cNT2YjbLtSw/SiS
         /nqQ==
X-Gm-Message-State: ACgBeo1ZMJ1vOOf9DKLOJtMKbPvrGmZPauED3cE7yUtwot9ouwo6iAjL
        4DfIpj5Xvsy3YM648G+BSkPMFF40rrlcbh1zWJ7M501du4Q=
X-Google-Smtp-Source: AA6agR7HEfoR6wNjFbVynYHplhg2JF8IjcYXJKodyp5VVPqz3gfCjYEuQi2QUB2e5WZqfm7hB94cJWy7OmqLcwQ0zj4=
X-Received: by 2002:a05:6402:13c1:b0:43b:e330:9bbf with SMTP id
 a1-20020a05640213c100b0043be3309bbfmr27454258edx.417.1660162426446; Wed, 10
 Aug 2022 13:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220803225716.1287921-1-vi@endrift.com> <CABBYNZKcAZeDqjeHzTfqmvKS3Tbur-rRi6+uPL4x4t8MnWp5ug@mail.gmail.com>
 <c0f52a2d-19ff-acb2-92ac-cec87819a2cf@endrift.com> <CABBYNZLtWN7oWBRc-YjV6baCPpkh_J-2mUMO83A_3y=Xtn==dw@mail.gmail.com>
 <dbeb83e5-9986-ca5d-e71f-cdaa579794bb@endrift.com>
In-Reply-To: <dbeb83e5-9986-ca5d-e71f-cdaa579794bb@endrift.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 10 Aug 2022 13:13:34 -0700
Message-ID: <CABBYNZLHFAj4LwaMTEvCmysF2D__xrhJT9ORY-qmm_XYcGjjtQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] hog-lib: Increase maximum report map size
To:     Vicki Pfau <vi@endrift.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Vicki,

On Tue, Aug 9, 2022 at 7:02 PM Vicki Pfau <vi@endrift.com> wrote:
>
>
>
> On 8/3/22 17:16, Luiz Augusto von Dentz wrote:
> > Hi Vicki,
> >
> > On Wed, Aug 3, 2022 at 5:05 PM Vicki Pfau <vi@endrift.com> wrote:
> >>
> >>
> >>
> >> On 8/3/22 16:55, Luiz Augusto von Dentz wrote:
> >>> Hi Vicki,
> >>>
> >>> On Wed, Aug 3, 2022 at 4:07 PM Vicki Pfau <vi@endrift.com> wrote:
> >>>>
> >>>> Though a 512 byte report map size seems plenty large, there exist so=
me devices
> >>>> (e.g. Brydge W-Touch) that send larger reports. There is no protocol=
-defined
> >>>> maximum size so doubling the maximum size is safe, and should hopefu=
lly fix
> >>>> most real-world failures.
> >>>> ---
> >>>>  profiles/input/hog-lib.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> >>>> index 4a9c60185..9f3eb428c 100644
> >>>> --- a/profiles/input/hog-lib.c
> >>>> +++ b/profiles/input/hog-lib.c
> >>>> @@ -64,7 +64,7 @@
> >>>>  #define HOG_PROTO_MODE_BOOT    0
> >>>>  #define HOG_PROTO_MODE_REPORT  1
> >>>>
> >>>> -#define HOG_REPORT_MAP_MAX_SIZE        512
> >>>> +#define HOG_REPORT_MAP_MAX_SIZE        1024
> >>>>  #define HID_INFO_SIZE                  4
> >>>>  #define ATT_NOTIFICATION_HEADER_SIZE   3
> >>>
> >>> Afaik 512 is the maximum length an attribute can have even when using
> >>> read long procedure:
> >>>
> >>> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 3, Part F
> >>> page 1416:
> >>>
> >>> The maximum length of an attribute value shall be 512 octets.
> >>>
> >>> And
> >>>
> >>> BLUETOOTH SPECIFICATION
> >>> HID Service Specification
> >>> Page 16 of 26
> >>>
> >>> 2.6.1 Report Map Characteristic Behavior
> >>> The GATT Read Characteristic Value or Read Long Characteristic Values=
 sub-
> >>> procedures are used to read the Report Map characteristic value.
> >>> The length of the Report Map characteristic value is limited to 512 o=
ctets.
> >>>
> >>> So I believe the device is not compliant and very likely needs to hav=
e
> >>> multiple instances of HID Service instead of combining everything in =
a
> >>> single instance.
> >>>
> >>>> --
> >>>> 2.37.1
> >>>>
> >>>
> >>>
> >>
> >> Ah, that's strange. I looked through the spec but didn't see those. Th=
at said, while the device may be non-compliant, the device is on the market=
 and I doubt I could get them to update the firmware as a random third part=
y. It works on Windows, so clearly Windows doesn't have a problem with its =
noncompliance. So this raises the question, how should Linux handle non-com=
pliant hardware, especially when it could easily be made to work just by be=
nding the rules in this one instance? I can absolutely change the commit me=
ssage since it's erroneous, but the question then comes down to how should =
it be handled at all.
> >
> > While I agree this could be worked around it is probably worth
> > checking with the manufacturer if it is aware of the problem because
> > even if we were to allow reading past 512 bytes offset in the future
> > there may be qualification tests enforcing not to do so, besides
> > versions up to BlueZ 5.65 would still not work anyway so I thing
> > letting the manufacturer know there is a problem with their
> > implementation is actually worth a shot here.
> >
> Brydge replied with the standard tech support "this is only supported on =
Windows, so there probably won't be a firmware update" reply, despite its n=
oncompliance. And since I doubt Windows will add a change to limit it, well=
, that kind of limits our options here to either "enforce compliance and br=
eak non-compliant hardware" or "figure out a way to bend the rules". Given =
that BlueZ, upon expanding the maximum size, does successfully read the ove=
rly-long report map (it does use the read blob with offset message to get t=
he last several bytes), it does work as intended if we ignore that specific=
 rule. Though obviously that's up to the bluetooth maintainers to solve, so=
 at this point I'm just tossing my two cents at it.

Well we can do what Windows is doing but let's have it documented
then, we could as well scalate this with Bluetooth SIG since the
manufacturer seem to be intentionally creating interoperability
problems with a standard service, but that would likely take a lot
more time and most likely will need to be resolved by introducing a
test that enforces that HoG client don't attempt to read past 512
bytes offset.

Btw, if there is no limitation on how big the report map can get in
HID, I'd leave it up to the kernel to figure out if that is acceptable
or not, so I'd remove the 1024.

--=20
Luiz Augusto von Dentz
