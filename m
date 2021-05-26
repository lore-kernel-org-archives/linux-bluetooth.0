Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF4CC47088
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 15:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0E39613CA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 15:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbhEZPCg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 May 2021 11:02:36 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:53311 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbhEZPCf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 May 2021 11:02:35 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 030E9CED1B;
        Wed, 26 May 2021 17:08:57 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: BT Intel: Regression loading firmware in linux-5.13-rc3
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZLYsM_LgKU8r0BRGp3hAk8m2OQWxnwtGz8VwidGCHRB-A@mail.gmail.com>
Date:   Wed, 26 May 2021 17:01:02 +0200
Cc:     Chris Clayton <chris2553@googlemail.com>,
        "K, Kiran" <kiran.k@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <F70C22C4-8E2D-4C98-8AF9-0C12A06BFC85@holtmann.org>
References: <81eddb07-f346-c12a-345b-d929fd2edb10@googlemail.com>
 <DM8PR11MB5573280FAB275DCEE789D389F5259@DM8PR11MB5573.namprd11.prod.outlook.com>
 <52914cbc-4004-8389-fa7b-6b42cf8f85e1@googlemail.com>
 <CABBYNZKtApu7Q4kU+msfLco-ihDrx5kWiugDRT0ic3_Tb1YSGg@mail.gmail.com>
 <d97da5b6-a337-3550-ace3-e6789fd9165f@googlemail.com>
 <CABBYNZLYsM_LgKU8r0BRGp3hAk8m2OQWxnwtGz8VwidGCHRB-A@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>>> Thanks for your reply, Kiran.
>>>> 
>>>> Does the phrase "next release" mean linux-5.13-rc4 or the next release of linux-firmware?  I just want to know what to
>>>> look out for.
>>>> 
>>>> Thanks
>>>> 
>>>> Chris
>>>> 
>>>> 
>>>> On 25/05/2021 11:14, K, Kiran wrote:
>>>>> Hi Chris,
>>>>> 
>>>>> This is a known issue related to firmware and is expected to be fixed in next release.
>>>>> 
>>>>> Thanks,
>>>>> Kiran
>>>>> 
>>>>> 
>> <snip>
>>> 
>>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/drivers/bluetooth/btusb.c?id=183dce5a7fd3040ced6a220b0aa536c926f10cd9
>>> 
>>> That said we shall probably merge it to 5.13 before it is released.
>>> I think you should, otherwise, without patching, 5.13.0 will be broken for many bluetooth users.
>> 
>> I've applied your patch your patch to Linus' latest and greatest (by hand - it doesn't apply cleanly to the current 5.13
>> tree). The error messages are no longer produced and bluetooth is working fine, so...
>> 
>> Tested-by: Chris Clayton <chris2553@googlemail.com>
> 
> Shall I have another pull request, or do we need to send this directly
> to Linus somehow?

if this is not urgent, we can put it into bluetooth.git tree and ask net.git to pull it. However if we already have this in net-next, it gets a bit trickier.

Regards

Marcel

