Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9029C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Nov 2022 20:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiKAU1Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Nov 2022 16:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKAU1D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Nov 2022 16:27:03 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6542BD2
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 13:27:02 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id BACBC81E72;
        Tue,  1 Nov 2022 21:27:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1667334421;
        bh=5fTp7OzwYVZG6MD/wr502JQXy32M5jP6ub+x/dxy/u4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CVZDx+R/QKNgFyidTX2JF98tF6JOxjH5vBadMb9tTT2GERDG5Fgad60i1iQKk3m5L
         UHNZqt4GrJpkFzvc9kzuR042CAqzRJKr9TfXYDQae40e35QYG7BctUKQsgfaG5Fq6s
         gMVBQxaFSyjOt/Ll251HLr3lTsbK7dNwguiFPEDOH2tpllUdvOTix+PpgW7NRGJXOf
         k6b9/1pljlkf6CQ4G05ckrkQ9U1CkDWjtO3PAN+48LIfT1f6kkT4zRUrUnub6xEuDN
         r1cM1ysev+j9YdD6zmucYzG7Mu3cxNkGjk9LbDc880oJDPPS4QlOxlHEguH4MOip1g
         1XkFh0AoaLGqQ==
Message-ID: <a347544a-ff06-5f62-0ac1-27ff7a70b6bd@denx.de>
Date:   Tue, 1 Nov 2022 21:27:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [BlueZ] tools: Make hciattach_* firmware path build-time
 configurable
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
References: <20221101115333.18223-1-marex@denx.de>
 <63612127.4a0a0220.ee3ae.be5c@mx.google.com>
 <1f4bcb64-9402-3975-960a-fc1c1f7cebe4@denx.de>
 <CABBYNZLQKEJZc_bDNOEqVHqZNv8pOnCxEAQBT68i693t87Ur_A@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CABBYNZLQKEJZc_bDNOEqVHqZNv8pOnCxEAQBT68i693t87Ur_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 11/1/22 20:24, Luiz Augusto von Dentz wrote:
> Hi Marek,
> 
> On Tue, Nov 1, 2022 at 8:45 AM Marek Vasut <marex@denx.de> wrote:
>>
>> On 11/1/22 14:37, bluez.test.bot@gmail.com wrote:
>>> This is automated email and please do not reply to this email!
>>>
>>> Dear submitter,
>>>
>>> Thank you for submitting the patches to the linux bluetooth mailing list.
>>> This is a CI test results with your patch series:
>>> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690839
>>>
>>> ---Test result---
>>>
>>> Test Summary:
>>> CheckPatch                    PASS      1.01 seconds
>>> GitLint                       PASS      0.86 seconds
>>> Prep - Setup ELL              PASS      26.44 seconds
>>> Build - Prep                  PASS      0.68 seconds
>>> Build - Configure             PASS      8.16 seconds
>>> Build - Make                  PASS      723.76 seconds
>>> Make Check                    PASS      10.90 seconds
>>> Make Check w/Valgrind         PASS      287.82 seconds
>>> Make Distcheck                PASS      233.70 seconds
>>> Build w/ext ELL - Configure   PASS      8.17 seconds
>>> Build w/ext ELL - Make        PASS      83.94 seconds
>>> Incremental Build w/ patches  PASS      0.00 seconds
>>> Scan Build                    WARNING   476.19 seconds
>>>
>>> Details
>>> ##############################
>>> Test: Scan Build - WARNING
>>> Desc: Run Scan Build with patches
>>> Output:
>>> *****************************************************************************
>>> The bugs reported by the scan-build may or may not be caused by your patches.
>>> Please check the list and fix the bugs if they are caused by your patch.
>>> *****************************************************************************
>>> tools/hciattach_qualcomm.c:218:8: warning: Although the value stored to 'n' is used in the enclosing expression, the value is never actually read from 'n'
>>>                   if ((n = read_hci_event(fd, resp, 100)) < 0) {
>>>                        ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> tools/hciattach_qualcomm.c:253:8: warning: Although the value stored to 'n' is used in the enclosing expression, the value is never actually read from 'n'
>>>                   if ((n = read_hci_event(fd, resp, 100)) < 0) {
>>>                        ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> 2 warnings generated.
>>
>> That's unlikely caused by this patch.
> 
> Yep, the scan-build rebuilds the file you have changed so any problem
> it finds in that file will be reported, anyway I can ignore the
> warnings but patches to fix these warnings are welcome as well.

Done
