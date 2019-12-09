Return-Path: <SRS0=WaXy=Z7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D475C43603
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Dec 2019 09:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4026520726
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Dec 2019 09:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfLIJnT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:43:19 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40296 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbfLIJnS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Dec 2019 04:43:18 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gkiagia)
        with ESMTPSA id 51C5328DF20
Subject: Re: Proposal for a new API and usage of Bluetooth HSP and HFP
 profiles on Linux
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Denis Kenzior <denkenz@gmail.com>,
        linux-bluetooth@vger.kernel.org,
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
References: <20191201185740.uot7zb2s53p5gu7z@pali>
 <20191207200942.nbao4mxsqw4sp67v@pali>
From:   George Kiagiadakis <george.kiagiadakis@collabora.com>
Openpgp: preference=signencrypt
Message-ID: <c37951ef-77ff-d5eb-8b35-19bd5725a7c9@collabora.com>
Date:   Mon, 9 Dec 2019 11:43:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191207200942.nbao4mxsqw4sp67v@pali>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

+ the bluez-alsa maintainer

See my comments below...

On 07/12/2019 22:09, Pali Rohár wrote:

> +Denis from ofono
>
> ofono and pulseaudio are two main users of HFP profile on Linux...
>
> On Sunday 01 December 2019 19:57:40 Pali Rohár wrote:
>> Hello!
>>
>> I'm sending this email to relevant mailing lists and other people who
>> could be interested in it. (I'm not subscribed to all of ML, so please
>> CC me when replying).
>>
>>
>> I would like to open a discussion about a completely new way of handling
>> Bluetooth HSP and HFP profiles on Linux. These two profiles are the only
>> standard way how to access microphone data from Bluetooth Headsets.
>>
>>
>> Previously in bluez4, HFP profile was implemented by bluez daemon and
>> telephony HFP functionality was provided by either dummy modem, ofono
>> modem or by Nokia's CSD Maemo modem.
>>
>> In bluez5 version was modem code together with implementation of HFP
>> profile removed. And let implementation of HSP and HFP profiles to
>> external application.
>>
>> Currently HSP profile is implemented in pulseaudio daemon to handle
>> microphone and Bluetooth speakers. HFP profile is not implemented yet.
>>
>>
>> HSP and HFP profiles use AT modem commands, so its implementation needs
>> to parse and generates AT commands, plus implement needed state machine
>> for it.
>>
>> And now problem is that last version of HFP profile specification is too
>> complicated, plus Bluetooth headsets vendors started to inventing and
>> using of own custom extensions to HFP profile and AT commands.
>>
>> Main problem of this "external" implementation outside of bluez is that
>> only one application can communicate with remote Bluetooth device. It
>> is application which received needed socket from bluez.
>>
>> So in this design if audio daemon (pulseaudio) implements HFP profile
>> for processing audio, and e.g. power supply application wants to
>> retrieve battery level from Bluetooth device, it means that audio daemon
>> needs to implement also battery related functionality.
>>
>> It does not make sense to force power supply daemon (upower) to
>> implement audio routing/encoding/decoding or audio daemon (power supply)
>> to force implementing battery related operations.
>>
>>
>> For handle this problem I would like to propose a new way how to use and
>> implement HSP and HFP profiles on Linux.
>>
>> Implement a new HSP/HFP daemon (I called it hsphfpd) which register HSP
>> and HFP profiles in bluez and then exports functionality for all other
>> specific applications via DBus API (API for audio, power supply, input
>> layer, telephony functions, vendor extensions, etc...). So it would acts
>> as proxy daemon between bluez and target applications (pulseaudio,
>> upower, ofono, ...)
>>
>> This would simplify whole HFP usage as applications would not need to
>> re-implement parsing and processing of AT commands and it would allow
>> more applications to use HFP profile at one time. And also it means that
>> audio software does not have to implement telephony stack or power
>> supply operations.
>>
>>
>> I wrote a document how such DBus API could look like, see here:
>>
>>   https://github.com/pali/hsphfpd-prototype/raw/prototype/hsphfpd.txt
>>
>>
>> And also I implemented "prototype" implementation to verify that
>> designed API make sense and can be really implemented. Prototype fully
>> supports HSP profile in both HS and AG role, plus HFP profile in HF
>> role. This prototype implementation is available here:
>>
>>   https://github.com/pali/hsphfpd-prototype
>>
>> Some other details are written in README:
>>
>>   https://github.com/pali/hsphfpd-prototype/raw/prototype/README
>>
>>
>> What do you think about it? Does it make sense to have such design?
>> Would you accept usage of such hsphfpd daemon, implemented according to
>> specification, on Linux desktop?
>>
>> I would like to hear your opinion if I should continue with this hsphfpd
>> design, or not.
>>
>>
>> With this design and implementation of hsphfpd is possible to easily fix
>> pulseaudio issue about power supply properties:
>>
>>   https://gitlab.freedesktop.org/pulseaudio/pulseaudio/issues/722
>>
>>

In general, I agree that HFP/HSP AT protocol handling is something that
the audio daemons should not have to worry about. However, I am
concerned with the level of fragmentation that exists in the bluetooth
stack.

At the moment, the best case scenario is that we have 2 processes
involved in bluetooth audio (in the case where we route directly to/from
the speakers & microphone of the linux host in question):

  bluez5 <-> pulseaudio

With pipewire & bluez-alsa, we have 3 processes:

  bluez5 <-> pipewire bluetooth session <-> pipewire daemon

  bluez5 <-> bluez-alsa <-> alsa application

The 3 process separation here happens so that the bluetooth codecs run
in the process that sits in the middle. This avoids having to care about
codecs on the right side and also avoids slowing down the pipewire
daemon (so that it can still do low-latency audio processing)

When ofono comes into play, we increase this by 1:

   bluez5 <-> ofono <-> pulseaudio

  bluez5 <-> ofono <-> pipewire bluetooth session <-> pipewire daemon

  bluez5 <-> ofono <-> bluez-alsa <-> alsa application

With your proposal, we have one more:

   bluez5 <-> hfphspd <-> ofono <-> pulseaudio

  bluez5 <-> hfphspd <-> ofono <-> pipewire bluetooth session <->
pipewire daemon

  bluez5 <-> hfphspd <-> ofono <-> bluez-alsa <-> alsa application

And it can become even more crazy when you do ugly hacks like what I
have done in Automotive Grade Linux, where I use bluez-alsa for its
codec implementation & HFP/HSP handling, and then route the audio using
a gstreamer-based helper process to the pipewire daemon process
(temporarily, to workaround issues in the pipewire native implementation):

  bluez5 <-> hfphspd <-> ofono <-> bluez-alsa <-> gstreamer helper <->
pipewire daemon

Instead of all of this crazy context switching, what I would prefer to
see is a standalone component library that someone could combine in a
single process to get things done. This would:

* avoid re-implementing all kinds of stuff over and over in different
audio daemons (we do have 3 implementations atm: pulseaudio, pipewire &
bluez-alsa)
* prevent people like me from doing ugly hacks to get work done
* improve collaboration between all the different people that care about
the bluetooth stack instead of having them antagonize each other
* avoid the context switching overkill; we should only have 1 process
between bluez and the audio daemon / solution, imho
* potentially allow people to use some components in combination with a
proprietary bluetooth stack instead of bluez (a strong requirement in
the automotive industry at the moment, at least)

I imagine that this component library would include:

* bluetooth audio codecs
* HFP/HSP commands handling
* telephony handling
* exposure of common D-Bus APIs for side-channel things like power
management or phone dialing

... and then every downstream user (pulse, pipewire, bluez-alsa, ...)
could reuse these components and implement the rest of the routing /
management logic in their own daemon.

My two cents...

Regards,
George


