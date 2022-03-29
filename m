Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4418BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Mar 2022 08:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbiC2ID2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Mar 2022 04:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiC2ID1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Mar 2022 04:03:27 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0BD1EC69
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 01:01:44 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nZ6nM-0003wL-PP; Tue, 29 Mar 2022 10:01:41 +0200
Message-ID: <e2c9b59e-2b0f-8eab-def7-bc736b0ecce5@leemhuis.info>
Date:   Tue, 29 Mar 2022 10:01:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Bug 215725] New: Basilisk X Hyperspeed Bluetooth LE mouse fail
 to connect under 5.17 with Opcode 0x2043 failure
Content-Language: en-US
References: <bug-215725-62941@https.bugzilla.kernel.org/>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        linux-bluetooth@vger.kernel.org, bugzilla-daemon@kernel.org
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
In-Reply-To: <bug-215725-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1648540905;734e64e1;
X-HE-SMSGID: 1nZ6nM-0003wL-PP
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

On 22.03.22 14:38, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=215725
> 
>             Bug ID: 215725
>            Summary: Basilisk X Hyperspeed Bluetooth LE mouse fail to
>                     connect under 5.17 with Opcode 0x2043 failure

Hey bluetooth maintainers, what's up here? That's a report about a
regression that was submitted more than a week ago. Has anything
happened to get it fixed? Reminder: this ideally should be fixed in
5.17.y before 5.16.y becomes EOL, which I guess will happen in round
about two or three weeks from now.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.


