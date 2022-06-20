Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C410C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Jun 2022 10:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbiFTKGW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Jun 2022 06:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240739AbiFTKGL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Jun 2022 06:06:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA7313F16
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jun 2022 03:06:10 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1o3EIK-0002S5-Fk; Mon, 20 Jun 2022 12:06:08 +0200
Message-ID: <d5654901-6b1f-a1fa-0101-8b52b345af7b@pengutronix.de>
Date:   Mon, 20 Jun 2022 12:06:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [BUG] BLE device unpairing triggers kernel panic
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
Content-Language: en-US
In-Reply-To: <CABBYNZ+ubN2rc=zoN_53Pmp6kt3L5UcY3knbtjhhVOjPBpJv4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 17.06.22 22:48, Luiz Augusto von Dentz wrote:
> On Thu, Jun 16, 2022 at 3:38 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>> On 16.05.22 18:37, Ahmad Fatoum wrote:
>>>>>> - Commit a56a1138cbd8 ("Bluetooth: hci_sync: Fix not using conn_timeout")
>>>>>>   fixes, despite the title, what event is waited on. First Pairing works now,
>>>>>>   but the second pairing times out and crashes the kernel:
>>>>>>
>>>>>>   [   84.191684] Bluetooth: hci0: Opcode 0x200d failed: -110
>>>>>>   [   84.230478] Bluetooth: hci0: request failed to create LE connection: err -110
>>>>>>   [   84.237690] Unable to handle kernel read from unreadable memory at virtual address 0000000000000ca8
>>>>
>>>> That said the error -110 mean -ETIMEDOUT
>>>
>>> Yes, this issue remains still. I feel better about my revert
>>> knowing that the crash is fixed, but I'd like this regression
>>> here fixed upstream as well. I'll try to collect some more
>>> information and report back.
>>
>> I've now found time to revisit this and sprinkle around some
>> extra logging. This is the initial pairing that works:
>>
>>   Bluetooth: entered hci_le_create_conn_sync()
>>   Bluetooth: hci0: opcode 0x200d plen 25
>>   Bluetooth: hci0: event 0x0f (sent = 0x0a)
>>   Bluetooth: hci0: BT: opcode 0x200d (sent: 0x0a)
>>   Bluetooth: hci0: event 0x3e (sent = 0x0a)
>>   Bluetooth: hci0: BT: subevent 0x0a (sent 0x0a)
>>   Bluetooth: entered hci_le_meta_evt(event=0x0a) completion clause
>>
>> I unpaired on device side and then retried pairing:
>>
>>   Bluetooth: entered hci_le_create_conn_sync()
>>   Bluetooth: hci0: opcode 0x200d plen 25
>>   Bluetooth: hci0: event 0x0f (sent = 0x0a)
>>   Bluetooth: hci0: BT: opcode 0x200d (sent: 0x0a)
>>   Bluetooth: entered hci_abort_conn()
>>   Bluetooth: hci0: opcode hci_req_add_ev 0x200e
>>   Bluetooth: hci0: event 0x0e (sent = 0x00)
>>   Bluetooth: hci0: event 0x3e (sent = 0x00)
>>   Bluetooth: hci0: BT: subevent 0x0a (sent 0x00)
>>   Bluetooth: __hci_cmd_sync_sk pending (event = 0x0a status=1, err=-110)
>>   Bluetooth: hci0: Opcode 0x200d failed: -110
>>   Bluetooth: hci0: opcode 0x2006 plen 15
>>   Bluetooth: hci0: event 0x0e (sent = 0x00)
>>   Bluetooth: hci0: opcode 0x200a plen 1
>>   Bluetooth: hci0: event 0x0e (sent = 0x00)
>>   Bluetooth: hci0: request failed to create LE connection: err -110
>>
>>
>> But now it times out as reported. It looks like the
>> intermittent hci_abort_conn() is at fault here. My theory is
>> that replacing hci->sent_cmd is the problem here, as other
>> events can't be matched anymore.
> 
> Yep, unpair command uses hci_abort_conn when it should really be using
> hci_abort_conn_sync, the problem is if we do that then it probably no
> longer work because it would have to wait for sync queue to complete
> so it would only be able to disconnect after the connect command
> completes, well perhaps that is acceptable

Disconnect of connection #1 being processed after new connection #2
concluded sounds wrong. Would I be able to reconnect
afterwards or would all connections, but the first, be directly
disconnected...?

> otherwise we need a
> different queue to handle command that abort/cancel other already in
> the queue.

Is the revert an acceptable interim solution or are there issues
I am missing?

Cheers,
Ahmad

> 
>> We've been deploying the revert for a while now and I just posted
>> it to the mailing list[1]. There have been other reports
>> of this issue with different hardware too and fixing sent_cmd
>> would likely be too complicated/time intensive for me.
>>
>> I am happy to test future patches that fix this properly though.
>>
>> [1]: https://lore.kernel.org/linux-bluetooth/20220616092418.738877-1-a.fatoum@pengutronix.de/T/#t
>>
>> Cheers,
>> Ahmad
>>
>>
>>
>>>
>>> Cheers,
>>> Ahmad
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
