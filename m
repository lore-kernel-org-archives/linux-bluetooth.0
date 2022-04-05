Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3E0C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Apr 2022 00:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347827AbiDFAlc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Apr 2022 20:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572965AbiDERcO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Apr 2022 13:32:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AF02314E
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Apr 2022 10:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 528B0B81ED7
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Apr 2022 17:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18037C385A0;
        Tue,  5 Apr 2022 17:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649179813;
        bh=Dm3HMZyiEVGb+ruYMJkdkRPrGkveBCtQImdPMRSobiQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RrhNOsnyfe2HHC58JS5LF3yY0hpe1dtHCPofBtR3CI76JL2ZXQTf+T2lmCkX90DeD
         R+2fD1oLwz/gTJPMtDAWxbEZYG7sgKitvpsrSmuXal/aA07r/wuI4oOVak4mqN+ANs
         4G/+FIpbfjKMGXKE2uiftW5eudsiSV8QdP9K8sDfF11P4+TweMtA9RLsqT36B+WvCJ
         3FjgNn+9bb5d72xOzsbp6ks2PCFFVIJJM1Bx8/F+JTQ0pYRVoMjHwr5AbT03d7TolS
         JRr1h/5SH+/OcJKXgM8bnHl1lrBdbJ5Quxb1yLyycU51ICx8/K/rhZHBcskShjISpu
         SvSVENBCeWyQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE791E85D15;
        Tue,  5 Apr 2022 17:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/4] Bluetooth: HCI: Add
 HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164917981297.18365.2641777452049475210.git-patchwork-notify@kernel.org>
Date:   Tue, 05 Apr 2022 17:30:12 +0000
References: <20220401233826.122544-1-luiz.dentz@gmail.com>
In-Reply-To: <20220401233826.122544-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Fri,  1 Apr 2022 16:38:23 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk which can be
> used to mark HCI_Enhanced_Setup_Synchronous_Connection as broken even
> if its support command bit are set since some controller report it as
> supported but the command don't work properly with some configurations
> (e.g. BT_VOICE_TRANSPARENT/mSBC).
> 
> [...]

Here is the summary with links:
  - [v4,1/4] Bluetooth: HCI: Add HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk
    https://git.kernel.org/bluetooth/bluetooth-next/c/c625b467f47c
  - [v4,2/4] Bluetooth: Print broken quirks
    https://git.kernel.org/bluetooth/bluetooth-next/c/fa5cd0fd5bdf
  - [v4,3/4] Bluetooth: btusb: Set HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for QCA
    https://git.kernel.org/bluetooth/bluetooth-next/c/38a1944deda4
  - [v4,4/4] Bluetooth: hci_sync: Split hci_dev_open_sync
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


