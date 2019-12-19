Return-Path: <SRS0=Qms+=2J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24103C43603
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Dec 2019 01:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03852176D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Dec 2019 01:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ec4VWp2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfLSBHp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Dec 2019 20:07:45 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43999 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfLSBHp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Dec 2019 20:07:45 -0500
Received: by mail-oi1-f194.google.com with SMTP id p125so22104oif.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Dec 2019 17:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GaBcnb1+DGe/H6P00Fvikm3cHH0c+ImBAjEWQsi/myo=;
        b=ec4VWp2xLpv16UsRs4Bh4HRhax72GPvVDcBGQTEjKc86utu29OG4BObpUadBwY2u4B
         fcX6qYzzrAkXBlNDyE2t0AtJSt38cwoykHCY2OQ+1NAw6FpK/OxMxIOBtrsBv5lnl4NY
         sGgRlxJDhgQOUN7jIszWgR9eUR0TkLVde1K7OJs4dtYB+gqkrfck+o0iD14qvZC8whn5
         hCV33OTbh1VNnaC3MrtD1/2y5p+IpFNPwxHdeWRxTkpkMfQVE2jFTppyDNzCvKX6DAVm
         uInaHSq//BusZGFDMBARQ30jc/ckW285+jcCFD66Iz14R6WWSYvQbmGEVuUPXqCKIn0b
         Ex+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GaBcnb1+DGe/H6P00Fvikm3cHH0c+ImBAjEWQsi/myo=;
        b=APla6bmkMOJkYXe8Ai7fUXUx7Ju+0dnatGRaIeYh8AVB5/oRMe1oZOf7/6rn3Sp0Ce
         BnoWjzLA7WvQ0VnzJnAbV//pZNu3vM/CcTaCs0YnoGHKjK3NugwK/l/l4nCi4i+0/er0
         JCK+mUg/zuALfNp1qbIV55ycPdAwhNx0dqCCD5EQRb2ydZ08WeMxSZHWS9yWDvuyr/Tg
         TiylLU/pp5r/XIacWmbJJb2xM4Soi6OCJEpN8dLlSIB6kVJ0cGhPIJt7K0m7qTrtzDWC
         A8mdJrQQdeIa+Qa+xt1unGTnRVJoOM5vm/VjOIP/eWQABqs+KP5FmpTERc1Gvr/nviQ4
         3NWw==
X-Gm-Message-State: APjAAAUWmC7HaZywN1KtMn4+zkzYpZlh8TDvCRpG64PKE3qOKQMpi99n
        VB0kE12FwSSCU6h9CuxcakA=
X-Google-Smtp-Source: APXvYqyLLFGHH9FQ3sE4hb67IvRD2nX5qF00l1IylJzbBfWGPbJiodzB5195dOSh6pLFhyTk9WZzVA==
X-Received: by 2002:aca:e084:: with SMTP id x126mr1604271oig.97.1576717664186;
        Wed, 18 Dec 2019 17:07:44 -0800 (PST)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id m11sm1443320oie.20.2019.12.18.17.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 17:07:43 -0800 (PST)
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
References: <20191201185740.uot7zb2s53p5gu7z@pali>
 <508d35f29c2abc26af15e232a38d3ca53eb33706.camel@iki.fi>
 <20191202184512.rx6p63c6axztnwrw@pali> <20191205093200.x47npi5sxtcphr2o@pali>
 <CABBYNZKi7UUg7kASKadGr7sDJH0-tfuuZr9rd4Xu8ZUA9LqTMA@mail.gmail.com>
 <20191216091521.reh2urr25husschv@pali>
 <3ca53c66-1df0-41bf-710e-dea709906234@gmail.com>
 <20191218172828.vfie4su2whts2fqh@pali> <20191218173632.aqdmdhutu3ruezck@pali>
 <06eb7e98-1357-afd1-40a5-2ccb139d8dec@gmail.com>
 <20191218213349.2ksew2wnhgu3peub@pali>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <0cfbe253-417c-e7c0-553a-abf360a80c9f@gmail.com>
Date:   Wed, 18 Dec 2019 19:03:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191218213349.2ksew2wnhgu3peub@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

> Yes, I see. Also there are devices without HFP support, only with HSP.
> pulseaudio support also these devices and pulseaudio is not going to
> drop support for them. Last time when I looked at ofono, it has no HSP
> support. Is ofono going to add support for HSP?
> 

No.

<snip>

> 
> But would you accept patches which exports DBus API e.g. for displaying text
> on HFP headset with embedded display? Or patches which implements 3
> different way for reporting battery level status of HFP headset? And API
> for sending "computer battery level" to HFP headset? Or implementing
> setup of SCO sockets (via RFCOMM layer) for custom codecs? Or exporting
> uinput linux device for button press events? Because all these

So which roles are we talking about here?  Your Design document shows 
hsphfpd registering for both HFP AG and HFP HF roles, but maybe this was 
not the intent?

If you're talking about extending oFono APIs when it is acting as the HF 
connecting to the AG, then codec setup APIs, etc are definitely 
something that would be welcome.

If you're talking about AG role, then that is different... In general, 
if the oFono is in an AG role, then there should be nothing to configure 
and there are no APIs for this role.  Things like reporting AG battery 
level to HFP headset are done directly using plugins.  See 
ofono_emulator_set_indicator and how this is done by upower.c for 
example.  I happily take patches for any additional features (codecs, 
etc) you want to support here.

But... oFono upstream has no interest in accepting forwarded AT commands 
from some external daemon if we're in AG role.  We rejected such a 
design years ago and nothing has changed.

AG role is already quite tricky to implement without additional 
complexity introduced by having multiple applications and IPC.  "Its 
your funeral" as the saying goes if you want to go that route.

<snip>

> I disagree here. Primary purpose of HFP for desktop users is ability to
> use bluetooth's microphone. And not telephony stack and its complicated
> features like call hold and others, which are in HFP used and
> implemented probably only in car kits.

So your primary goal here is to have the desktop play the role of the 
AG, purely so you can forward the audio from a headset out to whatever 
it is that you want.  And you want oFono (or some other daemon) to 
(optionally) handle the call related AT commands in the HFP AG role.

Such a design will get a NAK from me on the oFono side.  But don't let 
that stop you.  You can simply invoke oFono APIs directly from your 
daemon.  No need for any changes in oFono itself.  As mentioned above, I 
wouldn't recommend it, but... :)

> 
>>>> Also for using ofono with HFP profile is not possible on desktop
>>>> computer which do not have any modem as it is hooked to some active
>>>> modem.
>>
>> This statement is not true at all.  You can use oFono without any 'real'
>> modems attached.  It can happily manage only HFP devices (or modems as we
>> call them.)
> 
> Ok, can you please provide exact steps how to do it, including
> activating of bidirectional audio stream?

So again, which role?  If we're the HF connecting to the AG, then things 
just work without a modem.  If we're the AG, then yes you need a modem 
to be driven by the AG connection.

>>
>> You must be thinking of the oFono HFP AG implementation...
> 
> Yes! For connecting bluetooth headset you need HFP AG implementation.
> 
> And I guess this is the reason why simulator is needed. HFP headset acts
> as a "client" for modem. Therefore on desktop / laptop you need to
> implement "modem server" which will be used by HFP headset "client".
> 
> And phone simulator is doing exactly this "modem server", it is
> simulator of modem.
> 

Okay, I see now.  Yes, the above is correct.  My comments about not 
needing a modem device hold true only if oFono is in HFP HF role 
connecting to an AG.

Regards,
-Denis
