Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B477C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 09:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 552A861284
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 09:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbhKQJpv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbhKQJpv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Nov 2021 04:45:51 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596F6C061570;
        Wed, 17 Nov 2021 01:42:53 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mnHSp-00058a-L8; Wed, 17 Nov 2021 10:42:47 +0100
Message-ID: <8919a36b-e485-500a-2722-529ffa0d2598@leemhuis.info>
Date:   Wed, 17 Nov 2021 10:42:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
Content-Language: en-BS
To:     Aditya Garg <gargaditya08@live.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Orlando Chamberlain <redecorating@protonmail.com>,
        Daniel Winkler <danielwinkler@google.com>,
        Johan Hedberg <johan.hedberg@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Sonny Sasaka <sonnysasaka@chromium.org>
References: <20211001083412.3078-1-redecorating@protonmail.com>
 <CABBYNZLjSfcG_KqTEbL6NOSvHhA5-b1t_S=3FQP4=GwW21kuzg@mail.gmail.com>
 <972034A8-4B22-4FEE-9B37-C0A7C7ADD60C@live.com> <YYZr14zwHnd52rQ7@kroah.com>
 <829A2DF8-818E-4AF1-84F9-49B5822F9146@live.com> <YYePw07y2DzEPSBR@kroah.com>
 <70a875d0-7162-d149-dbc1-c2f5e1a8e701@leemhuis.info>
 <20211116090128.17546-1-redecorating@protonmail.com>
 <e75bf933-9b93-89d2-d73f-f85af65093c8@leemhuis.info>
 <3B8E16FA-97BF-40E5-9149-BBC3E2A245FE@live.com> <YZSuWHB6YCtGclLs@kroah.com>
 <52DEDC31-EEB2-4F39-905F-D5E3F2BBD6C0@live.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <52DEDC31-EEB2-4F39-905F-D5E3F2BBD6C0@live.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1637142173;218bf6f5;
X-HE-SMSGID: 1mnHSp-00058a-L8
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 17.11.21 10:26, Aditya Garg wrote:
>> On 17-Nov-2021, at 12:55 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> On Wed, Nov 17, 2021 at 03:28:29AM +0000, Aditya Garg wrote:
>>>> On 16-Nov-2021, at 2:56 PM, Thorsten Leemhuis <regressions@leemhuis.info> wrote:
>>>> On 16.11.21 10:02, Orlando Chamberlain wrote:
>>>>>> Bluetooth maintainers, what's the status here? The proposed patch is
>>>>>> fixing a regression. It's not a recent one (it afaics was introduced in
>>>>>> v5.11-rc1). Nevertheless it would be good to get this finally resolved.
>>>>>> But this thread seems inactive for more than a week now. Or was progress
>>>>>> made, but is only visible somewhere else?
>>>>>
>>>>> I think the best solution is getting broadcom to update their firmware,
>>>>> I've just sent them a message through a form on their website, I couldn't
>>>>> seem to get it to tell me "Your message has been sent", so it's possible
>>>>> that it didn't submit (more likely I've sent the same message several times).
>>>>>
>>>>> If I hear back from them I'll send something here.
>>>>
>>>> Thx for that. But FWIW: from the point of the regression tracker that's
>>>> not the best solution, as according to your report this is a regression.
>>>> IOW: we deal with something that used to up to a certain kernel version
>>>> and was broken by a change to the kernel. That is something frown upon
>>>> in Linux kernel development, hence changes introducing regression are
>>>> often quickly reverted, if they can't get fixed by follow up change quickly.
>>>>
>>>> That sentence has two "quickly", as we want to prevent more people
>>>> running into the issue, resulting in a loss of trust. But that's what
>>>> will happen if we wait for a firmware update to get developed, tested,
>>>> published, and rolled out. And even then we can't expect users to have
>>>> the latest firmware installed when they switch to a new kernel.
>>>>
>>>> Hence the best solution *afaics* might be: fix this in the kernel
>>>> somehow now with a workaround; once the firmware update is out, change
>>>> the kernel again to only apply the workaround if the old firmware is in use.
>>> I have an idea. Can we make LE Read Transmit Power as a module parameter and users can turn it off if it is causing trouble. I have a patch for the same but haven't tested it yet.
>>
>> Module parameters are for the 1990's, please never add new ones as they
>> modify code, not data, and you want to do something like this on a
>> per-device basis, not on "all devices in the system", right?
>
> Exactly. Since the issue affects only a few Macs and not all devices.
> In fact I have spotted just 2 Macs yet affected with this issue.
When Greg said "per-device basis", he afaics meant: per-device in a
system, as a module parameter would also affect a second bluetooth
controller if there was one (say one connected via USB) -- and that
shouldn't happen.

And FWIW: it's still a regression if something that used to work
suddenly requires a module parameter to get working.

So if this just affects two macs, why can't the fix be realized as a
quirk that is only enabled on those two systems? Or are they impossible
to detect clearly via DMI data or something like that?

Ciao, Thorsten
