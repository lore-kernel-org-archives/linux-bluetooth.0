Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D58EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 04:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjGMEB2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 00:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjGMEB1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 00:01:27 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3339F1BE3
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 21:01:24 -0700 (PDT)
Received: from [192.168.0.185] (ip5f5ae840.dynamic.kabel-deutschland.de [95.90.232.64])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7D40861E5FE01;
        Thu, 13 Jul 2023 06:00:09 +0200 (CEST)
Message-ID: <552a361b-d699-5d96-543a-e3aa09e6c05c@molgen.mpg.de>
Date:   Thu, 13 Jul 2023 06:00:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: bluetooth broken in Intel Macbook 2014
Content-Language: en-US
To:     John Holland <johnbholland@icloud.com>,
        =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@nordicsemi.no>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
References: <370f0784-05c2-a36d-bfe8-f5159aeb8729@icloud.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <370f0784-05c2-a36d-bfe8-f5159aeb8729@icloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

[Fix email address, Cc: +regressions@lists.linux.dev, regzbot commands]

#regzbot ^introduced: c13380a55522bf14e54779a142487c224509db95
#regzot monitor: https://bugzilla.kernel.org/show_bug.cgi?id=217651

Am 13.07.23 um 01:08 schrieb John Holland:
> Hello,
> 
> I've had my first attempt at kernel development in trying to fix a 
> problem with newer kernels and the bluetooth in my Macbook Pro (2014 
> vintage). I did the bisecting and found that the commit below seems to 
> be the culprit.
> 
> 
> commit c13380a55522bf14e54779a142487c224509db95
> Author: Tomasz Moń <tomasz.mon@nordicsemi.no>
> Date:   Tue Feb 7 12:57:41 2023 +0100
> 
>     Bluetooth: btusb: Do not require hardcoded interface numbers
> ......
> 
> Reverting this change in both 6.3 and 6.5 restores my ability to use the 
> Bluetooth in this Mac. I created a bug in bugzilla for it.
> 
> 
> This is new to me, I'm a retired application developer. I hope this is 
> close enough to the correct process. Thanks,
> 
> John Holland
> 
> 
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=217651
