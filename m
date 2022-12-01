Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D42C43217
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Dec 2022 14:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiLAOlL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 09:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiLAOlK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 09:41:10 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0ED5A897B
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 06:41:07 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p0kkL-0006Jb-Px; Thu, 01 Dec 2022 15:41:05 +0100
Message-ID: <726685b5-5533-4279-c38a-b8b9cde2f705@leemhuis.info>
Date:   Thu, 1 Dec 2022 15:41:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [Regression] Cambridge Silicon Radio, Ltd Bluetooth Dongle
 unusable again with kernel 6.0 #forregzbot
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     linux-bluetooth@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <RJ4W7HKW.X5Y4H63W.RFY63IY6@7AFBARQQ.HKEIB7DO.6ME2HPJY>
 <818a55d5-ea65-a962-d83d-0186bd666c2d@leemhuis.info>
In-Reply-To: <818a55d5-ea65-a962-d83d-0186bd666c2d@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1669905667;4f0b737b;
X-HE-SMSGID: 1p0kkL-0006Jb-Px
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 26.10.22 11:17, Thorsten Leemhuis wrote:
> [Note: this mail is primarily send for documentation purposes and/or for
> regzbot, my Linux kernel regression tracking bot. That's why I removed
> most or all folks from the list of recipients, but left any that looked
> like a mailing lists. These mails usually contain '#forregzbot' in the
> subject, to make them easy to spot and filter out.]

> Hi, this is your Linux kernel regression tracker.
> 
> On 24.10.22 23:11, Jack wrote:
>> Cheap USB BT dongles that are bad clones of CSR  "ID 0a12:0001 Cambridge
>> Silicon Radio, Ltd Bluetooth Dongle (HCI mode)" have had historic
>> problems, due to various bad behaviors.  See [Bug 60824]
>> [PATCH][regression] Cambridge Silicon Radio, Ltd Bluetooth Dongle
>> unusable (https://bugzilla.kernel.org/show_bug.cgi) for more details and
>> background.  The patch in that bug was initially mainlined in 5.9, and
>> underwent several revisions since then.  It has continued to work
>> through all of the 5.19 series, but it does not work with any of the 6.0
>> kernels.
>> [...]
> 
> Thanks for the report. To be sure below issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced 766ae2422b4312
> #regzbot title net: bluetooth: Cambridge Silicon Radio, Ltd Bluetooth
> Dongle unusable again with kernel 6.0
> #regzbot ignore-activity

#regzbot inconclusive: some of this was fixed, some might still needs
fixing, but it'S tricky; the bluetooth people are working on it afaics

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
