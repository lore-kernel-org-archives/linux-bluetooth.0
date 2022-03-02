Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07794C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 15:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiCBPjA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 10:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiCBPi7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 10:38:59 -0500
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Mar 2022 07:38:16 PST
Received: from nmtao201.oxsus-vadesecure.net (mta-201a.oxsus-vadesecure.net [51.81.229.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5B44AE00
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Mar 2022 07:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; bh=v9xFj4pe2qkHz18VdGBTLttK5FfhA6qT3un4QL
 ByXTE=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1646235194;
 x=1646839994; b=He3ebTWZfWKNj0kUj69HX5FtCsJtjn/2cnwYNhUxIbRfIyviM155+1x
 dT3T3jWUiQsUVVcmjcwfKEXiKeCyFZJt5GMPrwQHf5uWQeu4/JujL4JVEGS6InrWCDH5kh7
 0zXJ4HF4BgdYHAejp0tFY0vExgMVf7MmmfWu9hgj43LW+oyFRioU0Es3ek5zHaCsbyoU+Wf
 HEkop8BydXNBUKqF0pnifDTwzHCS7H+wRSZyqo/+Yqj5whEPd9oCpVrUgARH2mql5I8I7Tj
 c5IQ2fyHxegyMQyWvauI67oLEu40ojxBu8VhZuXh7R5FFp/v07zal2DU555nD6XFHe0I2sM
 YHg==
Received: from [192.168.1.152] ([104.185.76.86])
 by smtp.oxsus-vadesecure.net ESMTP oxsus2nmtao01p with ngmta
 id eb1f8b1b-16d89a2fce79077e; Wed, 02 Mar 2022 15:33:14 +0000
Message-ID: <5a1c1826-92a9-f949-9f40-473416ab82b9@mindspring.com>
Date:   Wed, 2 Mar 2022 10:33:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Battery1 vs. GATT reporting
Content-Language: en-US
From:   Ed Beroset <beroset@mindspring.com>
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
References: <f46af838-8b28-79e6-5298-4458b44664ca@mindspring.com>
 <CAO271m=RNShfq+zRQjX=yK8NkUDwknr0mekJsCg_Rny3s0gUgA@mail.gmail.com>
 <72122fe6-8c8b-d26e-9c1d-75462052b503@mindspring.com>
 <CAO271m=-nxu238MKCtM-Kc1T88UOO4V2qyon0zF3ifVcThBsPA@mail.gmail.com>
 <307e7ee7-b973-4d15-03fd-31cc6087163b@mindspring.com>
In-Reply-To: <307e7ee7-b973-4d15-03fd-31cc6087163b@mindspring.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 3/1/22 11:01, Ed Beroset wrote:
> On 3/1/22 10:43, Sonny Sasaka wrote:
>> Hi Ed,
>>
>> What I do is call `gatt.select-attribute` on the characteristic called
>> "Battery Level", but it is not shown in your case. So maybe this is
>> the bug that you are encountering. What is the exact version of your
>> BlueZ (commit sha if possible)? Could you also try tip of tree to see
>> if this is already fixed?
> 
> Hi Sonny,
> 
> I'm sorry, I should have noted that this is with the tip of tree, commit 
> bf09e1f048.  Thanks for your help with this!

I am trying this from a different computer today and I find that now the 
Battery Service and Battery Level characteristic are showing up, even on 
the same devices I was reading the other day.  Not sure what's going on, 
but I am investigating further.  At the moment, it seems more likely 
that the problem is either with my devices or with my software.  I just 
wanted to report back to avoid having you all waste your time.  When I 
figure this out, I'll send another update.  Thanks for the help so far.

Ed
