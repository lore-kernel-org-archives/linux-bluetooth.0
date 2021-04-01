Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299C1C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 20:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 002BB610D1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 20:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbhDAUUF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Apr 2021 16:20:05 -0400
Received: from mout02.posteo.de ([185.67.36.66]:55447 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234940AbhDAUUE (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Apr 2021 16:20:04 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 3DD922400FB
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Apr 2021 22:20:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1617308403; bh=FnwrutHgNDi6ojqoLcvNN8xUKC/f2waJpLZDhCsE6XE=;
        h=Subject:To:Cc:From:Date:From;
        b=SZXzGLVw1ycjejrVrSQIqnAXE6nnLphtEo/KmH2z7cKU40rWO2P89/Yc0/u9wLREN
         b9jM1Zm5balofzxpmENQOehB/yjqywHOGoVCV/DLnMdxAcu0XwsgRX6ZTVrHUt9XUN
         9I4rZt3Bs0KpPqBITdOnDeK+565qcf4rFk9RxjeODhQ8iEfLTF9vTkHwT1p1CvDT8Q
         Ch69etZ+/zp9vGKhtYlpnZJX8DmVEr/hbfS59geS76spmLaouJq0SBPSyOffOAIBNj
         0uH42MDdogHxdqCreeQssMLuhin4glzd0FvKDH44/hGQb5KsBtbzh8n6sAXglJFs+W
         XsdzeP5FrUt5Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FBF0f5GPSz9rxP;
        Thu,  1 Apr 2021 22:20:02 +0200 (CEST)
Subject: Re: cannot get a2dp profile enabled
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <e2fb3695-5596-18c7-0bf1-fc701ba780f8@posteo.de>
 <CABBYNZJkscA_h7j3rWB-AiDrDa7=XjwFBxx3zOhw50hXSSSH-Q@mail.gmail.com>
From:   "mailinglisten@posteo.de" <mailinglisten@posteo.de>
Message-ID: <7911ecb9-44b9-f178-6318-f606112e80dd@posteo.de>
Date:   Thu, 1 Apr 2021 22:19:59 +0200
MIME-Version: 1.0
In-Reply-To: <CABBYNZJkscA_h7j3rWB-AiDrDa7=XjwFBxx3zOhw50hXSSSH-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Am 31.03.21 um 20:37 schrieb Luiz Augusto von Dentz:
> (....)
>> I have a Jabra headphone/headset device and pulseaudio can´t activate
>> the a2dp_sink, I want to be sure, A2DP is properly enabled in bluez.
>>
>> bluetoothctl info MAC-OF-HEADPHONE says:
>>
>> UUID: Advanced Audio Distribu.. (0000110d-0000-1000-8000-00805f9b34fb)
>>
> (...)
> It seems you have all the profiles necessary, perhaps there is some
> interoperability problem, try checking bluetoothd and btmon logs.

I can´t believe, how quickly I now found the solution....
I did not have loaded the hidp module, after loading hidp the a2dp_sink
was available....
I don´t know, why hidp was not loaded automatically, but now I know it
is needed to get a2dp working. Maybe many others with the same issue
just need hidp to load...

best regards
Malte
