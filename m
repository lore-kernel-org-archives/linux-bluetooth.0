Return-Path: <SRS0=CDO+=DV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E48C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Oct 2020 08:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EBF322200
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Oct 2020 08:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="yTUo3Wv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbgJNIol (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Oct 2020 04:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbgJNIoi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Oct 2020 04:44:38 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45A9C041E7A
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2020 22:06:31 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id j8so915365pjy.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2020 22:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GTY8OrccYe4mCjbqHOc79Uh42jvP30CMBNpOq0WvvCI=;
        b=yTUo3Wv7u2Ean1S9AMl9lQKsNz4VYkW3yewlo8IPK+J9dM+UbhYj6apF3Nre0o9JSJ
         N9rWpioN6+XCBKv7xnHA7M0vQBXnlfaSuLYkCFjjWRU5HTGwaywOpoVp00KsXL51Sfjs
         odj2GsPWrxTskCFYDMh0pXjy2HUeyDmuuAIHl/jcvgq2yMe+yRe4F5SyDytjKPYueeWn
         PhKW481+q+g1twTRv2sHrJACMe2qGZ4Kij6nkIeXpwkospERw4iKxo1h1bPdxUgUbOjv
         olh6I2bqq01XuyJgWmDLmk/0IirPWrcvfX61r30kU3DYzEGzuwByAT0a089HgLV8mTdN
         NKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GTY8OrccYe4mCjbqHOc79Uh42jvP30CMBNpOq0WvvCI=;
        b=ZZDGE+AJYxeeAix9Z7ceHXlM92FQvmiSL8MgGlKLVTN3Q4kW4samdAaGsTPn08BD2J
         uj96p7UGyzn5Ak0p0AYMgnuiBO+Cnmghgb/UxaOOAPOC0xWme75V5yD/Besf4exVIPE+
         WRo1s4jtuxyb4j4n9E+57Y7gK2GHtxuzayNhmXyOtF6H28ybe8PTT94rMb2HEsoE/dps
         G52gUK72Rpl/Jl8xO8y3ENTqZQdYDwcAqSFYAthdYmqsbhKm0gctQMs3L89GLScEqvIl
         OkZnv2jwNo8UCgBmu38r3EFKfQGpsmihXAc/LbjTK99a5N6dNDoOKsehSVt4jrSIQ2Bb
         3sTQ==
X-Gm-Message-State: AOAM532mOIwNedKrn4LWIQlh5i4Jx7WRLWvK54e7Rj3MRZQWMct/9/BQ
        nHLQe/bSwZg2P+LudUChUpBPR6kyL8v68HX8
X-Google-Smtp-Source: ABdhPJxMqXmg8b2Bpuwuz76Me1UhHxq601RCbhro011ncdxEHSpw6hBLF7Hs9mypYa38SecxHJXpEA==
X-Received: by 2002:a17:902:465:b029:d0:89f1:9e2a with SMTP id 92-20020a1709020465b02900d089f19e2amr2738643ple.6.1602651991033;
        Tue, 13 Oct 2020 22:06:31 -0700 (PDT)
Received: from [192.168.2.14] (216-19-182-159.dyn.novuscom.net. [216.19.182.159])
        by smtp.gmail.com with ESMTPSA id n203sm1608504pfd.81.2020.10.13.22.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 22:06:30 -0700 (PDT)
Subject: Re: Bose QC 35 Battery/ANC Support
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <333e38b3-da26-e3c6-76fb-1ee1caf90299@tcd.ie>
 <CABBYNZLFV6THotUuzATG0YJFgDh9cFoU575QqLD+Q2+EHoiPTA@mail.gmail.com>
From:   Peter Mullen <omaolaip@tcd.ie>
Message-ID: <6030b6bc-73f1-6fbd-e5c5-58e2ce4a5d26@tcd.ie>
Date:   Tue, 13 Oct 2020 22:06:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZLFV6THotUuzATG0YJFgDh9cFoU575QqLD+Q2+EHoiPTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 2020-10-12 9:43 a.m., Luiz Augusto von Dentz wrote:
> Hi Peter,
> 
> On Sun, Oct 11, 2020 at 1:04 PM Peter Mullen <omaolaip@tcd.ie> wrote:
>>
>> Hi all,
>>
>> I've been working on a plugin that adds support for battery level
>> reporting and Active Noise Cancelling (ANC) control for the Bose QC 35
>> headphones. The patch is nearly ready to go, but because of the
>> non-standard way it's implemented I figured it might be necessary to get
>> some preliminary feedback on it prior to submission (or to see if it's
>> worth submitting).
>>
>> As a brief overview of device control, the QC35 has a set of additional
>> controls operating over rfcomm channel 8 where messages are passed back
>> and forth between devices. The messages consist of a 3-byte opcode, a
>> 1-byte payload length, and N-bytes of payload. There's some more
>> information on the specifics here:
>> https://blog.davidventura.com.ar/reverse-engineering-the-bose-qc35-bluetooth-protocol.html
>>
>> As this is a non-standard "profile", there's no profile UUID assigned to
>> it which makes adding a profile somewhat more complicated. My solution
>> here was to add a profile under the iPod Accessory Protocol (iAP)
>> profile UUID which the QC35 lists, and to then filter out devices in the
>> profile probe callback based on manufacturer ID, device class, and
>> product ID. This isn't ideal as the probe will be called for any device
>> listing the iAP UUID, so suggestions for alternative approaches (if
>> necessary) are appreciated.
> 
> We could in possibly add pid/vid to btd_profile that way it can be
> probed by pid/vid in addition to UUID, that way one can make a driver
> that is specific to a vendor or a product.
Had a go at that this evening as a proof-of-concept; so far it's working
well, so this could be viable. I'll finish it off and test it out properly.

>> For session state control, I've hooked into the AVDTP state-change
>> callback. Again, possibly non-standard but this seemed to be the best
>> way to trigger the initiatiation/tearing down of the rfcomm connection.
> 
> I would recommend hooking to the btd_service state, like for example
> the policy plugin is doing.
I was able to get the plugin working based on the btd_service state cb,
but had a couple of concerns with it, mainly because we'll be receiving
events for all services on all devices, so the filtering of unused
events adds a bit of overhead.
I was also able to use the AVCTP state callback without issue, which may
be better suited than the AVDTP one.

>> For ANC integration, I've added a new dbus interface under
>> "org.bluez.Anc1". The interface contains a read-only "Range" property,
>> which indicates the number of discrete values the ANC can be set to, and
>> a read-write property "Level" which gets/sets the level. This interface
>> layout was chosen to be device agnostic, so that ANC support could
>> potentially be added for more devices in future.
> 
> I'd probably add Bose to the name of the interface if it is bose specific.
While the plugin is Bose specific, I had tried to keep the interface
itself generic so that integration with the DE or similar won't need any
changes if ANC support is added for other devices later.

--
Peter Mullen
