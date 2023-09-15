Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EB1CD37A7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Sep 2023 19:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjIOTuc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Sep 2023 15:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236306AbjIOTua (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Sep 2023 15:50:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4721BC7
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 12:50:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8A21C433C8;
        Fri, 15 Sep 2023 19:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694807425;
        bh=CY8Kltp0dtzCOOGki4rsyzPCumItu8bRrm3RE7bg6AM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YJ8dFHcdR0Rye+TT70bG1qFzypBbD8vxI61LAl8qkgbnIu/xN6LZSTFBxatX32hH7
         899Z+lF3eGClvGLrHhEBbX/lsv8ha1eYx7oOyZRbKCjEmjvFirEu82nfLfoEw9gzYS
         LMoprt/ZZHteALX6EleZlFfxgq0e6qPVKOuZp2xc2LQNmsnbFGCoY37vLjaAL2msT9
         Y0RdCdgnZ7NxcqpXJQL7KIEBBdBrn4o86N9FT4nzT19XGElgetQpwQCqD4KL7Nk+G2
         Ps29utPfpZACqSL6HK05ps7QTGgdPg1sO+GQA8cwABGh0GWJB0MNlJqk1hgfN/CpsD
         1w5Cmw7kB1olQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B219CE26882;
        Fri, 15 Sep 2023 19:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] l2cap-tester: Add tests for closing socket before
 connection completes
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169480742572.23728.10687776546673068500.git-patchwork-notify@kernel.org>
Date:   Fri, 15 Sep 2023 19:50:25 +0000
References: <20230914211003.3339238-1-luiz.dentz@gmail.com>
In-Reply-To: <20230914211003.3339238-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 14 Sep 2023 14:10:02 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds the following tests which attempts to close/shutdown the
> socket before the connection completes:
> 
> L2CAP BR/EDR Client - Close
> L2CAP LE Client - Close
> L2CAP Ext-Flowctl Client - Close
> 
> [...]

Here is the summary with links:
  - [v2,1/2] l2cap-tester: Add tests for closing socket before connection completes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d46f91c5be57
  - [v2,2/2] l2cap-tester: Add tests for connection timeout
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7b9d2f3c7634

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


