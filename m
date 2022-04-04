Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D03AC4167B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Apr 2022 21:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353237AbiDDV3E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379497AbiDDRQX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Apr 2022 13:16:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E583014019
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Apr 2022 10:14:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CC5FB818B6
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Apr 2022 17:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69423C2BBE4;
        Mon,  4 Apr 2022 17:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649092464;
        bh=J1K7zQVWebnSsp6wD5xFmA0KuvUnR7v4xxOgYYSWbNM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EPGDHTbleUpNM6xVsvU5glr1uuDo00MwVkr0sdbsADrsgrbEvERf6fp6q5j2M3Gyn
         7E9+gsOhuUsDJTZH+Pw4fZir/gIBAlUHZ3APNmCcWF7WiEe/E6/QttHsFuzzF9zHFU
         oBgP9GFPmoX14yN9pD05V4IctbiIpnvwsNM3W1ehO7F8KTTGq7J3yGmW3gVNSoksi4
         dUDGwpqcEY738N7iWCyrLD0JdogPixzedPZZD9ecjbQmnPrFDSXqS6mmUQ1iAArZ1g
         ACJAGNaEQb+tHXV9DWZKarD6fxUoxeEH9QdAr35GD8PGE9A5hC+RZgQx78Y0gtx5sb
         T9p/OiZNyfjmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53AF7E85AE7;
        Mon,  4 Apr 2022 17:14:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/6] [v4] Fix bugs found by SVACE static analisys tool
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164909246433.14329.9969531326038697330.git-patchwork-notify@kernel.org>
Date:   Mon, 04 Apr 2022 17:14:24 +0000
References: <20220401121647.3985682-1-i.kamaletdinov@omp.ru>
In-Reply-To: <20220401121647.3985682-1-i.kamaletdinov@omp.ru>
To:     Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 1 Apr 2022 15:16:41 +0300 you wrote:
> This patch set includes few fixes that was found by Linux Verification Center
> (linuxtesting.org) with the SVACE static analysis tool.
> 
> I have manually filtered out non-relevant and false positive problems and only
> procedeed with bugs that currently lead to some errors/vulnerabilities or may
> lead to them in some specific conditions.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/6] monitor: Fix out-of-bound read in print_le_states
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7fdfb67284a2
  - [BlueZ,2/6] tools: Fix buffer overflow in hciattach_tialt.c
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d328abaa1715
  - [BlueZ,3/6] tools: Fix signed integer overflow in btsnoop.c
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=497a0b220dbd
  - [BlueZ,4/6] tools: Limit width of fields in sscanf
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1e664b9838cd
  - [BlueZ,5/6] device: Limit width of fields in sscanf
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4afbef7790ce
  - [BlueZ,6/6] gatt: Fix double free and freed memory dereference
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3627eddea130

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


