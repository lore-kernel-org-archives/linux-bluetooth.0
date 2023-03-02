Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621DFC678D4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Mar 2023 20:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjCBUbq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Mar 2023 15:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjCBUbd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Mar 2023 15:31:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A9670423
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Mar 2023 12:30:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FD4B6163F
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Mar 2023 20:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 825B7C4339B;
        Thu,  2 Mar 2023 20:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677789018;
        bh=UprsZH9Sa+gsYj8ZQUne9TlhU0WwjPiGsGEkq8InWic=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=q6wgLRcZ2MayFeI3w8VuxsItoK+f5qCrW2TuHil1uuJMHZuhFybuL9JVgDw+xUfDC
         ihKTaRs2/hD8DIX99CcoV/nMPDE4cF1CGkcwwg5wIll5rIjCS6WpmfcYEQru/bW74Y
         A08iEWyneH+c8kaWiWeUdbA75oJEHXSxchQnzTupqC+z+O/TZTUfwurLrEK2tFJJOn
         DV29c/uA/CoBZ5lbCpPrO0Q+Msrx9kwZ0JwEQGD4DUJAepEXBKzqZIRiQVrB1GB6Yk
         q3JKSz3y1RZnx5TrZC1Vr9WX09M/WOHjgCuDWafkdFIaPU04KbkkQbOyllk4SrvqXW
         3EmM/zCBnf8Ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6AEF2C43161;
        Thu,  2 Mar 2023 20:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/5] device: Don't attempt to connect LE if ATT is
 already connected
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167778901843.1333.5124467077474096199.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Mar 2023 20:30:18 +0000
References: <20230301013842.718438-1-luiz.dentz@gmail.com>
In-Reply-To: <20230301013842.718438-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 28 Feb 2023 17:38:38 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This checks if an att instance already exists before attempting to
> connect it once again.
> ---
>  src/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,1/5] device: Don't attempt to connect LE if ATT is already connected
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1923f5dd9068
  - [BlueZ,2/5] client: Allow transport.send command to work with multiple transports
    (no matching commit)
  - [BlueZ,3/5] shared/bap: Cleanup requests on detach
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=36c234625bda
  - [BlueZ,4/5] share/gatt-client: Introduce idle callback
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d6f790f82de1
  - [BlueZ,5/5] media: Fix not checking BREDR support for A2DP
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=15458c5e1071

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


