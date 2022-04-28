Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7028FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Apr 2022 22:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbiD1Wdd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Apr 2022 18:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237245AbiD1Wdb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Apr 2022 18:33:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B41A1AF
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Apr 2022 15:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2658B83059
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Apr 2022 22:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACD1BC385AF;
        Thu, 28 Apr 2022 22:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651185012;
        bh=vm4+o4Y/Mgj7cpZLeTOhxn5Pcu0eMhusUKo6zCePVu4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TDPylmMJ8ncMrjcQRtoo+ChinsaCA2Qxx3ff4hpzcZInkc0oVqaCrKm7zaezx5WMI
         shAJCK4ueVtdF0U+U21uUzZrVJ53R2bFwAUDHtDLVCrOcTApKaS4I+jIAZ3ugJuNkO
         fabRfoPnJolh8X8KMaZRy4/BJdybexPu/Eb9FzZE2qBQsXIhZBJqF5m0nKIMcT/7kC
         ERXirgS/HFRYjyIyAnd0nVkwzyj0ie7UF1Vx5kFu71NDliSPGNIxXoCQn8hcCd3UcM
         MhoUgEwRMls32trGT1vGObphnJKuwTyfSkzL2bzy7HP1+3UUB1nVdzDNvYXjFTGON+
         EP2z4dLEWUKdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81302F03870;
        Thu, 28 Apr 2022 22:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] transport: Fix not being able to initialize volume
 properly
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165118501252.18997.1932540979259916756.git-patchwork-notify@kernel.org>
Date:   Thu, 28 Apr 2022 22:30:12 +0000
References: <20220428200520.1429133-1-luiz.dentz@gmail.com>
In-Reply-To: <20220428200520.1429133-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 28 Apr 2022 13:05:20 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> In case AVRCP is connected first and
> media_transport_update_device_volume is called without any media_player
> being available the volume setting would be lost and Transport.Volume
> won't be available, so this introduces btd_device_{set,get}_volume
> helpers which is used to store the volume temporarely so
> media_player_get_device_volume is able to restore it when the transport
> is created.
> 
> [...]

Here is the summary with links:
  - [v2] transport: Fix not being able to initialize volume properly
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fa7828bddd21

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


