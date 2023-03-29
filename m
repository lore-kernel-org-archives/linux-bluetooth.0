Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D764C6FD18
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Mar 2023 19:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjC2TvX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Mar 2023 15:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjC2TvS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Mar 2023 15:51:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661866E8B;
        Wed, 29 Mar 2023 12:50:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4441EB82438;
        Wed, 29 Mar 2023 19:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D31CBC433D2;
        Wed, 29 Mar 2023 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680119423;
        bh=TZnuON2ALMaVaJ38tnDMvCxndBybp4aPi0dcrIYjgmw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jyW9GB/knF2E2BGAy/FeDuny4C+OgyfVr0vYdVhzVUAfclTbbCSprGNX66eQgmvf4
         wO1F8R74F/DVDty4MPex5UbERwn73zRTbbEplYff5cBr2QobO+KfI6c26aWp3/4ZvE
         9Qs7koLhvyHGwmQXtDd6gZGdrnD5vkUFjjVHDAtrZ4PeoVpJxAag/Hhy/5m+vGCbGn
         RH7u8BpT/dNtWLFHTse8u12OBk+EvYnKYzGoIybV6zRjlblLUWKGOR5Y3fgfj7JmdR
         jh9qE1XHA+VT4AU0ikw6kBJKU91C2yjWbqvh7XnRM6K7mKx+pSa8NPXYD4u1g/DHpj
         8pZquQf43L7Cw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA9C4E21EE4;
        Wed, 29 Mar 2023 19:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] Bluetooth: btrtl: check for NULL in btrtl_set_quirks()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168011942375.31352.12731684585593411555.git-patchwork-notify@kernel.org>
Date:   Wed, 29 Mar 2023 19:50:23 +0000
References: <20230321114826.3544-1-max.chou@realtek.com>
In-Reply-To: <20230321114826.3544-1-max.chou@realtek.com>
To:     Max Chou <max.chou@realtek.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex_lu@realsil.com.cn, hildawu@realtek.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 21 Mar 2023 19:48:26 +0800 you wrote:
> From: Max Chou <max.chou@realtek.com>
> 
> The btrtl_set_quirks() has accessed btrtl_dev->ic_info->lmp_subver since
> b8e482d02513. However, if installing a Realtek Bluetooth controller
> without the driver supported, it will hit the NULL point accessed.
> 
> Add a check for NULL to avoid the Kernel Oops.
> 
> [...]

Here is the summary with links:
  - [1/1] Bluetooth: btrtl: check for NULL in btrtl_set_quirks()
    https://git.kernel.org/bluetooth/bluetooth-next/c/dfa0a31c0cee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


