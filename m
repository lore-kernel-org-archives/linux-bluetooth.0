Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0698C64ED9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Feb 2023 21:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjB0VkX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Feb 2023 16:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjB0VkW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Feb 2023 16:40:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93EC1BAEE
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Feb 2023 13:40:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60E1660F44
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Feb 2023 21:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C58E4C433EF;
        Mon, 27 Feb 2023 21:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677534017;
        bh=IX6TDUjioNZ1FC0LBgnkzOSHc2i5jFmKUfcI/zm7ulo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MwT/k52l4iwbBjuPo94tXYx3SBc+emW4D4iyGt6Snsh2JskPPnS2FbCPzI4PbihjG
         1G9MHTFwAT0ZH1AZRRchUeA2RJrmgO6o1TlS/9FRm60ApowU38JfNeOqHMprkEfoK/
         YrYwvdbV/4tGfjjAEK8pBpjhqvMhSNAncAWQtwa9WiU7Zbm3WNfs2eCD6YsM6vc1x0
         EktiZ85Xba9/xCjxCA8VTKh5KdCzS9vFM9JE56+EhSYIxFCXOIT5RHY4uWvLbCe+HE
         PHXwLeM41/G9wfXGYXqmejgK4KZpawuzbNtaTmOacEJknKpfOx8btCm0+biHe9kZJD
         lbQM0MKKFRUeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ACB63E68D2D;
        Mon, 27 Feb 2023 21:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: ISO: fix timestamped HCI ISO data packet parsing
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167753401770.12319.7774586415718578417.git-patchwork-notify@kernel.org>
Date:   Mon, 27 Feb 2023 21:40:17 +0000
References: <1fd2d4523c139deda93aab2c31f1508d79c32472.1676921889.git.pav@iki.fi>
In-Reply-To: <1fd2d4523c139deda93aab2c31f1508d79c32472.1676921889.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 20 Feb 2023 19:38:24 +0000 you wrote:
> Use correct HCI ISO data packet header struct when the packet has
> timestamp. The timestamp, when present, goes before the other fields
> (Core v5.3 4E 5.4.5), so the structs are not compatible.
> 
> Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> 
> [...]

Here is the summary with links:
  - Bluetooth: ISO: fix timestamped HCI ISO data packet parsing
    https://git.kernel.org/bluetooth/bluetooth-next/c/e16f2ec5cf3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


