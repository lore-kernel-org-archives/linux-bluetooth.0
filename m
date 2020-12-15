Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74838C4361B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 19:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D99522B3B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 19:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgLOT7j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Dec 2020 14:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgLOT7j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Dec 2020 14:59:39 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49976C0617A6
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 11:58:59 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id r3so21098613wrt.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 11:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zJcH5eDCZVqwOJhqycarIEqu16Jo1RZm7Ot6v/7HDRk=;
        b=iY2K1KiMUmRmi10Fo2OUE5BfZ0ME57hHmTb26TVBSZFG06/TXGj6AXkqg3kmY4Os33
         JDs+EhBubIxRyeC12X/grnc4cgJgZd5T59r6Wlk/beFBGOsmwFuH/dXyl5QRrWu0Fexg
         6dE1VTHzSHgAOOyKgDfGDYgbTG6LloDQDIIrTr58VwTQYJrnVJiZ+PeHwrpEnOLp5mSB
         yN/R3B6zqfmKOxRdyXK8jh77LxBAAl4lIXncZcwIVddJR3Iv6RBl7h4M7LH0/pYZDAR+
         m73P5tGxyVgMNjYIBWwh6b2u6Msvo+AK7JuRE6Ipz0l+T6Xx0sQb7/b2uz3ovZYLnAXX
         sANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zJcH5eDCZVqwOJhqycarIEqu16Jo1RZm7Ot6v/7HDRk=;
        b=Up75v/dyxyNq8whOWE9/MFJ+LiwtRkBhUg3LnQZyu4DM+AVu1DR9fd6dqhsBoT0/jQ
         Gq/1Lzg9t4fRmK1ZI++OnIZLhtQatJImqhBEdHRwTI+mvDL5DFG73qU+N88lz/cuYcqj
         4JHlNuFlNUn6v2XreM6fN1goqGBZGKWCeLNpPsGXR3d0sOgxpijY4bvY6NOezXvggacd
         rYJyk2DKyxS3WCy29C6oEiqL4Z2PtZXpcZjheuE3m3ZkmqPZsd66Xrk1l25wWvorKnim
         UCz81HySguKUlQ56C7hZMBUNWAt5QfDH9QLnQ+2N1hqojboR5Rw4IYwu+HnoV74GLhl7
         rzAA==
X-Gm-Message-State: AOAM530i0cMtA4lHRd88z8UPy9cOb37tP14FTBGtWPaGnZmALYWM/EIv
        zBdjIcRZv0RxB78Kvv90q9aNqRMU3yG23A==
X-Google-Smtp-Source: ABdhPJwfa8yhkYhU91VgBDgUsJm41kQ5cSHY9EBoLbjk5y5Z93RV0eQ1oEFzymmxREpQ+wNvzDT1lQ==
X-Received: by 2002:a5d:61ca:: with SMTP id q10mr35666268wrv.124.1608062337876;
        Tue, 15 Dec 2020 11:58:57 -0800 (PST)
Received: from urmel.joe.lo ([2001:16b8:3ffb:e500:aa5e:45ff:fe53:bf7])
        by smtp.gmail.com with ESMTPSA id n14sm45145wmi.1.2020.12.15.11.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 11:58:57 -0800 (PST)
Subject: Re: BLE Midi problem with mixed 16/128Bit UUIDs in characteristics
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <22bd6446-d293-c5d7-14b7-9db9fa0727f6@gmail.com>
 <CABBYNZ+yi2kX0P8c8u4ZpZNcuy=vRMHqEfsirPd-+EVdbqxnuw@mail.gmail.com>
From:   Johannes Deisenhofer <jo.deisenhofer@gmail.com>
Message-ID: <ea82ca14-2738-cf9d-070a-7934be6fc1ab@gmail.com>
Date:   Tue, 15 Dec 2020 20:58:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+yi2kX0P8c8u4ZpZNcuy=vRMHqEfsirPd-+EVdbqxnuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 12/15/20 6:51 PM, Luiz Augusto von Dentz wrote:
> Hi Johannes,
> 

Hi,

> 
> The spec doesn't allow mixing values of different sizes, or does it
> first return the 16 bits one and then later 3 are return in a
> different response?
>

No, all in one response (which is re-assembled from two HCI packets).

My working device (DIY, arduino, but probably based on nordic semi code)
does the right thing:
It returns all handles with 16 bit, the client requests a continuation,
which results in the MIDI I/O characteristic, 128Bit, in another response.

[ cut ]

> 
> Well if the device is returning mixed UUID sizes then there is nothing
> we can do to figure out since as you said there is only one len so all
> elements should be of the same length, perhaps Android doesn't use
> Read By Type procedure and discover them, anyway it is perhaps worth
> notifying them about this problem given that it doesn't seem to
> conform to the spec.
>

Thanks for clarifying. So quite obvious a bug in their (Roland's) 
implementation. I hope they care enough.
I contacted them through their customer support forum, but I don't have 
much hope getting by the first-level support there.
If anybody has a better contact...

In this case, it would help to fetch the characteristics service by 
service instead of all in one. All characteristic UUIDs for the MIDI 
service are 128bit, the rest is all 16 bit. Could be the reason it works 
with Windows, Android, OSX, and whatever else they test with.

 From my limited understandig, that could probably be changed, but needs 
to be done in the general code, slowing everybodys pairing time down. A 
non-starter, I guess, for a single buggy device.

So I'll keep a fork with my super-ugly workaround and hope for roland.
I have to rebuild bluez anyway because my distro does not use 
--enable-midi.

Thanks!
Jo
-- 
Johannes Deisenhofer
