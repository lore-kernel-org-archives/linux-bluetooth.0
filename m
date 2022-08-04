Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC300C19F2D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Aug 2022 00:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239191AbiHDARm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Aug 2022 20:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241020AbiHDARB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Aug 2022 20:17:01 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D7317E33
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Aug 2022 17:17:00 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id tl27so16302447ejc.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Aug 2022 17:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LvKfiYY3ThGcY/PvoVyzoh+l78b5Su4tnO7kvzXLjZA=;
        b=lgJ2FxVLXDkigW2RHPnUX09iozvB4QJorww8eTTkDWW8k5n0wfEY9yF36RP/uTgbiy
         flfRpomUGVgK0t7J8ktPcF/li1VQqIyJuMueaD7OTECzRrkb6I6+b2vrh6H4w7VVSLhZ
         3kPrE6B1zPx2goz0sJXBm9gvYS/wIjMrCU0pHuv6GOr9qoSO1uEKeaxpC1HyoXkWehjX
         P6ye8A+/KI3Z4uQguaFfNN4UZmu4etaRcUnochXIi+HB0RQO/GMj5ONYfjNKHOO0/KC2
         JfwcUn8jeX5KaiT5D1eLXFkk9qjSyUdNfnBvX2nvzRmFdYuD9PEn8+WLPgYTypBLEz9Z
         oKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LvKfiYY3ThGcY/PvoVyzoh+l78b5Su4tnO7kvzXLjZA=;
        b=PuMEWkLHyC6pzN64yQHhUh2BKCEXg37C+iKCqtnjmonx/088ASSa/OQNJy96Xeg8O/
         +LM2KPYOB2so31fsHdwcUCLCCjM2DebBW13WS4nZdQn2FJONjC/7j/IoGcMIUr9UkobP
         TtTXeGi59LikKNwCOhUnQkHZ/sM0CwilXYMCEWNkDfL9tJNItTPxya6LuREfZCyLYua1
         +y+DITFcn7FXOwICa0/zyU2zr/GD7xvUgyPffORMCVrdMboWgpU6GvR3gt9N5GzwaIS4
         ETX//zW7A5PFNtvaPT4Q7eCCFbLSbkFzwLJWdjAIIdW4Z4iXdHNo7nXegnMRXbZs4VPD
         UsKA==
X-Gm-Message-State: AJIora+uBfm4Yi863OxLhQ91zbnmQdsbAhi6xOfAXi9Rd/eGMD185AYX
        TYUvgot9HKfVvuCZdkA9M/3kh1O9x0XhNBO9mT4B9S8EGHY=
X-Google-Smtp-Source: AGRyM1uCqYbyJAVAB65+xHuaFkNJiXnkMfrzfzY246kzApa/nivk1F+v1xcWkQbnYQih3K+14dB4yqXIG++xu83+vGo=
X-Received: by 2002:a17:907:2e0d:b0:72b:8cd4:ca52 with SMTP id
 ig13-20020a1709072e0d00b0072b8cd4ca52mr21130321ejc.541.1659572219475; Wed, 03
 Aug 2022 17:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220803225716.1287921-1-vi@endrift.com> <CABBYNZKcAZeDqjeHzTfqmvKS3Tbur-rRi6+uPL4x4t8MnWp5ug@mail.gmail.com>
 <c0f52a2d-19ff-acb2-92ac-cec87819a2cf@endrift.com>
In-Reply-To: <c0f52a2d-19ff-acb2-92ac-cec87819a2cf@endrift.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 3 Aug 2022 17:16:48 -0700
Message-ID: <CABBYNZLtWN7oWBRc-YjV6baCPpkh_J-2mUMO83A_3y=Xtn==dw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] hog-lib: Increase maximum report map size
To:     Vicki Pfau <vi@endrift.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Vicki,

On Wed, Aug 3, 2022 at 5:05 PM Vicki Pfau <vi@endrift.com> wrote:
>
>
>
> On 8/3/22 16:55, Luiz Augusto von Dentz wrote:
> > Hi Vicki,
> >
> > On Wed, Aug 3, 2022 at 4:07 PM Vicki Pfau <vi@endrift.com> wrote:
> >>
> >> Though a 512 byte report map size seems plenty large, there exist some=
 devices
> >> (e.g. Brydge W-Touch) that send larger reports. There is no protocol-d=
efined
> >> maximum size so doubling the maximum size is safe, and should hopefull=
y fix
> >> most real-world failures.
> >> ---
> >>  profiles/input/hog-lib.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> >> index 4a9c60185..9f3eb428c 100644
> >> --- a/profiles/input/hog-lib.c
> >> +++ b/profiles/input/hog-lib.c
> >> @@ -64,7 +64,7 @@
> >>  #define HOG_PROTO_MODE_BOOT    0
> >>  #define HOG_PROTO_MODE_REPORT  1
> >>
> >> -#define HOG_REPORT_MAP_MAX_SIZE        512
> >> +#define HOG_REPORT_MAP_MAX_SIZE        1024
> >>  #define HID_INFO_SIZE                  4
> >>  #define ATT_NOTIFICATION_HEADER_SIZE   3
> >
> > Afaik 512 is the maximum length an attribute can have even when using
> > read long procedure:
> >
> > BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 3, Part F
> > page 1416:
> >
> > The maximum length of an attribute value shall be 512 octets.
> >
> > And
> >
> > BLUETOOTH SPECIFICATION
> > HID Service Specification
> > Page 16 of 26
> >
> > 2.6.1 Report Map Characteristic Behavior
> > The GATT Read Characteristic Value or Read Long Characteristic Values s=
ub-
> > procedures are used to read the Report Map characteristic value.
> > The length of the Report Map characteristic value is limited to 512 oct=
ets.
> >
> > So I believe the device is not compliant and very likely needs to have
> > multiple instances of HID Service instead of combining everything in a
> > single instance.
> >
> >> --
> >> 2.37.1
> >>
> >
> >
>
> Ah, that's strange. I looked through the spec but didn't see those. That =
said, while the device may be non-compliant, the device is on the market an=
d I doubt I could get them to update the firmware as a random third party. =
It works on Windows, so clearly Windows doesn't have a problem with its non=
compliance. So this raises the question, how should Linux handle non-compli=
ant hardware, especially when it could easily be made to work just by bendi=
ng the rules in this one instance? I can absolutely change the commit messa=
ge since it's erroneous, but the question then comes down to how should it =
be handled at all.

While I agree this could be worked around it is probably worth
checking with the manufacturer if it is aware of the problem because
even if we were to allow reading past 512 bytes offset in the future
there may be qualification tests enforcing not to do so, besides
versions up to BlueZ 5.65 would still not work anyway so I thing
letting the manufacturer know there is a problem with their
implementation is actually worth a shot here.

--=20
Luiz Augusto von Dentz
