Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A194C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 13:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B30B608FB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 13:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhKENmW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Nov 2021 09:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhKENmV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Nov 2021 09:42:21 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484F7C061714;
        Fri,  5 Nov 2021 06:39:42 -0700 (PDT)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mizRS-0006hc-NT; Fri, 05 Nov 2021 14:39:39 +0100
Message-ID: <5ee758fc-571d-a28a-9f12-4f7d74835ec0@leemhuis.info>
Date:   Fri, 5 Nov 2021 14:39:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
Content-Language: en-BS
To:     Orlando Chamberlain <redecorating@protonmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     danielwinkler@google.com, Johan Hedberg <johan.hedberg@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, sonnysasaka@chromium.org
References: <4970a940-211b-25d6-edab-21a815313954@protonmail.com>
 <20210930063106.19881-1-redecorating@protonmail.com>
 <20210930141256.19943-1-redecorating@protonmail.com>
 <FA02CDD7-CFEC-4481-9940-BA95D81FD3F3@holtmann.org>
 <275acce4-9eab-9cba-7145-5a75a69ca530@protonmail.com>
 <20211001083412.3078-1-redecorating@protonmail.com>
 <1D2217A9-EA73-4D93-8D0B-5BC2718D4788@holtmann.org>
 <20211001132756.434e56bb@localhost> <20211004111518.0765650c@localhost>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20211004111518.0765650c@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1636119582;9234bea1;
X-HE-SMSGID: 1mizRS-0006hc-NT
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Lo, this is your Linux kernel regression tracker speaking. I have this
regression on the radar of regzbot, my Linux regression tracking bot:
https://linux-regtracking.leemhuis.info/regzbot/regression/4970a940-211b-25d6-edab-21a815313954@protonmail.com/

Has any progress been made since below mail? If not: how can we get the
ball rolling again and get this regression fixed?

Ciao, Thorsten

P.S.: I have no personal interest in this issue. Hence, feel free to
exclude me on further messages in this thread after the first reply, as
I'm only posting this mail to hopefully get a status update and things
rolling again.

#regzbot poke

On 04.10.21 13:15, Orlando Chamberlain wrote:
> On Fri, 01 Oct 2021 23:28:03 +1000
> "Orlando Chamberlain" <redecorating@protonmail.com> wrote:
>> On Fri, 01 Oct 2021 19:35:16 +1000
>> "Marcel Holtmann" <marcel@holtmann.org> wrote:
>>
>>> I would really prefer to do that via the ACPI table matching in
>>> hci_bcm.c and not via some magic chip id check.
>>
>> Initially I thought we may be able to do this based off BCM2E7C (which
>> is in the DSDT table which I'll attach), however it seems like many
>> Macs also have that (i.e. MacBookPro14,1, MacBookAir8,1, MacBook9,1),
>> so unless all these don't support LE Read Transmit Power, (which
>> would be hard to determine), I don't know if BCM2E7C can be used to
>> quirk it.
> 
> I think there aren't any Macs that support LE Read Transmit Power.
> 
> I checked the Bluetooth spec here
> https://www.bluetooth.com/specifications/specs/core-specification-5-1/
> and it seems like 5.1 is the first version that mentions LE Read
> Transmit Power. It says 5.1 was adopted on 21 Jan 2019.
> 
> As far as I know, all of the models released after that date that have
> ever had working Bluetooth were affected, while unaffected models were
> released before that date (and thus shouldn't support LE Read Transmit
> Power? This is at least true for the MacBookPro15,1, a 2018 model that
> doesn't support the command).
> 
> I think this means that no Apple computer released so far supports the
> command, so disabling LE Read Transmit Power for all Apple controllers
> based off "apple-uart-blth" (probably a better choice than "BCM2E7C")
> won't affect any controllers that actually support it.
> 
> Device (BLTH)
> {
>     Name (_HID, EisaId ("BCM2E7C"))  // _HID: Hardware ID
>     Name (_CID, "apple-uart-blth")  // _CID: Compatible ID
>     Name (_UID, One)  // _UID: Unique ID
>     Name (_ADR, Zero)  // _ADR: Address
> 
> As to future Apple computers, they seem to no longer be using UART and
> instead have a second Broadcom PCI device (the first being for WiFi)
> that is for Bluetooth. 3 Intel Macs Models have this second device
> (MacBookPro15,4, MacBookPro16,3 and MacBookAir9,1), and so do the M1
> ones.
> 
> I can't say that they won't move back to UART at some point and then
> support LE Read Transmit Power, but if they do, I don't think they
> would move back to x86_64, so only having this quirk activated when
> compiling for x86_64 might be an option if that's an issue.
> 
>> I'll try to see if I can find something else in the ACPI tables that
>> can be used as a quirk. (I'll see if I can get the table of a similar
>> model that wasn't affected and compare the BLTH sections)
> 
> The BLTH sections were the same for affected and unaffected macs.
> 
> 
> 
> Would disabling LE Read Transmit Power if the controller is
> "apple-uart-blth" work for you?
> 
