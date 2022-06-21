Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8018FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 08:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347788AbiFUIcJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 04:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346183AbiFUIcJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 04:32:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707D21573A
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 01:32:08 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1o3ZIs-00019W-LJ; Tue, 21 Jun 2022 10:32:06 +0200
Message-ID: <1d1b76cf-df6f-3935-5cd2-c45ea78f2c33@pengutronix.de>
Date:   Tue, 21 Jun 2022 10:32:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [BUG] BLE device unpairing triggers kernel panic
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <a1ce1743-e450-6cdb-dfab-56a3e3eb9aed@pengutronix.de>
 <CABBYNZ+z8kBUKGXbZSfb0ynJaTnPQRp0wFDUb12AW1ymbNx1eg@mail.gmail.com>
 <CABBYNZ+zsuggTpaUSPsZKeL=qqvM1=sgMWzdWEqaS_oh6dhY2g@mail.gmail.com>
 <8d5c4724-d511-39b1-21d7-116c91cada45@pengutronix.de>
 <b0cb4fb0-6b89-b9df-9ae6-421ac52b0100@pengutronix.de>
 <CABBYNZ+ubN2rc=zoN_53Pmp6kt3L5UcY3knbtjhhVOjPBpJv4Q@mail.gmail.com>
 <d5654901-6b1f-a1fa-0101-8b52b345af7b@pengutronix.de>
 <CABBYNZ+8dpPBqaQMr-Hz_DJRxT-0ucCjgAJH50FUaN7Sn9H6rA@mail.gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <CABBYNZ+8dpPBqaQMr-Hz_DJRxT-0ucCjgAJH50FUaN7Sn9H6rA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Luiz,

On 20.06.22 22:18, Luiz Augusto von Dentz wrote:
> On Mon, Jun 20, 2022 at 3:06 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>> Disconnect of connection #1 being processed after new connection #2
>> concluded sounds wrong. Would I be able to reconnect
>> afterwards or would all connections, but the first, be directly
>> disconnected...?
> 
> That depends on the order you have queued the commands, it will be
> processed in the exact order it is received, that why I said it is
> single queue design, and it is done like that to prevent messing up
> with states since we know the exact order the commands will be sent.
> 
>>> otherwise we need a
>>> different queue to handle command that abort/cancel other already in
>>> the queue.
>>
>> Is the revert an acceptable interim solution or are there issues
>> I am missing?
> 
> Afaik there were problem with concurrent connections request, so what
> would really help us here is to have some tests to emulate this
> scenario with our CI, in the meantime please check if the following
> fixes your problem:
> 
> https://gist.github.com/Vudentz/b4fff292c7f4ad55ca3299fd5ab797ae

Doesn't help unfortunately. First pairing works as before.
Second still fails:

  Bluetooth: hci0: Opcode 0x200d failed: -110
  Bluetooth: hci0: request failed to create LE connection: err -110

Cheers,
Ahmad

> 
>> Cheers,
>> Ahmad
>>
>>>
>>>> We've been deploying the revert for a while now and I just posted
>>>> it to the mailing list[1]. There have been other reports
>>>> of this issue with different hardware too and fixing sent_cmd
>>>> would likely be too complicated/time intensive for me.
>>>>
>>>> I am happy to test future patches that fix this properly though.
>>>>
>>>> [1]: https://lore.kernel.org/linux-bluetooth/20220616092418.738877-1-a.fatoum@pengutronix.de/T/#t
>>>>
>>>> Cheers,
>>>> Ahmad
>>>>
>>>>
>>>>
>>>>>
>>>>> Cheers,
>>>>> Ahmad
>>>>>
>>>>
>>>>
>>>> --
>>>> Pengutronix e.K.                           |                             |
>>>> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
>>>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>>>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
>>>
>>>
>>>
>>
>>
>> --
>> Pengutronix e.K.                           |                             |
>> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> 
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
