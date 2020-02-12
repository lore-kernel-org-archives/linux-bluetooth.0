Return-Path: <SRS0=IUpk=4A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC35BC352A4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Feb 2020 21:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D27206DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Feb 2020 21:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVGAFLjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgBLV3L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:29:11 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:33987 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbgBLV3K (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Feb 2020 16:29:10 -0500
Received: by mail-ot1-f48.google.com with SMTP id j16so3480494otl.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2020 13:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P9AXzHWaqJpnn5e1daEk48lMUC1rnlU9Sx/oX+nyZBQ=;
        b=OVGAFLjv28kCj+rv+L3IacVxxpbFmMxvhjBDG7B/27jbRs7pqSNXFZO34E0I4IInx6
         0bfokI0sjBSPrB5+6OcE5NkP8///fFhb498Y3zY2/mTV1LE8iJLFgARaFkkF7MzRBThF
         osdTuXqiGKBqFX5vHZCSguJgJ2T87ZBT/gEO9XZWSmEa0OR8Anev1/ozAIBVD0Q+Cz2h
         ZfRImDVBWlnRdeOsm5t/HT6gQ0us/1UogdLCtW+KVFibfsjNO4knHKeAya+CvwXt0CRo
         AJSomOMCsV+56i8cJLaV/y553dYJPxTWbYS1q28FyurVejGCqnYGF3QkibGFiw7ocijf
         4XMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P9AXzHWaqJpnn5e1daEk48lMUC1rnlU9Sx/oX+nyZBQ=;
        b=tNQeFwK7dw+iDDA+FDxC4C+GdXCAV4bYHIsgssNRSe0V5BhHVyj6JITsw3AGTWxPRZ
         4dCyP64nwxSKR5ZkPjixxhSPvpoBvgu3IMAc0MPxDqp55SHcMSuVBPZNrU2ezMx4nZpM
         AURSYEj8weG6o0mVBfElN+rUBNp4aPqhTBHEtrcIQjhTGT88Wr5YX8yvZO2uWUnuZ7Xf
         xB1BRz8u24zjC6iYyYRpr+IBbOVi8xqdin5+YAAnkbi0Zg5xJALYmEv41mhqrBzqOq9T
         PKQrP0x0nGiQ0ASICSLAIQ89oEtr/qcVHAeUzA2fZ8F5Kt++yCDJ445RnWfLanqmVLqa
         luWA==
X-Gm-Message-State: APjAAAXq8hRLlVIMWY+yYB9QNbHHeeeVk8jwGzfLJHL1n55yNtyZRYg/
        65DHF0nsdgbvsqJQX3k3K7TM3wUh
X-Google-Smtp-Source: APXvYqzeTT6o2Hv3P3MvLtiQtx2toJyC6XSU6ZFHG872ZYPvTGaEJZOlDxvJsmQNlTmywERGpe3oqQ==
X-Received: by 2002:a9d:12a2:: with SMTP id g31mr4019335otg.283.1581542949443;
        Wed, 12 Feb 2020 13:29:09 -0800 (PST)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id p83sm33135oia.51.2020.02.12.13.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2020 13:29:08 -0800 (PST)
Subject: Re: HSP/HFP ofono bluetooth support for Linux desktop
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc:     ofono@ofono.org, linux-bluetooth@vger.kernel.org
References: <20200107192311.efit6zftt27encdc@pali>
 <721332d3-336a-b9d2-f8cd-72da785fb9dc@gmail.com>
 <20200108212537.zs6pesil2vjguvu6@pali>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <57639029-7588-956b-8e3c-a2a6ed11b758@gmail.com>
Date:   Wed, 12 Feb 2020 15:29:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200108212537.zs6pesil2vjguvu6@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On 1/8/20 3:25 PM, Pali Rohár wrote:
> Hello!
> 

Somehow this went straight to my Junk folder, so I didn't see this 
message at all until now.

> 
> Audio application (e.g. pulseaudio) really do not want to handle two
> separate services to monitor and process HSP/HFP devices. >
> For audio application are HSP and HFP devices equivalent, they provide
> same features: SCO socket, API for controlling microphone and speaker
> gain; plus optionally specify used codec.
> 
> So having two separate services which fully divided for audio
> application purpose does not make sense.
> 
> So it is possible that both HSP and HFP audio cards would be available
> via one audio API? Because I do not see how it could be done via design
> like dundee.
> 

One API sure.  Maybe on multiple services.  Honestly, I don't see why 
this would be such a burden for PA to watch 2 dbus services instead of 
1.  From oFono perspective it would make more sense to keep the HSP part 
a separate daemon.  I could be convinced otherwise if it is indeed a big 
burden for PA...

>> You can then implement the same API interfaces for setting up the HSP audio
>> stream as oFono does today (i.e. https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/doc/handsfree-audio-api.txt),
> 
> This API is unusable for both HSP and HFP audio streams. In pulseaudio
> it is somehow used, but it is not suitable.
> 

Funny.  "It is used but not suitable"?

> Main objection for handsfree-audio-api.txt is that it does not provide
> information about locally used codec and somehow mixes air codec and
> local codec. In my hsphfpd.txt I used term "AgentCodec" for bluetooth
> local codec and term "AirCodec" for bluetooth air codec format.

Okay.  But, just FYI, at the time there was no hw that could do such 
on-the-fly conversions, so this use case wasn't considered/implemented. 
There's really no reason why we couldn't extend our APIs to handle this.

> 
> Another objection against handsfree-audio-api.txt API is that it is
> bound to HF codecs (via number) and does not support for pass e.g. CSR
> codecs.

True.  In retrospect we probably should have used strings.  But it was 
assumed that vendor extensions would go via the Bluetooth SIG Assigned 
Numbers facility.  Anyhow, we can always add a 'Register2' method that 
could take codecs as a string array or a combination of strings & ints. 
And if Register2 was used, then use 'NewConnection2' with a signature 
that supports passing in vendor codecs and whatever else that might be 
needed.

> 
> What is completely missing in that API is controlling volume level.
>

It is there on the CallVolume interface

> And also API does not provide socket MTU information or ability to
> change/specify which codec would be used.

There was no need, we automatically defaulted to using Wide band if 
available.  Third party codecs are a new use case (for oFono HFP), so 
would require an API extension.

> 
> Non-audio APIs which are needed to export (for both HSP and HFP profiles):
> 
> * battery level (0% - 100%)
> * power source (external, battery, unknown)
> * ability to send "our laptop" battery level and power source to remote device
> * send text message to embedded display
> * process button press event (exported via linux kernel uinput)
> 

I think all of these are feasible to support under the current oFono 
structure, either via plugins or API extensions.

Regards,
-Denis
