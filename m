Return-Path: <SRS0=Qms+=2J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234DCC43603
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Dec 2019 14:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA33220684
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Dec 2019 14:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWsRcAg1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfLSO62 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:58:28 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:38584 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfLSO62 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Dec 2019 09:58:28 -0500
Received: by mail-oi1-f175.google.com with SMTP id l9so180520oii.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Dec 2019 06:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Acid9lU4EIt+EAG1iiMnpm/K+Q/o4AxFDqCFsxkurnc=;
        b=cWsRcAg1zkThfhBQqi/fTX1a+a0h/rwoYlxp3Alj8nAyl2G54VDe+6Wqqk1pZtVkml
         ZEY4VGq0fHcCAY3xsGV+okzhio2UwbF3eE/gnlAiCvfv2lVw+PXvSBRQI8U1jN3qtZES
         uCiCse9TAX/x5vmnxAw1m6FlkUxvuQroMxR2dOE1vxzemZcwmhq7G9bZzRnG6/bpBQ6Z
         x8Tlr7UhzJgOgy4lu9bjON3XoJlI+aCF2cNtOMz21fAeHJyMbfUFTZwU9Pos6svA0KXG
         Pg7gAd31W00qPqycD/JcbTXVPLaR5qQMY7ddX+NCHlzYLdwiEC6HdP6qpGHiqXqs4DmO
         9lGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Acid9lU4EIt+EAG1iiMnpm/K+Q/o4AxFDqCFsxkurnc=;
        b=GpuUvoTsU2qVRJ7CAMtBozpQoXZhe3FZtR2Cm99lbUqqo5Dsks6MoWOvyQ9Mj/rV0v
         FbVzszjsCZzQOV6aSpAiUzP/uRaJnGiETx9NRUYhN2GDk8J0cvPjE2BSE26oSnDWanIn
         cXL65rmj0JVw+bsk8PryaqAjwhKckVg59Q0Ve3uxAUFVxVAZKc6ekrr1N47LzqhN9MAn
         w7KRzAyMUFt0LligzHgd5KWLAxQ9BBUo7VpYKL833sNkecaJzHDza38YppPmdU3IyCOx
         5UXxIXQPEh6UefWnsdGDeFcBJbwn4WhL1TrCD+0nAX9euKQSlFr9tdGF7MZUenmAmTrG
         aqsw==
X-Gm-Message-State: APjAAAXiOPpd3vVfig0Xsk3kK5M3RGgx/CwQAi3yWdrOagtTq7QQ/seF
        qfxqC3HYmUmpPf+uWovkUxQ=
X-Google-Smtp-Source: APXvYqxQ+2I+b97AnGOkEOes7NxmFJvSYxzHcfqrbOYutyJ1OOYeQXZ/kTbNCUwQEtixZwqiWCKLyQ==
X-Received: by 2002:aca:eb0f:: with SMTP id j15mr2150041oih.6.1576767506503;
        Thu, 19 Dec 2019 06:58:26 -0800 (PST)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id a17sm2200108otq.49.2019.12.19.06.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 06:58:26 -0800 (PST)
Subject: Re: [pulseaudio-discuss] Proposal for a new API and usage of
 Bluetooth HSP and HFP profiles on Linux
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Tanu Kaskinen <tanuk@iki.fi>,
        General PulseAudio Discussion 
        <pulseaudio-discuss@lists.freedesktop.org>, ofono@ofono.org,
        devkit-devel@lists.freedesktop.org,
        Bastien Nocera <hadess@hadess.net>,
        Georg Chini <georg@chini.tk>,
        Russell Treleaven <rtreleaven@bunnykick.ca>,
        Arun Raghavan <arun@arunraghavan.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sre@ring0.de>, Pavel Machek <pavel@ucw.cz>
References: <20191202184512.rx6p63c6axztnwrw@pali>
 <20191205093200.x47npi5sxtcphr2o@pali>
 <CABBYNZKi7UUg7kASKadGr7sDJH0-tfuuZr9rd4Xu8ZUA9LqTMA@mail.gmail.com>
 <20191216091521.reh2urr25husschv@pali>
 <3ca53c66-1df0-41bf-710e-dea709906234@gmail.com>
 <20191218172828.vfie4su2whts2fqh@pali> <20191218173632.aqdmdhutu3ruezck@pali>
 <06eb7e98-1357-afd1-40a5-2ccb139d8dec@gmail.com>
 <20191218213349.2ksew2wnhgu3peub@pali>
 <0cfbe253-417c-e7c0-553a-abf360a80c9f@gmail.com>
 <20191219095132.blj3oyyrlfowv5ik@pali>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <90261b42-1048-370f-7680-acd9f7e754ed@gmail.com>
Date:   Thu, 19 Dec 2019 08:53:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191219095132.blj3oyyrlfowv5ik@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

>>> But would you accept patches which exports DBus API e.g. for displaying text
>>> on HFP headset with embedded display? Or patches which implements 3
>>> different way for reporting battery level status of HFP headset? And API
>>> for sending "computer battery level" to HFP headset? Or implementing
>>> setup of SCO sockets (via RFCOMM layer) for custom codecs? Or exporting
>>> uinput linux device for button press events? Because all these
>>
>> So which roles are we talking about here?  Your Design document shows
>> hsphfpd registering for both HFP AG and HFP HF roles, but maybe this was not
>> the intent?
> 
> My proposed hsphfpd is going to support both roles. Which means to
> implement whole HFP profile. So for connecting bluetooth headsets (when
> AG role is needed on desktop) and also for connecting mobile phones
> (when HF role is needed on desktop).
> 
> And my primary motivation is for bluetooth headsets as this is what are
> asking desktop and laptop users again and again that is missing on Linux
> systems.
> 
> So higher priority has AG role and slightly lower priority has HF role.
> 

So to summarize.  You have broadly 3 main use cases for HFP:

1. HF connecting to AG role.  Essentially a carkit role.  oFono does 
this pretty well already and has the APIs defined that cover up to HFP 
1.7.  Any vendor extensions can be easily added.  And some carkit 
manufacturers already use it.

2. AG role when you have a 'real modem' behind it.  oFono already 
provides everything needed for this scenario.

3. AG role when you don't have a real modem or you have some sort of 
VoIP use case.  oFono doesn't cover this case as you stated.

So I can see value in something that implements case #3.  But having 
said that, oFono will not be receiving AT commands from external daemons:
	- For case 1, it'd just be a rehash of what oFono does well already.  I 
reinvented a few wheels in my time, but doesn't mean I think this one 
should be.
	- The reasoning for case 2/3 I already covered upthread.

>> If you're talking about extending oFono APIs when it is acting as the HF
>> connecting to the AG, then codec setup APIs, etc are definitely something
>> that would be welcome.
>>
>> If you're talking about AG role, then that is different... In general, if
>> the oFono is in an AG role, then there should be nothing to configure and
>> there are no APIs for this role.
> 
> Codecs needs to be configured also in AG role. Before accepting SCO
> connection you need to configure SCO socket for correct codec. Also for
> vendor codecs it needs to be properly negotiated via AT commands.
>

Sure, but that doesn't mean they need an actual D-Bus API to be 
configured with.  You can simply extend oFono emulator to support 
whatever codecs you want and whatever custom AT command handling that 
you need.  If the HF requests the codec, then you use it.  There's no 
D-Bus API required here.  Again, take a look at how this is done in 
oFono today.

>> Such a design will get a NAK from me on the oFono side.  But don't let that
>> stop you.  You can simply invoke oFono APIs directly from your daemon.  No
>> need for any changes in oFono itself.  As mentioned above, I wouldn't
>> recommend it, but... :)
> 
> So if you are disagreeing with this design, can you propose alternative?
> Which would support needs for desktop users? Support for HSP profile (in
> AG role), support for HFP profile (in AG role), ability to parse and
> interpret needed AT commands. And later also HS and HF role of these
> profiles.
> 

There have been one or two implementations of AG role fully external to 
oFono.  These implementations simply used the existing oFono APIs to 
drive the modem.  You could do that.  But as I said, we rejected such a 
design a long time ago due to complexity and other issues.

Or you can ignore the call control aspects entirely...

But in the end, it is your architecture.  All I can do is point out 
(early in the process) what is and what is not acceptable to oFono upstream.

>>
>> Okay, I see now.  Yes, the above is correct.  My comments about not needing
>> a modem device hold true only if oFono is in HFP HF role connecting to an
>> AG.
> 
> Ok. So I guess now you understood main problem. I thought it was
> obvious, but seems that bluetooth HFP is too complicated, so talking
> about it always needs more detailed explanation. Sorry for that if it
> was not clear from my side since beginning what are requirements for my
> setup.

Well it was a bit of reading comprehension fail on my part as well.  The 
two roles are really quite different, so precise language helps.

Regards,
-Denis
