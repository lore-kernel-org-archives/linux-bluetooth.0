Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141ADC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 May 2022 16:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbiEPQiE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 May 2022 12:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343768AbiEPQiC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 May 2022 12:38:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F193AA4D
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 May 2022 09:38:01 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nqdjL-0001x3-Tx; Mon, 16 May 2022 18:37:59 +0200
Message-ID: <8d5c4724-d511-39b1-21d7-116c91cada45@pengutronix.de>
Date:   Mon, 16 May 2022 18:37:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [BUG] BLE device unpairing triggers kernel panic
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <a1ce1743-e450-6cdb-dfab-56a3e3eb9aed@pengutronix.de>
 <CABBYNZ+z8kBUKGXbZSfb0ynJaTnPQRp0wFDUb12AW1ymbNx1eg@mail.gmail.com>
 <CABBYNZ+zsuggTpaUSPsZKeL=qqvM1=sgMWzdWEqaS_oh6dhY2g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABBYNZ+zsuggTpaUSPsZKeL=qqvM1=sgMWzdWEqaS_oh6dhY2g@mail.gmail.com>
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

On 14.05.22 01:52, Luiz Augusto von Dentz wrote:
> On Fri, May 13, 2022 at 1:14 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:

Thanks for the quick reply.

>> Hi Ahmad,
>>
>> On Fri, May 13, 2022 at 7:10 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>>
>>> Hello,
>>>
>>> On Linux v5.18-rc5, I can reliably crash the kernel on the second (un)pairing
>>> with a customer's BLE device. I have bisected the issue and found two commits:
>>>
>>> - Commit 6cd29ec6ae5e ("Bluetooth: hci_sync: Wait for proper events when
>>>   connecting LE") causes previously working pairing to time out, presumably
>>>   because it keeps waiting for the wrong event.
>>
>> Can you describe in more details what is the second pairing, are you
>> pairing 2 devices concurrently? I recall someone for nxp having
>> similar problem, at least the traces look pretty similar, the problem
>> seems to be the expected event don't match the event the controller
>> send, in this case hci_le_enh_conn_complete_evt, so hci_event process
>> it and frees the hci_conn instead of first running the callback.

It's the same device. I set the host to pairable, then have the device
pair with the host. Then I unpair on the device and then redo the
same operation again. First one works. Second one fails triggering
the crash.

> Looks like my memory failed me on this one, the sync callback is run
> last so we shouldn't cleanup the hci_conn at that point, perhaps
> something like the following should fix the crash:
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 0270e597c285..c1634af670b8 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5632,10 +5632,8 @@ static void le_conn_complete_evt(struct hci_dev
> *hdev, u8 status,
>                 status = HCI_ERROR_INVALID_PARAMETERS;
>         }
> 
> -       if (status) {
> -               hci_conn_failed(conn, status);
> +       if (status)
>                 goto unlock;
> -       }

Yes, this fixes the crash for me. Can you send a patch to that effect?
Feel free to add:

  Tested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

>         if (conn->dst_type == ADDR_LE_DEV_PUBLIC)
>                 addr_type = BDADDR_LE_PUBLIC;
> 
>>> - Commit a56a1138cbd8 ("Bluetooth: hci_sync: Fix not using conn_timeout")
>>>   fixes, despite the title, what event is waited on. First Pairing works now,
>>>   but the second pairing times out and crashes the kernel:
>>>
>>>   [   84.191684] Bluetooth: hci0: Opcode 0x200d failed: -110
>>>   [   84.230478] Bluetooth: hci0: request failed to create LE connection: err -110
>>>   [   84.237690] Unable to handle kernel read from unreadable memory at virtual address 0000000000000ca8
> 
> That said the error -110 mean -ETIMEDOUT

Yes, this issue remains still. I feel better about my revert
knowing that the crash is fixed, but I'd like this regression
here fixed upstream as well. I'll try to collect some more
information and report back.

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
