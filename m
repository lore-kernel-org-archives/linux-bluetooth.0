Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC502C00140
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Aug 2022 18:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbiHOSJ6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Aug 2022 14:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiHOSJ5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Aug 2022 14:09:57 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F012A249
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Aug 2022 11:09:56 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id j3so8411754ljo.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Aug 2022 11:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=jFL82xF+WMQA52cVyDqW8EHU6WHjVelwDV2bKFl0RvA=;
        b=WfraAer/5uHbIOQPK6ayw8pAJPABpZB+Tf6ubGVkI6IoR3Y9lDY9Z58SFsERXF7tQ2
         Cw6qD7hJUmXDi/u5Dt06stgSntX0KxC1Bcw2G6FDEpQSNeOnSvd69naGVxl4nMMRY2jD
         pkBUV/2mCPa5uKxu+5R8pk9CS/VNhuyG/C6Vmaoh2yi5g1nnySFUmkZxxwouOqBFwXw9
         XLDacrjiq4ky45lr4FveYMTy5CLXDi4Oh8d92AGyJ3ezY54x56JOA/5gW28iYPT/9YfO
         seJQ57wFBZrBswk8gKhoeJXkouRWh5r/taumBXEmxoU7fMfzIqZ+O1Y5UnAJhVm109GG
         5McA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=jFL82xF+WMQA52cVyDqW8EHU6WHjVelwDV2bKFl0RvA=;
        b=l4c6NDtJAqKP5/QwwwRS6XbC+peareo6MllsLhJbAaztWPnvRlVudSfCZ28jBQ+QYD
         EbO2P9t5l+wBRQi8FAfsUQnMN8dGEacm1ex3aQnINSuDM/Ad4Pi6NPmtWyZQHRKfjuyt
         riX/rvBxJTd992RJCRe0eHCyt4BrJm1CEVpZ8bIhMSFuJRGaqYAqCgezYeG0NaD/Kbu2
         1E/xJT+ycWQMk0F4PVUNdh5IPDq38y5R4+W9MVfSsIVkWKcxSFVMiax0tqBmxqoaHibR
         39/T4b99EWsTOQbcr9stH3wFR97UznAC6xxHuppq0c84hq6T2LgLGGkNMJVczgLnE+Qq
         pBkA==
X-Gm-Message-State: ACgBeo0uuBE7npY37XYPIiENSerN229+hA25XUTW5e8wcXmIiOn5jSgL
        0e6oRrrLMI3XuYdWGP/eYGIhMC65TnLoPClDtAeHgcKEto0=
X-Google-Smtp-Source: AA6agR4hVWp0/08gDxABG4uG7D90Wy3SUvD9rtg1MMudGuo7ACPNki42jQKxdp/KicDb5kVS9MMgTNvDURASgUxedwM=
X-Received: by 2002:a05:651c:4d4:b0:25e:c766:202e with SMTP id
 e20-20020a05651c04d400b0025ec766202emr5012515lji.423.1660586993210; Mon, 15
 Aug 2022 11:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220803225716.1287921-1-vi@endrift.com> <CABBYNZKcAZeDqjeHzTfqmvKS3Tbur-rRi6+uPL4x4t8MnWp5ug@mail.gmail.com>
 <c0f52a2d-19ff-acb2-92ac-cec87819a2cf@endrift.com> <CABBYNZLtWN7oWBRc-YjV6baCPpkh_J-2mUMO83A_3y=Xtn==dw@mail.gmail.com>
 <dbeb83e5-9986-ca5d-e71f-cdaa579794bb@endrift.com> <CABBYNZLHFAj4LwaMTEvCmysF2D__xrhJT9ORY-qmm_XYcGjjtQ@mail.gmail.com>
In-Reply-To: <CABBYNZLHFAj4LwaMTEvCmysF2D__xrhJT9ORY-qmm_XYcGjjtQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 15 Aug 2022 11:09:41 -0700
Message-ID: <CABBYNZKbCcz7p+EaNpWZkuX77BJ-DsoT=BRUQGwJjAhTesLhXA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] hog-lib: Increase maximum report map size
To:     Vicki Pfau <vi@endrift.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Vicki,

On Wed, Aug 10, 2022 at 1:13 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Vicki,
>
> On Tue, Aug 9, 2022 at 7:02 PM Vicki Pfau <vi@endrift.com> wrote:
> >
> >
> >
> > On 8/3/22 17:16, Luiz Augusto von Dentz wrote:
> > > Hi Vicki,
> > >
> > > On Wed, Aug 3, 2022 at 5:05 PM Vicki Pfau <vi@endrift.com> wrote:
> > >>
> > >>
> > >>
> > >> On 8/3/22 16:55, Luiz Augusto von Dentz wrote:
> > >>> Hi Vicki,
> > >>>
> > >>> On Wed, Aug 3, 2022 at 4:07 PM Vicki Pfau <vi@endrift.com> wrote:
> > >>>>
> > >>>> Though a 512 byte report map size seems plenty large, there exist =
some devices
> > >>>> (e.g. Brydge W-Touch) that send larger reports. There is no protoc=
ol-defined
> > >>>> maximum size so doubling the maximum size is safe, and should hope=
fully fix
> > >>>> most real-world failures.
> > >>>> ---
> > >>>>  profiles/input/hog-lib.c | 2 +-
> > >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>>
> > >>>> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> > >>>> index 4a9c60185..9f3eb428c 100644
> > >>>> --- a/profiles/input/hog-lib.c
> > >>>> +++ b/profiles/input/hog-lib.c
> > >>>> @@ -64,7 +64,7 @@
> > >>>>  #define HOG_PROTO_MODE_BOOT    0
> > >>>>  #define HOG_PROTO_MODE_REPORT  1
> > >>>>
> > >>>> -#define HOG_REPORT_MAP_MAX_SIZE        512
> > >>>> +#define HOG_REPORT_MAP_MAX_SIZE        1024
> > >>>>  #define HID_INFO_SIZE                  4
> > >>>>  #define ATT_NOTIFICATION_HEADER_SIZE   3
> > >>>
> > >>> Afaik 512 is the maximum length an attribute can have even when usi=
ng
> > >>> read long procedure:
> > >>>
> > >>> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 3, Part F
> > >>> page 1416:
> > >>>
> > >>> The maximum length of an attribute value shall be 512 octets.
> > >>>
> > >>> And
> > >>>
> > >>> BLUETOOTH SPECIFICATION
> > >>> HID Service Specification
> > >>> Page 16 of 26
> > >>>
> > >>> 2.6.1 Report Map Characteristic Behavior
> > >>> The GATT Read Characteristic Value or Read Long Characteristic Valu=
es sub-
> > >>> procedures are used to read the Report Map characteristic value.
> > >>> The length of the Report Map characteristic value is limited to 512=
 octets.
> > >>>
> > >>> So I believe the device is not compliant and very likely needs to h=
ave
> > >>> multiple instances of HID Service instead of combining everything i=
n a
> > >>> single instance.
> > >>>
> > >>>> --
> > >>>> 2.37.1
> > >>>>
> > >>>
> > >>>
> > >>
> > >> Ah, that's strange. I looked through the spec but didn't see those. =
That said, while the device may be non-compliant, the device is on the mark=
et and I doubt I could get them to update the firmware as a random third pa=
rty. It works on Windows, so clearly Windows doesn't have a problem with it=
s noncompliance. So this raises the question, how should Linux handle non-c=
ompliant hardware, especially when it could easily be made to work just by =
bending the rules in this one instance? I can absolutely change the commit =
message since it's erroneous, but the question then comes down to how shoul=
d it be handled at all.
> > >
> > > While I agree this could be worked around it is probably worth
> > > checking with the manufacturer if it is aware of the problem because
> > > even if we were to allow reading past 512 bytes offset in the future
> > > there may be qualification tests enforcing not to do so, besides
> > > versions up to BlueZ 5.65 would still not work anyway so I thing
> > > letting the manufacturer know there is a problem with their
> > > implementation is actually worth a shot here.
> > >
> > Brydge replied with the standard tech support "this is only supported o=
n Windows, so there probably won't be a firmware update" reply, despite its=
 noncompliance. And since I doubt Windows will add a change to limit it, we=
ll, that kind of limits our options here to either "enforce compliance and =
break non-compliant hardware" or "figure out a way to bend the rules". Give=
n that BlueZ, upon expanding the maximum size, does successfully read the o=
verly-long report map (it does use the read blob with offset message to get=
 the last several bytes), it does work as intended if we ignore that specif=
ic rule. Though obviously that's up to the bluetooth maintainers to solve, =
so at this point I'm just tossing my two cents at it.
>
> Well we can do what Windows is doing but let's have it documented
> then, we could as well scalate this with Bluetooth SIG since the
> manufacturer seem to be intentionally creating interoperability
> problems with a standard service, but that would likely take a lot
> more time and most likely will need to be resolved by introducing a
> test that enforces that HoG client don't attempt to read past 512
> bytes offset.
>
> Btw, if there is no limitation on how big the report map can get in
> HID, I'd leave it up to the kernel to figure out if that is acceptable
> or not, so I'd remove the 1024.

Are you still planning to update this change? Btw, how about Android,
does it handle such devices?

--=20
Luiz Augusto von Dentz
