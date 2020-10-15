Return-Path: <SRS0=NBlN=DW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9B3C433E7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Oct 2020 03:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E892222E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Oct 2020 03:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="AANVp1Ke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgJODDF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Oct 2020 23:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgJODDE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Oct 2020 23:03:04 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87485C061755
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2020 20:03:04 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h6so955461pgk.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2020 20:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XVbJn08xC0b/sSuXCJV4ZXz7O5aagd5WBx3bhi5MerM=;
        b=AANVp1Ke0aEGZhr3IogE3nCDsYwLTBbUmSZIpAMesKcMBGtNZxDEg+fWgFl6gGZ/t6
         bvXgKarS0dAr/x4ZH2pOq0zUK5yQpicLrUjerjvFFp4zc7VlNhNfVmh/P5qYT41fDdT+
         6ju+6r/CKlX+OSsjseuV9UDXlOJwtVgflCze25dWuzyrK3Oei/bu7V6WcoPomjqvQneS
         gHw5Q2v4XwfKHxJ/o8awv8MpCI45e/jyylRHX1OK3+QMKSQtlPHsCy8Adtv+/WDnLCxi
         CnM34n/YKFX5AwUNmHRVhkcWLlAWF0MRg6yvBdG3PJQxvWDT6gpbzVx8N14dl4qlSnq6
         ymjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XVbJn08xC0b/sSuXCJV4ZXz7O5aagd5WBx3bhi5MerM=;
        b=Bkmzv5NHQQJsRdHaf2G7onOcq67LQluU8B33dd6H7uKxCb+M6HDrbrhoWFgEpyhIv1
         R9KA/cSZU/O61j6D/ww0+IQ8kthXscLJ1awjQQ6yfaY6XcD4y4LXHT6ogiks7bmxqPN9
         xsf3wGAshghxAkQZWXsdT0kJm80lIlICrdW2g4+xwuPFeh+x1pwhSLFmeaWAMLxsrpVo
         OzDGr7hEEJ0l++LiXki+P4b10gxAqxtNb/6ELOLDuwf/h04hJUxlRPIe13jJIm3t1wRJ
         SbG20LtrxmyffKTcqN1RytvNfQD2/fUDPl/j7Fi8+gcwWbkSqWPrI84bqeYT5z+oPzmN
         GfpQ==
X-Gm-Message-State: AOAM5327fjGZJTpI4M3koDFok3y+ipod0DXvL1PtowJFkSLuzaXWzhda
        IVE5aLzSfdQ4eA13CoRBXeq/qmrVpvHlrp5e
X-Google-Smtp-Source: ABdhPJy6wWkDYHFyDt7TDJW3WUYg80K94LhVQWoRJwHff1dhTQA6A64XOuaoI+gKsAXszsYGq5wijw==
X-Received: by 2002:a62:7d15:0:b029:155:29ed:db4c with SMTP id y21-20020a627d150000b029015529eddb4cmr2122061pfc.77.1602730983628;
        Wed, 14 Oct 2020 20:03:03 -0700 (PDT)
Received: from [192.168.2.14] (216-19-182-159.dyn.novuscom.net. [216.19.182.159])
        by smtp.gmail.com with ESMTPSA id c4sm1040688pjq.7.2020.10.14.20.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 20:03:03 -0700 (PDT)
Subject: Re: Bose QC 35 Battery/ANC Support
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <333e38b3-da26-e3c6-76fb-1ee1caf90299@tcd.ie>
 <CABBYNZLFV6THotUuzATG0YJFgDh9cFoU575QqLD+Q2+EHoiPTA@mail.gmail.com>
 <6030b6bc-73f1-6fbd-e5c5-58e2ce4a5d26@tcd.ie>
 <CABBYNZLMciCQP_f+e7EM1v=9eS3BAnP17gxYBUNCVE4KxO_8-Q@mail.gmail.com>
From:   Peter Mullen <omaolaip@tcd.ie>
Message-ID: <629b8c04-a40a-2a13-9fa4-0e3a71c591a4@tcd.ie>
Date:   Wed, 14 Oct 2020 20:03:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZLMciCQP_f+e7EM1v=9eS3BAnP17gxYBUNCVE4KxO_8-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 2020-10-14 10:15 a.m., Luiz Augusto von Dentz wrote:
> Hi Peter,
> 
> On Tue, Oct 13, 2020 at 10:06 PM Peter Mullen <omaolaip@tcd.ie> wrote:
>>
>> Hi Luiz,
>>
>> On 2020-10-12 9:43 a.m., Luiz Augusto von Dentz wrote:
>>> Hi Peter,
>>>
>>> On Sun, Oct 11, 2020 at 1:04 PM Peter Mullen <omaolaip@tcd.ie> wrote:
>>>>
>>>> Hi all,
>>>>
>>>> I've been working on a plugin that adds support for battery level
>>>> reporting and Active Noise Cancelling (ANC) control for the Bose QC 35
>>>> headphones. The patch is nearly ready to go, but because of the
>>>> non-standard way it's implemented I figured it might be necessary to get
>>>> some preliminary feedback on it prior to submission (or to see if it's
>>>> worth submitting).
>>>>
>>>> As a brief overview of device control, the QC35 has a set of additional
>>>> controls operating over rfcomm channel 8 where messages are passed back
>>>> and forth between devices. The messages consist of a 3-byte opcode, a
>>>> 1-byte payload length, and N-bytes of payload. There's some more
>>>> information on the specifics here:
>>>> https://blog.davidventura.com.ar/reverse-engineering-the-bose-qc35-bluetooth-protocol.html
>>>>
>>>> As this is a non-standard "profile", there's no profile UUID assigned to
>>>> it which makes adding a profile somewhat more complicated. My solution
>>>> here was to add a profile under the iPod Accessory Protocol (iAP)
>>>> profile UUID which the QC35 lists, and to then filter out devices in the
>>>> profile probe callback based on manufacturer ID, device class, and
>>>> product ID. This isn't ideal as the probe will be called for any device
>>>> listing the iAP UUID, so suggestions for alternative approaches (if
>>>> necessary) are appreciated.
>>>
>>> We could in possibly add pid/vid to btd_profile that way it can be
>>> probed by pid/vid in addition to UUID, that way one can make a driver
>>> that is specific to a vendor or a product.
>> Had a go at that this evening as a proof-of-concept; so far it's working
>> well, so this could be viable. I'll finish it off and test it out properly.
>>
>>>> For session state control, I've hooked into the AVDTP state-change
>>>> callback. Again, possibly non-standard but this seemed to be the best
>>>> way to trigger the initiatiation/tearing down of the rfcomm connection.
>>>
>>> I would recommend hooking to the btd_service state, like for example
>>> the policy plugin is doing.
>> I was able to get the plugin working based on the btd_service state cb,
>> but had a couple of concerns with it, mainly because we'll be receiving
>> events for all services on all devices, so the filtering of unused
>> events adds a bit of overhead.
>> I was also able to use the AVCTP state callback without issue, which may
>> be better suited than the AVDTP one.
> 
> I guess we could add support for subscribing to state changes of a
> specific service, that way you don't need to filter anything at the
> plugin, how about that?

Had a look into this, but since the state callback is being registered
during profile-probe, we're not guaranteed that the other services will
have been created yet, so we won't be able to specify which service we
want to subscribe to.
I've removed the AVDTP/AVCTP state callback hook anyway, and switched
over to the existing service-state cb; after moving things around the
overhead turned out to be pretty low, so I'll get it all tidied up and
submit a patch in a couple of days (pending any further feedback).

>>>> For ANC integration, I've added a new dbus interface under
>>>> "org.bluez.Anc1". The interface contains a read-only "Range" property,
>>>> which indicates the number of discrete values the ANC can be set to, and
>>>> a read-write property "Level" which gets/sets the level. This interface
>>>> layout was chosen to be device agnostic, so that ANC support could
>>>> potentially be added for more devices in future.
>>>
>>> I'd probably add Bose to the name of the interface if it is bose specific.
>> While the plugin is Bose specific, I had tried to keep the interface
>> itself generic so that integration with the DE or similar won't need any
>> changes if ANC support is added for other devices later.
>>
>> --
>> Peter Mullen
> 
> 
> 
