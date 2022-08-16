Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5FDC32772
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 18:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbiHPSbl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 14:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236499AbiHPSbg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 14:31:36 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E6E57E18
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 11:31:34 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id bx38so11346958ljb.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 11:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=veKrb3uU4qV+Ha6yxxeAeb1+OfQ3l2xSgID393fxLJ8=;
        b=g5bG+fZyHw3OORSkjacFJ43EPT1e8XDhvxBAsDhaqt/ttKhef0lnDpRVyOZTFVM0ro
         V2mtxH3OLReaktn3Ppf6zThi8A+ECeJcEhSv700SDWrmh1z/ro4/yaHGP2513LE1moRc
         mWlj8JZxEVAXh52o4OWqDbl1JPGSWRPqaeqYdl4djsTXeI/35wJDdBNz2OhQ/yZOEDa9
         sreLjG2zBRlgfazP5xu8eGHug9AJ/TZgBISvwz/FoV4QdB90aWMTAXiLYxUbkbFC+kSs
         cuivADgB2JGaPKyuWgXJys7iL4HPjyrpM5Akj4yvHELiYkBtCzTK4Lp1kF6pryG0c2dH
         wJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=veKrb3uU4qV+Ha6yxxeAeb1+OfQ3l2xSgID393fxLJ8=;
        b=yTgWnj+SZnTnlov8Iol+MTL94ILjmB8jOGF2kUpqPBzk8y1dAvSvIeELw45gfg4/PW
         FuJB9ttUc4SZaO5FBUOHn+WvZ3Rnq647rZxQx8vQH9yxwlG+eYnmbuZK52b5qSEMwwJ7
         lByEV73LTEQZ+YFjQel64miBnQ/ASml94TGABEfZuuix2vPHcHUws3VGEcbEeXanvvcV
         PIivoqC1ivGwBM+3YHcVkHJQsBv7CmKTnDI95N7I5A8xnS1Z0mCAliFGi9q0Js2Ruuek
         a1Xpipf/tqoTyykasbw9OrlwxiAsaRXXMH1F/wkKuDHQb5mFeqgGNalMTlzOXcNBVOdD
         HL6A==
X-Gm-Message-State: ACgBeo3M+kPr9/tij7m1T26ZLldJCc8Nl5J3y7YBg5/rFJiNmHtAHbnM
        TXLB//k/erK5L9QpYz+j5stcm1M+j+Gbm8nTTxUfHaRq5hTDXQ==
X-Google-Smtp-Source: AA6agR4tanPd2NWJMlOAAvQ4rbhVl5jVDfoawNA6pAIFSTNCT/xRv8nhdkxU0rJA/jbscswJxG1yWBxAi545aiP9yXQ=
X-Received: by 2002:a2e:8e90:0:b0:260:201:765b with SMTP id
 z16-20020a2e8e90000000b002600201765bmr6984620ljk.432.1660674692684; Tue, 16
 Aug 2022 11:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220803225716.1287921-1-vi@endrift.com> <CABBYNZKcAZeDqjeHzTfqmvKS3Tbur-rRi6+uPL4x4t8MnWp5ug@mail.gmail.com>
 <c0f52a2d-19ff-acb2-92ac-cec87819a2cf@endrift.com> <CABBYNZLtWN7oWBRc-YjV6baCPpkh_J-2mUMO83A_3y=Xtn==dw@mail.gmail.com>
 <dbeb83e5-9986-ca5d-e71f-cdaa579794bb@endrift.com> <CABBYNZLHFAj4LwaMTEvCmysF2D__xrhJT9ORY-qmm_XYcGjjtQ@mail.gmail.com>
 <CABBYNZKbCcz7p+EaNpWZkuX77BJ-DsoT=BRUQGwJjAhTesLhXA@mail.gmail.com> <be49af1f-f08a-7e26-42e5-98fe83077488@endrift.com>
In-Reply-To: <be49af1f-f08a-7e26-42e5-98fe83077488@endrift.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 16 Aug 2022 11:31:20 -0700
Message-ID: <CABBYNZLqjUpkCArjqHad4OKxT3PAow0T8+vP+tOvCtJbSG2p3g@mail.gmail.com>
Subject: Re: [PATCH BlueZ] hog-lib: Increase maximum report map size
To:     Vicki Pfau <vi@endrift.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Vicki,

On Mon, Aug 15, 2022 at 6:49 PM Vicki Pfau <vi@endrift.com> wrote:
>
> Hi,
>
> On 8/15/22 11:09, Luiz Augusto von Dentz wrote:
> > Hi Vicki,
> >
> > On Wed, Aug 10, 2022 at 1:13 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> >>
> >> Hi Vicki,
> >>
> >> On Tue, Aug 9, 2022 at 7:02 PM Vicki Pfau <vi@endrift.com> wrote:
> >>>
> >>>
> >>>
> >>> On 8/3/22 17:16, Luiz Augusto von Dentz wrote:
> >>>> Hi Vicki,
> >>>>
> >>>> On Wed, Aug 3, 2022 at 5:05 PM Vicki Pfau <vi@endrift.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 8/3/22 16:55, Luiz Augusto von Dentz wrote:
> >>>>>> Hi Vicki,
> >>>>>>
> >>>>>> On Wed, Aug 3, 2022 at 4:07 PM Vicki Pfau <vi@endrift.com> wrote:
> >>>>>>>
> >>>>>>> Though a 512 byte report map size seems plenty large, there exist=
 some devices
> >>>>>>> (e.g. Brydge W-Touch) that send larger reports. There is no proto=
col-defined
> >>>>>>> maximum size so doubling the maximum size is safe, and should hop=
efully fix
> >>>>>>> most real-world failures.
> >>>>>>> ---
> >>>>>>>  profiles/input/hog-lib.c | 2 +-
> >>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>>
> >>>>>>> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> >>>>>>> index 4a9c60185..9f3eb428c 100644
> >>>>>>> --- a/profiles/input/hog-lib.c
> >>>>>>> +++ b/profiles/input/hog-lib.c
> >>>>>>> @@ -64,7 +64,7 @@
> >>>>>>>  #define HOG_PROTO_MODE_BOOT    0
> >>>>>>>  #define HOG_PROTO_MODE_REPORT  1
> >>>>>>>
> >>>>>>> -#define HOG_REPORT_MAP_MAX_SIZE        512
> >>>>>>> +#define HOG_REPORT_MAP_MAX_SIZE        1024
> >>>>>>>  #define HID_INFO_SIZE                  4
> >>>>>>>  #define ATT_NOTIFICATION_HEADER_SIZE   3
> >>>>>>
> >>>>>> Afaik 512 is the maximum length an attribute can have even when us=
ing
> >>>>>> read long procedure:
> >>>>>>
> >>>>>> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 3, Part F
> >>>>>> page 1416:
> >>>>>>
> >>>>>> The maximum length of an attribute value shall be 512 octets.
> >>>>>>
> >>>>>> And
> >>>>>>
> >>>>>> BLUETOOTH SPECIFICATION
> >>>>>> HID Service Specification
> >>>>>> Page 16 of 26
> >>>>>>
> >>>>>> 2.6.1 Report Map Characteristic Behavior
> >>>>>> The GATT Read Characteristic Value or Read Long Characteristic Val=
ues sub-
> >>>>>> procedures are used to read the Report Map characteristic value.
> >>>>>> The length of the Report Map characteristic value is limited to 51=
2 octets.
> >>>>>>
> >>>>>> So I believe the device is not compliant and very likely needs to =
have
> >>>>>> multiple instances of HID Service instead of combining everything =
in a
> >>>>>> single instance.
> >>>>>>
> >>>>>>> --
> >>>>>>> 2.37.1
> >>>>>>>
> >>>>>>
> >>>>>>
> >>>>>
> >>>>> Ah, that's strange. I looked through the spec but didn't see those.=
 That said, while the device may be non-compliant, the device is on the mar=
ket and I doubt I could get them to update the firmware as a random third p=
arty. It works on Windows, so clearly Windows doesn't have a problem with i=
ts noncompliance. So this raises the question, how should Linux handle non-=
compliant hardware, especially when it could easily be made to work just by=
 bending the rules in this one instance? I can absolutely change the commit=
 message since it's erroneous, but the question then comes down to how shou=
ld it be handled at all.
> >>>>
> >>>> While I agree this could be worked around it is probably worth
> >>>> checking with the manufacturer if it is aware of the problem because
> >>>> even if we were to allow reading past 512 bytes offset in the future
> >>>> there may be qualification tests enforcing not to do so, besides
> >>>> versions up to BlueZ 5.65 would still not work anyway so I thing
> >>>> letting the manufacturer know there is a problem with their
> >>>> implementation is actually worth a shot here.
> >>>>
> >>> Brydge replied with the standard tech support "this is only supported=
 on Windows, so there probably won't be a firmware update" reply, despite i=
ts noncompliance. And since I doubt Windows will add a change to limit it, =
well, that kind of limits our options here to either "enforce compliance an=
d break non-compliant hardware" or "figure out a way to bend the rules". Gi=
ven that BlueZ, upon expanding the maximum size, does successfully read the=
 overly-long report map (it does use the read blob with offset message to g=
et the last several bytes), it does work as intended if we ignore that spec=
ific rule. Though obviously that's up to the bluetooth maintainers to solve=
, so at this point I'm just tossing my two cents at it.
> >>
> >> Well we can do what Windows is doing but let's have it documented
> >> then, we could as well scalate this with Bluetooth SIG since the
> >> manufacturer seem to be intentionally creating interoperability
> >> problems with a standard service, but that would likely take a lot
> >> more time and most likely will need to be resolved by introducing a
> >> test that enforces that HoG client don't attempt to read past 512
> >> bytes offset.
>
> Is the client the device or the computer? Because the computer does succe=
ssfully read past 512 bytes, and I believe it's needed for this device.
>
> >>
> >> Btw, if there is no limitation on how big the report map can get in
> >> HID, I'd leave it up to the kernel to figure out if that is acceptable
> >> or not, so I'd remove the 1024.
>
> That makes sense. I can look into how to arbitrarily size that buffer.
>
> >
> > Are you still planning to update this change? Btw, how about Android,
> > does it handle such devices?
> >
>
> Ah sorry, your reply was somewhat open ended and I didn't realize you wan=
ted me to specifically look into this. As for Android, I have no idea. I ca=
n try pairing the trackpad with an Android device and seeing what happens, =
but I don't have anything with modern Android as it's not my day-to-day pho=
ne OS.

Well iOS would do as well, what Im after is if that is in fact never
enforced by other major OS, I do see there have been some tickets
created about that already so Im trying to get some response, please
forward this to the manufactures:

https://www.bluetooth.org/errata/errata_view.cfm?errata_id=3D17495

In the meantime there is yet another device that appear to have similar pro=
blem:

https://github.com/bluez/bluez/pull/376

--=20
Luiz Augusto von Dentz
