Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2250AC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Nov 2022 20:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiKAUuV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Nov 2022 16:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiKAUuU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Nov 2022 16:50:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436FD193CF
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 13:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B38AAB81F7B
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 20:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63AEFC433D7;
        Tue,  1 Nov 2022 20:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667335817;
        bh=sbdaqpTOITCywckctdVVz0B1GdkaCznVyKz8ujbuce8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lE8zYN61WLMbmJ8jT37GZCIISFnb1IJLyfettO442BAd0KZkVECuoiXvxgJT+Y3fg
         KbVBdpuwD61lLnLtfuiqV/Pfdg/8QnNNa3TRw00PV3mPEofDcD9sC0YDOVhVFKTYm7
         h9yU+jqGShbV3Si4IcgN9udEx02UVdwardHG31uQ/jpr1wjLZvjdnuJRVFD4cSOwT3
         a4DhfKxvOU8RRzJCfwB6/dgr1GZtLYmuseApdsFBSKG7e8RynEp+MbgJqPnx85y7pD
         ky8avA47wq+Kx/5ZvyQwf8KbBOusDoZzZVbRoPYQynXeWAUtqyynSgB6zOJs3OVo8r
         kcolG2+37aQug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49F41E270D5;
        Tue,  1 Nov 2022 20:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: L2CAP: Fix accepting connection request for
 invalid SPSM
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166733581629.15990.15999727575150425079.git-patchwork-notify@kernel.org>
Date:   Tue, 01 Nov 2022 20:50:16 +0000
References: <20221031231033.2718204-1-luiz.dentz@gmail.com>
In-Reply-To: <20221031231033.2718204-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 31 Oct 2022 16:10:32 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The Bluetooth spec states that the valid range for SPSM is from
> 0x0001-0x00ff so it is invalid to accept values outside of this range:
> 
>   BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 3, Part A
>   page 1059:
>   Table 4.15: L2CAP_LE_CREDIT_BASED_CONNECTION_REQ SPSM ranges
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: L2CAP: Fix accepting connection request for invalid SPSM
    https://git.kernel.org/bluetooth/bluetooth-next/c/a0978378c152
  - [2/2] Bluetooth: L2CAP: Fix l2cap_global_chan_by_psm
    https://git.kernel.org/bluetooth/bluetooth-next/c/6bdbca3c41e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


