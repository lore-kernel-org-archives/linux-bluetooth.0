Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375BEC33C8C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 17:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17B6208C4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 17:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fwq8zqK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgAGRfv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:35:51 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:41211 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbgAGRfv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 12:35:51 -0500
Received: by mail-ot1-f45.google.com with SMTP id r27so717422otc.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 09:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0jXl+jsx9LaQYg4ikm51xDrcog0mCBX/+V0TxesH48o=;
        b=Fwq8zqK7AKQQonr7Eto93CfWpCIEuBWtI3nAm5E9XYha6/tS8j8U2D+4ZwKkrGF09E
         rzucAM1LBeT6nGub3jmU8Qw22KbfnEqd264oRm+ReKmdzTNNfazrmivaL16ASaZ3AcQt
         tE2iiJmfEhXFPSQpplEB8EFaw8hnOHh2w4j1ZdB5HqAIwY4l8F+T907TyTNLkNWImZiQ
         KnBoW/jq/l+L3v/HpwBqpdZWaGX7wgCoWlfIAU/UBiFR8feQzyaGy8HkHX7hi2ZfyErF
         5mH1T/DB8VkolD+j2AXIrhSsdIoZK3UAR3K3LwROfrU9GJJJziAtaDYzcHyHnOcQUVv3
         9+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0jXl+jsx9LaQYg4ikm51xDrcog0mCBX/+V0TxesH48o=;
        b=HP6MEkr+1pAaU/6xBhaeeSdCA3yiRi+3WH1fFbm3xG0o2gXpV6sp6TkJjS0bf4Vi/t
         +dzNV7JAOONHNk+iThJpdrx0gfo9KvLMRbXDNkooajtDcB0nGW4giLdux+1EkuXx7Jxc
         PJIuGOHA4TttF3S36AcLFUPVZEP7pI7pwHaUWtV3Gqj5hVQxTKdONffCWNOGXWIKwB0x
         2VJMtbkhL59BG1tuwQFX2EWDSEPJJfOsBVG2z9k11TpX2CYrAsLfY3gcj/EKjj9NODn0
         h1+5Xf7VVQEKHZnKx+ccwLB/+PEWuenrWSKm8IDEU6xLUid1hcgLgX1vPEScwCadNQvp
         8yCw==
X-Gm-Message-State: APjAAAWpcMLr6qyYWyvbcl73WKcvAbfYiLGPUi8R8qRdq4xqVf+lsuEe
        twu1JCMKqhMx+9s9YS3BpdcHL9Hv
X-Google-Smtp-Source: APXvYqw07Ji2ltjTUgfUvkVUowCcYziX/5vzPjmxvA6sC5YQjem0iv4TqtEHAfTSBbYgepBiYs//TA==
X-Received: by 2002:a9d:67d2:: with SMTP id c18mr885714otn.362.1578418550113;
        Tue, 07 Jan 2020 09:35:50 -0800 (PST)
Received: from new-host-2.home (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id d131sm151802oia.36.2020.01.07.09.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jan 2020 09:35:49 -0800 (PST)
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
References: <3ca53c66-1df0-41bf-710e-dea709906234@gmail.com>
 <20191218172828.vfie4su2whts2fqh@pali> <20191218173632.aqdmdhutu3ruezck@pali>
 <06eb7e98-1357-afd1-40a5-2ccb139d8dec@gmail.com>
 <20191218213349.2ksew2wnhgu3peub@pali>
 <0cfbe253-417c-e7c0-553a-abf360a80c9f@gmail.com>
 <20191219095132.blj3oyyrlfowv5ik@pali>
 <90261b42-1048-370f-7680-acd9f7e754ed@gmail.com>
 <20191219153344.hxnoa3idqvgdwrp2@pali>
 <76f1cb25-b608-e4e9-6fd9-8da932c56a15@gmail.com>
 <20191220224657.n4m6qkxa4sceau3l@pali>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <1eeea3f8-d06b-f774-c01d-1c7dbdb71c32@gmail.com>
Date:   Tue, 7 Jan 2020 11:35:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191220224657.n4m6qkxa4sceau3l@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

<snip>

>> I think you will need to do this regardless.  Otherwise I fail to see how
>> you prevent one 'agent' from consuming AT commands it shouldn't be. This is
>> a possibility you need to consider, whether it happens by accident or
>> maliciously.
> 
> Some subset of AT commands are needed to parse and interpret. But not
> telephony commands and having up-to-date internal telephony state.

Please think some more about what I said.  You will need to parse every 
AT command in your daemon, no way around that.  You are right that you 
do not need to keep track of the telephony state, but that is besides 
the point.  So if you need an AT parser anyway, the whole reasoning for 
the proposed architecture starts to look shaky.

<snip>

> 
>> - The other example is more practical. HFP Service Level Connection (SLC)
>> establishment is actually quite tricky.  There are certain limitations on
>> what can and cannot be done prior to SLC establishment, including how audio
>> handling is done.
> 
> I know :-) I already implemented prototype implementation to check and
> see how complicated it is and if API make sense and how hard it is for
> agents (audio - pulseaudio) implement and maintain it.
> 
>> Unfortunately, codec negotiation, indicator negotiation,
>> and feature negotiation are part of the SLC. oFono already solves all of
>> this and handles all of it nicely.
> 
> CSR codecs are not supported nor implemented in ofono. It is more
> complicated as HFP codecs... and needs a new API for audio application.
> Another value which brings my hsphfpd is that it handles these CSR
> codecs and provide API for audio application to use them.
> 

Again, you're not addressing my main point.  Codec negotiation is part 
of SLC establishment.  SLC has both telephony and audio aspects. 
They're inseparable.  Your architecture fails to address this...

CSR codecs are not part of SLC and can be bolted on later.  I already 
told you that oFono can easily be changed to support this.

>> We have passed all relevant
>> certification testing.  It is very unclear how you plan to handle this (or
>> whether you realistically even can) in your architecture when the
>> responsibilities are split between the various daemons.  So again, oFono has
>> nothing to gain here...
> 
> I was not thinking about certification. It is not something which I
> could do.... And also pulseaudio itself do not have certifications.

So again, no reason for us to get involved :)

Bottom line is there's no value for us in this architecture.  If you 
want to use the existing oFono APIs, that's fine.  But we're not adding 
a plugin for taking arbitrary AT commands from some other daemon :)

<snip>

>> Perhaps this can even be solved in oFono itself (since it already does 90%
>> of what you want) by making the modem requirement optional.  What we could
>> do for example is to create a dummy modem if an AG connection is requested
>> and no other suitable modems are detected in the system.  The resultant AG
>> wouldn't have any call control capability, it could still be used for
>> transferring audio data, battery, etc.  If you want to pursue this, we can
>> brainstorm further.
> 
> Well, if this would work automatically without any user interaction or
> without special setup, it seems to be usable.
> 
> But what is needed from this implementation in ofono? Basically API for
> each functionality designed in hsphfod daemon. And one of it is also
> support for HSP profile (with CSR and Apple extensions).

Start a separate thread on ofono for this.  I already gave you hints on 
how to solve the 'AG without a real modem' use case.  That would seem to 
be the biggest 'win' and it should be fairly easy to make this work.

> 
> I'm not against for it, but I thought that having functionality which is
> not related to telephony / modem you would not want to see in ofono
> project (like linux uinput layer for button events or API for displaying
> raw text on embedded display; or CSR audio codec negotiation).
> 
> So how do you see possibility to have also HSP profile in ofono? So have
> one place which would provide audio API for SCO? Because this is a big
> requirements from audio software side, to not use 4 different APIs to
> access SCO sockets (and its rfcomm / SLC configuration) in HSP and HFP
> profiles.
> 

HSP is a separate issue.  Maybe we can handle it like the 'dundee' 
daemon inside oFono (which handles Bluetooth DUN profile).  In other 
words have a dedicated daemon for hsp support that reuses the relevant 
bits of oFono and maybe exposes the same APIs (i.e the ones documented 
in doc/handsfree-audio-api.txt).  That would make life for PulseAudio 
pretty easy.

Regards,
-Denis
