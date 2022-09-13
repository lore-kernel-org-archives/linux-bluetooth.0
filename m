Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8A2ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Sep 2022 16:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiIMQmt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Sep 2022 12:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiIMQm1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Sep 2022 12:42:27 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5F5BB022
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 08:36:58 -0700 (PDT)
Received: from [185.122.133.20] (helo=[172.16.40.43]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oY7UJ-0003Pb-Jo; Tue, 13 Sep 2022 17:06:11 +0200
Message-ID: <e7c8127a-d561-3a3d-f208-770f3abbee17@leemhuis.info>
Date:   Tue, 13 Sep 2022 16:06:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US, de-DE
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Peter Sutton <peter@foxdogstudios.com>
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev
References: <CAD+dNTsbuU4w+Y_P7o+VEN7BYCAbZuwZx2+tH+OTzCdcZF82YA@mail.gmail.com>
 <24e95c8b-dc05-0d00-50bb-58b71c5baf94@molgen.mpg.de>
 <CAD+dNTuRThoa2OSzQ27tENB29GJ4oD0j3D+P4k42HzopEeTJMw@mail.gmail.com>
 <CAD+dNTsqBEjzG7BinKtxveH9faJqss89WPufbSsaB5FZRDgOPA@mail.gmail.com>
 <ef7a1421-06c5-f3b7-8c7f-7fdfd7862c96@molgen.mpg.de>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [Bug] [Deadlock] Kernel thread deadlock in rfcomm socket release
 when connect interrupted
In-Reply-To: <ef7a1421-06c5-f3b7-8c7f-7fdfd7862c96@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1663083419;7ef54709;
X-HE-SMSGID: 1oY7UJ-0003Pb-Jo
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 12.09.22 07:23, Paul Menzel wrote:
> [Cc: +regressions]
> 
> #regzbot ^introduced: b7ce436a5d798bc59e71797952566608a4b4626b

thx for this

> #regzbot title: [Bug] [Deadlock] Kernel thread deadlock in rfcomm socket
> release when connect interrupted

BTW & JFYI: regzbot will automatically use the mail's subject as title
by default, so it seems in this case that "#regzbot title:" is superfluous.

> Am 11.09.22 um 17:42 schrieb Peter Sutton:
>> Just following this up. Is there anything I can do to help fix this?
>> Running a custom kernel is a real pain. I've been running with the
>> commit revert and upgrading with Arch Linux kernel releases with no
>> issue.
> 
> (Please do not top post.)
> 
> Have you tested bluetooth-next already? Regardless, the offending commit
> present in Linux since 5.15-rc1 should be reverted.

Well, I'd be a bit more careful here, as reverting commits after so much
time easily can cause other regressions.

>> On Mon, 30 May 2022 at 12:44, Peter Sutton <peter@foxdogstudios.com>
>> wrote:
>>>
>>> Commit b7ce436a5d798bc59e71797952566608a4b4626b is the probable cause.
>>> I compiled a custom Arch Linux kernel package [1] and the bug was
>>> present. Reverting the commit fixed the bug. Below is the reply I was
>>> writing before Matt found the suspect commit and I tested with the
>>> custom kernel.

Anyway, the main reason why I write this: I'm currently traveling and
only took a very quick look into this, but a fix for a deadlock for
RFCOMM sk state change was posted last year already:

https://lore.kernel.org/all/20211004180734.434511-1-desmondcheongzx@gmail.com/

It seems it never went anywhere, unless I'm missing something. Is that
maybe the same problem or somehow related?

>>>> What hardware is that?
>>>
>>> $ dmesg | grep iwlwifi
>>> Me: Intel(R) Dual Band Wireless AC 8260, REV=0x204
>>> Matt: Intel(R) Dual Band Wireless AC 8265, REV=0x230
>>>
>>> We both get:
>>>
>>> $ lsusb | grep Bluetooth
>>> Me & Matt: Bus 001 Device 006: ID 8087:0a2b Intel Corp. Bluetooth
>>> wireless interface
>>>
>>>> As a lot of patches are also applied to the stable series, do you know,
>>>> if this is a regression? Does it work with Linux 5.15(.0) or 5.10?
>>>
>>> Bug is present on current Arch Linux LTS kernel:
>>>
>>> $ uname -a
>>> Linux taffer 5.15.43-1-lts #1 SMP Wed, 25 May 2022 14:08:34 +0000
>>> x86_64 GNU/Linux
>>>
>>> Matt tested on 5.10.115 and the bug is not present. So I guess it's a
>>> regression. Anecdotally, we encountered this behaviour 1 yr ago
>>> (difficult to say exactly), then it went away but came back about 1 or
>>> 2 months ago. All of this is on Arch Linux, I update about once a
>>> week.
>>>
>>> [1] https://wiki.archlinux.org/title/Kernel/Arch_Build_System

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
