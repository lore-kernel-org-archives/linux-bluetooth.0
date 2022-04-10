Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78526C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 Apr 2022 09:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbiDJJIE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 10 Apr 2022 05:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiDJJID (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 10 Apr 2022 05:08:03 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D21292
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Apr 2022 02:05:53 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ndTW2-0005gq-4M; Sun, 10 Apr 2022 11:05:50 +0200
Message-ID: <7afb6b94-cbd8-fecd-9c68-4200d87cda59@leemhuis.info>
Date:   Sun, 10 Apr 2022 11:05:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 1/4] Bluetooth: HCI: Add
 HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk
Content-Language: en-US
To:     patchwork-bot+bluetooth@kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Jakub Kicinski <kuba@kernel.org>
References: <20220401233826.122544-1-luiz.dentz@gmail.com>
 <164917981297.18365.2641777452049475210.git-patchwork-notify@kernel.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <164917981297.18365.2641777452049475210.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1649581553;da8f8199;
X-HE-SMSGID: 1ndTW2-0005gq-4M
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

On 05.04.22 19:30, patchwork-bot+bluetooth@kernel.org wrote:
> 
> This series was applied to bluetooth/bluetooth-next.git (master)
> by Marcel Holtmann <marcel@holtmann.org>:
> 
> On Fri,  1 Apr 2022 16:38:23 -0700 you wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

BTW: Thx for taking care of this, Luiz!

>> This adds HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk which can be
>> used to mark HCI_Enhanced_Setup_Synchronous_Connection as broken even
>> if its support command bit are set since some controller report it as
>> supported but the command don't work properly with some configurations
>> (e.g. BT_VOICE_TRANSPARENT/mSBC).
>>
>> [...]
> 
> Here is the summary with links:
>   - [v4,1/4] Bluetooth: HCI: Add HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk
>     https://git.kernel.org/bluetooth/bluetooth-next/c/c625b467f47c
>   - [v4,2/4] Bluetooth: Print broken quirks
>     https://git.kernel.org/bluetooth/bluetooth-next/c/fa5cd0fd5bdf
>   - [v4,3/4] Bluetooth: btusb: Set HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for QCA
>     https://git.kernel.org/bluetooth/bluetooth-next/c/38a1944deda4
>   - [v4,4/4] Bluetooth: hci_sync: Split hci_dev_open_sync
>     (no matching commit)
> 
> You are awesome, thank you!

Hey, this patchset is fixing a regression from 5.16 (see patch 3/4), but
apparently is only scheduled to go upstream in the next cycle, as it was
applied to bluetooth-next.git. The patches also seem to miss tags to get
them backported to stable. Is that intentional? At least patches 1, 2,
and 3 don't look that complex, why can't they get in this cycle and get
backported to stable soon to finally provide a solution for users that
are plagued by this for weeks already?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.
