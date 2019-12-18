Return-Path: <SRS0=1j7M=2I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6188C43603
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Dec 2019 17:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A8C2176D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Dec 2019 17:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8TexXag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfLRREk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:04:40 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35361 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfLRREj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Dec 2019 12:04:39 -0500
Received: by mail-oi1-f193.google.com with SMTP id k4so1405316oik.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Dec 2019 09:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SfP1xXY4ryjBuLsnMqz7SAwvHNqxaejX/KYCu0nSAlk=;
        b=i8TexXagdHLUll2b6gBnKxOyoPqRzwKi+Pem9AT7XRrZicPwyVQT+yaNQnjBPD5Knt
         1WLOz//G+PcXffTTGPVCAxbf+GACvUpty7rIU8RcOLiwUoaPAK87tt7YW3k6HfJphAnf
         RumETaO1SWSDiugVTLog5J/6mCoqsEHuYqCOhKPK3i4HiHdYG7qIh4M//Fhwi9PsJeDN
         pBAQkEAwzTjm24hY/FkYlVbW1CUQUGSLbCCcrcq8c0bfdjcPEw3NNZAj896x74X+ABdi
         bV8htjXIvctLxn4tCowFHoOROFABioJo1Rcc8GoaAQsWZvTun2abJJU6DONmF9mOJoqs
         os7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SfP1xXY4ryjBuLsnMqz7SAwvHNqxaejX/KYCu0nSAlk=;
        b=OrhtFaY6jIsLZgbH6Ubd/83iYF2/ilSFlXPeG3pSrSuK7j0GhtQ6yKevLbS+nPOl72
         jm69KAe4wtF5CvyqZYzra8CK/edjQEurUvtspOnJgmk3MOE66gabSh1TjAjv9pZBrSdi
         7Or0ZHPZk62rS7bS6vTqN8M0395JZ/+QClWp1v4Zyob8uK2UnwgAE5LzY/McUVY6TLLK
         i6bU4r5/db6H9s3aHCj49G3BR4nrn1+y5ZXn/lKuCAPpy88QnJo5t8+W8lVk/LDLeGL7
         65CteIhpUDPGuWzcmsoJzA78yqzFvKKePgzXYEJYRifN//qZH//poSGAXqcAH7Zpy5QV
         F4XA==
X-Gm-Message-State: APjAAAUJkPCPS9i1rB33PnoesYkgcGlZaswmHoD+EZ+NrCSzNEH2DiO7
        pAIj1PP7GZN3onnKHHEiQSE=
X-Google-Smtp-Source: APXvYqw1z3bNPXmKuKVJ3w+IvCL5l9d1sxfoLkwpoyf4kT+Qb0tSUiAOFLsrWuvVx3kdNysPlMsBJg==
X-Received: by 2002:aca:3b03:: with SMTP id i3mr949724oia.160.1576688678896;
        Wed, 18 Dec 2019 09:04:38 -0800 (PST)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id i12sm988541otk.11.2019.12.18.09.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 09:04:38 -0800 (PST)
Subject: Re: [pulseaudio-discuss] Proposal for a new API and usage of
 Bluetooth HSP and HFP profiles on Linux
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
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
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <3ca53c66-1df0-41bf-710e-dea709906234@gmail.com>
Date:   Wed, 18 Dec 2019 11:00:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191216091521.reh2urr25husschv@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On 12/16/19 3:15 AM, Pali Rohár wrote:
> Hi!
> 
> On Monday 16 December 2019 00:11:04 Luiz Augusto von Dentz wrote:
>> Hi Pali,
>>
>> On Thu, Dec 5, 2019 at 11:32 AM Pali Rohár <pali.rohar@gmail.com> wrote:
>>>
>>> On Monday 02 December 2019 19:45:12 Pali Rohár wrote:
>>>> On Monday 02 December 2019 19:01:11 Tanu Kaskinen wrote:
>>>>> I think hsphfpd should be part of bluetoothd, but if that's not
>>>>> possible, then that's not possible.
>>>>
>>>> I do not know if bluez developers are interested in having this code as
>>>> part of bluez project, specially when in bluez4 HFP profile was there
>>>> and in bluez5 was HFP code completely removed.
>>>
>>> Hello, could someone from bluez developers comment this Tanu's point?
>>
>> I would have to say no, we are definitely not interested in yet
>> another daemon for AT parsing, we actually have too many of these
>> around, either in a form of Modem Manager, oFono, etc.
> 
> Proposed hsphfpd daemon is not (only) for parsing AT commands, but for
> implementing logic around HSP and HFP profiles and export either native
> interfaces (linux uinput) or DBus interfaces for features provided by
> HSP and HFP specifications and also for current and future vendor
> extensions. And part of this HSP/HFP implementation is of course needed
> parsing and interpreting some of AT commands. Look into my design and
> API proposal. Current daemons which provides AT parsing (like ofono or
> modem manager) are not suitable for for whole HSP and HFP profiles with
> all those extensions (like all possible ways for reporting battery
> level), so for HFP is needed some of custom AT parser.

I'm not sure what logic around HSP you really care about.  It is just a 
single button press in the end.

For HFP, oFono can already support all sorts of extensions.  See for 
example how we handled Siri for HFP support in oFono here:
https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/doc/siri-api.txt. 
  Many of the extensions you talked about are also relevant for real 
modems as well (like battery reporting, call volume, etc).  Some of 
these APIs are already defined in fact.

Given the above, oFono upstream has no interest in adding or maintaining 
support this new framework.

Regards,
-Denis
