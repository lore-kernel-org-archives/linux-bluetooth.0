Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9010ECAAD5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Sep 2022 06:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiILGii (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Sep 2022 02:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiILGih (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Sep 2022 02:38:37 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDB11C914
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Sep 2022 23:38:35 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5ae91f.dynamic.kabel-deutschland.de [95.90.233.31])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0062E61EA1932;
        Mon, 12 Sep 2022 08:23:28 +0200 (CEST)
Message-ID: <ef7a1421-06c5-f3b7-8c7f-7fdfd7862c96@molgen.mpg.de>
Date:   Mon, 12 Sep 2022 08:23:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [Bug] [Deadlock] Kernel thread deadlock in rfcomm socket release
 when connect interrupted
Content-Language: en-US
To:     Peter Sutton <peter@foxdogstudios.com>
References: <CAD+dNTsbuU4w+Y_P7o+VEN7BYCAbZuwZx2+tH+OTzCdcZF82YA@mail.gmail.com>
 <24e95c8b-dc05-0d00-50bb-58b71c5baf94@molgen.mpg.de>
 <CAD+dNTuRThoa2OSzQ27tENB29GJ4oD0j3D+P4k42HzopEeTJMw@mail.gmail.com>
 <CAD+dNTsqBEjzG7BinKtxveH9faJqss89WPufbSsaB5FZRDgOPA@mail.gmail.com>
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAD+dNTsqBEjzG7BinKtxveH9faJqss89WPufbSsaB5FZRDgOPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

[Cc: +regressions]

#regzbot ^introduced: b7ce436a5d798bc59e71797952566608a4b4626b
#regzbot title: [Bug] [Deadlock] Kernel thread deadlock in rfcomm socket 
release when connect interrupted

Dear Pete,


Am 11.09.22 um 17:42 schrieb Peter Sutton:
> Just following this up. Is there anything I can do to help fix this?
> Running a custom kernel is a real pain. I've been running with the
> commit revert and upgrading with Arch Linux kernel releases with no
> issue.

(Please do not top post.)

Have you tested bluetooth-next already? Regardless, the offending commit 
present in Linux since 5.15-rc1 should be reverted.


Kind regards,

Paul


> On Mon, 30 May 2022 at 12:44, Peter Sutton <peter@foxdogstudios.com> wrote:
>>
>> Commit b7ce436a5d798bc59e71797952566608a4b4626b is the probable cause.
>> I compiled a custom Arch Linux kernel package [1] and the bug was
>> present. Reverting the commit fixed the bug. Below is the reply I was
>> writing before Matt found the suspect commit and I tested with the
>> custom kernel.
>>
>>> What hardware is that?
>>
>> $ dmesg | grep iwlwifi
>> Me: Intel(R) Dual Band Wireless AC 8260, REV=0x204
>> Matt: Intel(R) Dual Band Wireless AC 8265, REV=0x230
>>
>> We both get:
>>
>> $ lsusb | grep Bluetooth
>> Me & Matt: Bus 001 Device 006: ID 8087:0a2b Intel Corp. Bluetooth wireless interface
>>
>>> As a lot of patches are also applied to the stable series, do you know,
>>> if this is a regression? Does it work with Linux 5.15(.0) or 5.10?
>>
>> Bug is present on current Arch Linux LTS kernel:
>>
>> $ uname -a
>> Linux taffer 5.15.43-1-lts #1 SMP Wed, 25 May 2022 14:08:34 +0000 x86_64 GNU/Linux
>>
>> Matt tested on 5.10.115 and the bug is not present. So I guess it's a
>> regression. Anecdotally, we encountered this behaviour 1 yr ago
>> (difficult to say exactly), then it went away but came back about 1 or
>> 2 months ago. All of this is on Arch Linux, I update about once a
>> week.
>>
>> [1] https://wiki.archlinux.org/title/Kernel/Arch_Build_System
