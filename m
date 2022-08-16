Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0C8C25B0E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 20:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbiHPUGJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 16:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiHPUGH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 16:06:07 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B08C7F114
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 13:06:05 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id s9so11607962ljs.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 13:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=Fp3KFitrlYtPyk8bhNMfY3RORNQ0dC1EGnM4qwmATYo=;
        b=B+8GUauGL6vgsw9wtsk0Sky5+2pDe1SgIsoEFgo9MS+G+YlXEOwfRO4brdVvYHXPs/
         DYS8Xo5UY/NBxGbl5Fa1ph/4WN9z2lh/kVB0tlIE+NXpSN4bMOBT7ZkNUONuWe4OtZfn
         nE4KteVdt2P66uVxAonGfsPqR6h8KxQwSKrhIsfZLoTnucQDQ2s+WZqKuG7ATs9JTFLZ
         aHHCG8ztWFD+4dTrRGMz/vz1WlLv1qUB8KzN2iZ92m7LrB+Ps4JiCxBR+L4ECgOmyn3a
         z6RYYRmxF1p0k2u2FK7y/ysNnTegHeKHw1B5EvSP/AHowx/EOecPSaprZ6ZB165CVU47
         jn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Fp3KFitrlYtPyk8bhNMfY3RORNQ0dC1EGnM4qwmATYo=;
        b=JgdkgT2nrYIKb32LaheQx8DFxZ0BJmgyDfUJrIzbeQgeHjPWS+zYNNUdgBM+hphJ7k
         I7ZELEIt4Oe+ByCS1DNODlCMdRCCzpmHM7WRPfOTc5iLulUu1+4vemIMweYfrqo2hSBF
         TiE9NJmu2yjgk950dqqMKzbSqSNlqNlRgvtVGOctaB88i87Nx0ljem+JgbJ2+Pe5f/72
         Ac7NHr0MQspGfWnv2ZRBUNFATQFMJoNKDOxDp4fdrkQcxIsri4vv2LQF2gxvA9KHIp3v
         Hf1BwMQUZTqHFqeJH8HGM9KsbsVjGrg3prKn5+pSn4lgjQJi+XzBiJrBX0ZIjU1rsAYv
         LVAQ==
X-Gm-Message-State: ACgBeo3C9DGoAZmeXCqQuY3ERDtKEuuzMgMsLDjzGrQFZ8ew3bSHOr5u
        GaGIPz5YA3nHBmPpYO96aGRGKKQpjd/aYKSLyVGZuSivHB0x8A==
X-Google-Smtp-Source: AA6agR5zk+C3GdUHqpVNveU/Gk/OTPKjPxYid0t0zdVt+PLb2kqm8xA6nO//rAH52cB0Gc/31CZy70Uk2tH42m+lIxs=
X-Received: by 2002:a2e:b0ee:0:b0:25f:ddf3:e523 with SMTP id
 h14-20020a2eb0ee000000b0025fddf3e523mr6490786ljl.260.1660680363815; Tue, 16
 Aug 2022 13:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220803225716.1287921-1-vi@endrift.com> <CABBYNZKcAZeDqjeHzTfqmvKS3Tbur-rRi6+uPL4x4t8MnWp5ug@mail.gmail.com>
 <c0f52a2d-19ff-acb2-92ac-cec87819a2cf@endrift.com> <CABBYNZLtWN7oWBRc-YjV6baCPpkh_J-2mUMO83A_3y=Xtn==dw@mail.gmail.com>
 <dbeb83e5-9986-ca5d-e71f-cdaa579794bb@endrift.com> <CABBYNZLHFAj4LwaMTEvCmysF2D__xrhJT9ORY-qmm_XYcGjjtQ@mail.gmail.com>
 <CABBYNZKbCcz7p+EaNpWZkuX77BJ-DsoT=BRUQGwJjAhTesLhXA@mail.gmail.com>
 <be49af1f-f08a-7e26-42e5-98fe83077488@endrift.com> <CABBYNZLqjUpkCArjqHad4OKxT3PAow0T8+vP+tOvCtJbSG2p3g@mail.gmail.com>
In-Reply-To: <CABBYNZLqjUpkCArjqHad4OKxT3PAow0T8+vP+tOvCtJbSG2p3g@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 16 Aug 2022 13:05:52 -0700
Message-ID: <CABBYNZJTLfJqDB+ZCHLG68anBBc=aL5Xe5KbDVj_FHV2ei-SzA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] hog-lib: Increase maximum report map size
To:     Vicki Pfau <vi@endrift.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Vicki,

On Tue, Aug 16, 2022 at 11:31 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Vicki,
>
> On Mon, Aug 15, 2022 at 6:49 PM Vicki Pfau <vi@endrift.com> wrote:
> >
> > Hi,
> >
> > On 8/15/22 11:09, Luiz Augusto von Dentz wrote:
> > > Hi Vicki,
> > >
> > > On Wed, Aug 10, 2022 at 1:13 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > >>
> > >> Hi Vicki,
> > >>
> > >> On Tue, Aug 9, 2022 at 7:02 PM Vicki Pfau <vi@endrift.com> wrote:
> > >>>
> > >>>
> > >>>
> > >>> On 8/3/22 17:16, Luiz Augusto von Dentz wrote:
> > >>>> Hi Vicki,
> > >>>>
> > >>>> On Wed, Aug 3, 2022 at 5:05 PM Vicki Pfau <vi@endrift.com> wrote:
> > >>>>>
> > >>>>>
> > >>>>>
> > >>>>> On 8/3/22 16:55, Luiz Augusto von Dentz wrote:
> > >>>>>> Hi Vicki,
> > >>>>>>
> > >>>>>> On Wed, Aug 3, 2022 at 4:07 PM Vicki Pfau <vi@endrift.com> wrote=
:
> > >>>>>>>
> > >>>>>>> Though a 512 byte report map size seems plenty large, there exi=
st some devices
> > >>>>>>> (e.g. Brydge W-Touch) that send larger reports. There is no pro=
tocol-defined
> > >>>>>>> maximum size so doubling the maximum size is safe, and should h=
opefully fix
> > >>>>>>> most real-world failures.
> > >>>>>>> ---
> > >>>>>>>  profiles/input/hog-lib.c | 2 +-
> > >>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>>>>>
> > >>>>>>> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.=
c
> > >>>>>>> index 4a9c60185..9f3eb428c 100644
> > >>>>>>> --- a/profiles/input/hog-lib.c
> > >>>>>>> +++ b/profiles/input/hog-lib.c
> > >>>>>>> @@ -64,7 +64,7 @@
> > >>>>>>>  #define HOG_PROTO_MODE_BOOT    0
> > >>>>>>>  #define HOG_PROTO_MODE_REPORT  1
> > >>>>>>>
> > >>>>>>> -#define HOG_REPORT_MAP_MAX_SIZE        512
> > >>>>>>> +#define HOG_REPORT_MAP_MAX_SIZE        1024
> > >>>>>>>  #define HID_INFO_SIZE                  4
> > >>>>>>>  #define ATT_NOTIFICATION_HEADER_SIZE   3
> > >>>>>>
> > >>>>>> Afaik 512 is the maximum length an attribute can have even when =
using
> > >>>>>> read long procedure:
> > >>>>>>
> > >>>>>> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 3, Part F
> > >>>>>> page 1416:
> > >>>>>>
> > >>>>>> The maximum length of an attribute value shall be 512 octets.
> > >>>>>>
> > >>>>>> And
> > >>>>>>
> > >>>>>> BLUETOOTH SPECIFICATION
> > >>>>>> HID Service Specification
> > >>>>>> Page 16 of 26
> > >>>>>>
> > >>>>>> 2.6.1 Report Map Characteristic Behavior
> > >>>>>> The GATT Read Characteristic Value or Read Long Characteristic V=
alues sub-
> > >>>>>> procedures are used to read the Report Map characteristic value.
> > >>>>>> The length of the Report Map characteristic value is limited to =
512 octets.
> > >>>>>>
> > >>>>>> So I believe the device is not compliant and very likely needs t=
o have
> > >>>>>> multiple instances of HID Service instead of combining everythin=
g in a
> > >>>>>> single instance.
> > >>>>>>
> > >>>>>>> --
> > >>>>>>> 2.37.1
> > >>>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>
> > >>>>> Ah, that's strange. I looked through the spec but didn't see thos=
e. That said, while the device may be non-compliant, the device is on the m=
arket and I doubt I could get them to update the firmware as a random third=
 party. It works on Windows, so clearly Windows doesn't have a problem with=
 its noncompliance. So this raises the question, how should Linux handle no=
n-compliant hardware, especially when it could easily be made to work just =
by bending the rules in this one instance? I can absolutely change the comm=
it message since it's erroneous, but the question then comes down to how sh=
ould it be handled at all.
> > >>>>
> > >>>> While I agree this could be worked around it is probably worth
> > >>>> checking with the manufacturer if it is aware of the problem becau=
se
> > >>>> even if we were to allow reading past 512 bytes offset in the futu=
re
> > >>>> there may be qualification tests enforcing not to do so, besides
> > >>>> versions up to BlueZ 5.65 would still not work anyway so I thing
> > >>>> letting the manufacturer know there is a problem with their
> > >>>> implementation is actually worth a shot here.
> > >>>>
> > >>> Brydge replied with the standard tech support "this is only support=
ed on Windows, so there probably won't be a firmware update" reply, despite=
 its noncompliance. And since I doubt Windows will add a change to limit it=
, well, that kind of limits our options here to either "enforce compliance =
and break non-compliant hardware" or "figure out a way to bend the rules". =
Given that BlueZ, upon expanding the maximum size, does successfully read t=
he overly-long report map (it does use the read blob with offset message to=
 get the last several bytes), it does work as intended if we ignore that sp=
ecific rule. Though obviously that's up to the bluetooth maintainers to sol=
ve, so at this point I'm just tossing my two cents at it.
> > >>
> > >> Well we can do what Windows is doing but let's have it documented
> > >> then, we could as well scalate this with Bluetooth SIG since the
> > >> manufacturer seem to be intentionally creating interoperability
> > >> problems with a standard service, but that would likely take a lot
> > >> more time and most likely will need to be resolved by introducing a
> > >> test that enforces that HoG client don't attempt to read past 512
> > >> bytes offset.
> >
> > Is the client the device or the computer? Because the computer does suc=
cessfully read past 512 bytes, and I believe it's needed for this device.
> >
> > >>
> > >> Btw, if there is no limitation on how big the report map can get in
> > >> HID, I'd leave it up to the kernel to figure out if that is acceptab=
le
> > >> or not, so I'd remove the 1024.
> >
> > That makes sense. I can look into how to arbitrarily size that buffer.
> >
> > >
> > > Are you still planning to update this change? Btw, how about Android,
> > > does it handle such devices?
> > >
> >
> > Ah sorry, your reply was somewhat open ended and I didn't realize you w=
anted me to specifically look into this. As for Android, I have no idea. I =
can try pairing the trackpad with an Android device and seeing what happens=
, but I don't have anything with modern Android as it's not my day-to-day p=
hone OS.
>
> Well iOS would do as well, what Im after is if that is in fact never
> enforced by other major OS, I do see there have been some tickets
> created about that already so Im trying to get some response, please
> forward this to the manufactures:
>
> https://www.bluetooth.org/errata/errata_view.cfm?errata_id=3D17495
>
> In the meantime there is yet another device that appear to have similar p=
roblem:
>
> https://github.com/bluez/bluez/pull/376

I went ahead and sent a patch myself, could you please verify it does
work the your device:

https://patchwork.kernel.org/project/bluetooth/patch/20220816191144.1515498=
-1-luiz.dentz@gmail.com/


--=20
Luiz Augusto von Dentz
