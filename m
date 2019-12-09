Return-Path: <SRS0=WaXy=Z7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3530C43603
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Dec 2019 11:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F6E2077B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Dec 2019 11:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFYrSTfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfLILHL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:07:11 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37237 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLILHL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Dec 2019 06:07:11 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so14463954wmf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Dec 2019 03:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oE0rilF40wWs22o3DL+ONvYBO0mzM0rmFHYM05cw310=;
        b=DFYrSTfnV6lAIb4VXHFg8b0Ryy169Cq7fwxZ/AcyF0nQRsyL6ZQ9zhuJoea14BlYNa
         PLE+JxkM7Gg/RxEL44Ru5qp8HUvdVecLQrN47kA+GmE4TP9BpYx6ukXpyRGocJsdZz9Z
         XDzCocS36b6TzbbLJVIZx7i72ijbaqBFYQJhakxsmSy4RBttDbgoU3a8MVMTU8jtYJ/y
         7lLCEGoBW1ff0JWcjBHnoexJA21Fr3qROcfHHXBC2L1SAf3nc4dAknNn/Y0M3BekAmgZ
         QZ916+gyq9asvm/rB5dTq3WD3Tg41ZmqTNqUpI+/bzRxfJJu2ZWBshApXPKzTELWTVHX
         yGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oE0rilF40wWs22o3DL+ONvYBO0mzM0rmFHYM05cw310=;
        b=fyyCIgUPiAZ8i+9yCr5+YWs8Z/3bXmmQoM8dLHsHDFZXx/kRZImurS0zJuKx0+Ucyj
         rlxEQw8CyLbQSVYfaIChupWcqf/5nEEDe+iF3+djPrfD/JgdXPMaLhVtF3qO85SPwwIx
         sts2w/qahJQ2qOgBtQbq7vth+FocDKxCb4kboM1fXHGTXsr88OsDH1WfVGdR/+wV5TVZ
         +wbKeLJhTw8uZReliPh+wUr1FmgEF81rxHGWQC9i+uMrpHcgo6QN0fYVWOBUo8Ktw4Ws
         a5o4qlFSUEIH41snADp2js8tmuCbiBRpJEO072tDfFYk30tZFrEj9pLufKrpLQ1cfZCw
         B9fQ==
X-Gm-Message-State: APjAAAUDhSsY8IKVSyqutZ+30QsGnQu7cxqIUtG8FSCB18djK8NE7/ai
        tIlvf7r6ddAQpbszmGfc7cg=
X-Google-Smtp-Source: APXvYqxNOosJLKPnGO0pg/Z1GbKwB/tu72s36Cpue9ORbxGb9h8Jp4kORIpStAecWt48tsJAluX80w==
X-Received: by 2002:a05:600c:149:: with SMTP id w9mr23241797wmm.132.1575889627967;
        Mon, 09 Dec 2019 03:07:07 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id t5sm26828245wrr.35.2019.12.09.03.07.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Dec 2019 03:07:07 -0800 (PST)
Date:   Mon, 9 Dec 2019 12:07:06 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     George Kiagiadakis <george.kiagiadakis@collabora.com>
Cc:     Denis Kenzior <denkenz@gmail.com>, linux-bluetooth@vger.kernel.org,
        General PulseAudio Discussion 
        <pulseaudio-discuss@lists.freedesktop.org>, ofono@ofono.org,
        devkit-devel@lists.freedesktop.org,
        Bastien Nocera <hadess@hadess.net>,
        Georg Chini <georg@chini.tk>,
        Russell Treleaven <rtreleaven@bunnykick.ca>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Tanu Kaskinen <tanuk@iki.fi>,
        Arun Raghavan <arun@arunraghavan.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sre@ring0.de>, Pavel Machek <pavel@ucw.cz>,
        Wim Taymans <wim.taymans@gmail.com>,
        Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: Re: Proposal for a new API and usage of Bluetooth HSP and HFP
 profiles on Linux
Message-ID: <20191209110706.4dtehxx67c3lysr7@pali>
References: <20191201185740.uot7zb2s53p5gu7z@pali>
 <20191207200942.nbao4mxsqw4sp67v@pali>
 <c37951ef-77ff-d5eb-8b35-19bd5725a7c9@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c37951ef-77ff-d5eb-8b35-19bd5725a7c9@collabora.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi George!

On Monday 09 December 2019 11:43:08 George Kiagiadakis wrote:
> In general, I agree that HFP/HSP AT protocol handling is something that
> the audio daemons should not have to worry about. However, I am
> concerned with the level of fragmentation that exists in the bluetooth
> stack.
> 
> At the moment, the best case scenario is that we have 2 processes
> involved in bluetooth audio (in the case where we route directly to/from
> the speakers & microphone of the linux host in question):
> 
>   bluez5 <-> pulseaudio
> 
> With pipewire & bluez-alsa, we have 3 processes:
> 
>   bluez5 <-> pipewire bluetooth session <-> pipewire daemon
> 
>   bluez5 <-> bluez-alsa <-> alsa application

Yes, that is truth.

> The 3 process separation here happens so that the bluetooth codecs run
> in the process that sits in the middle. This avoids having to care about
> codecs on the right side and also avoids slowing down the pipewire
> daemon (so that it can still do low-latency audio processing)
> 
> When ofono comes into play, we increase this by 1:
> 
>    bluez5 <-> ofono <-> pulseaudio
> 
>   bluez5 <-> ofono <-> pipewire bluetooth session <-> pipewire daemon
> 
>   bluez5 <-> ofono <-> bluez-alsa <-> alsa application

Yes.

> With your proposal, we have one more:
> 
>    bluez5 <-> hfphspd <-> ofono <-> pulseaudio
> 
>   bluez5 <-> hfphspd <-> ofono <-> pipewire bluetooth session <->
> pipewire daemon
> 
>   bluez5 <-> hfphspd <-> ofono <-> bluez-alsa <-> alsa application

No, this is not how hsphpfd is suppose to work. Look at design & API:
https://github.com/pali/hsphfpd-prototype/blob/prototype/hsphfpd.txt

ofono would be there only in agent role, similar like audio daemon
(pulseaudio/pipewire/bluez-alsa). So it would look like:

              +---- <-> ofono
              |
bluez5 <-> hsphfpd
              |
              +---- <-> pulseaudio / pipewire / bluez-alsa

You can connect / disconnect ofono without loosing audio functionality.
(Or connect / disconnect audio daemon without loosing telephony modem
functionality.)

hsphfpd is central point for all HSP and HFP related operations and
applications.

> And it can become even more crazy when you do ugly hacks like what I
> have done in Automotive Grade Linux, where I use bluez-alsa for its
> codec implementation & HFP/HSP handling, and then route the audio using
> a gstreamer-based helper process to the pipewire daemon process
> (temporarily, to workaround issues in the pipewire native implementation):
> 
>   bluez5 <-> hfphspd <-> ofono <-> bluez-alsa <-> gstreamer helper <->
> pipewire daemon

With hsphfpd involved, you would never talk with ofono. Also ofono is
not required for this setup.

> Instead of all of this crazy context switching, what I would prefer to
> see is a standalone component library that someone could combine in a
> single process to get things done. This would:
> 
> * avoid re-implementing all kinds of stuff over and over in different
> audio daemons (we do have 3 implementations atm: pulseaudio, pipewire &
> bluez-alsa)

HSP/HFP AT commands needed for audio handling are already designed to be
handled by hsphfpd daemon. Please look at details.

> * prevent people like me from doing ugly hacks to get work done
> * improve collaboration between all the different people that care about
> the bluetooth stack instead of having them antagonize each other

This is reason why I started this discussion :) and proposed my hsphfpd
daemon.

> * avoid the context switching overkill; we should only have 1 process
> between bluez and the audio daemon / solution, imho

There is no context switching in hsphfpd design once audio connection is
established. From hsphfpd you get native audio SCO socket, so audio is
not routed throw hsphfpd nor bluez daemons. Socket directly pass data to
kernel.

> * potentially allow people to use some components in combination with a
> proprietary bluetooth stack instead of bluez (a strong requirement in
> the automotive industry at the moment, at least)

The only what is needed is that "other stack" just export DBus interface
for registering HSP and HFP profiles according to bluez documentation.
Then hsphfpd would work with that bluetooth "other stack".

> I imagine that this component library would include:
> 
> * bluetooth audio codecs

AT commands are covered by hsphfpd. Encoding / decoding of data is up to
the application agent. Please look into hsphfpd.txt document.

But creating a library which would do encoding and decoding of audio
data and acts as a hsphfpd audio application agent is possible. If other
projects want to use it (e.g. pulseaudio, bluez-alsa, pipewire, jack) we
can start a separate discussion about API of such library. I guess that
more audio daemons would be different requirements and to be usable in
all projects we need to cover all of them.

> * HFP/HSP commands handling

This is already covered by hsphpfd.

> * telephony handling

In hsphfpd this is exported to external telephony agent. Possibly ofono
or modem manager (whatever project will implement needed API and
connects to hsphfpd daemon).

> * exposure of common D-Bus APIs for side-channel things like power
> management or phone dialing

This is part of hsphfpd daemon, please look at hsphfpd.txt if it covers
your needs. Btw, phone dialing is part of telephony handling.

> ... and then every downstream user (pulse, pipewire, bluez-alsa, ...)
> could reuse these components and implement the rest of the routing /
> management logic in their own daemon.
> 
> My two cents...
> 
> Regards,
> George

-- 
Pali Rohár
pali.rohar@gmail.com
