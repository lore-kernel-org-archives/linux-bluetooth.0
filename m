Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E60C64ED6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Feb 2023 21:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjB0Vk3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Feb 2023 16:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjB0VkY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Feb 2023 16:40:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A391C305
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Feb 2023 13:40:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 857F5B80DC7
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Feb 2023 21:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45C4DC433A1;
        Mon, 27 Feb 2023 21:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677534018;
        bh=Gr3J5EKr0Kvl50vhRx+Mua+nBos2kuX28NupB/frB6c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jFdH26jLzgyBibu9It4C5VVdkx1uGPTdkd9X6nYT2I3o44eCAr4ywITY8tHHbFyLi
         e+mf1AX18BxgBFXqeTJTZlk22aSxfmErk0SNqbnZoYiSd9NdLoR2XkNzwSH5F0P0QP
         8w6OwPsizylAWWH6E/Shr7mlgpnw1ycnhvkmqLbY7hORt49DBx8kxJdKeOOrMQsZxp
         zRq+9Y91ovVAIyYgbxXH9hRvJuVHJstghvtB9s2ynluXdDD8yF/cxDYxhDCftfvjzM
         R4xURHy1dcqsI/ncyV7NL5N28ODCeVF52DDT32GfNYDXlbllHWgpsUXuudidmbaNDC
         idLREtL6Q7Dsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 325F6E50D60;
        Mon, 27 Feb 2023 21:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] shared/bap: fix crash unregistering media endpoint
 while streaming
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167753401820.12319.8127078407084755990.git-patchwork-notify@kernel.org>
Date:   Mon, 27 Feb 2023 21:40:18 +0000
References: <fe1bf6efbd6bdfc8507e13559bb3852b23446f2f.1677261870.git.pav@iki.fi>
In-Reply-To: <fe1bf6efbd6bdfc8507e13559bb3852b23446f2f.1677261870.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 24 Feb 2023 18:09:46 +0000 you wrote:
> Always free BAP stream in bt_bap_stream_release if it is not attached to
> a client session, simplifying the cleanup.
> 
> Fixes the following ASAN crash is observed when media endpoint is
> unregistered (stopping sound server) while streaming from remote BAP
> client:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] shared/bap: fix crash unregistering media endpoint while streaming
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fcdd38acf6b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


