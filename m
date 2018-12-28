Return-Path: <SRS0=+lf3=PF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57A1C43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 22:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76351217F9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 22:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7WEeU3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeL1WKZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:10:25 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:43240 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbeL1WKZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Dec 2018 17:10:25 -0500
Received: by mail-ot1-f45.google.com with SMTP id a11so19628316otr.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Dec 2018 14:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3nqRhVsf+aiP/4j5aCIgTmryRoa455rAYuX9YWyNASw=;
        b=V7WEeU3WK4Df1IDdWWI6vKJDhT7fVTUawHEfk/d+a4Kcg58lDyb4vFlTs5HucqHkYS
         FFG3u+TTJ1JFy9yxgRI08v0AXiPpeC7+vuxD7J6nps11ftvVI/AOc7m/97sPu9KhguQ4
         /aK9mMLz51514jodlGcQhyR5qZVkMPfPCpK7iLuoqrP8QLsTsaenpvgtkjK2lq/sShOW
         NeNrKCa97jdqbBStaxFiFTY0V9BceCfx4GfbnscZffx+VcseRd5QY3dxVjccwQ+Xf7ri
         LpteeeZYOFwGbp9PNAx/t1+w1NehFBEU6Id0ny/x++TJyo6MxSTW4wrcjiNfQjzHnRox
         Co6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3nqRhVsf+aiP/4j5aCIgTmryRoa455rAYuX9YWyNASw=;
        b=c/QBx2o4ZNFjlaRqLOFWGqzSvgOD5ecTvb0ZLJAJiLl2m5Kfs+6pv9z+tR8C/Z8PeS
         POs/VjKdjosI5kFbvLqetYqmgcy2fS+VBpRckgFfhhW7qUYIsS7wHx0uT2y2YqS8++89
         Yxfn2Z+gEAWdywG3VgJsFGNF0wuRhYsImIXKBmVl3b7uFNq7enWA0LLq1SVUVxZErxit
         NeCFkin96mJVCw1wd+D3rDm/uKNf8KK1hiJ/TpPYgj1dxtasDtHIHpUgR5WKwgXiDN04
         NOuJwH7pjwjbJIzJoFc/XJVkcO3t9HrtjcaQbLDgVEoNJ/ZbqucdMCyuwPOnXpB9voNm
         VUrw==
X-Gm-Message-State: AJcUukf2CWpoVIjq8s/VwQjAJEf7hZZZZkn0zT+Y/xiDoY1wC7InGagA
        /AzPfl552+ZUh/aRy/sl/TNlZV3+S5stFc0gGueITWWM
X-Google-Smtp-Source: ALg8bN7hV0wG7ftbNEexVWWI9YNklHEPX8z28UFACeT9Z1o/4BIsqRAT0K6msZgwQs4Qb/HIdu1/p6GFN7vN6ZQB760=
X-Received: by 2002:a9d:3426:: with SMTP id v35mr2160258otb.71.1546035023317;
 Fri, 28 Dec 2018 14:10:23 -0800 (PST)
MIME-Version: 1.0
References: <20180711082352.oo6srapfnol5nkxq@pali> <CABBYNZJuGT5_zhg-BkAc4XjtVu5His92cHTujrin=SMOVbaodQ@mail.gmail.com>
 <20180711144501.ovdxc2expa4bg6sc@pali> <20181215202910.j24amjshrvjqprll@pali>
 <CABBYNZLK4tyL8nvWbXxr6VctyEyJkMdwNiWMy4gUge9h9Vb4SQ@mail.gmail.com> <20181228191102.GA31975@reaktio.net>
In-Reply-To: <20181228191102.GA31975@reaktio.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 28 Dec 2018 19:10:11 -0300
Message-ID: <CABBYNZ+bwbSkH4qtkuzhE=JY6KAGwJ_E4ABGT_LE6E277eTNDQ@mail.gmail.com>
Subject: Re: bluez: dbus method call for switching endpoint
To:     =?UTF-8?B?UGFzaSBLw6Rya2vDpGluZW4=?= <pasik@iki.fi>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pasi,

On Fri, Dec 28, 2018 at 4:46 PM Pasi K=C3=A4rkk=C3=A4inen <pasik@iki.fi> wr=
ote:
>
> Hi Luiz,
>
> On Tue, Dec 18, 2018 at 01:02:39PM -0300, Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >
> > On Sat, Dec 15, 2018 at 5:29 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> =
wrote:
> > >
> > > On Wednesday 11 July 2018 16:45:01 Pali Roh=C3=A1r wrote:
> > > > On Wednesday 11 July 2018 16:27:07 Luiz Augusto von Dentz wrote:
> > > > > One way to solve all of these is that we would expose the remote
> > > > > endpoints using MediaEndpoint1
> > > >
> > > > So client application (like pulseadio) would see list of remote
> > > > endpoints (one for each codec) and choose one for connection?
> > > >
> > > > Looks like this should solve this problem.
> > >
> > > Are there any progress on such API in bluez?
> > >
> > > On pulseaudio mailing list other people proposed patches for other A2=
DP
> > > codecs and basically bluez API for choosing A2DP codec is still missi=
ng
> > > part...
> >
> > Im currenlty on vacation but will try to find time for that, that said
> > that shouldn't stop us to include support for other codecs, the last
> > set seems to have some sort of priority for ordering the registration
> > of the codecs.
> >
>
> Let us know when you have something to see/try!
> I'm happy to do testing of the patches.
>
> People are currently eager to get support for multiple BT audio codecs wo=
rking and merged upstream :)

Note that it is very unlikely that this API would allow multiple
codecs at the same time, headsets normally only allow one
configuration at time. Making it possible to switch codecs is more of
a workaround for headsets that don't honor the codec priority since
they normally codec back, although some model no longer configure a
stream just wait the source.

Regarding the API I still didn't have time to start it, so it will
take a little longer than I antecipated.
--=20
Luiz Augusto von Dentz
