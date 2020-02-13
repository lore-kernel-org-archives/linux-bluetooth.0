Return-Path: <SRS0=+UdQ=4B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B41C2BA83
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Feb 2020 18:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA96206CC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Feb 2020 18:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcT00+fQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgBMSOP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:14:15 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:45976 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbgBMSOO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Feb 2020 13:14:14 -0500
Received: by mail-ot1-f50.google.com with SMTP id 59so6469162otp.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2020 10:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ubeluhxE6KL4DVUqEbYaBnJcEDVIEMqcij2FA5XeTi4=;
        b=LcT00+fQGlOKVVCQdAXtB9Tp+Bi0u9rgfN7g6htLmHVZUwz+BiuQjbSDcNbV2+4TZv
         3OGEhUF6CQw15vQlBQnbpog125jrKPpzSncFXQG8CFymQNgaAU3QuFNNSpNjfuYhpCgi
         Zx66BZiK0QrqXA426I3bbPF+2VuCjATfJ6H5UHnvhwcJYroevyaQWYIMAp2W3ooRRoWW
         gwo74evBvWyPvL4v+75gkvvrETB3Sn/fMQjwwrpVfABKvnc5HHiJoQIBALGdjhouem26
         XFXWMDAqyX5hjqSjzAPvRC6ltFn2wULOaD/GKtZlNFGVua9zks2LlBA3DGz/bdF+bXS3
         hOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ubeluhxE6KL4DVUqEbYaBnJcEDVIEMqcij2FA5XeTi4=;
        b=O/nw3yQbntUW+aMJrW2hwUsG6ixyMwW+AkI3+zbezOyuXdBwqcx6MbY7D7toC2cYLf
         PF8QNix9STSaYRTGjf8Y5XLn0sroBIx0bP3L7UQOhMeKj/EqPYKZRKaLzv56gn4uBqOX
         ImkB6VmpzFCW9ZmSlLpFNKt+UeIVzu7GoO4DicWW43cN9cOv9hEvWj5Zqab2Dt5YPLxP
         tp3r1nw/MnCaClBVkMqCSb9ZErpIYhbYSkeuprHEZtrZMIPXez5W3Gm3/D5ap7O1Sp2Y
         JECufs5biWIm50S2MWCDX8rYSFryJTdu+Ug49njGhtoai+cfAibcJNag/8e2ptemu33I
         OjNg==
X-Gm-Message-State: APjAAAUOySEf3Iw/Uo47UMmjUxFOl0dCuhgdieBIQtn/cWDPS864YTBB
        dHLNpSwEVboCUd/maJy2koiWNaGL
X-Google-Smtp-Source: APXvYqwclD34Y2pniakZJ9PR/V5iRwdMN8vU2mycKMEI3vgptXq06wcLjKMiXaXDR3gYYrlyT6WlDw==
X-Received: by 2002:a05:6830:138b:: with SMTP id d11mr13581250otq.38.1581617651314;
        Thu, 13 Feb 2020 10:14:11 -0800 (PST)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id f142sm907166oig.48.2020.02.13.10.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2020 10:14:10 -0800 (PST)
Subject: Re: HSP/HFP ofono bluetooth support for Linux desktop
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc:     ofono@ofono.org, linux-bluetooth@vger.kernel.org
References: <20200107192311.efit6zftt27encdc@pali>
 <721332d3-336a-b9d2-f8cd-72da785fb9dc@gmail.com>
 <20200108212537.zs6pesil2vjguvu6@pali>
 <57639029-7588-956b-8e3c-a2a6ed11b758@gmail.com>
 <20200213174621.e2q4ryu36p5ericx@pali>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <6679dd2b-4780-e44f-b86d-28cf65638888@gmail.com>
Date:   Thu, 13 Feb 2020 12:14:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200213174621.e2q4ryu36p5ericx@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

> Used by who? Gateway role is fully broken and client (hfp) role is used

I guess that depends on your perspective.  I've already pointed out that 
the desktop 'AG' use case was never something we needed to implement. 
If you want to fix oFono to do that, great.  If you want to write your 
own daemon to do this, also great.

> probably only by some power users. Also there is no support for mSBC in
> pusleaudio.

Why is oFono at fault for this?  Genuine question.  What are the 
roadblocks to mSBC support?

> 
> So, no, really it is not used.
> 
>>> Main objection for handsfree-audio-api.txt is that it does not provide
>>> information about locally used codec and somehow mixes air codec and
>>> local codec. In my hsphfpd.txt I used term "AgentCodec" for bluetooth
>>> local codec and term "AirCodec" for bluetooth air codec format.
>>
>> Okay.  But, just FYI, at the time there was no hw that could do such
>> on-the-fly conversions, so this use case wasn't considered/implemented.
> 
> This cannot be truth as probably every bluetooth HW is doing on-the-fly
> conversion between CVSD and PCM. I was not able to find HW which allows
> me to send raw CVSD samples...

At the time this was all done in software.  Alternatively, the hardware 
was directly wired between the sound card / modem and the bluetooth 
chip.  So just opening the SCO socket was enough.

>> True.  In retrospect we probably should have used strings.  But it was
>> assumed that vendor extensions would go via the Bluetooth SIG Assigned
>> Numbers facility.  Anyhow, we can always add a 'Register2' method that could
>> take codecs as a string array or a combination of strings & ints. And if
>> Register2 was used, then use 'NewConnection2' with a signature that supports
>> passing in vendor codecs and whatever else that might be needed.
> 
> This is still not enough. Audio application (e.g. pulseaudio) need to
> register AgentCodec, not AirCodec. And current API is somehow mixed.
> Audio application needs to know what is the format which bluetooth chip
> sends to userspace (PCM? mSBC? CVSD? PCMA? AuriStream?) and which format
> bluetooth chip expects. I named this AgentCodec.

So how do you negotiate the 'AgentCodec'?  Does BlueZ expose this 
information?  If so, how? SCO socket option or ...?

>>> And also API does not provide socket MTU information or ability to
>>> change/specify which codec would be used.
>>
>> There was no need, we automatically defaulted to using Wide band if
>> available.  Third party codecs are a new use case (for oFono HFP), so would
>> require an API extension.
> 
> MTU is needed also for mSBC codec if encoding is done in software
> (pulseaudio). Without it, this wide band support in ofono is unusable
> for pulseaudio.

Isn't the MTU obtained from the SCO socket itself?  How is oFono at 
fault here?

> 
> And also API extension for choosing codec. Also for choosing if software
> of hardware encoding would be used. We know that there are lot of broken
> devices in different way and it is really needed for either blacklist
> some codec or switch between hw and sw encoding if something strange
> happen. Without it pulseaudio is not going to support more codes then
> default required (CVSD).

This seems to be a kernel / device driver / firmware  issue and should 
be solved at that level.

> 
>>>
>>> Non-audio APIs which are needed to export (for both HSP and HFP profiles):
>>>
>>> * battery level (0% - 100%)
>>> * power source (external, battery, unknown)
>>> * ability to send "our laptop" battery level and power source to remote device
>>> * send text message to embedded display
>>> * process button press event (exported via linux kernel uinput)
>>>
>>
>> I think all of these are feasible to support under the current oFono
>> structure, either via plugins or API extensions.
> 
> Ok. Are you going to implement them?
> I think that all of these are missing parts in ofono and something which
> is needed to be implemented for desktop/laptop HSP and HFP profile
> support.
> 

There are no plans to do this at the moment.

Regards,
-Denis
