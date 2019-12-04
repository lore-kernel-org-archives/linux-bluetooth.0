Return-Path: <SRS0=DiUs=Z2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57D2C43603
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Dec 2019 15:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9B82073B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Dec 2019 15:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=arunraghavan.net header.i=@arunraghavan.net header.b="MbyYZBJh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eq3fDpeK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfLDPZ6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:25:58 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:44551 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727828AbfLDPZ5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Dec 2019 10:25:57 -0500
X-Greylist: delayed 609 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Dec 2019 10:25:56 EST
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 36A028D3;
        Wed,  4 Dec 2019 10:15:46 -0500 (EST)
Received: from imap38 ([10.202.2.88])
  by compute3.internal (MEProxy); Wed, 04 Dec 2019 10:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        arunraghavan.net; h=mime-version:message-id:in-reply-to
        :references:date:from:to:cc:subject:content-type
        :content-transfer-encoding; s=mesmtp; bh=zuyMcS61SYpn7Z5DNj9PE0P
        i+8LaRj+SPIHF+39T1hQ=; b=MbyYZBJh5PHbnWHKR/E9kbAPra6I0Hrl3qlTgN+
        4A1lsqc2f3Oyi89k7dK3UTwMktxei7cCs5wrLoRaO5JM6wLDqG1AjXIEFQ3fhXLz
        Mk9ErAerPFdDPpsmHUmGAthCrKN50bObqSKxRGrgO9xnKuONcviRxzG8CAcN5zqe
        5P4k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=zuyMcS61SYpn7Z5DNj9PE0Pi+8LaRj+SPIHF+39T1
        hQ=; b=eq3fDpeKSHU0hIJYm9W1LtH13NcqGjUwdWDCdV8QdGJkNcBvuMMhRZxVJ
        zohskEhchqn6ZhFR1YncivPq+MbkVYgX4qPqADqqghcwEJlF3By4H6FR1qDTRgge
        nmGyudxPmB9JlHCGILaaHfYw4qhrTrb23xGohm6VOWtCus9SFKB4QFCHe8Fn0Wwr
        khfzYDAtlV/INkv138qygXhe+mZHZQ9nqHPGq2EdlQMPGQsKiWSAXttYs9JfViXX
        fiBeBFOAZN5Bdc9pmWqIdA/Je2lalqP0J5m7QV54gVOpSCGphN15BeljZt9MiLo2
        fs07XahSH77rZjd72Ewsb2mFqTJsw==
X-ME-Sender: <xms:n83nXejcqjrF0MJxewEzvFLLXy24pLCf7WpVM_dIaG6aED2o7Mm4cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejledgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    uhhnucftrghghhgrvhgrnhdfuceorghruhhnsegrrhhunhhrrghghhgrvhgrnhdrnhgvth
    eqnecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgpdhgihhthhhusgdrtgho
    mhenucfrrghrrghmpehmrghilhhfrhhomheprghruhhnsegrrhhunhhrrghghhgrvhgrnh
    drnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:n83nXSjX_ps5GYOeAg6sw1CjyEnoNsmo152zDRfZQcxDDz778g1Rtw>
    <xmx:n83nXY6De5_NWQZQPj8cBnOTZ2TaO_EbVRQpBZy7vrgEXYIYDwjs4A>
    <xmx:n83nXU27SMXAOVhvTinz-hQwci6hAyvMSVgicTe1iagBFr9Yq-2fVg>
    <xmx:oc3nXWRsRevuiIIBIT98F9BgDPjaos7XWCMgXkDctAbLZ1s0x-SqSLcIVAU>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 659FC4C000A4; Wed,  4 Dec 2019 10:15:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-612-g13027cc-fmstable-20191203v1
Mime-Version: 1.0
Message-Id: <190b130f-bc84-4af1-a807-5b5fbef3f166@www.fastmail.com>
In-Reply-To: <20191202184512.rx6p63c6axztnwrw@pali>
References: <20191201185740.uot7zb2s53p5gu7z@pali>
 <508d35f29c2abc26af15e232a38d3ca53eb33706.camel@iki.fi>
 <20191202184512.rx6p63c6axztnwrw@pali>
Date:   Wed, 04 Dec 2019 20:45:23 +0530
From:   "Arun Raghavan" <arun@arunraghavan.net>
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        "Tanu Kaskinen" <tanuk@iki.fi>
Cc:     "PulseAudio Discussion" <pulseaudio-discuss@lists.freedesktop.org>,
        linux-bluetooth@vger.kernel.org, ofono@ofono.org,
        devkit-devel@lists.freedesktop.org,
        "Bastien Nocera" <hadess@hadess.net>,
        "Georg Chini" <georg@chini.tk>,
        "Russell Treleaven" <rtreleaven@bunnykick.ca>,
        "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
        "Marcel Holtmann" <marcel@holtmann.org>,
        "Sebastian Reichel" <sre@ring0.de>, "Pavel Machek" <pavel@ucw.cz>,
        "Wim Taymans" <wim.taymans@gmail.com>,
        "George Kiagiadakis" <george.kiagiadakis@collabora.com>
Subject: =?UTF-8?Q?Re:_[pulseaudio-discuss]_Proposal_for_a_new_API_and_usage_of_B?=
 =?UTF-8?Q?luetooth_HSP_and_HFP_profiles_on_Linux?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

+Wim and George from PipeWire

On Tue, 3 Dec 2019, at 12:15 AM, Pali Roh=C3=A1r wrote:
> On Monday 02 December 2019 19:01:11 Tanu Kaskinen wrote:
> > On Sun, 2019-12-01 at 19:57 +0100, Pali Roh=C3=A1r wrote:
> > > Hello!
> > >=20
> > > I'm sending this email to relevant mailing lists and other people =
who
> > > could be interested in it. (I'm not subscribed to all of ML, so pl=
ease
> > > CC me when replying).
> > >=20
> > >=20
> > > I would like to open a discussion about a completely new way of ha=
ndling
> > > Bluetooth HSP and HFP profiles on Linux. These two profiles are th=
e only
> > > standard way how to access microphone data from Bluetooth Headsets=
.
> > >=20
> > >=20
> > > Previously in bluez4, HFP profile was implemented by bluez daemon =
and
> > > telephony HFP functionality was provided by either dummy modem, of=
ono
> > > modem or by Nokia's CSD Maemo modem.
> > >=20
> > > In bluez5 version was modem code together with implementation of H=
FP
> > > profile removed. And let implementation of HSP and HFP profiles to=

> > > external application.
> > >=20
> > > Currently HSP profile is implemented in pulseaudio daemon to handl=
e
> > > microphone and Bluetooth speakers. HFP profile is not implemented =
yet.
> > >=20
> > >=20
> > > HSP and HFP profiles use AT modem commands, so its implementation =
needs
> > > to parse and generates AT commands, plus implement needed state ma=
chine
> > > for it.
> > >=20
> > > And now problem is that last version of HFP profile specification =
is too
> > > complicated, plus Bluetooth headsets vendors started to inventing =
and
> > > using of own custom extensions to HFP profile and AT commands.
> > >=20
> > > Main problem of this "external" implementation outside of bluez is=
 that
> > > only one application can communicate with remote Bluetooth device.=
 It
> > > is application which received needed socket from bluez.
> > >=20
> > > So in this design if audio daemon (pulseaudio) implements HFP prof=
ile
> > > for processing audio, and e.g. power supply application wants to
> > > retrieve battery level from Bluetooth device, it means that audio =
daemon
> > > needs to implement also battery related functionality.
> > >=20
> > > It does not make sense to force power supply daemon (upower) to
> > > implement audio routing/encoding/decoding or audio daemon (power s=
upply)
> > > to force implementing battery related operations.
> > >=20
> > >=20
> > > For handle this problem I would like to propose a new way how to u=
se and
> > > implement HSP and HFP profiles on Linux.
> > >=20
> > > Implement a new HSP/HFP daemon (I called it hsphfpd) which registe=
r HSP
> > > and HFP profiles in bluez and then exports functionality for all o=
ther
> > > specific applications via DBus API (API for audio, power supply, i=
nput
> > > layer, telephony functions, vendor extensions, etc...). So it woul=
d acts
> > > as proxy daemon between bluez and target applications (pulseaudio,=

> > > upower, ofono, ...)
> > >=20
> > > This would simplify whole HFP usage as applications would not need=
 to
> > > re-implement parsing and processing of AT commands and it would al=
low
> > > more applications to use HFP profile at one time. And also it mean=
s that
> > > audio software does not have to implement telephony stack or power=

> > > supply operations.
> > >=20
> > >=20
> > > I wrote a document how such DBus API could look like, see here:
> > >=20
> > >   https://github.com/pali/hsphfpd-prototype/raw/prototype/hsphfpd.=
txt
> > >=20
> > >=20
> > > And also I implemented "prototype" implementation to verify that
> > > designed API make sense and can be really implemented. Prototype f=
ully
> > > supports HSP profile in both HS and AG role, plus HFP profile in H=
F
> > > role. This prototype implementation is available here:
> > >=20
> > >   https://github.com/pali/hsphfpd-prototype
> > >=20
> > > Some other details are written in README:
> > >=20
> > >   https://github.com/pali/hsphfpd-prototype/raw/prototype/README
> > >=20
> > >=20
> > > What do you think about it? Does it make sense to have such design=
?
> > > Would you accept usage of such hsphfpd daemon, implemented accordi=
ng to
> > > specification, on Linux desktop?
> > >=20
> > > I would like to hear your opinion if I should continue with this h=
sphfpd
> > > design, or not.
> > >=20
> > >=20
> > > With this design and implementation of hsphfpd is possible to easi=
ly fix
> > > pulseaudio issue about power supply properties:
> > >=20
> > >   https://gitlab.freedesktop.org/pulseaudio/pulseaudio/issues/722
> >=20
> > I quite like this proposal. Avoiding the need to implement the butto=
n
> > press, battery level etc. handling separately in PulseAudio, oFono a=
nd
> > PipeWire seems like a pretty good justification to me. I assume you'=
re
> > volunteering to maintain this new daemon?
>=20
> Yes, I can maintain this new daemon.
>=20
> > It's not clear to me how this would affect the PulseAudio <-> oFono
> > interaction, if at all.
>=20
> Only one application can register to bluez and "own" bluez socket for
> communication with bluetooth headset. Currently it can be either
> pulseaudio (with native backend in pulseaudio for HSP profile) or ofon=
o
> (with ofono backend in pulseaudio for HFP profile).
>=20
> So if hsphfpd would be in use, then ofono would not be able to get
> socket from bluez. And it would be needed to add a new "plugin" into
> ofono to use hsphpfd for telephony operations. See hsphfpd.txt file
> (there is diagram of usage).
>=20
> > When oFono is used, would PulseAudio get the
> > audio socket from oFono or hsphfpd?
>=20
> Always from hsphfpd.
>=20
> > What about volume commands, would they go through oFono or would
> > PulseAudio interact with hsphfpd directly?
>=20
> Internally they are handled by hsphpfd directly and appropriate API is=

> exported via DBus for audio application daemon (pulseaudio). For detai=
ls
> see hsphfpd.txt file, interface org.hsphfpd.AudioTransport.
>=20
> > I think hsphfpd should be part of bluetoothd, but if that's not
> > possible, then that's not possible.
>=20
> I do not know if bluez developers are interested in having this code a=
s
> part of bluez project, specially when in bluez4 HFP profile was there
> and in bluez5 was HFP code completely removed.
>=20
> But it should not matter where hsphpfd is implemented.
>=20
> > (I don't want to get into a lengthy discussion about programming
> > languages, but I'll just note here that I don't like Perl.)
>=20
> It is just a prototype. I used Perl just because it is faster for me t=
o
> implement parsing of AT commands needed for prototype purposes.

Broadly, I think this is a good thing to do. My main concern is having t=
his be adequately maintained over a longer period of time.

The other thing to note is that in PipeWire, it is possible for external=
 entities to implement the equivalent of a "sink" or "source" (it's just=
 a node in PipeWire terminology), so in the long run, it might be good t=
o have a single BT audio daemon that manages A2DP and HSP/HFP..

This would also have the benefit of moving codec dependencies out of Pul=
seAudio (which I'll help mitigate in other ways within PulseAudio anyway=
).

Cheers,
Arun
