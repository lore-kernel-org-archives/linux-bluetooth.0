Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5959C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Dec 2021 11:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbhLQLjp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Dec 2021 06:39:45 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:42461 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233856AbhLQLjp (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Dec 2021 06:39:45 -0500
Received: from [192.168.0.3] (ip5f5aed08.dynamic.kabel-deutschland.de [95.90.237.8])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id F0F7A61EA192F;
        Fri, 17 Dec 2021 12:39:42 +0100 (CET)
Message-ID: <3ae32390-a8e5-9b65-6252-9e7f201bd08a@molgen.mpg.de>
Date:   Fri, 17 Dec 2021 12:39:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH] Bluetooth: btintel: Fix broken LED quirk for legacy
 ROM device
Content-Language: en-US
To:     Tedd An <tedd.an@intel.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
References: <20211216033453.9806-1-hj.tedd.an@gmail.com>
 <904d134a-a672-72a9-dddb-1c48d151e62e@molgen.mpg.de>
 <7bca0b8840cc1bab1c7ea7f25d8cca6ee41ecb04.camel@intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <7bca0b8840cc1bab1c7ea7f25d8cca6ee41ecb04.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Tedd,


Am 16.12.21 um 19:38 schrieb An, Tedd:

> On Thu, 2021-12-16 at 08:52 +0100, Paul Menzel wrote:

>> Am 16.12.21 um 04:34 schrieb Tedd Ho-Jeong An:
>>> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>>>
>>> This patch fix the broken LED quirk for Intel legacy ROM devices.
>>
>> fix*es*
>>
>> Excuse my ignorance, but what are Intel legacy ROM devices? Maybe also
>> mention the IDs 0x0a2a and 0x0aa7 in the commit message?
>>
>>> Legacy device sends the SW RFKILL while shutting down the device (like
>>> HCI interface down) to turn off the LED by putting the device in assert.
>>>
>>> Once the SW RFKILL is on, it needs the HCI_Reset to exit from the SW
>>> RFKILL state. This patch checks the quirk and send the HCI_Reset before
>>
>> send*s*
>>
>>> sending the HCI_Intel_Read_Version command.
>>
>> Is that document in some datasheet/specification? If so, please mention it.
>>
>> Also, in the commit message summary you write “Fix”. If it fixes an old
>> commit, please add a Fixes: tag.
>>
>>> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
>>> ---
>>>    drivers/bluetooth/btintel.c | 13 ++++++-------
>>>    drivers/bluetooth/btusb.c   | 10 ++++++++--
>>>    2 files changed, 14 insertions(+), 9 deletions(-)
>>
>> I have a Dell Latitude E7250 with the 8087:0a2a. How can I test this?
> 
> Apply this patch on top of the bluetooth-next (or current mainline)
> The BT interface should be available after reboot.

On the laptop, I do not have any problems with missing BT interface 
after reboot with Linux 5.16-rc5. Are not all devices affected?

[…]


Kind regards,

Paul
