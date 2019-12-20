Return-Path: <SRS0=msWm=2K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250A6C43603
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Dec 2019 21:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1442146E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Dec 2019 21:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeeUC6hZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfLTVTF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:19:05 -0500
Received: from mail-il1-f169.google.com ([209.85.166.169]:46641 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfLTVTF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Dec 2019 16:19:05 -0500
Received: by mail-il1-f169.google.com with SMTP id t17so9087908ilm.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2019 13:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SVBUsED3zN4uP3nGytson7MdXiYmAMCMZdmQi3lsBGs=;
        b=GeeUC6hZylQDmw8ZdtLM6T/A+6xuGCj+UKRgeT20aq/51Dm8eR/ifUNUhf5x0HFQ5G
         +Lf3Abvgc/SVJ0Hh35+Oi2tTVCq6WrHKY1xlZwh9wBq2TI6zfsuAC0h+cLxjXN30Xbhf
         RDXjpQvbnfpHbGCCVkcRDldsLkWZvYsDbCwh1O92oFfnONB0zTzpG8b5Lbg/F0A0CoUW
         vbWvRu8XJbxTlgmqczdvJVFZ47kwew3A1Tk0AQvqJGYcmIPqqePHl6mGNKsdYWW/sFiF
         3JfxPpyZzs+wmQctnQ+mXUhqMwWeL6wlHqeHNImBKN+BDGcJQWqSPAxVSIKKQSwBr/pw
         1B2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SVBUsED3zN4uP3nGytson7MdXiYmAMCMZdmQi3lsBGs=;
        b=SWRZpzrMwHk7pbr9qmOppDVlhDEURW18kg5GR3NbVgjnC/uYpaxlqeGSLDN1uJXaPi
         h7X2C1ALr/BX4FfctWtrho5HfxVq6BOFrQYe9XgUX68h6YddzZlB9foaEBtpqOFbKsxm
         nd3c3L7h8TaAjZigqn4y764hDX4ONgB+hJm77GjjELkxfSbs4canfZMjdk51cWDrE+I2
         FR5/5d6GeJz50crlI2gUNl8rmEEGwrbKs5u8Lks4xanVxeVY0rdVUHOOwDddbhApt7LG
         84ztcuyES+WxFj6d0i0wd5aAmrhQxWtemKPCSS2/ubX81wnTpy6O8Q6jVNMqymcBNwM6
         RGbg==
X-Gm-Message-State: APjAAAXXlw48mH2FPQMSrY4+i+A7PgQ8ial2pGpytqjFyGZMMVCKyWLm
        LJZDxddC1y4ELeq07iwN+eM=
X-Google-Smtp-Source: APXvYqzH3uqM+NWocXjKH7lthC1QDzjS40g+648VHRlbDdKkspY6OisQoaqb4s3yjmZUp15NaxkIXA==
X-Received: by 2002:a92:de46:: with SMTP id e6mr6110634ilr.122.1576876743911;
        Fri, 20 Dec 2019 13:19:03 -0800 (PST)
Received: from new-host-2.home ([2605:a601:ad86:2901:f189:7fcc:ad5c:18d3])
        by smtp.googlemail.com with ESMTPSA id u7sm1137576iob.16.2019.12.20.13.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 13:19:03 -0800 (PST)
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
References: <CABBYNZKi7UUg7kASKadGr7sDJH0-tfuuZr9rd4Xu8ZUA9LqTMA@mail.gmail.com>
 <20191216091521.reh2urr25husschv@pali>
 <3ca53c66-1df0-41bf-710e-dea709906234@gmail.com>
 <20191218172828.vfie4su2whts2fqh@pali> <20191218173632.aqdmdhutu3ruezck@pali>
 <06eb7e98-1357-afd1-40a5-2ccb139d8dec@gmail.com>
 <20191218213349.2ksew2wnhgu3peub@pali>
 <0cfbe253-417c-e7c0-553a-abf360a80c9f@gmail.com>
 <20191219095132.blj3oyyrlfowv5ik@pali>
 <90261b42-1048-370f-7680-acd9f7e754ed@gmail.com>
 <20191219153344.hxnoa3idqvgdwrp2@pali>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <76f1cb25-b608-e4e9-6fd9-8da932c56a15@gmail.com>
Date:   Fri, 20 Dec 2019 15:19:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191219153344.hxnoa3idqvgdwrp2@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

>> There have been one or two implementations of AG role fully external to
>> oFono.  These implementations simply used the existing oFono APIs to drive
>> the modem.
> 
> bluez & pulseaudio developers told me that it would be a good idea to
> avoid implementing a new AT parser for telephony stack. And rather use
> ofono implementation for telephony part...

In my opinion there's nothing scary about AT parsing.  In fact that is 
the easiest part of this whole venture.  If you don't want to roll your 
own parser, you can borrow one from the oFono project.  We already 
solved this nicely in the form of the gatchat library.  You could 
incorporate this into your project (if it is GPL compatible).  Or you 
could wait until we port gatchat to ell which will be under LGPL license.

> 
> But if I should use existing DBus API provided by ofono, it means that I
> need to do parsing of all AT commands (including telephony) and
> translate them to ofono DBus API.

I think you will need to do this regardless.  Otherwise I fail to see 
how you prevent one 'agent' from consuming AT commands it shouldn't be. 
This is a possibility you need to consider, whether it happens by 
accident or maliciously.

> 
> I agree, this should work and there is not need to modify ofono. But it
> means that in hsphfpd daemon I need to have full AT parser for all
> telephony commands and it was something which bluez / pa developers
> thought that should be avoided. Therefore I come up with idea that
> telephony commands would be handled by external Telephony Agent, which
> can be ofono.

Understood.  But I think the metric function was selected 
inappropriately in this case.  My opinion is that you should have 
started with what the overall architecture should look like; you should 
not have based design decisions on which parts might be a little hard to 
implement.

> 
>> You could do that.  But as I said, we rejected such a design a
>> long time ago due to complexity and other issues.
> 
> Anyway, what is the problem with accepting modem socket in ofono via
> DBus and starts talking with it like with any other modem which ofono
> supports? Currently ofono already takes modem socket from bluez via DBus
> API, so in same way hsphfpd can pass modem socket to ofono. Basically
> ofono then can reuse same code which already uses for sockets from
> bluez, just it do not have to parse and interpret audio related AT
> commands (as these are handled by hsphpfd itself).
> 
> What are exact issues? I do not see complexity at ofono part (as has
> already everything implemented) and currently I do not see those "other"
> issues.

The issues are many.  And really the question is not whether it 'could 
be' done, but whether it 'should be' done.  Let me describe a couple 
examples:

- In the case of HF role (1), oFono already provides all the necessary 
APIs.  So put yourself in oFono's maintainer shoes.  What would we gain 
by supporting almost the same but different mechanism?  We would have to 
introduce a new hfp_hf plugin, one that is almost identical, but 
different to hfp_hf_bluez5 plugin.  These two plugins would have 
coexistence issues, which would add more complexity.  Then there's the 
impact on PulseAudio and other users.  How do they know when to use the 
HandsfreeAudio API vs some external API?  Supporting this new way buys 
us a lot of extra code / complexity with no value added.

- The other example is more practical. HFP Service Level Connection 
(SLC) establishment is actually quite tricky.  There are certain 
limitations on what can and cannot be done prior to SLC establishment, 
including how audio handling is done.  Unfortunately, codec negotiation, 
indicator negotiation, and feature negotiation are part of the SLC. 
oFono already solves all of this and handles all of it nicely.  We have 
passed all relevant certification testing.  It is very unclear how you 
plan to handle this (or whether you realistically even can) in your 
architecture when the responsibilities are split between the various 
daemons.  So again, oFono has nothing to gain here...

> 
> You suggested to use phone simulator together with ofono and then
> starts extending / patching phone simulator to supports all needed parts
> which are in my hsphfpd design (battery status, button press, codec
> selection)?
> 

Not quite.  I suggested you expand oFono's emulator implementation (for 
AG role) and its DBus APIs (for HF role) to support the new vendor 
specific features that you want.

Forget about the phone simulator, it is really irrelevant for what 
you're trying to accomplish.

> Also how to handle the main problem of phone simulator that it is too
> much complicated to setup it on desktop? Looking at the steps...
> 
> https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Bluetooth/#index5h2
> 
> ... that desktop user needs to run nontrivial commands in command like,
> plus creating configuration file only just to connect bluetooth headset
> is ridiculous and non-acceptable for desktop application.
> 
> If this problem is not fixed, ofono and phone simulator are not usable
> as "main" software implementation of HFP profile for usage of bluetooth
> headsets on Linux.

oFono was never advertised as solving the 'HFP AG without a modem' use 
case.  This is something we never had as a requirement / objective. 
Phonesim is a development tool.  So of course it isn't trivial to setup, 
it isn't meant to be used in production in the first place.  The use of 
phonesim described in the PA wiki, while creative, is a giant hack ;)

Basically it all boils down to the fact that nobody has stepped up all 
this time to solve a particular use case you care about.  But blaming 
oFono for this is misguided.

So, if you want to solve the HFP AG without a modem case I fully support 
your efforts.

Perhaps this can even be solved in oFono itself (since it already does 
90% of what you want) by making the modem requirement optional.  What we 
could do for example is to create a dummy modem if an AG connection is 
requested and no other suitable modems are detected in the system.  The 
resultant AG wouldn't have any call control capability, it could still 
be used for transferring audio data, battery, etc.  If you want to 
pursue this, we can brainstorm further.

Regards,
-Denis
