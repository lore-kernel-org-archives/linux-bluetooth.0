Return-Path: <SRS0=9PGa=ZY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFAEC432C0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Dec 2019 17:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B2120848
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Dec 2019 17:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bf/Pik4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfLBRBX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:01:23 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:43451 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727529AbfLBRBX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Dec 2019 12:01:23 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 55D7574E5;
        Mon,  2 Dec 2019 12:01:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 02 Dec 2019 12:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=xyQy9dAG/Tk48e38Og5fQtPsXOm8/6FxUgZbTP01B
        Ng=; b=bf/Pik4AdK0i81RPryJxjIgJ7hgyNIDZGbjoN+R4OAjyO0mshRZcfUNm3
        EaUputDAh8bkMj90N2L4Bzitqkm7bmk35bTwq23U+DExlmaDSQiTC02uvdV3/oDh
        8LzaOfMSXA33z7ml2MZfIJibzGZvwYO3FuDDEvJnW1bNhiU2HFlucrR3ByyoqhG7
        pHS04t9exslmjJLqyy7atg6AE5GvFaP2Uqi0l4t0It/r8eQxlLP76Frq+2i+wj2Q
        yAwlvm46uU+E7M0gjoIG+DzYRtFnzZy9SvIPmw+y6HqbQSv4XFnO2w9RDLcFXLQ3
        glQzV+UGJ4tx5l15szDDv1UxUWqoQ==
X-ME-Sender: <xms:YEPlXeDwNs0g1OqHto87mco9gEFY-giThKkRH6TvrFEAdaPvyWYr-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejhedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gorfhhihhshhhinhhgqdfkphfpvghtfihorhhkucdlfedttddmnecujfgurhepkffuhffv
    ffgjfhgtfggggfesthekredttderjeenucfhrhhomhepvfgrnhhuucfmrghskhhinhgvnh
    cuoehtrghnuhhksehikhhirdhfiheqnecuffhomhgrihhnpehfrhgvvgguvghskhhtohhp
    rdhorhhgpdhlihgsvghrrghprgihrdgtohhmpdhgihhthhhusgdrtghomhdpphgrthhrvg
    honhdrtghomhenucfkphepudeliedrvdeggedrudeluddruddtieenucfrrghrrghmpehm
    rghilhhfrhhomhepthgrnhhukhesihhkihdrfhhinecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:YEPlXcQ2HDC1UyZfOV2HWwtWuhwVTDzkWHQ52EvnmEWxIFW5_3CpRA>
    <xmx:YEPlXRVWViSgA4QhWpgBdwvq7A7Jm1-UNX2Ew8OrNG55b7GlW7hpIQ>
    <xmx:YEPlXcGbgD3AAArjpq19t3Dk5elSPGTOVihDsKUHzu6z43S0iNO0BA>
    <xmx:YkPlXVyZOVwHg8mwwDmdib3G8v3WvglYBkbH5sbpiBfXUbAs2QlTBb0g5UI>
Received: from laptop (unknown [196.244.191.106])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5C055306050C;
        Mon,  2 Dec 2019 12:01:17 -0500 (EST)
Message-ID: <508d35f29c2abc26af15e232a38d3ca53eb33706.camel@iki.fi>
Subject: Re: [pulseaudio-discuss] Proposal for a new API and usage of
 Bluetooth HSP and HFP profiles on Linux
From:   Tanu Kaskinen <tanuk@iki.fi>
To:     General PulseAudio Discussion 
        <pulseaudio-discuss@lists.freedesktop.org>,
        linux-bluetooth@vger.kernel.org, ofono@ofono.org,
        devkit-devel@lists.freedesktop.org,
        Bastien Nocera <hadess@hadess.net>,
        Georg Chini <georg@chini.tk>,
        Russell Treleaven <rtreleaven@bunnykick.ca>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Arun Raghavan <arun@arunraghavan.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sre@ring0.de>, Pavel Machek <pavel@ucw.cz>
Cc:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Date:   Mon, 02 Dec 2019 19:01:11 +0200
In-Reply-To: <20191201185740.uot7zb2s53p5gu7z@pali>
References: <20191201185740.uot7zb2s53p5gu7z@pali>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sun, 2019-12-01 at 19:57 +0100, Pali Rohár wrote:
> Hello!
> 
> I'm sending this email to relevant mailing lists and other people who
> could be interested in it. (I'm not subscribed to all of ML, so please
> CC me when replying).
> 
> 
> I would like to open a discussion about a completely new way of handling
> Bluetooth HSP and HFP profiles on Linux. These two profiles are the only
> standard way how to access microphone data from Bluetooth Headsets.
> 
> 
> Previously in bluez4, HFP profile was implemented by bluez daemon and
> telephony HFP functionality was provided by either dummy modem, ofono
> modem or by Nokia's CSD Maemo modem.
> 
> In bluez5 version was modem code together with implementation of HFP
> profile removed. And let implementation of HSP and HFP profiles to
> external application.
> 
> Currently HSP profile is implemented in pulseaudio daemon to handle
> microphone and Bluetooth speakers. HFP profile is not implemented yet.
> 
> 
> HSP and HFP profiles use AT modem commands, so its implementation needs
> to parse and generates AT commands, plus implement needed state machine
> for it.
> 
> And now problem is that last version of HFP profile specification is too
> complicated, plus Bluetooth headsets vendors started to inventing and
> using of own custom extensions to HFP profile and AT commands.
> 
> Main problem of this "external" implementation outside of bluez is that
> only one application can communicate with remote Bluetooth device. It
> is application which received needed socket from bluez.
> 
> So in this design if audio daemon (pulseaudio) implements HFP profile
> for processing audio, and e.g. power supply application wants to
> retrieve battery level from Bluetooth device, it means that audio daemon
> needs to implement also battery related functionality.
> 
> It does not make sense to force power supply daemon (upower) to
> implement audio routing/encoding/decoding or audio daemon (power supply)
> to force implementing battery related operations.
> 
> 
> For handle this problem I would like to propose a new way how to use and
> implement HSP and HFP profiles on Linux.
> 
> Implement a new HSP/HFP daemon (I called it hsphfpd) which register HSP
> and HFP profiles in bluez and then exports functionality for all other
> specific applications via DBus API (API for audio, power supply, input
> layer, telephony functions, vendor extensions, etc...). So it would acts
> as proxy daemon between bluez and target applications (pulseaudio,
> upower, ofono, ...)
> 
> This would simplify whole HFP usage as applications would not need to
> re-implement parsing and processing of AT commands and it would allow
> more applications to use HFP profile at one time. And also it means that
> audio software does not have to implement telephony stack or power
> supply operations.
> 
> 
> I wrote a document how such DBus API could look like, see here:
> 
>   https://github.com/pali/hsphfpd-prototype/raw/prototype/hsphfpd.txt
> 
> 
> And also I implemented "prototype" implementation to verify that
> designed API make sense and can be really implemented. Prototype fully
> supports HSP profile in both HS and AG role, plus HFP profile in HF
> role. This prototype implementation is available here:
> 
>   https://github.com/pali/hsphfpd-prototype
> 
> Some other details are written in README:
> 
>   https://github.com/pali/hsphfpd-prototype/raw/prototype/README
> 
> 
> What do you think about it? Does it make sense to have such design?
> Would you accept usage of such hsphfpd daemon, implemented according to
> specification, on Linux desktop?
> 
> I would like to hear your opinion if I should continue with this hsphfpd
> design, or not.
> 
> 
> With this design and implementation of hsphfpd is possible to easily fix
> pulseaudio issue about power supply properties:
> 
>   https://gitlab.freedesktop.org/pulseaudio/pulseaudio/issues/722

I quite like this proposal. Avoiding the need to implement the button
press, battery level etc. handling separately in PulseAudio, oFono and
PipeWire seems like a pretty good justification to me. I assume you're
volunteering to maintain this new daemon?

It's not clear to me how this would affect the PulseAudio <-> oFono
interaction, if at all. When oFono is used, would PulseAudio get the
audio socket from oFono or hsphfpd? What about volume commands, would
they go through oFono or would PulseAudio interact with hsphfpd
directly?

I think hsphfpd should be part of bluetoothd, but if that's not
possible, then that's not possible.

(I don't want to get into a lengthy discussion about programming
languages, but I'll just note here that I don't like Perl.)

-- 
Tanu

https://www.patreon.com/tanuk
https://liberapay.com/tanuk

