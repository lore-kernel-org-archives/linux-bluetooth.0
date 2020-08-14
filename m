Return-Path: <SRS0=Aqt4=BY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8381BC433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 08:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BB1A207DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 08:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597392104;
	bh=Jg0UKpPfQWQi3+FOI35pkwnDNhqPylAnpzgmFN2q6m4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gPhsYZEx+u3xIFjL8dgWV2MW8NMkGXXc3HusgH24ISfjRGFJCCr118Vvsic1tMhRO
	 Zo912jgLR6PdINZnh3nCsSckeaHCrApGtJkIyTGnzc4+RamCwYf50ABgNAFe/qBfYS
	 SkS4+s7GyYSXZF9ZlqUqQeVJbPf+Q9xCKxmL0DBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgHNIBn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Aug 2020 04:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgHNIBn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Aug 2020 04:01:43 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F9D42065C;
        Fri, 14 Aug 2020 08:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597392102;
        bh=Jg0UKpPfQWQi3+FOI35pkwnDNhqPylAnpzgmFN2q6m4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BFw6AgNFi4ABRI5micuWSD5wPZUWeyUZeuR2k/olspvXko6ID0dBS0gO5p3c2OjLs
         VDc/kSxCvMon33u3GyUtdsHi0JqxHr3n5fTb8zQwjIYZCSu+IT3T2Kl3JkOYvRocr1
         K1btzgyGd56Uu+nH4HwKgtayf4+blI2RHEPJ2MAw=
Received: by pali.im (Postfix)
        id D4FEEBD5; Fri, 14 Aug 2020 10:01:39 +0200 (CEST)
Date:   Fri, 14 Aug 2020 10:01:39 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH] Install avinfo utility
Message-ID: <20200814080139.23g24skan7krigdo@pali>
References: <20200506193435.3746-1-pali@kernel.org>
 <CECA6D9A-0F26-40E8-BFDF-A24CD972307D@holtmann.org>
 <20200610093306.zt3q3s2wmwp3almw@pali>
 <7672C0A0-AF6A-41B2-B50F-7836B3E5CC73@holtmann.org>
 <20200611125304.b4mxxuv7rupamfmg@pali>
 <20200713090913.6duirl4yhrjcyxoh@pali>
 <20200808132042.mma5ykynagwx3ubd@pali>
 <CABBYNZ+Ep6njp9vfEZrFTGCiSMcsdoPnPa21H0ApJ1O3tau_MQ@mail.gmail.com>
 <20200809153321.gywj4elkefrcusvz@pali>
 <CABBYNZJwf==cfNgEzVJ0r+gA7QVFxyXp25OT13X+=qW6pH5-9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJwf==cfNgEzVJ0r+gA7QVFxyXp25OT13X+=qW6pH5-9A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sunday 09 August 2020 11:22:53 Luiz Augusto von Dentz wrote:
> Hi Pali,
> 
> On Sun, Aug 9, 2020 at 8:33 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Saturday 08 August 2020 22:33:48 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > >
> > > On Sat, Aug 8, 2020 at 6:20 AM Pali Rohár <pali@kernel.org> wrote:
> > > >
> > > > On Monday 13 July 2020 11:09:13 Pali Rohár wrote:
> > > > > On Thursday 11 June 2020 14:53:04 Pali Rohár wrote:
> > > > > > On Wednesday 10 June 2020 19:31:47 Marcel Holtmann wrote:
> > > > > > > Hi Pali,
> > > > > > >
> > > > > > > >>> This utility is very useful for determining which A2DP codecs are supported
> > > > > > > >>> by remote side. So install it to system as part of bluez package.
> > > > > > > >>> ---
> > > > > > > >>> Makefile.tools | 4 ++--
> > > > > > > >>> 1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > > >>>
> > > > > > > >>> diff --git a/Makefile.tools b/Makefile.tools
> > > > > > > >>> index 9b9236609..d52721612 100644
> > > > > > > >>> --- a/Makefile.tools
> > > > > > > >>> +++ b/Makefile.tools
> > > > > > > >>> @@ -176,9 +176,9 @@ endif
> > > > > > > >>> if TOOLS
> > > > > > > >>> bin_PROGRAMS += tools/rctest tools/l2test tools/l2ping tools/bccmd \
> > > > > > > >>>                       tools/bluemoon tools/hex2hcd tools/mpris-proxy \
> > > > > > > >>> -                     tools/btattach
> > > > > > > >>> +                     tools/btattach tools/avinfo
> > > > > > > >>>
> > > > > > > >>> -noinst_PROGRAMS += tools/bdaddr tools/avinfo tools/avtest \
> > > > > > > >>> +noinst_PROGRAMS += tools/bdaddr tools/avtest \
> > > > > > > >>>                       tools/scotest tools/amptest tools/hwdb \
> > > > > > > >>>                       tools/hcieventmask tools/hcisecfilter \
> > > > > > > >>>                       tools/btinfo tools/btconfig \
> > > > > > > >>
> > > > > > > >> I had no intention to install that tool since it is too limited
> > > > > > > >
> > > > > > > > Sorry, but I have not seen any limitations with this tool yet. I'm using
> > > > > > > > it very often. And also other people who use it have not mentioned any
> > > > > > > > limitations or problems.
> > > > > > > >
> > > > > > > > So could you be more specific what are those limitations?
> > > > > > > >
> > > > > > > > Also it is the first thing which I'm saying people that should run and
> > > > > > > > send me output of it if something related to A2DP does not work.
> > > > > > > >
> > > > > > > > And because linux distributions do not package this utility and bluez
> > > > > > > > developers (for me for unknown reasons) decided to not install it,
> > > > > > > > result is that people have to always compile bluez from source to run
> > > > > > > > this utility if their A2DP audio does not work or "remote" debugging of
> > > > > > > > A2DP is needed.
> > > > > > > >
> > > > > > > > So result is that who want to know why A2DP audio does not work is
> > > > > > > > forced to compile & install bluez from sources and not to use from
> > > > > > > > distribution package. And this probably not the expected state.
> > > > > > > >
> > > > > > > > In any case, nobody reported to me any limitation with one exception
> > > > > > > > that it cannot decode capabilities of some custom vendor codecs. But
> > > > > > > > most of them are already supported as I sent needed patches in past.
> > > > > > > >
> > > > > > > >> and makes too many assumption.
> > > > > > > >
> > > > > > > > For example which assumptions?
> > > > > > >
> > > > > > > that nothing else is happening right now. It backstabs the actual AVDTP and A2DP implementation.
> > > > > >
> > > > > > Marcel, but this is not a problem. For that one purpose which avinfo
> > > > > > provides it ideal and works fine. Personally I do not see any problem
> > > > > > with it.
> > > > > >
> > > > > > > >> In addition it has a bad name with no Bluetooth prefix.
> > > > > > > >
> > > > > > > > So, lets rename it. What about "btavinfo"?
> > > > > > >
> > > > > > > Lets extend btinfo with all sort of capabilities. Make the av portion just one of. I want to remove the multitudes of test utilities anyway. We have to many tiny utilities that are just scattered around and avinfo is just one of them.
> > > > > >
> > > > > > This looks like a not-so-trivial task and moreover independent of
> > > > > > providing current version of avinfo to users.
> > > > > >
> > > > > > avinfo already exists, is already part of bluez project, it is already
> > > > > > compiling during bluez build and is already used by me and lot of other
> > > > > > users and works for that one purpose as expected.
> > > > > >
> > > > > > > >
> > > > > > > >> If we think it is useful to have such a test utility, then we need to clean this up first
> > > > > > > >
> > > > > > > > What exactly to clean up first?
> > > > > > > >
> > > > > > > > Note that I have already done cleanup of this utility.
> > > > > > > >
> > > > > > > >> and put this into a larger btinfo work to gather appropriate information from a remote device for debug purposes.
> > > > > > > >
> > > > > > > > I do not see how btinfo can be used for A2DP purposes. Seems this is
> > > > > > > > utility for local controller info and not for remove A2DP.
> > > > > > >
> > > > > > > This needs a bit thinking, but pretty much simple things like this:
> > > > > > >
> > > > > > >   btinfo local
> > > > > > >   btinfo avdtp <remote_bdaddr>
> > > > > > >
> > > > > > > We can create a module handling system so that you can easily links existing tiny utilities into one.
> > > > > >
> > > > > > I'm not against this change. But this is additional work which needs to
> > > > > > be done. And it would not happen today or tomorrow unless you have
> > > > > > already patches which implement it.
> > > > > >
> > > > > > As I said avinfo is already there, implemented, it is working and is
> > > > > > part of bluez source code. And is basically the first step when
> > > > > > debugging issues with A2DP audio.
> > > > > >
> > > > > > So what is the real issue with not only compiling this avinfo tool
> > > > > > during building bluez but also installing it?
> > > > >
> > > > > Because nobody presented any real issue for more then month and I'm not
> > > > > aware of any, could be avinfo finally enabled during installation?
> > > >
> > > > PING, two months passed and I have not received any new reply to this patch.
> > > >
> > > > If there are really no problems, could it be applied?
> > >
> > > For the record I do intend to enable listing available endpoints in
> > > bluetooth-player, which might actually get merged into bluetoothctl as
> > > a new menu,
> >
> > Will it provide everything which is avinfo provides?
> 
> Regarding endpoints yes, it is the endpoint information that has been
> exposed via D-Bus objects.

Ok, please let me know know it is merged and I will try it.

> > > recently there have been some vulnerabilities reported
> > > against these kind of tools that are meant to only be used for testing
> > > purposes
> >
> > Could you be more specific what is that vulnerability, so we can fix it?
> 
> It is not related to avinfo, it was gatttool if you are curious about
> it, but most if not all our tools do tend to leak memory when they are
> exiting which would trigger some analyzer, etc, to have pointless
> reports about those leaks.

Ok, but this does not look like security issue. Just false positive
report of memory leak. Nothing highly critical.

> > It is the only issue? If yes, I'm going to fix it once I receive
> > details about it.
> >
> > > so I would only be in favor of installing them with we add
> > > some new build option i.e. --enable-testing and document that these
> > > tools are meant for testing only (and shall probably be package
> > > separately) so we avoid these pointless reports for tools that are not
> > > really meant to be used in production.
> >
> > As I said, avinfo is required tool for debugging A2DP audio transfers in
> > case there are problems and probably it is the only tool useful for such
> > purpose.
> >
> > Lot of users are reporting that "audio does not work" and the only way
> > to debug is, is to ask users to provide full output of avinfo.
> 
> Well if the issue is at the negotiation it avinfo is not the useful,
> btmon traces are what I usually recommend having as you can figure out
> what issues are 99% of the time.

In more cases it is needed to know what codecs and which their
configuration is supported. And dumping this is hard from btmon as it
produce tons of output (not related to this) and in some cases it does
not provide this information (e.g. when during handshake is not
enumerated all codecs).

So btmon is not replacement for avinfo. It is tool for diagnostic other
issues, e.g. those related to handshake / negotiation. So both are
required.

> > Well, it can be classified as "testing tool", but highly required in
> > case audio does not work.
> 
> It is not a qualifiable implementation that is for sure, so
> classifying it as a testing tool is the best we can do.

Ok, I have no problem to say it is "for testing" or "for debugging".
Distribution maintainers can decide where to put that package and how to
install it.

But important is that tool needs to be available to end users in some
form.

> > So please provide information about that vulnerability and I will fix
> > it. As being silent for two months about existing vulnerability is not
> > really good.
