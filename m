Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01C1C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Feb 2021 13:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E46464E0B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Feb 2021 13:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhBENa4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Feb 2021 08:30:56 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59746 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhBEN2h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Feb 2021 08:28:37 -0500
Received: from [123.112.66.2] (helo=[192.168.0.103])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <hui.wang@canonical.com>)
        id 1l818T-0001op-RB; Fri, 05 Feb 2021 13:26:58 +0000
Subject: Re: [PATCH] Bluetooth: btusb: Add a parameter to load fw forcibly for
 Intel BT
From:   Hui Wang <hui.wang@canonical.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
References: <20201130052753.111742-1-hui.wang@canonical.com>
 <116CA1BC-A38E-4622-99D7-91C7DF6EA463@holtmann.org>
 <efdddc31-bf46-42e6-8edd-710835ed3f4b@canonical.com>
Message-ID: <10c5e78c-3f07-2891-cbeb-7130ec5d7895@canonical.com>
Date:   Fri, 5 Feb 2021 21:26:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <efdddc31-bf46-42e6-8edd-710835ed3f4b@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



>>>
>>>     /* controller is already having an operational firmware */
>>> -    if (ver.fw_variant == 0x23)
>>> +    if (ver.fw_variant == 0x23) {
>>> +        if (force_load_fw) {
>>> +            btintel_reset_to_bootloader(hdev);
>>> +            force_load_fw = false;
>>> +            return -EAGAIN;
>>> +        }
>>> +        bt_dev_info(hdev, "already in operational mode, not load 
>>> fw. Set force_load_fw=1 to load fw forcibly");
>>>         goto finish;
>>> +    }
>> I don’t like this approach. I rather do this in a more generic way 
>> that resets the controller and puts it into boot loader support if 
>> support. We can use the experimental mgmt setting for this.
> OK, got it, will investigate it. Thanks.

Hi Marcel,

Do you mean use experimental features in the mgmt? Recently I read the 
mgmt exp_features related code, looks like the userspace tool btmgmt 
only supports 2 commands so far, they are expinfo and exp-debug, it 
looks like expinfo read some info from kernel, exp-debug set one bool 
value to kernel, but exp-debug sends the hard-coded uuid to kernel, my 
understanding is this could only set FEATURE_DEBUG. If i add a new 
feature like reset_controller_to_bootloader, I can't call it through 
expinfo or exp-debug.

And the kernel commit (cbbdfa6f3319 Bluetooth: Enable controller RPA 
resolution using Experimental feature) add a new feature, how to set 
this feature via expinfo and exp-debug or some userspace tool?

Thanks,

Hui.

>>
>> Regards
>>
>> Marcel
>>
