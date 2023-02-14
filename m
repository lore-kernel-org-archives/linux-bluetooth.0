Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E525EC05027
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Feb 2023 20:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjBNUkV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Feb 2023 15:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjBNUkT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Feb 2023 15:40:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7B08A47
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Feb 2023 12:40:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0B9E618A8
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Feb 2023 20:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EAE2C433EF;
        Tue, 14 Feb 2023 20:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676407217;
        bh=CFN2vxFgKlzfnqzO2r9uPv+lYbNEh/oFqKWrHjlMcbA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Q9d01T9eKBeKvLEzbAjA8R96VvzUeVP2pzovmJMZqdLhpODObs8w/bDFeckJQ3/oA
         BRmn/nzi2jqrhRkR+mU5sxoGCryHW4hhxsJc2PT36PE5fir7IC3hmn7h1vaMu2uP+M
         2SB1gMMSfeR4IyOYbXlEtr6k9qE9IhqOGytg8cJYx9hqjY1TCnPBA3GiRVLkrIKNIg
         ZisJ6+VtHZljW2F/ZV+JGwSqG4xWCTOyb5dpUT+myt/XnmcCbugrwWwt1dUmg2wohS
         wb/gX4C3kirkUDmAHjrk9SqYKD4MBHXqgOXxJxITrHqh9Wqmrf076muYK/QehXrA3P
         mfKqnVehWZHJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EAB2DE45098;
        Tue, 14 Feb 2023 20:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: MGMT: Use BIT macro when defining bitfields
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167640721695.14815.1854565862440161963.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Feb 2023 20:40:16 +0000
References: <20230213223042.575952-1-luiz.dentz@gmail.com>
In-Reply-To: <20230213223042.575952-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 13 Feb 2023 14:30:42 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes use of BIT macro when defining bitfields which makes it
> clearer what bit it is toggling.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: MGMT: Use BIT macro when defining bitfields
    https://git.kernel.org/bluetooth/bluetooth-next/c/08529d9c72d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


