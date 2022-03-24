Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC805C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Mar 2022 19:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346529AbiCXTvu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Mar 2022 15:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345562AbiCXTvt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Mar 2022 15:51:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C370555776
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Mar 2022 12:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AACFB825E7
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Mar 2022 19:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 384A5C340F0;
        Thu, 24 Mar 2022 19:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648151414;
        bh=xbLazDta6MaqYGoUYQc8yMO4oqN/v1bZpBy8CCzIkXc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TjSTdOxrd2BjE97VUcUdHGi/BzsJzUboseqKp25snpbh4a10d5SRZ4LLTc3wl8dVj
         aY8uxdqV26WREsfyyhAjaW7RjS6Y6iv6LrtSL4rj7J7FaSCh1o557iZ11Q5tGWudO+
         dw8l4qYChreenkEvnkpGIqU8V6R7usOJoXSeSagZr2KiDFqmzBvisVvkx/l6BBZ9wY
         aZ5UFDyKQEue8stL3KdXgE4oKZ2WT13Js3B2TPOmnWfTJ6QNSxxtU0iiHeCrBkH8aw
         nENc9obmHpQTbJrH5ypfwpl2JnDRU6SnSdz0q4ptzgqjNtlXlJfOAwVp4ZrHbB+TqA
         OA4RTM39Umavw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1CBA6EAC09C;
        Thu, 24 Mar 2022 19:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/9] log: Introduce DBG_IS_ENABLED
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164815141411.1997.13222632264620582894.git-patchwork-notify@kernel.org>
Date:   Thu, 24 Mar 2022 19:50:14 +0000
References: <20220323201341.3596128-2-luiz.dentz@gmail.com>
In-Reply-To: <20220323201341.3596128-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 23 Mar 2022 13:13:33 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This introduces DBG_IS_ENABLE macro which can be used to check if
> BTD_DEBUG_FLAG_PRINT has been enabled for the current file.
> ---
>  src/log.c | 12 ++++++++++++
>  src/log.h | 11 +++++++++++
>  2 files changed, 23 insertions(+)

Here is the summary with links:
  - [BlueZ,v2,1/9] log: Introduce DBG_IS_ENABLED
    (no matching commit)
  - [BlueZ,v3,2/9] mgmt: Add DBG macro
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f9cb7c802f27
  - [BlueZ,v3,3/9] mgmt: Introduce mgmt_set_verbose
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b7c807269f1f
  - [BlueZ,v3,4/9] adapter: Don't use DBG in mgmt_debug
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=62c6037ea02b
  - [BlueZ,v3,5/9] att: Log file and function names
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8039d42687fd
  - [BlueZ,v3,6/9] gatt-client: Add DBG macro
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e0870ce5e1fe
  - [BlueZ,v3,7/9] gatt-server: Add DBG macro
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=55c25d91e4d6
  - [BlueZ,v3,8/9] att: Rename att_debug and att_verbose to DBG and VERBOSE
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e1b808c128fa
  - [BlueZ,v3,9/9] device: Don't use DBG in gatt_debug
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=71cec503c8da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


