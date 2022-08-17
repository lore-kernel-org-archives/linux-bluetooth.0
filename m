Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E7FC32773
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Aug 2022 10:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238983AbiHQKZC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Aug 2022 06:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238982AbiHQKZB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Aug 2022 06:25:01 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4779A5A3E9
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Aug 2022 03:25:00 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oOGEM-0007dz-3X; Wed, 17 Aug 2022 12:24:58 +0200
Message-ID: <12cafbc4-39a2-1bea-c1d1-2cad406c8b83@leemhuis.info>
Date:   Wed, 17 Aug 2022 12:24:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [BUG] BLE device unpairing triggers kernel panic
Content-Language: en-US
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
References: <a1ce1743-e450-6cdb-dfab-56a3e3eb9aed@pengutronix.de>
 <CABBYNZ+z8kBUKGXbZSfb0ynJaTnPQRp0wFDUb12AW1ymbNx1eg@mail.gmail.com>
 <CABBYNZ+zsuggTpaUSPsZKeL=qqvM1=sgMWzdWEqaS_oh6dhY2g@mail.gmail.com>
 <8d5c4724-d511-39b1-21d7-116c91cada45@pengutronix.de>
 <b0cb4fb0-6b89-b9df-9ae6-421ac52b0100@pengutronix.de>
 <CABBYNZ+ubN2rc=zoN_53Pmp6kt3L5UcY3knbtjhhVOjPBpJv4Q@mail.gmail.com>
 <d5654901-6b1f-a1fa-0101-8b52b345af7b@pengutronix.de>
 <CABBYNZ+8dpPBqaQMr-Hz_DJRxT-0ucCjgAJH50FUaN7Sn9H6rA@mail.gmail.com>
 <1d1b76cf-df6f-3935-5cd2-c45ea78f2c33@pengutronix.de>
 <CABBYNZLdy-rndKczoG_WiWXQmacX+vzCbftQKvzJ3B6imtZopw@mail.gmail.com>
 <1a5ec80d-690f-285c-3da8-ccdaf5516d85@pengutronix.de>
 <CABBYNZJQKc9ozReXLeESWY8U648eQytKfGB4WmhZi4M+YOW7jw@mail.gmail.com>
 <b7b080ff-a5da-a10c-674b-c3bb653f0aeb@leemhuis.info>
 <577c7140-a30c-ca06-a81e-c791e44b1321@pengutronix.de>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <577c7140-a30c-ca06-a81e-c791e44b1321@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1660731900;01766985;
X-HE-SMSGID: 1oOGEM-0007dz-3X
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 07.07.22 07:45, Ahmad Fatoum wrote:
> On 04.07.22 14:11, Thorsten Leemhuis wrote:
>> Hi, this is your Linux kernel regression tracker. Top-posting for once,
>> to make this easily accessible to everyone.
>>
>> Looks like the discussions to fix this regression got stuck. What can be
>> done to get thing rolling again? Or has progress been made and I just
>> missed it? Ciao, Thorsten
> 
> No progress has been made as far as I am aware. I am reverting the commit
> introducing the regression on my systems and haven't yet had the time to
> debug this further to help find an alternative solution.

Just wondering: still no progress I assume?

Anyway: I'm putting it on the backburner to get it out of the
spot-light, as this doesn't look urgent and things seems to progress
very slowly.

#regzbot backburner: debuging is slow this further

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.


>> On 24.06.22 21:59, Luiz Augusto von Dentz wrote:
>>> On Fri, Jun 24, 2022 at 5:53 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>>> On 21.06.22 20:52, Luiz Augusto von Dentz wrote:
>>>>> On Tue, Jun 21, 2022 at 1:32 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>>>>> On 20.06.22 22:18, Luiz Augusto von Dentz wrote:
>>>>>>> On Mon, Jun 20, 2022 at 3:06 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>>>>>>> Disconnect of connection #1 being processed after new connection #2
>>>>>>>> concluded sounds wrong. Would I be able to reconnect
>>>>>>>> afterwards or would all connections, but the first, be directly
>>>>>>>> disconnected...?
>>>>>>>
>>>>>>> That depends on the order you have queued the commands, it will be
>>>>>>> processed in the exact order it is received, that why I said it is
>>>>>>> single queue design, and it is done like that to prevent messing up
>>>>>>> with states since we know the exact order the commands will be sent.
>>>>>>>
>>>>>>>>> otherwise we need a
>>>>>>>>> different queue to handle command that abort/cancel other already in
>>>>>>>>> the queue.
>>>>>>>>
>>>>>>>> Is the revert an acceptable interim solution or are there issues
>>>>>>>> I am missing?
>>>>>>>
>>>>>>> Afaik there were problem with concurrent connections request, so what
>>>>>>> would really help us here is to have some tests to emulate this
>>>>>>> scenario with our CI, in the meantime please check if the following
>>>>>>> fixes your problem:
>>>>>>>
>>>>>>> https://gist.github.com/Vudentz/b4fff292c7f4ad55ca3299fd5ab797ae
>>>>>>
>>>>>> Doesn't help unfortunately. First pairing works as before.
>>>>>> Second still fails:
>>>>>>
>>>>>>   Bluetooth: hci0: Opcode 0x200d failed: -110
>>>>>>   Bluetooth: hci0: request failed to create LE connection: err -110
>>>>>
>>>>> Can we try to add a test in mgmt-tester to reproduce the error above?
>>>>
>>>> I am not familiar with mgmt-tester. What information do you
>>>> need to reproduce? In the meantime, can we revert the commit?
>>>> I understand that this may break other uses, but I believe
>>>> previously working stuff should have precedence..
>>>
>>> Have a looks at:
>>>
>>> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/test-runner.txt
>>>
>>> And then run with:
>>>
>>> sudo tools/test-runner -k <pathyto/bzImage> -- tools/mgmt-tester
>>>
>>> Btw, can we have the exact steps to reproduce it using bluetoothctl if possible?
>>>
>>>> Cheers,
>>>> Ahmad
>>>>
>>>>>
>>>>>> Cheers,
>>>>>> Ahmad
>>>>>>
>>>>>>>
>>>>>>>> Cheers,
>>>>>>>> Ahmad
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> We've been deploying the revert for a while now and I just posted
>>>>>>>>>> it to the mailing list[1]. There have been other reports
>>>>>>>>>> of this issue with different hardware too and fixing sent_cmd
>>>>>>>>>> would likely be too complicated/time intensive for me.
>>>>>>>>>>
>>>>>>>>>> I am happy to test future patches that fix this properly though.
>>>>>>>>>>
>>>>>>>>>> [1]: https://lore.kernel.org/linux-bluetooth/20220616092418.738877-1-a.fatoum@pengutronix.de/T/#t
>>
> 
> 
