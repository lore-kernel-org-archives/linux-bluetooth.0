Return-Path: <SRS0=zjTV=BT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69092C433DF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  9 Aug 2020 05:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D98E20729
	for <linux-bluetooth@archiver.kernel.org>; Sun,  9 Aug 2020 05:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RccIo4MQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgHIFeD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 9 Aug 2020 01:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgHIFeC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 9 Aug 2020 01:34:02 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B5FC061756
        for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2020 22:34:02 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id k12so4824480otr.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 08 Aug 2020 22:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2VpcYfBJa/ronbImLa6I+wXesRjiNdZljgfdNr+5KsE=;
        b=RccIo4MQtUPYotw1GL+NPkug/MlbGmQr/xuIGZ61BLn6DLzHQpTKjMLqQp7pUuKQhy
         e+VqOhwmGB+rnJF2TZmduSWM9pszK0uPGcfGJV6a/gNJFRhIC6uOM+hcvdPf3roF+kQi
         zp+EQDj/fQJj4LPMkgUKy6g4ejDEm1gIV4Vgte2KHlPS/mMWPgBBG3W++t4jp3VD7ofZ
         ViZ/4mJMdKa2QfpWfylmmvNFDV6wGt6mkEJbXui84NgXCCXHf2ZmqqcTb84nXn3Ba2HD
         UcHVMlKQi31LxPwEkhRXEUWo1VsY44NeEufPv4TG6YQEdPaxnyAzKjNiVmZF+dSMkboY
         hi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2VpcYfBJa/ronbImLa6I+wXesRjiNdZljgfdNr+5KsE=;
        b=MLY24vzrw9ElbWUIis4aMTNSCMf0q06V7O/X5DKiguWBFJb8ICsEq14lsLzkkV9P/y
         9JXpfXCR59WJipzUg/5taX5W27zbSJSMxV6sZvVfORqbeV6sRFpf7qAxYFz61Q3ZOX5d
         60uMskW6M/iHu4Tkkh/sjNjHbAg7VyvK0q5Pujg64H39KrajDt+N169CC7aKir+6Kb0i
         X8mZVpkVfD/MSqeu/t0F3RIc4BXlYNv8lqcT/hU2HyBaf/8zV+JWKAfADFO8pyE7ceSa
         xyUxMc+fGb7rIT0NhcjHOIMGp/sNs54TEr3QjNghtM2S2oBAM24RMI2KuWQmhXf/xcIw
         8A0g==
X-Gm-Message-State: AOAM530jO//w8tPGJIhlIviXW73ZU2gPEgEgCQ0gZ+RTEzov9M+cA/u5
        7uPmz6bE+CIZqOPfhvqADgxK3nbSKoSFMnsp5qJD+g==
X-Google-Smtp-Source: ABdhPJx8yDPl1Lm/96FrMiRuxKpdHNophm9vVC+3/azSbq7r9ybDXdWUQpoZT1OHPfNUzE3J6bTpW8hkSV+h7C/9FK0=
X-Received: by 2002:a9d:39c2:: with SMTP id y60mr18534190otb.91.1596951240503;
 Sat, 08 Aug 2020 22:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200506193435.3746-1-pali@kernel.org> <CECA6D9A-0F26-40E8-BFDF-A24CD972307D@holtmann.org>
 <20200610093306.zt3q3s2wmwp3almw@pali> <7672C0A0-AF6A-41B2-B50F-7836B3E5CC73@holtmann.org>
 <20200611125304.b4mxxuv7rupamfmg@pali> <20200713090913.6duirl4yhrjcyxoh@pali> <20200808132042.mma5ykynagwx3ubd@pali>
In-Reply-To: <20200808132042.mma5ykynagwx3ubd@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sat, 8 Aug 2020 22:33:48 -0700
Message-ID: <CABBYNZ+Ep6njp9vfEZrFTGCiSMcsdoPnPa21H0ApJ1O3tau_MQ@mail.gmail.com>
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

On Sat, Aug 8, 2020 at 6:20 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Monday 13 July 2020 11:09:13 Pali Roh=C3=A1r wrote:
> > On Thursday 11 June 2020 14:53:04 Pali Roh=C3=A1r wrote:
> > > On Wednesday 10 June 2020 19:31:47 Marcel Holtmann wrote:
> > > > Hi Pali,
> > > >
> > > > >>> This utility is very useful for determining which A2DP codecs a=
re supported
> > > > >>> by remote side. So install it to system as part of bluez packag=
e.
> > > > >>> ---
> > > > >>> Makefile.tools | 4 ++--
> > > > >>> 1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >>>
> > > > >>> diff --git a/Makefile.tools b/Makefile.tools
> > > > >>> index 9b9236609..d52721612 100644
> > > > >>> --- a/Makefile.tools
> > > > >>> +++ b/Makefile.tools
> > > > >>> @@ -176,9 +176,9 @@ endif
> > > > >>> if TOOLS
> > > > >>> bin_PROGRAMS +=3D tools/rctest tools/l2test tools/l2ping tools/=
bccmd \
> > > > >>>                       tools/bluemoon tools/hex2hcd tools/mpris-=
proxy \
> > > > >>> -                     tools/btattach
> > > > >>> +                     tools/btattach tools/avinfo
> > > > >>>
> > > > >>> -noinst_PROGRAMS +=3D tools/bdaddr tools/avinfo tools/avtest \
> > > > >>> +noinst_PROGRAMS +=3D tools/bdaddr tools/avtest \
> > > > >>>                       tools/scotest tools/amptest tools/hwdb \
> > > > >>>                       tools/hcieventmask tools/hcisecfilter \
> > > > >>>                       tools/btinfo tools/btconfig \
> > > > >>
> > > > >> I had no intention to install that tool since it is too limited
> > > > >
> > > > > Sorry, but I have not seen any limitations with this tool yet. I'=
m using
> > > > > it very often. And also other people who use it have not mentione=
d any
> > > > > limitations or problems.
> > > > >
> > > > > So could you be more specific what are those limitations?
> > > > >
> > > > > Also it is the first thing which I'm saying people that should ru=
n and
> > > > > send me output of it if something related to A2DP does not work.
> > > > >
> > > > > And because linux distributions do not package this utility and b=
luez
> > > > > developers (for me for unknown reasons) decided to not install it=
,
> > > > > result is that people have to always compile bluez from source to=
 run
> > > > > this utility if their A2DP audio does not work or "remote" debugg=
ing of
> > > > > A2DP is needed.
> > > > >
> > > > > So result is that who want to know why A2DP audio does not work i=
s
> > > > > forced to compile & install bluez from sources and not to use fro=
m
> > > > > distribution package. And this probably not the expected state.
> > > > >
> > > > > In any case, nobody reported to me any limitation with one except=
ion
> > > > > that it cannot decode capabilities of some custom vendor codecs. =
But
> > > > > most of them are already supported as I sent needed patches in pa=
st.
> > > > >
> > > > >> and makes too many assumption.
> > > > >
> > > > > For example which assumptions?
> > > >
> > > > that nothing else is happening right now. It backstabs the actual A=
VDTP and A2DP implementation.
> > >
> > > Marcel, but this is not a problem. For that one purpose which avinfo
> > > provides it ideal and works fine. Personally I do not see any problem
> > > with it.
> > >
> > > > >> In addition it has a bad name with no Bluetooth prefix.
> > > > >
> > > > > So, lets rename it. What about "btavinfo"?
> > > >
> > > > Lets extend btinfo with all sort of capabilities. Make the av porti=
on just one of. I want to remove the multitudes of test utilities anyway. W=
e have to many tiny utilities that are just scattered around and avinfo is =
just one of them.
> > >
> > > This looks like a not-so-trivial task and moreover independent of
> > > providing current version of avinfo to users.
> > >
> > > avinfo already exists, is already part of bluez project, it is alread=
y
> > > compiling during bluez build and is already used by me and lot of oth=
er
> > > users and works for that one purpose as expected.
> > >
> > > > >
> > > > >> If we think it is useful to have such a test utility, then we ne=
ed to clean this up first
> > > > >
> > > > > What exactly to clean up first?
> > > > >
> > > > > Note that I have already done cleanup of this utility.
> > > > >
> > > > >> and put this into a larger btinfo work to gather appropriate inf=
ormation from a remote device for debug purposes.
> > > > >
> > > > > I do not see how btinfo can be used for A2DP purposes. Seems this=
 is
> > > > > utility for local controller info and not for remove A2DP.
> > > >
> > > > This needs a bit thinking, but pretty much simple things like this:
> > > >
> > > >   btinfo local
> > > >   btinfo avdtp <remote_bdaddr>
> > > >
> > > > We can create a module handling system so that you can easily links=
 existing tiny utilities into one.
> > >
> > > I'm not against this change. But this is additional work which needs =
to
> > > be done. And it would not happen today or tomorrow unless you have
> > > already patches which implement it.
> > >
> > > As I said avinfo is already there, implemented, it is working and is
> > > part of bluez source code. And is basically the first step when
> > > debugging issues with A2DP audio.
> > >
> > > So what is the real issue with not only compiling this avinfo tool
> > > during building bluez but also installing it?
> >
> > Because nobody presented any real issue for more then month and I'm not
> > aware of any, could be avinfo finally enabled during installation?
>
> PING, two months passed and I have not received any new reply to this pat=
ch.
>
> If there are really no problems, could it be applied?

For the record I do intend to enable listing available endpoints in
bluetooth-player, which might actually get merged into bluetoothctl as
a new menu, recently there have been some vulnerabilities reported
against these kind of tools that are meant to only be used for testing
purposes so I would only be in favor of installing them with we add
some new build option i.e. --enable-testing and document that these
tools are meant for testing only (and shall probably be package
separately) so we avoid these pointless reports for tools that are not
really meant to be used in production.

--=20
Luiz Augusto von Dentz
