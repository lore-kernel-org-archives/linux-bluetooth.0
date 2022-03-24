Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D8EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Mar 2022 19:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347046AbiCXTvv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Mar 2022 15:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241865AbiCXTvt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Mar 2022 15:51:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CB65577D
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Mar 2022 12:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8CA8B825EA
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Mar 2022 19:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43D16C340EE;
        Thu, 24 Mar 2022 19:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648151414;
        bh=XZqEOBJQQlq7VCGMMsJBD5p9DGGXOB6LJObQU7dI3xs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WTqZY+CocvWaek26hitlgCD4Wl0YbVp8CkaeMPxAz8ZVGF9VtmRMnBB3+7DjTaAo8
         B3RPaD9ACjRM3uHBqsEQUcHkbYmUjcqMZf+7Ax42rVJtHsFg1ISbqM5IGrBz5HhhB6
         yPql6Yl1ePiFV9qJtZEF06BJiA51WkWrbWMWgEbVj69aWczk+1FawG0i9ajnVm4Myd
         p5mrocGUJTy3Dkr1r/Crtf0SII6CPs5dlwD8UQnH9wAKyik6h2Bc6YYFAumTSLykkF
         aMHE+tivcps1RSrw266u278B5hDD+eZGT8eTst0UTBHkcZmyDfdwhMW1cXkBTVV9vu
         jpXpL+lpYGctw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25FDDE6D44B;
        Thu, 24 Mar 2022 19:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC BlueZ] adapter: Introduce BTD_ADAPTER_DBG
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164815141415.1997.13571288803188237421.git-patchwork-notify@kernel.org>
Date:   Thu, 24 Mar 2022 19:50:14 +0000
References: <20220323224003.3736525-1-luiz.dentz@gmail.com>
In-Reply-To: <20220323224003.3736525-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 23 Mar 2022 15:39:54 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This introduces BTD_ADAPTER_DBG which includes the controller index
> when using DBG_IDX, in addition to it also add similar macro for
> devices in the form of BTD_DEVICE_DBG which resolves the adapter and
> before calling BTD_ADAPTER_DBG.
> 
> [...]

Here is the summary with links:
  - [RFC,BlueZ] adapter: Introduce BTD_ADAPTER_DBG
    (no matching commit)
  - [BlueZ,v4,2/9] mgmt: Add DBG macro
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f9cb7c802f27
  - [BlueZ,v4,3/9] mgmt: Introduce mgmt_set_verbose
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b7c807269f1f
  - [BlueZ,v4,4/9] adapter: Don't use DBG in mgmt_debug
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=62c6037ea02b
  - [BlueZ,v4,5/9] att: Log file and function names
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8039d42687fd
  - [BlueZ,v4,6/9] gatt-client: Add DBG macro
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e0870ce5e1fe
  - [BlueZ,v4,7/9] gatt-server: Add DBG macro
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=55c25d91e4d6
  - [BlueZ,v4,8/9] att: Rename att_debug and att_verbose to DBG and VERBOSE
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e1b808c128fa
  - [BlueZ,v4,9/9] device: Don't use DBG in gatt_debug
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=71cec503c8da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


