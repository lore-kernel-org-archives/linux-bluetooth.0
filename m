Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F477C77B62
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Apr 2023 12:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbjDDMTv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Apr 2023 08:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbjDDMTY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Apr 2023 08:19:24 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379F73C1E
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Apr 2023 05:14:53 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pjfYo-0007I6-JD; Tue, 04 Apr 2023 14:14:50 +0200
Message-ID: <b06c1999-e6b9-877c-d51f-c3dac24746a2@leemhuis.info>
Date:   Tue, 4 Apr 2023 14:14:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [BUG] BLE device unpairing triggers kernel panic
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
References: <a1ce1743-e450-6cdb-dfab-56a3e3eb9aed@pengutronix.de>
 <CABBYNZ+z8kBUKGXbZSfb0ynJaTnPQRp0wFDUb12AW1ymbNx1eg@mail.gmail.com>
 <CABBYNZ+zsuggTpaUSPsZKeL=qqvM1=sgMWzdWEqaS_oh6dhY2g@mail.gmail.com>
 <8d5c4724-d511-39b1-21d7-116c91cada45@pengutronix.de>
 <b0cb4fb0-6b89-b9df-9ae6-421ac52b0100@pengutronix.de>
 <CABBYNZ+ubN2rc=zoN_53Pmp6kt3L5UcY3knbtjhhVOjPBpJv4Q@mail.gmail.com>
 <d5654901-6b1f-a1fa-0101-8b52b345af7b@pengutronix.de>
 <CABBYNZ+8dpPBqaQMr-Hz_DJRxT-0ucCjgAJH50FUaN7Sn9H6rA@mail.gmail.com>
 <1d1b76cf-df6f-3935-5cd2-c45ea78f2c33@pengutronix.de>
 <CABBYNZLdy-rndKczoG_WiWXQmacX+vzCbftQKvzJ3B6imtZopw@mail.gmail.com>
 <1a5ec80d-690f-285c-3da8-ccdaf5516d85@pengutronix.de>
 <CABBYNZJQKc9ozReXLeESWY8U648eQytKfGB4WmhZi4M+YOW7jw@mail.gmail.com>
 <b7b080ff-a5da-a10c-674b-c3bb653f0aeb@leemhuis.info>
 <577c7140-a30c-ca06-a81e-c791e44b1321@pengutronix.de>
 <12cafbc4-39a2-1bea-c1d1-2cad406c8b83@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <12cafbc4-39a2-1bea-c1d1-2cad406c8b83@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1680610493;53031b62;
X-HE-SMSGID: 1pjfYo-0007I6-JD
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 17.08.22 12:24, Thorsten Leemhuis wrote:
> On 07.07.22 07:45, Ahmad Fatoum wrote:
>> On 04.07.22 14:11, Thorsten Leemhuis wrote:
>>> Hi, this is your Linux kernel regression tracker. Top-posting for once,
>>> to make this easily accessible to everyone.
>>>
>>> Looks like the discussions to fix this regression got stuck. What can be
>>> done to get thing rolling again? Or has progress been made and I just
>>> missed it? Ciao, Thorsten
>>
>> No progress has been made as far as I am aware. I am reverting the commit
>> introducing the regression on my systems and haven't yet had the time to
>> debug this further to help find an alternative solution.
> 
> Just wondering: still no progress I assume?
> 
> Anyway: I'm putting it on the backburner to get it out of the
> spot-light, as this doesn't look urgent and things seems to progress
> very slowly.
> 
> #regzbot backburner: debuging is slow this further

Great, I see (from interpreting
https://lore.kernel.org/all/04377d2a-4d97-0345-18a1-1f18533436fe@pengutronix.de/
[thx!] and looking at the described errors) that this was finally addressed:

#regzbot fix: 2731e038a76d
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

