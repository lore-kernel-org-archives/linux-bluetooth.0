Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0653C43217
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Nov 2021 12:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350712AbhKYMbp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Nov 2021 07:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347043AbhKYMaE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Nov 2021 07:30:04 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C725FC061759;
        Thu, 25 Nov 2021 04:26:52 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mqDpr-0006L6-UD; Thu, 25 Nov 2021 13:26:44 +0100
Message-ID: <332a19f1-30f0-7058-ac18-c21cf78759bb@leemhuis.info>
Date:   Thu, 25 Nov 2021 13:26:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
Content-Language: en-BS
To:     Aditya Garg <gargaditya08@live.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Orlando Chamberlain <redecorating@protonmail.com>,
        Daniel Winkler <danielwinkler@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Johan Hedberg <johan.hedberg@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "sonnysasaka@chromium.org" <sonnysasaka@chromium.org>
References: <20211001083412.3078-1-redecorating@protonmail.com>
 <YYePw07y2DzEPSBR@kroah.com>
 <70a875d0-7162-d149-dbc1-c2f5e1a8e701@leemhuis.info>
 <20211116090128.17546-1-redecorating@protonmail.com>
 <e75bf933-9b93-89d2-d73f-f85af65093c8@leemhuis.info>
 <3B8E16FA-97BF-40E5-9149-BBC3E2A245FE@live.com> <YZSuWHB6YCtGclLs@kroah.com>
 <52DEDC31-EEB2-4F39-905F-D5E3F2BBD6C0@live.com>
 <8919a36b-e485-500a-2722-529ffa0d2598@leemhuis.info>
 <20211117124717.12352-1-redecorating@protonmail.com>
 <F8D12EA8-4B37-4887-998E-DC0EBE60E730@holtmann.org>
 <40550C00-4EE5-480F-AFD4-A2ACA01F9DBB@live.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <40550C00-4EE5-480F-AFD4-A2ACA01F9DBB@live.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1637843212;64181b7a;
X-HE-SMSGID: 1mqDpr-0006L6-UD
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking again.

On 19.11.21 17:59, Aditya Garg wrote:
>> On 18-Nov-2021, at 12:31 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>>>> So if this just affects two macs, why can't the fix be realized as a
>>>> quirk that is only enabled on those two systems? Or are they impossible
>>>> to detect clearly via DMI data or something like that?
>>>
>>> I think we should be able to quirk based off the acpi _CID "apple-uart-blth"
>>> or _HID "BCM2E7C". Marcel suggested quirking based of the acpi table here
>>> https://lore.kernel.org/linux-bluetooth/1D2217A9-EA73-4D93-8D0B-5BC2718D4788@holtmann.org/
>>>
>>> This would catch some unaffected Macs, but they don't support the LE Read
>>> Transmit Power command anyway (the affected macs were released after it
>>> was added to the Bluetooth spec, while the unaffected Macs were released
>>> before it was added to the spec, and thus don't support it).
>>>
>>> I'm not sure how to go about applying a quirk based off this, there are
>>> quirks in drivers/bluetooth/hci_bcm.c (no_early_set_baudrate and
>>> drive_rts_on_open), but they don't seem to be based off acpi ids.
>>>
>>> It might be simpler to make it ignore the Unknown Command error, like
>>> in this patch https://lore.kernel.org/linux-bluetooth/CABBYNZLjSfcG_KqTEbL6NOSvHhA5-b1t_S=3FQP4=GwW21kuzg@mail.gmail.com/
>>> however that only applies on bluetooth-next and needed the status it
>>> checks for to be -56, not 0x01.
>>
>> so we abstain from try-and-error sending of commands. The Bluetooth spec
>> has a list of supported commands that a host can query for a reason. This
>> is really broken behavior of the controller and needs to be pointed out as
>> such.
> Well all I can do is provide you any logs or information I can. But we do really wish to get this regression fixed soon.
>>
>> The question is just how we quirk it.

This thread once again looks stalled and smells a lot like "everyone
agrees that his should be fixed, but afaics nobody submitted a fix or
committed to work on one". Please speak up if my impression is wrong, as
this is a regression and thus needs to be fixed, ideally quickly. Part
of my job is to make that happen and thus remind developers and
maintainers about this until we have a fix.

Ciao, Thorsten

#regzbot title bluetooth: "Query LE tx power on startup" broke Bluetooth
on MacBookPro16,1
#regzbot poke
