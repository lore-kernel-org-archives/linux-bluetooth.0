Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D59DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Mar 2022 05:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355405AbiCYF7o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Mar 2022 01:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244003AbiCYF7o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Mar 2022 01:59:44 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8F95FC8
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Mar 2022 22:58:08 -0700 (PDT)
Received: from [192.168.0.3] (ip5f5aef76.dynamic.kabel-deutschland.de [95.90.239.118])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id B45A961E64846;
        Fri, 25 Mar 2022 06:58:05 +0100 (CET)
Message-ID: <9dcd9cae-ee36-c812-f725-c81a035e4456@molgen.mpg.de>
Date:   Fri, 25 Mar 2022 06:58:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] obexd: Fix can't receive small files sent by windows
Content-Language: en-US
To:     Xinpeng Wang <wangxinpeng@uniontech.com>
Cc:     linux-bluetooth@vger.kernel.org
References: <20220323052149.28674-1-wangxinpeng@uniontech.com>
 <8ff37c48-4e71-1c40-53bb-5bb99d7a1a88@molgen.mpg.de>
 <2022032321151404413716@uniontech.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <2022032321151404413716@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Xinpeng,


Am 23.03.22 um 14:15 schrieb wangxinpeng@uniontech.com:

> Thank you very much for your guidance.

Thank you for the patch, and your response. Sorry for the late reply.

> Modifications to the patch, I will pay attention to replace it with `--reroll-count`
> in the future, thanks a lot.

Awesome.

> A Windows device refers to a computer with the Windows 10 system installed.
> 
> Ways to reproduce the problem:
> 1.Use the laptop with the windows 10 system installed to send small files to the computer
> with the ubuntu system through bluetooth
> (I found that sometimes sending fails during testing,then i installed a blueman on ubuntu,
> use blueman to connect to the windows computer first);
> 2.the small file's size is less than 10k.
> After sending ok, it will be found that the file is in the ~/.cache/obexd/ directory, but not transferred to
> the ~/Download directory. For large files, it is in the ~/Download directory after sending.
> 
> Validation bug fix:
> This problem needs to be done by bluez and the upper management program (like blueman);
> the full effect cannot be seen until the upper management program is modified.
> Now use dbus-monitor --session path=/org/bluez/obex/server/session1/transfer0
> (this command is the first time the file is received at startup, and the number will be incremented each time after that)
>   to see whether obexd generates the correct signal(include Filename).

Thank you for the detailed response. I do currently not have a Microsoft 
Windows system to test this, but sounds good.

Personally, I would like to hive this information in the commit message, 
but I d not know the policy of the project. If you are up to it, you 
could amend the commit message, and reroll it.

Thank you for your work.


Kind regards,

Paul
