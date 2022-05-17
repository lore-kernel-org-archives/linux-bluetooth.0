Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14DAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 May 2022 21:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiEQV3m (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 May 2022 17:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiEQV3l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 May 2022 17:29:41 -0400
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 May 2022 14:29:39 PDT
Received: from nmtao201.oxsus-vadesecure.net (mta-201a.oxsus-vadesecure.net [51.81.229.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FF151E55
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 May 2022 14:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; bh=Vjo3Yw0FgcE6G1TF8DPJ8lZRhmH/FZWFwMVGl6
 Ulef0=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1652822677;
 x=1653427477; b=JxbN600ZsUCFm5vVVRYp7oCV1KpntPP7nbasp+YP693/9et+IWhJoVP
 h5hhoMFiuXzuaG8ah1plSoVRIrhb6C/pXzDFXX/5I0UKTKl/QX1rswmISZoHwVYh/aWB/af
 XYT/XGKmmpF5+tz5Bc4d9xWaB004+G1XEE5czn01WxIBLRNyw0XiN9IB+pLQlKgX2TzRvww
 5He3T6IQSSlAIku5b9McJ6mrgOv67IPccLKAtFwwxWM4QUUd82PhjV8BqHSkM5TSVluVr+Z
 9pcBwsFhX5dSHwhcPND+yAEzHlovMoyPHTWyUAWEWWHSwn34ta9+Ya3FylhgVHgnoz1ydlA
 f1w==
Received: from [192.168.1.152] ([104.185.76.86])
 by smtp.oxsus-vadesecure.net ESMTP oxsus2nmtao01p with ngmta
 id 80eda1ad-16f00177ca0807e1; Tue, 17 May 2022 21:24:37 +0000
Message-ID: <db5b5136-25c9-c334-e5bd-725bcbcc89a2@mindspring.com>
Date:   Tue, 17 May 2022 17:24:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
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
 <5a1c1826-92a9-f949-9f40-473416ab82b9@mindspring.com>
In-Reply-To: <5a1c1826-92a9-f949-9f40-473416ab82b9@mindspring.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: oxsus-vadesecure.net;
 auth=pass smtp.auth=beroset@mindspring.com smtp.mailfrom=beroset@mindspring.com;
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 3/2/22 10:33, Ed Beroset wrote:
> On 3/1/22 11:01, Ed Beroset wrote:
>> On 3/1/22 10:43, Sonny Sasaka wrote:
>>> Hi Ed,
>>>
>>> What I do is call `gatt.select-attribute` on the characteristic called
>>> "Battery Level", but it is not shown in your case. So maybe this is
>>> the bug that you are encountering. What is the exact version of your
>>> BlueZ (commit sha if possible)? Could you also try tip of tree to see
>>> if this is already fixed?
>>
>> Hi Sonny,
>>
>> I'm sorry, I should have noted that this is with the tip of tree, 
>> commit bf09e1f048.  Thanks for your help with this!
> 
> I am trying this from a different computer today and I find that now the 
> Battery Service and Battery Level characteristic are showing up, even on 
> the same devices I was reading the other day.  Not sure what's going on, 
> but I am investigating further.  At the moment, it seems more likely 
> that the problem is either with my devices or with my software.  I just 
> wanted to report back to avoid having you all waste your time.  When I 
> figure this out, I'll send another update.  Thanks for the help so far.

OK, it's been a while, but the problem was eventually tracked not to 
BlueZ but a Qt component I was using.  Essentially, changes in BlueZ 
were being tracked by changes in Qt, but there was a problem with the Qt 
implementation starting with BlueZ version 5.55.  No change required in 
BlueZ, and already fixed in Qt, but I thought I'd circle back around and 
let you all know the resolution.

https://bugreports.qt.io/browse/QTBUG-70222

Ed
