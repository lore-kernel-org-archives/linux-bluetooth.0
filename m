Return-Path: <SRS0=zjTV=BT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F00C433E0
	for <linux-bluetooth@archiver.kernel.org>; Sun,  9 Aug 2020 18:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A70A4206C0
	for <linux-bluetooth@archiver.kernel.org>; Sun,  9 Aug 2020 18:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag5QUjFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgHISXI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 9 Aug 2020 14:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgHISXH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 9 Aug 2020 14:23:07 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850B6C061756
        for <linux-bluetooth@vger.kernel.org>; Sun,  9 Aug 2020 11:23:07 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k12so5629740otr.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Aug 2020 11:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o2lF/nlQ8cjk+f5euqbhqvYXb0X8Exdt9M4jAdEQkgA=;
        b=ag5QUjFLFM1W+f/jPKULcmBJs7YbpCmphgN86+yfECawJF3YcyLo+zOD70CADFXjJB
         DOfCF1U7Ib79cbKKo3AaUk7Bysprqr8xdFfSzx+Ud3idTzXLfe02kGhwmy8Y60IG5WWD
         Xaij+oJdnDmbC3rKsPtcWLctNI7WeG8lC2rkKujb3JJfdaV7mgYeQRVaVOCDv5w0U5M3
         xK4ODb1gE8cEV8NMmGN38rQilc4jBXxKPP1BO9nS5nRm6WDqp6NMpkclQeGu1vH2XnV9
         Yowjsck3S4FaZXXSLqvkQjjJpdPDkpsUGhuzSxqE6x2W8Sy3VLV3VjBNU8RRVS5X7zv9
         EeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o2lF/nlQ8cjk+f5euqbhqvYXb0X8Exdt9M4jAdEQkgA=;
        b=Fd93BtX9H8aC48ACYcY5q+8wx81w42uiprvWohgmXpBm/bzywnjXPHm/sc0ZfGMS5v
         KWH21Bp15sAKup4+rWFuUPk+reI+W3riMvV2wJrlQIOlSXeRV/fUFdwV6BoOywRHs/ow
         yXKjYKdBfjHj+dcuA9HW9rggYPNdn73ld/FhEMVzZ6DgTVksyF98N+jn9QBqdRyEYDwX
         EaXQjpR0uhTJyhoql+DKiqTI5y9I8WU3MnLdVEzdJWIhEGVN7uWO9XlmAK4GsUoLxLUr
         qVx4p48+klV8W93rJhquiwfcAgT0jNhygbVy3GdTgeXDS9eM11VfLJJQ1w+5Bxh+lmyD
         DHrQ==
X-Gm-Message-State: AOAM532VJQ4mdvXF2qEF3sXIEYIzp1lQngXMEky/koBM5iqT8I6kcw4N
        zyISS45tWsuw9YRYvlll/j8o/ebGy2nDGo21cyc=
X-Google-Smtp-Source: ABdhPJwoSYTyt6oAfIWSvm6hswkUc5O03kNJ0U97PRNcIwHW5RbcPNwL/WQ8xtLA8aTu961N0NEs72icrSIP03Lsvbk=
X-Received: by 2002:a9d:6053:: with SMTP id v19mr20193915otj.362.1596997386134;
 Sun, 09 Aug 2020 11:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200506193435.3746-1-pali@kernel.org> <CECA6D9A-0F26-40E8-BFDF-A24CD972307D@holtmann.org>
 <20200610093306.zt3q3s2wmwp3almw@pali> <7672C0A0-AF6A-41B2-B50F-7836B3E5CC73@holtmann.org>
 <20200611125304.b4mxxuv7rupamfmg@pali> <20200713090913.6duirl4yhrjcyxoh@pali>
 <20200808132042.mma5ykynagwx3ubd@pali> <CABBYNZ+Ep6njp9vfEZrFTGCiSMcsdoPnPa21H0ApJ1O3tau_MQ@mail.gmail.com>
 <20200809153321.gywj4elkefrcusvz@pali>
In-Reply-To: <20200809153321.gywj4elkefrcusvz@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 9 Aug 2020 11:22:53 -0700
Message-ID: <CABBYNZJwf==cfNgEzVJ0r+gA7QVFxyXp25OT13X+=qW6pH5-9A@mail.gmail.com>
Subject: Re: [PATCH] Install avinfo utility
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Sun, Aug 9, 2020 at 8:33 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Saturday 08 August 2020 22:33:48 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >
> > On Sat, Aug 8, 2020 at 6:20 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > >
> > > On Monday 13 July 2020 11:09:13 Pali Roh=C3=A1r wrote:
> > > > On Thursday 11 June 2020 14:53:04 Pali Roh=C3=A1r wrote:
> > > > > On Wednesday 10 June 2020 19:31:47 Marcel Holtmann wrote:
> > > > > > Hi Pali,
> > > > > >
> > > > > > >>> This utility is very useful for determining which A2DP code=
cs are supported
> > > > > > >>> by remote side. So install it to system as part of bluez pa=
ckage.
> > > > > > >>> ---
> > > > > > >>> Makefile.tools | 4 ++--
> > > > > > >>> 1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > >>>
> > > > > > >>> diff --git a/Makefile.tools b/Makefile.tools
> > > > > > >>> index 9b9236609..d52721612 100644
> > > > > > >>> --- a/Makefile.tools
> > > > > > >>> +++ b/Makefile.tools
> > > > > > >>> @@ -176,9 +176,9 @@ endif
> > > > > > >>> if TOOLS
> > > > > > >>> bin_PROGRAMS +=3D tools/rctest tools/l2test tools/l2ping to=
ols/bccmd \
> > > > > > >>>                       tools/bluemoon tools/hex2hcd tools/mp=
ris-proxy \
> > > > > > >>> -                     tools/btattach
> > > > > > >>> +                     tools/btattach tools/avinfo
> > > > > > >>>
> > > > > > >>> -noinst_PROGRAMS +=3D tools/bdaddr tools/avinfo tools/avtes=
t \
> > > > > > >>> +noinst_PROGRAMS +=3D tools/bdaddr tools/avtest \
> > > > > > >>>                       tools/scotest tools/amptest tools/hwd=
b \
> > > > > > >>>                       tools/hcieventmask tools/hcisecfilter=
 \
> > > > > > >>>                       tools/btinfo tools/btconfig \
> > > > > > >>
> > > > > > >> I had no intention to install that tool since it is too limi=
ted
> > > > > > >
> > > > > > > Sorry, but I have not seen any limitations with this tool yet=
. I'm using
> > > > > > > it very often. And also other people who use it have not ment=
ioned any
> > > > > > > limitations or problems.
> > > > > > >
> > > > > > > So could you be more specific what are those limitations?
> > > > > > >
> > > > > > > Also it is the first thing which I'm saying people that shoul=
d run and
> > > > > > > send me output of it if something related to A2DP does not wo=
rk.
> > > > > > >
> > > > > > > And because linux distributions do not package this utility a=
nd bluez
> > > > > > > developers (for me for unknown reasons) decided to not instal=
l it,
> > > > > > > result is that people have to always compile bluez from sourc=
e to run
> > > > > > > this utility if their A2DP audio does not work or "remote" de=
bugging of
> > > > > > > A2DP is needed.
> > > > > > >
> > > > > > > So result is that who want to know why A2DP audio does not wo=
rk is
> > > > > > > forced to compile & install bluez from sources and not to use=
 from
> > > > > > > distribution package. And this probably not the expected stat=
e.
> > > > > > >
> > > > > > > In any case, nobody reported to me any limitation with one ex=
ception
> > > > > > > that it cannot decode capabilities of some custom vendor code=
cs. But
> > > > > > > most of them are already supported as I sent needed patches i=
n past.
> > > > > > >
> > > > > > >> and makes too many assumption.
> > > > > > >
> > > > > > > For example which assumptions?
> > > > > >
> > > > > > that nothing else is happening right now. It backstabs the actu=
al AVDTP and A2DP implementation.
> > > > >
> > > > > Marcel, but this is not a problem. For that one purpose which avi=
nfo
> > > > > provides it ideal and works fine. Personally I do not see any pro=
blem
> > > > > with it.
> > > > >
> > > > > > >> In addition it has a bad name with no Bluetooth prefix.
> > > > > > >
> > > > > > > So, lets rename it. What about "btavinfo"?
> > > > > >
> > > > > > Lets extend btinfo with all sort of capabilities. Make the av p=
ortion just one of. I want to remove the multitudes of test utilities anywa=
y. We have to many tiny utilities that are just scattered around and avinfo=
 is just one of them.
> > > > >
> > > > > This looks like a not-so-trivial task and moreover independent of
> > > > > providing current version of avinfo to users.
> > > > >
> > > > > avinfo already exists, is already part of bluez project, it is al=
ready
> > > > > compiling during bluez build and is already used by me and lot of=
 other
> > > > > users and works for that one purpose as expected.
> > > > >
> > > > > > >
> > > > > > >> If we think it is useful to have such a test utility, then w=
e need to clean this up first
> > > > > > >
> > > > > > > What exactly to clean up first?
> > > > > > >
> > > > > > > Note that I have already done cleanup of this utility.
> > > > > > >
> > > > > > >> and put this into a larger btinfo work to gather appropriate=
 information from a remote device for debug purposes.
> > > > > > >
> > > > > > > I do not see how btinfo can be used for A2DP purposes. Seems =
this is
> > > > > > > utility for local controller info and not for remove A2DP.
> > > > > >
> > > > > > This needs a bit thinking, but pretty much simple things like t=
his:
> > > > > >
> > > > > >   btinfo local
> > > > > >   btinfo avdtp <remote_bdaddr>
> > > > > >
> > > > > > We can create a module handling system so that you can easily l=
inks existing tiny utilities into one.
> > > > >
> > > > > I'm not against this change. But this is additional work which ne=
eds to
> > > > > be done. And it would not happen today or tomorrow unless you hav=
e
> > > > > already patches which implement it.
> > > > >
> > > > > As I said avinfo is already there, implemented, it is working and=
 is
> > > > > part of bluez source code. And is basically the first step when
> > > > > debugging issues with A2DP audio.
> > > > >
> > > > > So what is the real issue with not only compiling this avinfo too=
l
> > > > > during building bluez but also installing it?
> > > >
> > > > Because nobody presented any real issue for more then month and I'm=
 not
> > > > aware of any, could be avinfo finally enabled during installation?
> > >
> > > PING, two months passed and I have not received any new reply to this=
 patch.
> > >
> > > If there are really no problems, could it be applied?
> >
> > For the record I do intend to enable listing available endpoints in
> > bluetooth-player, which might actually get merged into bluetoothctl as
> > a new menu,
>
> Will it provide everything which is avinfo provides?

Regarding endpoints yes, it is the endpoint information that has been
exposed via D-Bus objects.

> > recently there have been some vulnerabilities reported
> > against these kind of tools that are meant to only be used for testing
> > purposes
>
> Could you be more specific what is that vulnerability, so we can fix it?

It is not related to avinfo, it was gatttool if you are curious about
it, but most if not all our tools do tend to leak memory when they are
exiting which would trigger some analyzer, etc, to have pointless
reports about those leaks.

> It is the only issue? If yes, I'm going to fix it once I receive
> details about it.
>
> > so I would only be in favor of installing them with we add
> > some new build option i.e. --enable-testing and document that these
> > tools are meant for testing only (and shall probably be package
> > separately) so we avoid these pointless reports for tools that are not
> > really meant to be used in production.
>
> As I said, avinfo is required tool for debugging A2DP audio transfers in
> case there are problems and probably it is the only tool useful for such
> purpose.
>
> Lot of users are reporting that "audio does not work" and the only way
> to debug is, is to ask users to provide full output of avinfo.

Well if the issue is at the negotiation it avinfo is not the useful,
btmon traces are what I usually recommend having as you can figure out
what issues are 99% of the time.

> Well, it can be classified as "testing tool", but highly required in
> case audio does not work.

It is not a qualifiable implementation that is for sure, so
classifying it as a testing tool is the best we can do.

> So please provide information about that vulnerability and I will fix
> it. As being silent for two months about existing vulnerability is not
> really good.



--=20
Luiz Augusto von Dentz
