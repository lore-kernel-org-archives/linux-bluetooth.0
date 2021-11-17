Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EC6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 19:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E4F861A58
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 19:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhKQTET convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Nov 2021 14:04:19 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:40956 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhKQTES (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Nov 2021 14:04:18 -0500
Received: from smtpclient.apple (p4fefc15c.dip0.t-ipconnect.de [79.239.193.92])
        by mail.holtmann.org (Postfix) with ESMTPSA id AE6D9CECF6;
        Wed, 17 Nov 2021 20:01:17 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211117124717.12352-1-redecorating@protonmail.com>
Date:   Wed, 17 Nov 2021 20:01:17 +0100
Cc:     regressions@leemhuis.info, danielwinkler@google.com,
        gargaditya08@live.com, gregkh@linuxfoundation.org,
        Johan Hedberg <johan.hedberg@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        regressions@lists.linux.dev, sonnysasaka@chromium.org
Content-Transfer-Encoding: 8BIT
Message-Id: <F8D12EA8-4B37-4887-998E-DC0EBE60E730@holtmann.org>
References: <20211001083412.3078-1-redecorating@protonmail.com>
 <YYePw07y2DzEPSBR@kroah.com>
 <70a875d0-7162-d149-dbc1-c2f5e1a8e701@leemhuis.info>
 <20211116090128.17546-1-redecorating@protonmail.com>
 <e75bf933-9b93-89d2-d73f-f85af65093c8@leemhuis.info>
 <3B8E16FA-97BF-40E5-9149-BBC3E2A245FE@live.com> <YZSuWHB6YCtGclLs@kroah.com>
 <52DEDC31-EEB2-4F39-905F-D5E3F2BBD6C0@live.com>
 <8919a36b-e485-500a-2722-529ffa0d2598@leemhuis.info>
 <20211117124717.12352-1-redecorating@protonmail.com>
To:     Orlando Chamberlain <redecorating@protonmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Orlando,

>> So if this just affects two macs, why can't the fix be realized as a
>> quirk that is only enabled on those two systems? Or are they impossible
>> to detect clearly via DMI data or something like that?
> 
> I think we should be able to quirk based off the acpi _CID "apple-uart-blth"
> or _HID "BCM2E7C". Marcel suggested quirking based of the acpi table here
> https://lore.kernel.org/linux-bluetooth/1D2217A9-EA73-4D93-8D0B-5BC2718D4788@holtmann.org/
> 
> This would catch some unaffected Macs, but they don't support the LE Read
> Transmit Power command anyway (the affected macs were released after it
> was added to the Bluetooth spec, while the unaffected Macs were released
> before it was added to the spec, and thus don't support it).
> 
> I'm not sure how to go about applying a quirk based off this, there are
> quirks in drivers/bluetooth/hci_bcm.c (no_early_set_baudrate and
> drive_rts_on_open), but they don't seem to be based off acpi ids.
> 
> It might be simpler to make it ignore the Unknown Command error, like
> in this patch https://lore.kernel.org/linux-bluetooth/CABBYNZLjSfcG_KqTEbL6NOSvHhA5-b1t_S=3FQP4=GwW21kuzg@mail.gmail.com/
> however that only applies on bluetooth-next and needed the status it
> checks for to be -56, not 0x01.

so we abstain from try-and-error sending of commands. The Bluetooth spec
has a list of supported commands that a host can query for a reason. This
is really broken behavior of the controller and needs to be pointed out as
such.

The question is just how we quirk it.

Regards

Marcel

